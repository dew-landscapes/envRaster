
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


