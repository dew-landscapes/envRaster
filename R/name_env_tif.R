

#' Use meta data to name raster cube paths/files
#'
#' Either create file path for saving a cube or parse the meta data from a cube
#'
#' @param x Either dataframe with path(s) to parse (in column `path`), character
#' vector of path(s) to search, or named list.
#' @param dir_only Logical. Are full file paths provided (or required) or just a
#' directory?
#' @param skips Character. When parsing, skip (filter) any files with a match to
#' skips
#' @param prefixes Character. If x is a named list, any name prefixes to remove
#' before matching to naming structure.
#' @param file_type Character. e.g. "tif". More than one can be provided but if
#' `parse` then `file_type[1]` is used for `out_file` file type.
#' @param parse Logical. If `FALSE` an `out_file` path will be returned rather
#' than parsed. Assumes the appropriately names columns are supplied in `df`.
#' @param fill_null Logical. If `TRUE`, will fill up to `x_null` definitions
#' with NULL (and issue a warning).
#' @param x_null Numeric. Even if `fill_null` is `TRUE`, if there are more than
#' `x_null` missing definitions, an error will be thrown.
#' @param extent,grain,collection,layer Character vectors for
#' naming the meta data stored in file paths.
#' @param make_name Logical. If TRUE a column 'name' will be added to the
#' output in a format suitable for use in model formulas.
#'
#'
#' @return If `!parse`, tibble with (default) columns:
#' \describe{
#'   \item{polygons}{Vector layer originally used to define area of interest}
#'   \item{filt_col}{Column name from vector to filter to define area of interest}
#'   \item{level}{Level(s) of filt_col originally filtered to define area of interest}
#'   \item{buffer}{Any buffer around area of interest}
#'   \item{period}{Period represented within layer using ISO8601-compliant time
#'   period for regular data cubes. e.g., "P16D" for 16 days}
#'   \item{res}{Resolution of output raster in units of rasters crs}
#'   \item{source}{e.g. `DEA` is digital earth Austrlia}
#'   \item{collection}{e.g. `ga_ls8c_ard_3` is landsat 8 collection in DEA}
#'   \item{layer}{Band or layer name}
#'   \item{start_date}{Start date for layer}
#'   \item{file_type}{File type of `path`.}
#'   \item{path}{Full (relative) path including `file_type`.}
#'   \item{name}{A name that should be safe to use in model formulas:
#'   `paste0(layer, "__", gsub("-", "",start_date))`}
#' }
#'
#' If `!parse`, `df` with additional column `out_file`
#'
#' @export
#'
#' @example inst/examples/name_env_tif_ex.R
#'
name_env_tif <- function(x
                         , dir_only = FALSE
                         , skips = c("base")
                         , prefixes = c("sat", "use")
                         , file_type = c("\\.tif$", "\\.nc$")
                         , parse = FALSE
                         , fill_null = FALSE
                         , x_null = 3
                         , extent = c("vector"
                                      , "filt_col"
                                      , "filt_level"
                                      , "buffer"
                                      , "extent_time"
                                      )
                         , grain = c("res_x"
                                     , "res_y"
                                     , "grain_time"
                                     , "run_time"
                                     )
                         , collection = c("source"
                                          , "collection"
                                          )
                         , layer = c("layer"
                                     , "func"
                                     , "start_date"
                                     , "file_type"
                                     )
                         , make_name = TRUE
                         ) {

  df <- if(!"data.frame" %in% class(x)) {

    if("character" %in% class(x)) {

      if(isTRUE(dir.exists(x))) {

        dir(x
            , full.names = TRUE
            , recursive = TRUE
            ) %>%
          tibble::enframe(name = NULL
                          , value = "path"
                          ) %>%
          dplyr::filter(grepl(paste0(file_type, collapse = "|")
                              , path
                              )
                        )

      } else {

        tibble::tibble(path = x)

      }

    } else if("list" %in% class(x)) {

      get_names <- gsub(paste0("^", prefixes, "_", collapse = "|")
                        , ""
                        , names(x)
                        ) %in% c(extent, grain
                                 , collection, layer
                                 )

      x[get_names] %>%
        purrr::map(paste0, collapse = "--") %>%
        list2DF() %>%
        tibble::as_tibble() %>%
        purrr::set_names(gsub(paste0("^", prefixes, "_", collapse = "|"), "", names(.)))

    }

  } else x

  if(parse) {

      res <- df %>%
        {if(dir_only) (.) else (.) %>% dplyr::filter(!grepl(paste0(skips, collapse = "|"), path))} %>%
        dplyr::mutate(extent = if(!dir_only) basename(dirname(dirname(dirname(path)))) else basename(dirname(dirname(path)))
                      , grain = if(!dir_only) basename(dirname(dirname(path))) else  basename(dirname(path))
                      , collection = if(!dir_only) basename(dirname(path)) else basename(path)
                      , file = if(!dir_only) file = basename(path) else NULL
                      ) %>%
        tidyr::separate_wider_delim(extent
                                    , names = extent
                                    , delim = "__"
                                    ) %>%
        tidyr::separate(grain
                        , into = grain
                        , sep = "__"
                        ) %>%
        tidyr::separate(collection
                        , into = collection
                        , sep = "__"
                        )

      if(!dir_only) {

        res <- res %>%
          tidyr::separate(file
                        , into = layer
                        , sep = "__|\\."
                        ) %>%
          {if(make_name) (.) %>% dplyr::mutate(name = purrr::pmap_chr(dplyr::across(tidyselect::any_of(layer[1:(length(layer) - 1)]))
                                                                      , paste
                                                                      , sep = "__"
                                                                      )
                                               , name = gsub("-", "", name)
                                               ) else (.)
            }

      }

      if("path" %in% names(res)) {

        res <- res %>%
          dplyr::relocate(-path)

      }

  } else {

    if(fill_null) {

      # check all names are in df

      missing <- setdiff(c(extent
                           , grain
                           , collection
                           , if(!dir_only) layer
                           )
                         , names(df)
                         )

      if(length(missing) > x_null) {

        stop(length(missing)
             , " definitions are missing: "
             , envFunc::vec_to_sentence(missing)
             )

      }

      warning("All of "
              , envFunc::vec_to_sentence(missing)
              , " will be NULL"
              )

      if(length(missing)) {

        df <- cbind(df
                    , purrr::map(missing
                                 , \(x) tibble::tibble(!!rlang::ensym(x) := list(NULL))
                                 )
                    )

      }

    }

    res <- df %>%
      tidyr::unite("extent"
                  , tidyselect::any_of(extent)
                   , sep = "__"
                   ) %>%
      tidyr::unite("grain"
                   , tidyselect::any_of(grain)
                   , sep = "__"
                   ) %>%
      tidyr::unite("collection"
                   , tidyselect::any_of(collection)
                   , sep = "__"
                   ) %>%
      {if(dir_only) (.) |> dplyr::mutate(layer = "") else (.) %>% tidyr::unite("layer"
                                                                               , tidyselect::any_of(layer[!layer == "file_type"])
                                                                               , sep = "__"
                                                                               )
        } %>%
      dplyr::mutate(out_file = fs::path(extent
                                        , grain
                                        , collection
                                        , layer
                                        )
                    ) %>%
      {if(dir_only) (.) else (.) %>%
          dplyr::mutate(out_file = fs::path(out_file
                                            , paste0(layer
                                                     , "."
                                                     , gsub("\\\\\\."
                                                            , ""
                                                            , file_type[1]
                                                            )
                                                     )
                                            )
                        )
      }

    res <- res %>%
      dplyr::mutate(dplyr::across(tidyselect::where(is.character)
                                  , \(x) gsub("NULL", "", x)
                                  )
                    )

  }

  if(dir_only) res <- res %>%
    dplyr::rename(out_dir = out_file)

  return(res)

}
