

#' Summarise and fix common problems with raster indices
#'
#' e.g. `envRaster::ndvi`. `Inf` or `-Inf` returned as `NA`.
#'
#' @param sum_func how to summarise index if more than one value is returned
#' @param rm_na passed to `sum_func` `na.rm` argument (which also means
#' `sum_func` needs an `na.rm` argument)
#' @param make_int Logical. If true the result is multiplied by 10000 and
#' an integer is returned.
#'
#' @return Numeric of length(1).
#' @export
#'
#' @examples
fix_index <- function(vec
                      , sum_func = mean
                      , rm_na = TRUE
                      , make_int = TRUE
                      ) {

  res <- sum_func(vec, na.rm = rm_na)

  if(!is.finite(res)) res <- NA

  if(make_int) res <- as.integer(res * 10000)

  return(res)

}
