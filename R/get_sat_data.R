
#' Mung satellite data into regular cube via rstac and gdalcubes
#'
#' Returned .tif values are 16 bit signed integers. For reflectance these have
#' values 1 to 10000 with no data as -999 (as per the original Digital Earth
#' Australia cube). For indices these have values of index * 10000 with no data
#' as -32768.
#'
#' @param x SpatRaster, or path to raster (needs to be path if running in
#' parallel), to use as extent, resolution and crs for output.
#' @param start_date,end_date Character or Date. e.g. "2013-03-01". These
#' specify the temporal extent of the cube.
#' @param out_dir Character. Path into which results will be saved.
#' @param source_url Character. URL specifying the
#' [STAC](https://stacspec.org/en) endpoint.
#' @param collections Character. Name of collection(s) within the STAC endpoint
#' from which to build the cube. e.g. DEA Surface Reflectance (Sentinel-2,
#' Collection 3) could be specified by c("ga_s2am_ard_3", "ga_s2bm_ard_3").
#' @param period Character specifying the temporal cell size in
#' [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601). e.g. "P1M" specifies a
#' time period of one month.
#' @param property_filter Passed to the `property_filter` argument of
#' `gdalcubes::stac_image_collection()`.
#' @param aggregation_func Passed to the `aggregation` argument of
#' `gdalcubes::cube_view()`.
#' @param resampling_method Passed to the `resampling` argument of
#' `gdalcubes::cube_view()`.
#' @param layers Character. Regular expressions, to search within the items
#' returned by the rstac query, defining the layers (bands) from which to build
#' the cube.
#' @param excludes Character. Regular expressions, to search AND EXCLUDE within
#' the items returned by the rstac query. e.g. the default 'nbar_" excludes,
#' say, nbar_blue, but leaves nbart_blue.
#' @param indices Named list of pairs of `layers` to use to build indices within
#' the cube. e.g. indices = list(ndvi = c("nir", "red")) will create a layer in
#' the cube 'ndvi' as (nir - red) / (nir + red). Currently only relevant if
#' save_cube is TRUE.
#' @param mask Named list specifying any band, and the levels within that band,
#' that identify pixels in an image that should be excluded from the cube.
#' Default mask identifies cloud and cloud shadow within default source_url and
#' collections.
#' @param save_cube Logical. If `TRUE` the cube will be saved as an individual
#' .tif file (in out_dir) per band and inidice. The name of each .tif will be
#' layer__start_date.tif.
#' @param cores Numeric. Number of cores to pass to gdalcubes configuration for
#' "GDAL_NUM_THREADS".
#' @param force_new Logical. If a band already exists in out_dir, recreate it?
#' @param attempts Numeric. Occasionally, `rstac::get_request()` or
#' `rstac::items_fetch()` returns no items (probably due to issues with
#' `source_url`). If this is the case, retry up to `attempts` times to return
#' the appropriate items.
#' @param sleep Numeric. Time in seconds to wait between `attempts`.
#' @param gdalcubes_config List in the form of key = value pairs suitable for
#' `gdalcubes::gdalcubes_set_gdal_config()`. Also see
#' https://gdalcubes.github.io/source/concepts/config.html. These configuration
#' settings attempt to "improve computation times and I/O or network transfer
#' performance".
#' @param ... Passed to `gdalcubes::write_tif()`. Arguments, `x`, `dir`,
#' `prefix` and `pack` are already passed though, so attempting to use those
#' via dots will fail.
#'
#' @return If save_cube = FALSE, a data cube proxy object. If save_cube = TRUE,
#' invisible(NULL) and .tif file in out_dir for every time period, and layer or
#' indice, requested
#' @export
#'
#' @example inst/examples/get_sat_data_ex.R
  get_sat_data <- function(x
                           , start_date = "2013-03-01"
                           , end_date = paste0(as.numeric(format(Sys.Date(), "%Y")) - 1, "-12-31")
                           , out_dir = NULL
                           , source_url = "https://explorer.sandbox.dea.ga.gov.au/stac"
                           , collections = c("ga_ls9c_ard_3", "ga_ls8c_ard_3")
                           , period = "P1M"
                           , property_filter = NULL
                           , aggregation_func = "median"
                           , resampling_method = "bilinear"
                           , layers = c("green", "blue", "red")
                           , excludes = "nbar_" # no longer needed?
                           , indices = list(gdvi = c("green", "nir")
                                            , ndvi = c("nir", "red")
                                            )
                           , mask = list(band = "oa_fmask"
                                         , mask = c(2, 3)
                                         )
                           , save_cube = FALSE
                           , cores = 1
                           , force_new = FALSE
                           , attempts = 1
                           , sleep = 5 # seconds to wait between failed get_request calls
                           , gdalcubes_config = list(VSI_CACHE = "TRUE"
                                                     , GDAL_CACHEMAX = "5%"
                                                     , VSI_CACHE_SIZE = "100000000"
                                                     , GDAL_HTTP_MULTIPLEX = "YES"
                                                     , GDAL_INGESTED_BYTES_AT_OPEN = "32000"
                                                     , GDAL_DISABLE_READDIR_ON_OPEN = "EMPTY_DIR"
                                                     , GDAL_HTTP_VERSION = "2"
                                                     , GDAL_HTTP_MERGE_CONSECUTIVE_RANGES = "YES"
                                                     , GDAL_NUM_THREADS = cores
                                                     )
                           , ...
                         ) {

    # gdalcubes config--------
    purrr::iwalk(gdalcubes_config
                 , \(x, idx) gdalcubes::gdalcubes_set_gdal_config(as.character(idx), as.character(x))
                 )

    # bbox ------
    if(! "spatRaster" %in% class(x)) x <- terra::rast(x)

    x_bbox_latlong <- sf::st_bbox(x) %>%
      sf::st_as_sfc() %>%
      sf::st_transform(crs = 4326) %>% # need decimal lat/long for rstac
      sf::st_bbox()

    # rtac qry-------
    items <- NULL

    counter <- 0

    while(!any(!is.null(items$features), counter > attempts)) {

      if(counter > 0) Sys.sleep(sleep)

      items <- rstac::stac(source_url) %>%
        rstac::stac_search(collections = collections
                           , bbox = x_bbox_latlong
                           , datetime = paste0(as.character(start_date)
                                               , "/"
                                               , as.character(end_date)
                                               )
                           ) %>%
        rstac::get_request() %>%
        rstac::items_fetch() # fetch makes sure all items are returned (not just first x items)

      counter <- counter + 1

      message("attempt: "
              , counter
              , ". features: "
              , length(items$features)
              )

    }


    # collection ------

    if(!is.null(items$features)) {

      needed_layers <- items %>%
        rstac::items_assets() %>%
        grep(paste0(unique(c(layers, unname(unlist(indices)))), collapse = "|"), ., value = TRUE) %>%
        grep(paste0(excludes, collapse = "|"), ., value = TRUE, invert = TRUE)

      safe_collection <- purrr::safely(gdalcubes::stac_image_collection)

      col <- safe_collection(items$features
                             , asset_names = c(needed_layers, mask$band)
                             , property_filter = property_filter
                             )

      if(is.null(col$error)) {

        col <- col$result

      } else col <- NULL


      if(!is.null(col)) {

        # cube view------
        use_extent <- c(as.list(sf::st_bbox(x))
                        , t0 = as.character(start_date)
                        , t1 = as.character(end_date)
                        )

        names(use_extent)[1:4] <- c("left", "bottom", "right", "top")

        v_num <- gdalcubes::cube_view(srs = paste0("EPSG:", terra::crs(x, describe = T)$code)
                                      , dx = terra::res(x)[1]
                                      , dy = terra::res(x)[2]
                                      , dt = period
                                      , extent = use_extent
                                      , aggregation = aggregation_func
                                      , resampling = resampling_method
                                      )

        if(!is.null(mask$band)) {

          cloud_mask <- gdalcubes::image_mask(mask$band
                                              , values = mask$mask
                                              ) # clouds and cloud shadows

        }


        if(save_cube) {

        fs::dir_create(out_dir)

        # process layers------

          if(is.null(layers)) layers <- NA

        purrr::walk(needed_layers[grepl(paste0(layers, collapse = "|"), needed_layers)] # needed_layers includes any layers needed for the indices
                    , \(this_layer) {

                      message(paste0(this_layer
                                     , " "
                                     , start_date
                                     )
                              )

                      out_file <- fs::path(out_dir
                                           , paste0(gsub("nbart_", "", this_layer)
                                                    , "__"
                                                    , start_date
                                                    , ".tif"
                                                    )
                                           )

                      run <- if(!file.exists(out_file)) TRUE else force_new

                      if(run) {

                        safe_select_band <- purrr::safely(gdalcubes::select_bands)

                        ## cube_view layers-------

                        r <- gdalcubes::raster_cube(col
                                                    , v_num
                                                    , mask = if(exists("cloud_mask")) cloud_mask else NULL
                                                    ) %>%
                          safe_select_band(this_layer)

                        if(!is.null(r$result)) {

                          gdalcubes::write_tif(r$result
                                               , dir = dirname(out_file)
                                               , prefix = paste0(gsub("nbart_", "", this_layer)
                                                                 , "__"
                                                                 )
                                               , pack = list(type = "int16"
                                                             , scale = 1
                                                             , offset = 0
                                                             , nodata = -999
                                                             )
                                               , ...
                                               )

                        }

                      }

                    }

                    )


        # process indices-------

        purrr::iwalk(indices
                     , \(x, idx) {

                       message(paste0(idx
                                     , " "
                                     , start_date
                                     )
                              )

                       out_file <- fs::path(out_dir
                                            , paste0(idx
                                                     , "__"
                                                     , start_date
                                                     , ".tif"
                                                     )
                                            )

                       run <- if(!file.exists(out_file)) TRUE else force_new

                       if(run) {

                         # this deals with 'nbart_'
                         x[[1]] <- grep(x[[1]], needed_layers, value = TRUE)
                         x[[2]] <- grep(x[[2]], needed_layers, value = TRUE)

                         ## cube_view indices -------

                         r <- gdalcubes::raster_cube(col
                                                     , v_num
                                                     , mask = cloud_mask
                                                     ) %>%
                           gdalcubes::select_bands(c(x[[1]], x[[2]])) %>%
                           gdalcubes::apply_pixel(paste0("("
                                                         , x[[1]]
                                                         , "-"
                                                         , x[[2]]
                                                         , ")/("
                                                         , x[[1]]
                                                         , "+"
                                                         , x[[2]]
                                                         , ") * 10000"
                                                         )
                                                  , names = idx
                                                  )

                         gdalcubes::write_tif(r
                                              , dir = dirname(out_file)
                                              , prefix = paste0(idx
                                                                , "__"
                                                                )
                                              , pack = gdalcubes::pack_minmax(type = "int16"
                                                                              , scale = 1
                                                                              , offset = 0
                                                                              , nodata = -32768
                                                                              )
                                              , ...
                                              )

                       }

                     }
                     )

        } else {

          # cube only ------

          cube <- gdalcubes::raster_cube(col
                                         , v_num
                                         , mask = if(exists("cloud_mask")) cloud_mask else NULL
                                         )


        }

      }

    }

  if(!save_cube) cube else return(invisible(NULL))

  }


