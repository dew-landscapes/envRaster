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
#'   \item{type}{Type of layer. e.g. reflectance, indice, variability, derived}
#'   \item{layer}{A short name}
#'   \item{method}{Method used to summarise if more than one layer was available}
#'   \item{units}{Units of layer}
#'   \item{mult}{value * mult = data on original scale. Essentially irrelvant to
#'   use of the layers though}
#'   \item{description}{A slightly longer description of the layer than `layer`}
#'   \item{indicates}{Why is this layer ecologically useful?}
#'   \item{notes}{}
#'   \item{method_rf}{A reference for the method used to generate the output}
#'   \item{data_ref}{A reference for the method used to generate input layer(s)}
#'   ...
#' }
"ras_layers"
