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
#' @param cores Passed to `parallel::makeCluster` for `st_apply`
#' @param ...
#'
#' @return Side effect of saving index raster to disk
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
                              , func_indexes
                              , out_type = "tif"
                              , sum_func = "mean"
                              , clus_obj = NULL
                              , ...
                              ) {



    if(!"stars" %in% class(X)) stop("X needs to be a stars object")

    do_sum_func <- get(sum_func)

    ind_a <- func_indexes[1]
    ind_b <- func_indexes[2]

    ind <- stars::st_apply(X = X[,,,c(ind_a,ind_b)]
                    , c("x", "y", "year")
                    , FUN = func
                    , CLUSTER = if(!is.null(clus_obj)) clus_obj else NULL
                    , single_arg = FALSE
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






