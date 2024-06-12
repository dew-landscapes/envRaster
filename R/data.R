#' Lookup for sources of raster data
#'
#'
#' @format A data frame with `r nrow(ras_source)` rows and `r ncol(ras_source)` variables:
#' \describe{
#'   \item{source}{Short name of `source`}
#'   \item{source_name}{Full name of `source`}
#'   \item{source_url}{URL for `source`}
#'   \item{source_notes}{Notes about `source`}
#'   ...
#' }
"ras_source"

#' Lookup for collections of raster data
#'
#'
#' @format A data frame with `r nrow(ras_collection)` rows and `r ncol(ras_collection)` variables:
#' \describe{
#'   \item{source}{Short name of `source`}
#'   \item{type}{What sort of data is provided in the `collection`?}
#'   \item{collection}{Name of the `collection` within `source`}
#'   \item{coll_name}{Full name of the `collection` within `source`}
#'   \item{collection_url}{URL for `collection`}
#'   \item{collection_notes}{Notes about `collection`}
#'   ...
#' }
"ras_collection"
