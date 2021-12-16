

#' Make and fix common problems with raster indices
#'
#' e.g. `envRaster::ndvi`
#'
#' @param index function to calculate
#' @param sum_func how to summarise index if more than one value is returned
#' @param rm_na passed to `sum_func` `na.rm` argument (which also means
#' `sum_func` needs an `na.rm` argument)
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
make_index <- function(index = "ndvi"
                       , sum_func = mean
                       , rm_na = TRUE
                       ,  ...
                       ) {

  res <- R.utils::doCall(index
                         , ...
                         )

  if(length(res) > 1) res <- sum_func(res, na.rm = rm_na)

  if(!is.finite(res)) res <- NA

  return(res)

}
