#' Make a spatRaster from a vector of paths
#'
#' Allows for some degree of matching extent; settings a window (using the aoi);
#' and recoding categorical raster(s) to no more than cat_pred_levels.
#'
#' @param predictors Character. Paths to rasters.
#' @param is_env_pred Logical. Does the naming follow that described by
#' `envRaster::name_env_tif()`
#' @param aoi sf. Used in `terra::window()`
#' @param cat_pred_levels Named list. Usually `prep$cat_pred_levels()` resulting
#' from `envSDM::prep_sdm()`
#'
#' @returns spatRaster
#' @export
#'
#' @examples
make_env_stack <- function(predictors
                           , is_env_pred = TRUE
                           , aoi = NULL
                           , cat_pred_levels = NULL
                           ) {

  stack_desc <- predictors |>
    tibble::enframe(name = NULL, value = "path") |>
    dplyr::mutate(r = purrr::map(path, terra::rast)
                  , ncell = purrr::map_dbl(r, \(x) terra::ncell(x))
                  , extent = purrr::map(r, \(x) terra::ext(x))
                  , xmin = purrr::map_dbl(extent, \(x) x$xmin)
                  , xmax = purrr::map_dbl(extent, \(x) x$xmax)
                  , ymin = purrr::map_dbl(extent, \(x) x$ymin)
                  , ymax = purrr::map_dbl(extent, \(x) x$ymax)
                  ) |>
    dplyr::select(- r, - extent)

  unstackable <- stack_desc |>
    dplyr::anti_join(stack_desc |>
                       dplyr::count(dplyr::across(tidyselect::where(is.numeric))) |>
                       dplyr::filter(n == max(n)) |>
                       dplyr::select(- n)
                     )

   if(nrow(unstackable)) {

     warning(paste0(unstackable$path, collapse = "\n")
             , "\n"
             , if(nrow(unstackable) > 1) " are " else " is "
             , "not stackable with the other "
             , nrow(stack_desc) - nrow(unstackable)
             , " layers. Specified layers will not be used"
             )

   }

  stack <- stack_desc |>
    dplyr::anti_join(unstackable) |>
    dplyr::pull(path) |>
    terra::rast()

  if(is_env_pred) {

    names(stack) <- envRaster::name_env_tif(tibble::tibble(path = predictors[! predictors %in% unstackable$path]), parse = TRUE) |>
      dplyr::pull(name)

  }

  if(! is.null(aoi)) {

    if(sf::st_crs(aoi) != sf::st_crs(stack)) {

      aoi <- aoi |>
        terra::vect() |>
        terra::densify(50000) |>
        sf::st_as_sf() |>
        sf::st_transform(crs = sf::st_crs(stack)) |>
        sf::st_make_valid()

    }

    terra::window(stack) <- terra::ext(aoi |> sf::st_transform(crs = sf::st_crs(stack)))

  }

  if(!is.null(cat_pred_levels)) {

    for(x in names(cat_pred_levels)) {

      to_drop <- match(x, names(stack))

      temp_stack <- stack[[- to_drop]]

      rcl <- tibble::tibble(from_vals <- cat_pred_levels[[x]]$old_nr
                            , to_vals <- cat_pred_levels[[x]]$new_nr
                            ) |>
        as.matrix()

      new_cat <- terra::classify(stack[[x]]
                                 , rcl = rcl
                                 )

      levels(new_cat) <- tibble::tibble(id = sort(unique(rcl[,2]))
                                        , !!rlang::ensym(x) := sort(unique(rcl[,2]))
                                        )

      stack <- c(temp_stack, new_cat)

    }

  }

  return(stack)

}
