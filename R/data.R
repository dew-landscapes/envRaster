#' Simple feature to define a geographic area of interest.
#'
#' `aoi` defines an area in the northern Murray Mallee in South Australia.
#'
#' @format A simple feature with `r nrow(aoi)` rows and `r ncol(aoi)` variables:
#' \describe{
#'   \item{area}{Area of simple feature in sqare metres.}
#'   \item{geometry}{List column of geometry.}
#'   ...
#' }
"aoi"

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

#' Lookup for raster layers
#'
#'
#' @format A data frame with `r nrow(ras_layers)` rows and `r ncol(ras_layers)` variables:
#' \describe{
#'   \item{source}{Short name of `source`}
#'   \item{collection}{Name of the `collection` within `source`}
#'   \item{type}{}
#'   \item{layer}{}
#'   \item{method}{}
#'   \item{season}{}
#'   \item{year_min}{}
#'   \item{year_max}{}
#'   \item{units}{}
#'   \item{description}{}
#'   \item{indicates}{}
#'   \item{notes}{}
#'   \item{ref}{}
#'   \item{data_ref}{}
#'   ...
#' }
"ras_layers"
