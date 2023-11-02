

#' Parse meta data in raster paths used among `env` packages.
#'
#' @param x Either dataframe with path(s) to parse (in `col`) or character
#' vector of path(s) to search.
#' @param col Character. Name of column in `df` with with paths.
#' @param cube Logical. If `TRUE` paths are assumed to follow
#' `raster/cube_period/env-naming/band-start_date.tif`, otherwise
#' `raster/aligned/aoi-buffer-res/env-naming.tif`. Both the base directory and
#' file name are used in both cases.
#'
#' @return Dataframe. For cube paths, dataframe with columns:
#' \describe{
#'   \item{source}{e.g. `DEA` is digital earth Austrlia}
#'   \item{collection}{e.g. `ga_ls8c_ard_3` is landsat 8 collection in DEA}
#'   \item{aoi}{Area of interest}
#'   \item{buffer}{Any buffer around area of interest}
#'   \item{res}{Resolution of output raster in units of rasters crs}
#'   \item{layer}{Band or layer name}
#'   \item{start_date}{Start date for layer}
#'   \item{period}{Period represented within layer using ISO8601-compliant time
#'   period for regular data cubes. e.g., "P16D" for 16 days}
#'   \item{type}{File type of `path`.}
#'   \item{path}{Full (relative) path including `tif`.}
#' }
#' For static paths, dataframe with columns:
#' \describe{
#'  \item{season}{Season into which summary was made.}
#'   \item{epoch}{Date range (years) into which summary was made.}
#' }
#' @export
#'
#' @examples
parse_env_tif <- function(x
                          , col = "path"
                          , cube = TRUE
                           , ...
                           ) {

  df <- if(!"data.frame" %in% class(x)) {

    dir(x
        , full.names = TRUE
        ) |>
      tibble::enframe(name = NULL, value = "path")

  } else x


  if(cube) {

    res <- df |>
      dplyr::filter(grepl("nc$|tif$", path)) |>
      dplyr::mutate(period = gsub("cube__", "", basename(dirname(dirname(path))))
                    , context = basename(dirname(path))
                    , file = gsub("\\.nc$|\\.tif$", "", basename(path))
                    ) |>
      tidyr::separate(context
                      , into = c("source", "collection", "aoi", "buffer", "res")
                      , sep = "__"
                      ) |>
      tidyr::separate(file
                      , into = c("band", "start_date")
                      , sep = "__"
                      ) |>
      dplyr::relocate(-period
                      ) |>
      dplyr::relocate(-path)

  } else {

    res <- df |>
      dplyr::filter(grepl("nc$|tif$", path)) |>
      dplyr::mutate(context = basename(dirname(path))
                    , file = gsub("\\.nc$|\\.tif$", "", basename(path))
                    ) |>
      tidyr::separate(file
                      , into = c("source", "collection", "res", "epoch", "season", "band")
                      , sep = "__"
                      ) |>
      tidyr::separate(context
                      , into = c("aoi", "buffer", "res_II")
                      , sep = "__"
                      ) |>
      dplyr::select(-tidyselect::matches("_II")) |>
      dplyr::relocate(-path)

  }

  return(res)

}
