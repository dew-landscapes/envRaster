
#' Test for intersection of two rasters
#'
#' Actually tests for the intersection of the extent of each raster
#'
#' @param a,b raster as SpatRaster or path to raster
#'
#' @return Logical
#' @export
#'
#' @example inst/examples/test_ras_xn_ex.R
test_ras_xn <- function(a, b){

  if(! "SpatRaster" %in% class(a)) a <- terra::rast(a)
  if(! "SpatRaster" %in% class(b)) b <- terra::rast(b)

  ext_a <- terra::ext(a) %>%
    terra::as.polygons()

  terra::crs(ext_a) <- terra::crs(a)

  ext_b <- terra::ext(b) %>%
    terra::as.polygons()

  terra::crs(ext_b) <- terra::crs(b)

  ext_b <- ext_b %>%
    terra::project(y = terra::crs(a))

  int <- terra::intersect(ext_a, ext_b)

  ratio <- terra::expanse(ext_a) / terra::expanse(int)

  if(isTRUE(ratio > 0)) TRUE else FALSE

}
