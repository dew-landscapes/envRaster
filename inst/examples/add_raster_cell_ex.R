
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

  # random sample of points within the aoi
  sample <- matrix(nrow = 2, ncol = 2) %>% # include some NA x and y values
    rbind(sf::st_sample(aoi, 100) %>%
            sf::st_transform(crs = 4326) %>%
            sf::st_coordinates()
          ) %>%
    tibble::as_tibble() %>%
    dplyr::mutate(attribute = sample(letters[1:10], nrow(.), replace = TRUE))

  # add just cell to sample
  add_raster_cell(base
                  , sample
                  , x = "X"
                  , y = "Y"
                  )

  # add cell and cell centroids to sample
  add_raster_cell(base
                  , sample
                  , add_xy = TRUE
                  , x = "X"
                  , y = "Y"
                  )

  # add cell, cell centroids and original 'x' and 'y' to sample
  add_raster_cell(base
                  , sample
                  , add_xy = TRUE
                  , return_old_xy = TRUE
                  , x = "X"
                  , y = "Y"
                  )

  # add cell, cell centroids, cell values and original 'x' and 'y' to sample
  add_raster_cell(base
                  , sample
                  , add_xy = TRUE
                  , return_old_xy = TRUE
                  , add_val = TRUE
                  , x = "X"
                  , y = "Y"
                  )


