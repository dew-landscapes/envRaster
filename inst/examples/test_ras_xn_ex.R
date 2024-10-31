  #library(envRaster)

  out_dir <- file.path(system.file(package = "envRaster"), "examples")

  base_file <- fs::path(out_dir, "cube", "base.tif")

  if(!file.exists(base_file)) {

    make_base_grid(aoi
                   , out_res = 30
                   , out_epsg = 8059
                   , out_file = base_file
                   , datatype = "INT1U"
                   , overwrite = TRUE
                   )
  }

  base <- terra::rast(base_file)

  test_ras_xn(base, base)

  test_ras_xn(base
              , system.file("ex/meuse.tif", package="terra")
              )
