
#' Add cell to df with lat/long
#'
#'
#' @param ras SpatRaster, or path to raster (needs to be path if running in
#' parallel), with cell numbers to extract
#' @param df Dataframe with x/y columns
#' @param x,y Character. Name of columns in `df` with x and y coordinates
#' @param crs_df Single length vector. What crs are x and y?
#' @param add_xy Logical. Generate (centroid) x and y coords from cell? If TRUE,
#' these will be returned as `cell_x` and `cell_y`.
#' @param return_old_xy Logical. If true, the original x and y values will be
#' returned as `old_x` and `old_y`.
#' @param add_val Logical. If true the value(s) for cell will be extracted.
#' @param force_new Logical. If there is already a column `cell` in `df`, remove
#' it first?
#'
#' @return `df` with additional column `cell` with cell numbers from x and,
#' dependent on: `add_xy` columns `x` and `y`; and `add_val` any values from
#' `ras`.
#' @export
#'
#' @example inst/examples/add_raster_cell_ex.R
add_raster_cell <- function(ras
                            , df
                            , x = "long"
                            , y = "lat"
                            , crs_df = 4326
                            , add_xy = FALSE
                            , return_old_xy = FALSE
                            , add_val = FALSE
                            , force_new = FALSE
                            ) {

  if(! "SpatRaster" %in% class(ras)) ras <- terra::rast(ras)

  if(! "data.frame" %in% class(df)) df <- tibble::as_tibble(df)

  old_x <- paste0("old_", x)
  old_y <- paste0("old_", y)

  df <- df %>%
    dplyr::rename(!!rlang::ensym(old_x) := !!rlang::ensym(x)
                  , !!rlang::ensym(old_y) := !!rlang::ensym(y)
                  ) %>%
    {if(force_new) (.) %>% dplyr::select(!tidyselect::matches("^cell$")) else (.)}

  df_xy <- df %>%
    dplyr::distinct(!!rlang::ensym(old_x)
                    , !!rlang::ensym(old_y)
                    ) %>%
    dplyr::filter(!is.na(!!rlang::ensym(old_x))
                  , !is.na(!!rlang::ensym(old_y))
                  )

  points <- df_xy %>%
    sf::st_as_sf(coords = c(old_x, old_y)
                 , crs = crs_df
                 , remove = FALSE
                 ) %>%
    sf::st_transform(crs = terra::crs(ras)) %>%
    dplyr::bind_cols(tibble::as_tibble(sf::st_coordinates(.)) %>%
                       dplyr::rename(old_x_ras = X, old_y_ras = Y)
                     ) %>%
    sf::st_set_geometry(NULL)

  cells <- terra::cellFromXY(ras
                             , as.matrix(points[c("old_x_ras", "old_y_ras")])
                             )

  res <- points %>%
    dplyr::mutate(cell = cells)

  if(add_xy) {

    new_x <- paste0("cell_", x)
    new_y <- paste0("cell_", y)

    xy_res <- terra::xyFromCell(ras
                                , cells
                                ) %>%
      tibble::as_tibble() %>%
      dplyr::bind_cols(cell = cells) %>%
      dplyr::filter(!is.na(x)
                    , !is.na(y)
                    ) %>%
      sf::st_as_sf(coords = c("x","y")
                   , crs = terra::crs(ras)
                   ) %>%
      sf::st_transform(crs = crs_df) %>%
      dplyr::mutate(!!rlang::ensym(new_x) := sf::st_coordinates(.)[,1]
                    , !!rlang::ensym(new_y) := sf::st_coordinates(.)[,2]
                    ) %>%
      sf::st_set_geometry(NULL) %>%
      unique()

    res <- merge(res, xy_res) %>%
      tibble::as_tibble()

  }

  if(add_val) {

    cell_val <- terra::extract(ras
                               , cells
                               ) %>%
      tibble::as_tibble() %>%
      dplyr::bind_cols(cell = cells)

    res <- merge(res, cell_val) %>%
      tibble::as_tibble()

  }

  res <- df %>%
    dplyr::left_join(res) %>%
    dplyr::select(cell
                  , everything()
                  , -tidyselect::matches("old.*ras")
                  ) %>%
    {if(!return_old_xy) (.) %>% dplyr::select(-tidyselect::contains("old")) else (.)} %>%
    tibble::as_tibble()

  return(res)

}
