#' Add information from `ras_layers` to a dataframe
#'
#' @param df Dataframe with column `col`
#' @param col Character. Name of column in `col` containing information to match
#' to `ras_layers`. This is usually the `name` column resulting from
#' `envRaster::name_env_tif()` with argument `make_name` set to `TRUE`.
#' @param env_df Dataframe, usually resulting from a call to
#' `envRaster::prepare_env()`
#' @param make_id Logical. Create a column suitable for use as id in
#' `system.file("rmd/sources.Rmd", package = "envRaster")`
#'
#' @returns tibble with extra columns from `envRaster::ras_layers`,
#' `envRaster::ras_source`, and, if supplied, `env_df`. Possibly with `env_id`
#' column added if `make_id`.
#' @export
#'
#' @examples
env_add_info <- function(df
                         , col = "name"
                         , env_df = NULL
                         , make_id = TRUE
                         ) {

  df$name <- df[[col]]

  res <- df |>
    dplyr::mutate(layer = gsub("__.*", "", name)) |>
    dplyr::left_join(envRaster::ras_layers |>
                       dplyr::filter(! grepl("--", collection))
                     ) |>
    dplyr::left_join(envRaster::ras_source)

  if(!is.null(env_df)) {

    res <- res |>
      dplyr::left_join(env_df)

  }

  if(make_id) {

    res <- res |>
      dplyr::mutate(env_id = gsub("[[:punct:]]", "", name))

  }

  return(res)

}
