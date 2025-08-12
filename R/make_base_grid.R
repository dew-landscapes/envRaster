

#' Make a .tif file with appropriate extent, resolution and crs
#'
#' Probably won't work well with decimal degress out_epsg
#'
#' @param aoi sf from which an extent will be defined for the base grid
#' @param out_res Numeric. Desired resolution of the base grid
#' @param out_epsg Numeric. Appropriate [epsg](https://epsg.io/) code to define
#' the coordinate reference system for the base grid
#' @param lcm Numeric. Least common multiple. The extent of the resulting base
#' grid will be divisible by lcm. Default 9000 is dervied by
#' numbers::mLCM(c(1, 2, 3, 4, 5, 10, 20, 30, 50, 90, 100, 500, 1000))
#' @param name Character. Name of the layer in the base grid
#' @param values Used to fill the base grid
#' @param use_mask sf. Values in the bast grid outside of use_mask will be NA
#' @param out_file Character. Path into which to save the base grid
#' @param ret Character. If not "path", will return the resulting spatRaster. If
#'  "path", will return `out_file`. If `out_file` is `NULL` `ret` is "object".
#' @param ... Passed to `terra::writeRaster()`. Usually datatype = "INT1U" and,
#' maybe, gdal = c("COMPRESS=NONE")
#'
#' @return spatRaster or path. If out_file supplied, the base grid is written to
#' out_file
#' @export
#'
#' @example inst/examples/get_sat_data_ex.R
  make_base_grid <- function(aoi
                             , out_res = 90
                             , out_epsg = 8059
                             , lcm = 9000
                             , name = "base"
                             , use_mask = NULL
                             , out_file = NULL
                             , values = 1
                             , ret = "object"
                             , ...
                             ) {

    if(is.null(out_file)) ret <- "object"

    if(! "sf" %in% class(aoi)) stop("aoi is class "
                                    , class(aoi)
                                    , " but class sf required"
                                    )

    # round extent to km
    aoi_extent <- aoi %>%
      sf::st_transform(crs = out_epsg) %>%
      sf::st_bbox() %>%
      round(-3)

    # ew and ns distance
    aoi_ew <- as.numeric(aoi_extent$xmax - aoi_extent$xmin)
    aoi_ns <- as.numeric(aoi_extent$ymax - aoi_extent$ymin)

    # a function to make sure x is divisible by m (x will be changed)
    round_up <- function(x, m) m * ceiling(x / m)

    # find new distance so that it will be divisible by lcm
    ew_dist <- round_up(aoi_ew, lcm)
    ns_dist <- round_up(aoi_ns, lcm)

    # mid points of original ew and ns
    ew_mid <- (aoi_extent$xmax + aoi_extent$xmin) / 2
    ns_mid <- (aoi_extent$ymax + aoi_extent$ymin) / 2

    # build new raster using extent based on mid points + or - half new distance
    b <- terra::rast(crs = paste0("epsg:", out_epsg)
                     , xmin = ew_mid - (ew_dist / 2)
                     , xmax = ew_mid + (ew_dist / 2)
                     , ymin = ns_mid - (ns_dist / 2)
                     , ymax = ns_mid + (ns_dist / 2)
                     , resolution = out_res
                     , vals = values
                     , names = name
                     )

    if(!is.null(use_mask)) {

      stopifnot("sf" %in% class(use_mask))

      b <- b %>%
        terra::mask(use_mask)

    }

    if(!is.null(out_file)) {

      fs::dir_create(dirname(out_file))

      terra::writeRaster(b
                         , out_file
                         , ...
                         )

    }

    return(if(ret != "path") b else out_file)

  }
