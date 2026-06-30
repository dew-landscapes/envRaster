#' Add information from `ras_layers` to a dataframe
#'
#' @param df Dataframe with column `col`
#' @param col Character. Name of column in `col` containing information to match
#' to `ras_layers`. This is usually the `name` column resulting from
#' `envRaster::name_env_tif()` with argument `make_name` set to `TRUE`.
#'
#' @returns tibble with extra columns from `envRaster::ras_layers`
#' @export
#'
#' @examples
env_add_info <- function(df
                         , col = "name"
                         ) {

  df$name <- df[[col]]

  df |>
    dplyr::mutate(layer = gsub("__.*", "", name)) |>
    dplyr::left_join(envRaster::ras_layers |>
                       dplyr::filter(! grepl("--", collection))
                     )

}
