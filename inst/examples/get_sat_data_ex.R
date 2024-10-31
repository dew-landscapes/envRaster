
  #library(envRaster)

  out_dir <- file.path(system.file(package = "envRaster"), "examples")

  cube_dir <- fs::path(out_dir, "cube")
  settings_path <- fs::path(cube_dir, "settings.rds")

  if(!file.exists(settings_path)) {

    source(fs::path(out_dir, "name_env_tif_ex.R"))

  }

  settings <- rio::import(settings_path)

  base <- make_base_grid(aoi # aoi is sf provided with envRaster
                         , out_res = 30
                         , out_epsg = 8059
                         , out_file = fs::path(cube_dir, "base.tif")
                         , datatype = "INT1U"
                         , overwrite = TRUE
                         )

  # Can't get indices with save_cube = FALSE but can pass cube onto apply_pixel
  cube <- get_sat_data(x = base
                       , start_date = "2023-01-01"
                       , end_date = "2023-12-31"
                       , collections = c("ga_ls9c_ard_3"
                                         , "ga_ls8c_ard_3"
                                         )
                       , period = "P3M"
                       , layers = c("nir", "red")
                       , indices = NULL
                       , save_cube = FALSE
                       )

  if(FALSE) {

    # takes a minute or two
    cube %>%
      gdalcubes::apply_pixel("(nbart_nir - nbart_red) / (nbart_nir + nbart_red)", "ndvi") %>%
      gdalcubes::animate(col = viridis::viridis
                         , zlim = c(0, 1)
                         , downsample = FALSE
                         )

  }

  # Save a cube
  if(FALSE) {

    # takes a minute or two
    get_sat_data(x = base
                 , start_date = "2023-01-01"
                 , end_date = "2023-12-31"
                 , collections = settings$collection
                 , period = settings$period
                 , layers = NULL
                 , indices = list("ndvi" = c("nir", "red"))
                 , save_cube = TRUE
                 , out_dir = settings$out_dir
                 )

  }

