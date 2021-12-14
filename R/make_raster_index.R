#' Make raster indices
#'
#' e.g. ndvi
#'
#' @param stars_obj stars object
#' @param func index
#' @param season summer, winter etc
#' @param epoch e.g. 10-19
#' @param layer default 1.
#' @param out_dir directory to save results to
#' @param func_indexes NULL. or index of bands that are need by `func`
#' @param out_type tif
#' @param sum_func how to summarise over years in epoch
#' @param cores Passed to `parallel::makeCluster` for `st_apply`
#' @param ...
#'
#' @return Side effect of saving index raster to disk
#' @export
#'
#' @examples
  make_raster_index <- function(stars_obj
                              , func = "ndvi"
                              , season = NA
                              , epoch = NA
                              , layer = 1L
                              , out_dir
                              , force_new = FALSE
                              , func_indexes = NULL
                              , out_type = "tif"
                              , sum_func = "mean"
                              , clus_obj = NULL
                              , ...
                              ) {



    if(!"stars" %in% class(stars_obj)) stop("stars_obj needs to be a stars object")

    if(isTRUE(is.null(func_indexes))) {

      if(!all(formalArgs(func)[1:2] %in% attributes(stars_obj)$dimensions$band$values)) {

        stop("stars_obj needs to have band values in formals(func)")

      } else {

        library("envRaster")
        arg_a <- names(rlang::fn_fmls(get(func)))[1]
        arg_b <- names(rlang::fn_fmls(get(func)))[2]
        ind_a <- which(attributes(stars_obj)$dimensions$band$values == arg_a)
        ind_b <- which(attributes(stars_obj)$dimensions$band$values == arg_b)

      }

    } else {

      ind_a <- func_indexes[1]
      ind_b <- func_indexes[2]

    }

    do_sum_func <- get(sum_func)

    ind <- stars::st_apply(stars_obj %>%
                             dplyr::slice("band", c(ind_a,ind_b))
                    , MARGIN = c("x", "y", "year")
                    , FUN = func
                    , CLUSTER = if(!is.null(clus_obj)) clus_obj else NULL
                    , single_arg = FALSE
                    , .fname = func
                    ) %>%
      stars::st_apply(c("x", "y")
                      , function(x) 10000 * do_sum_func(x, na.rm = TRUE)
                      , CLUSTER = if(!is.null(clus_obj)) clus_obj else NULL
                      )

    out_file <- fs::path(out_dir
                         , paste0(func
                                  , "_"
                                  , layer
                                  , "_"
                                  , sum_func
                                  , "_"
                                  , season
                                  , "_"
                                  , epoch
                                  , "."
                                  , out_type
                                  )
                         )

    stars::write_stars(ind
                       , out_file
                       , ...
                       )

  }






