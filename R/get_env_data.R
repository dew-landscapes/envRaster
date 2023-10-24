

#' Get raster values for each unique location in a data frame.
#'
#'
#'
#' @param ras Either SpatRaster or path(s) from which to create SpatRaster.
#' @param df Dataframe with `x` and `y`.
#' @param x,y Columns in `df` with x and y coordinates.
#' @param crs_df Coordinate reference system for `x` and `y`. Passed to the
#' `crs` argument of [sf::st_as_sf()].
#'
#' @return `out_file` written to disk and corresponding dataframe with columns
#' \itemize{
#'   \item{`x`}{Same as `x`.}
#'   \item{`y`}{Same as `y`.}
#'   \item{name}{Concept being extracted - often the same as `file`.}
#'   \item{value}{Value of the raster at `x` and `y` coordinates.}
#'   \item{layer}{Layer from multiband raster. Will be `1` for single band
#'   raster.}
#'   \item{source}{Full path to raster.}
#'   \item{file}{filename component of `source`.}
#' }
#' @export
#'
#' @examples
get_env_data <- function(ras
                         , df
                         , x = "long"
                         , y = "lat"
                         , crs_df = 4326
                         ) {

  if(!"SpatRaster" %in% class(ras[[1]])) {

    ras <- terra::rast(ras)

  }

  crs_ras <- crs(ras)

  layer_names <- tibble::tibble(name = names(ras)
                                , source = terra::sources(ras
                                                          , bands = TRUE
                                                          )
                                ) %>%
    tidyr::unnest(cols = c(source)) %>%
    dplyr::rename(layer = bands)

  points <- df %>%
    dplyr::distinct(!!rlang::ensym(x), !!rlang::ensym(y)) %>%
    na.omit() %>%
    dplyr::mutate(ID = row_number()) %>%
    sf::st_as_sf(coords = c(x, y)
                 , crs = crs_df
                 , remove = FALSE
                 ) %>%
    sf::st_transform(crs = crs_ras) %>%
    dplyr::bind_cols(as_tibble(sf::st_coordinates(.)) %>%
                       dplyr::rename(ras_x = X, ras_y = Y)
                     ) %>%
    sf::st_set_geometry(NULL)


  points_spatvect <- points %>%
    terra::vect(crs = crs_ras
                , geom = c("ras_x", "ras_y")
                )

  pts_ext <- terra::extract(ras
                            , y = points_spatvect
                            )

  res <- pts_ext %>%
    tibble::as_tibble() %>%
    dplyr::left_join(points %>%
                       dplyr::select(ID
                                     , !!rlang::ensym(x)
                                     , !!rlang::ensym(y)
                                     )
                     ) %>%
    dplyr::select(!!rlang::ensym(x)
                  , !!rlang::ensym(y)
                  , layer_names$name
                  ) %>%
    tidyr::pivot_longer(layer_names$name) %>%
    dplyr::left_join(layer_names) %>%
    dplyr::mutate(file = basename(source)) %>%
    dplyr::select(-source, -file, -sid, everything(), file, source)

  return(res)

}

