#' Make raster indices
#'
#' e.g. ndvi
#'
#' @param X stars object
#' @param func index
#' @param season summer, winter etc
#' @param epoch e.g. 10-19
#' @param layer default 1.
#' @param out_dir directory to save results to
#' @param func_indexes NULL. or index of bands that are need by `func`
#' @param out_type tif
#' @param sum_func how to summarise over years in epoch
#' @param clus_obj `parallel::makeCluster` object passed to `st_apply`
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
  make_raster_index <- function(X
                              , func = "ndvi"
                              , season = NA
                              , epoch = NA
                              , layer = 1L
                              , out_dir
                              , force_new = FALSE
                              , func_indexes = NULL
                              , out_type = "tif"
                              , sum_func = "mean"
                              , clus_obj
                              , ...
                              ) {

    if(!"stars" %in% class(X)) stop("X needs to be a stars object")

    if(isTRUE(is.null(func_indexes))) {

      if(!all(formalArgs(func)[1:2] %in% attributes(X)$dimensions$band$values)) {

        stop("X needs to have band values in formals(func)")

      } else {

        arg_a <- names(rlang::fn_fmls(get(func)))[1]
        arg_b <- names(rlang::fn_fmls(get(func)))[2]
        ind_a <- which(attributes(X)$dimensions$band$values == arg_a)
        ind_b <- which(attributes(X)$dimensions$band$values == arg_b)

        }

    } else {

      ind_a <- func_indexes[1]
      ind_b <- func_indexes[2]

    }

    do_sum_func <- get(sum_func)

    ind <- stars::st_apply(X = X[,,,c(ind_a,ind_b)]
                    , c("x", "y", "year")
                    , FUN = func
                    , CLUSTER = clus_obj
                    ) %>%
      stars::st_apply(c("x", "y")
                      , function(x) 10000 * do_sum_func(x, na.rm = TRUE)
                      , CLUSTER = clus_obj
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






