% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/name_env_tif.R
\name{name_env_tif}
\alias{name_env_tif}
\title{Use meta data to name raster cube paths/files}
\usage{
name_env_tif(
  x,
  dir_only = FALSE,
  skips = c("base"),
  prefixes = c("sat", "use"),
  file_type = c("\\\\.tif", "\\\\.nc"),
  parse = FALSE,
  fill_null = FALSE,
  x_null = 3,
  ...,
  context_defn = c("polygons", "filt_col", "level", "buffer"),
  cube_defn = c("period", "res"),
  source_defn = c("source", "collection"),
  layer_defn = c("layer", "start_date", "file_type"),
  make_name = TRUE
)
}
\arguments{
\item{x}{Either dataframe with path(s) to parse (in column \code{path}), character
vector of path(s) to search, or named list.}

\item{dir_only}{Logical. Are full file paths provided (or required) or just a
directory?}

\item{skips}{Character. When parsing, skip (filter) any files with a match to
skips}

\item{prefixes}{Character. If x is a named list, any name prefixes to remove
before matching to naming structure.}

\item{file_type}{Character. e.g. "tif". More than one can be provided but if
\code{parse} then \code{file_type[1]} is used for \code{out_file} file type.}

\item{parse}{Logical. If \code{FALSE} an \code{out_file} path will be returned rather
than parsed. Assumes the appropriately names columns are supplied in \code{df}.}

\item{fill_null}{Logical. If \code{TRUE}, will fill up to \code{x_null} definitions
with NULL (and issue a warning).}

\item{x_null}{Numeric. Even if \code{fill_null} is \code{TRUE}, if there are more than
\code{x_null} missing definitions, an error will be thrown.}

\item{make_name}{Logical. If TRUE a column 'name' will be added to the
output in a format suitable for use in model formulas.}
}
\value{
If \code{!parse}, tibble with (default) columns:
\describe{
\item{polygons}{Vector layer originally used to define area of interest}
\item{filt_col}{Column name from vector to filter to define area of interest}
\item{level}{Level(s) of filt_col originally filtered to define area of interest}
\item{buffer}{Any buffer around area of interest}
\item{period}{Period represented within layer using ISO8601-compliant time
period for regular data cubes. e.g., "P16D" for 16 days}
\item{res}{Resolution of output raster in units of rasters crs}
\item{source}{e.g. \code{DEA} is digital earth Austrlia}
\item{collection}{e.g. \code{ga_ls8c_ard_3} is landsat 8 collection in DEA}
\item{layer}{Band or layer name}
\item{start_date}{Start date for layer}
\item{file_type}{File type of \code{path}.}
\item{path}{Full (relative) path including \code{file_type}.}
\item{name}{A name that should be safe to use in model formulas:
\code{paste0(layer, "__", gsub("-", "",start_date))}}
}

If \code{!parse}, \code{df} with additional column \code{out_file}
}
\description{
Either create file path for saving a cube or parse the meta data from a cube
}
\examples{

  #library(envRaster)

  out_dir <- file.path(system.file(package = "envRaster"), "examples")

  cube_dir <- fs::path(out_dir, "cube")

  settings <- list()

  # cube setup
  ## geographic extent
  settings$polygons <- "aoi"
  settings$filt_col <- NULL
  settings$level <- NULL
  settings$buffer <- 0
  # can be used in envFunc::make_aoi

  ## grain size
  settings$period <- "P3M"
  settings$sat_res <- 90

  ## source
  settings$source <- "DEA"
  settings$collection <- c("ga_ls9c_ard_3", "ga_ls8c_ard_3")

  ## directory
  settings$out_dir <- fs::path(cube_dir
                               , name_env_tif(settings
                                              , fill_null = TRUE
                                              , dir_only = TRUE
                                              )$out_dir
                               )

  fs::dir_create(settings$out_dir)

  # save settings
  rio::export(settings
              , fs::path(cube_dir, "settings.rds")
              )

  # go and make cube. e.g. examples in ?get_sat_data()
  tifs <- length(fs::dir_ls(settings$out_dir, regexp = "tif$"))

  if(!tifs) {

    source(fs::path(out_dir, "get_sat_data_ex.R"))

  }

  name_env_tif(settings$out_dir
               , parse = TRUE
               )


}
