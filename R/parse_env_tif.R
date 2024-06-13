

#' Parse meta data in raster paths used among `env` packages.
#'
#' @param x Either dataframe with path(s) to parse (in `path_col`) or character
#' vector of path(s) to search.
#' @param path_col Character. Name of column in `df` with with paths.
#' @param cube Logical. If `TRUE` paths are assumed to follow
#' `raster/cube_period/env-naming/band_start-date.tif`, otherwise
#' `raster/aligned/aoi-buffer-res/env-naming.tif`. Both the base directory and
#' file name are used in both cases.
#' @param ras_type Character. e.g. "tif". More than one can be provided but if
#' `make` then the `ras_type[1]` is used for `out_file` file type.
#' @param make Logical. If `FALSE` an `out_file` path will be returned rather
#' than parsed. Assumes the appropriately names columns are supplied in `df`.
#'
#' @return For cube paths, tibble with columns:
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
#'   \item{path}{Full (relative) path including `ras_type`.}
#' }
#' For static paths, tibble with columns:
#' \describe{
#'  \item{season}{Season into which summary was made.}
#'   \item{epoch}{Date range (years) into which summary was made.}
#' }
#'
#' If `make`, `df` with additional column `out_file`
#' @export
#'
#' @examples
parse_env_tif <- function(x
                          , path_col = "path"
                          , cube = TRUE
                          , ras_type = c("\\.tif", "\\.nc")
                          , make = FALSE
                          , ...
                          ) {

  df <- if(!"data.frame" %in% class(x)) {

      dir(x
          , full.names = TRUE
          , pattern = paste0(ras_type, collapse = "|")
          ) |>
        tibble::enframe(name = NULL
                        , value = "path"
                        )

    } else x

  if(!make) {

    if(cube) {

      res <- df |>
        dplyr::filter(grepl(paste0(ras_type, collapse = "|"), path)) |>
        dplyr::mutate(cube = gsub("cube__", "", basename(dirname(dirname(path))))
                      , context = basename(dirname(path))
                      , file = stringr::str_replace_all(basename(path)
                                                        , paste0(ras_type, collapse = "|")
                                                        , ""
                                                        )
                      ) |>
        tidyr::separate(cube
                        , into = c("period", "res")
                        , sep = "__"
                        ) |>
        tidyr::separate(context
                        , into = c("source", "collection", "layer", "aoi", "buffer")
                        , sep = "__"
                        ) |>
        tidyr::separate(file
                        , into = c("band", "start_date")
                        , sep = "__"
                        ) |>
        dplyr::relocate(-path)

    } else {

      res <- df |>
        dplyr::mutate(context = basename(dirname(path))
                      , file = gsub("\\.nc$|\\.tif$", "", basename(path))
                      ) |>
        tidyr::separate(file
                        , into = c("source", "collection", "resolution", "epoch", "season", "band")
                        , sep = "__"
                        ) |>
        tidyr::separate(context
                        , into = c("vector", "aoi", "buffer", "res")
                        , sep = "__"
                        ) |>
        dplyr::relocate(-path)

    }

  } else {

    if(cube) {

      res <- df |>
        dplyr::mutate(cube = "cube") %>%
        tidyr::unite("cube"
                     , cube
                     , period
                     , res
                     , sep = "__"
                     ) %>%
        tidyr::unite("dir"
                     , source
                     , collection
                     , layer
                     , aoi
                     , buffer
                     , sep = "__"
                     ) %>%
        tidyr::unite("out_file"
                     , band
                     , start_date
                     , sep = "__"
                     ) %>%
        dplyr::mutate(out_file = fs::path(cube
                                          , dir
                                          , paste0(out_file
                                                   , "."
                                                   , gsub("\\."
                                                          , ""
                                                          , ras_type[1]
                                                          )
                                                   )
                                          )
                      )

    } else {

      res <- df |>
        tidyr::unite("file"
                     , source
                     , collection
                     , res
                     , epoch
                     , season
                     , band
                     , sep = "__"
                     ) |>
        tidyr::unite("dir"
                     , vector
                     , aoi
                     , buffer
                     , res
                     , sep = "__"
                     ) |>
        dplyr::mutate(out_file = fs::path(dir
                                          , paste0(out_file
                                                   , "."
                                                   , gsub("\\."
                                                          , ""
                                                          , ras_type[1]
                                                          )
                                                   )
                                          )
                      )

    }

  }

  return(res)

}
