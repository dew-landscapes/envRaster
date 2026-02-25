
#' Add 'bin' to dataframe with coordinates
#'
#' Direct descendant of `envRaster::add_raster_cell()`. Adding `cell` is now
#' optional (and defaults to `FALSE`).
#'
#' @param ras SpatRaster, or path to raster (needs to be path if running in
#' parallel), with cell numbers to extract
#' @param df Dataframe with x/y columns
#' @param x,y Character. Name of columns in `df` with x and y coordinates
#' @param crs_df Single length vector. What crs are x and y?
#' @param add_xy Logical. Generate (centroid) x and y coords from cell? If TRUE,
#' these will be returned as `cell_x` and `cell_y` where 'x' and 'y' are as
#' defined by arguments `x` and `y`.
#' @param add_cell Logical. Add the cell id to the data frame?
#' @param return_old_xy Logical. If true, the original x and y values will be
#' returned as `old_x` and `old_y` where 'x' and 'y' are as per arguments `x`
#' and `y`.
#' @param add_val Logical. If true the value(s) for cell will be extracted using
#' `terra::extract()`.The names of any columns resulting from `add_val` will be
#' the same as the names in `ras`.
#'
#' @return `df` (as tibble) with additional column(s):
#' * `cell` with cell numbers from `ras`, if `add_cell`
#' * `cell_[x]` and `cell_[y]`, if `add_xy`
#' * If `add_val` any values from `ras`
#' Irrespective of the crs of `ras`, any returned x and y values will be in
#' `crs_df`.  If `return_old_xy` is `FALSE`, the original `x` and `y` columns
#' will be dropped.
#' @export
#'
#' @example inst/examples/add_raster_bin_ex.R
add_raster_bin <- function(ras
                            , df
                            , x = "long"
                            , y = "lat"
                            , crs_df = 4326
                            , add_xy = TRUE
                            , add_cell = ! add_xy
                            , return_old_xy = FALSE
                            , add_val = FALSE
                            ) {

  old_x <- paste0("old_", x)
  old_y <- paste0("old_", y)
  new_x <- paste0("cell_", x)
  new_y <- paste0("cell_", y)

  return_cols <- names(df)[!names(df) %in% c(x, y, old_x, old_y, new_x, new_y)]

  if(add_xy) return_cols <- c(return_cols, new_x, new_y)
  if(add_val) return_cols <- c(return_cols, names(ras))
  if(add_cell) return_cols <- c(return_cols, "cell")
  if(return_old_xy) return_cols <- c(return_cols, old_x, old_y)
  return_cols <- unique(return_cols)

  if(! "SpatRaster" %in% class(ras)) ras <- terra::rast(ras)

  if(! "data.frame" %in% class(df)) df <- tibble::as_tibble(df)

  df <- df |>
    dplyr::rename(!!rlang::ensym(old_x) := !!rlang::ensym(x)
                  , !!rlang::ensym(old_y) := !!rlang::ensym(y)
                  )

  df_xy <- df |>
    dplyr::distinct(!!rlang::ensym(old_x)
                    , !!rlang::ensym(old_y)
                    ) |>
    dplyr::filter(!is.na(!!rlang::ensym(old_x))
                  , !is.na(!!rlang::ensym(old_y))
                  ) |>
    dplyr::arrange(!!rlang::ensym(old_x)
                   , !!rlang::ensym(old_y)
                   )

  points <- df_xy |>
    envFunc::project_df(x = old_x
                        , y = old_y
                        , new_x = "old_x_ras"
                        , new_y = "old_y_ras"
                        , crs_from = paste0("epsg:", crs_df)
                        , crs_to = paste0("epsg:", terra::crs(ras, describe = TRUE)$code)
                        )

  cells <- terra::cellFromXY(ras
                             , as.matrix(points[c("old_x_ras", "old_y_ras")])
                             )

  res <- points |>
    dplyr::mutate(cell = cells)

  if(add_xy) {

    res <- terra::xyFromCell(ras
                             , cells
                             ) |>
      tibble::as_tibble() |>
      dplyr::bind_cols(res) |>
      envFunc::project_df(x = "x"
                          , y = "y"
                          , new_x = new_x
                          , new_y = new_y
                          , crs_from = paste0("epsg:", terra::crs(ras, describe = TRUE)$code)
                          , crs_to = paste0("epsg:", crs_df)
                          )

  }

  if(add_val) {

    res <- terra::extract(ras
                          , cells
                          ) |>
      dplyr::bind_cols(res) |>
      tibble::as_tibble()

  }

  res <- df |>
    dplyr::left_join(res) |>
    dplyr::select(tidyselect::all_of(return_cols)) |>
    dplyr::select(tidyselect::matches("cell")
                  , everything()
                  ) |>
    tibble::as_tibble()

  return(res)

}
