
  # source -----

  ras_source <- tibble::tribble(
    ~source, ~source_name, ~source_url, ~source_notes,
    "DEA", "Digital Earth Australia", "https://www.dea.ga.gov.au/", NA_character_,
    "NCI", "National Computational Infrastructure", "https://nci.org.au/", NA_character_,
    "DEW", "South Australian Department for Environment and Water", "https://environment.sa.gov.au", NA_character_,
    "ABS", "Australian Bureau of Statistics", "https://www.abs.gov.au/", NA_character_
  )


  # collection ------

  ras_collection <- tibble::tribble(
   ~collection, ~coll_name, ~coll_url, ~coll_notes,

    # distance -------
    "distance_to", "distance in metres to various landscape features", NA_character_, NA_character_,

    # GeoMAD -------
    "ga_ls8cls9c_gm_cyear_3",
      "DEA Geometric Median and Median Absolute Deviation (Landsat)",
      "https://knowledge.dea.ga.gov.au/notebooks/DEA_products/DEA_GeoMAD/", NA_character_,

    # Landsat 5 -------
    "ga_ls5t_ard_3",
      "Geoscience Australia Landsat 5 Thematic Mapper Analysis Ready Data Collection 3",
      "https://explorer.dev.dea.ga.gov.au/products/ga_ls5t_ard_3", NA_character_,

    # Landsat 7 -------
    "ga_ls7e_ard_3",
      "Geoscience Australia Landsat 7 Enhanced Thematic Mapper Plus Analysis Ready Data Collection 3",
      "https://explorer.dev.dea.ga.gov.au/products/ga_ls7e_ard_3", NA_character_,

    # Landsat 8 -------
    "ga_ls8c_ard_3",
      "Geoscience Australia Landsat 8 Operational Land Imager and Thermal Infra-Red Scanner Analysis Ready Data Collection 3",
      "https://explorer.sandbox.dea.ga.gov.au/products/ga_ls8c_ard_3", NA_character_,

    # Landsat 9 -------
    "ga_ls9c_ard_3",
      "Geoscience Australia Landsat 9 Operational Land Imager and Thermal Infra-Red Scanner Analysis Ready Data Collection 3",
      "https://explorer.dev.dea.ga.gov.au/products/ga_ls9c_ard_3", NA_character_,


    # WOFS -------
    "ga_ls_wo_fq_myear_3",
      "Geoscience Australia Landsat Water Observations Frequency Multi Year Collection 3",
      "https://explorer.dea.ga.gov.au/products/ga_ls_wo_fq_myear_3", NA_character_,

    # Barest earth -------
    "landsat_barest_earth",
      "Landsat 30+ Barest Earth",
      "https://explorer.dev.dea.ga.gov.au/products/landsat_barest_earth", NA_character_,

    # Climate -------
    "ANUClimate2",
      "Monthly mean climate data from at least 1970 to present. Rainfall grids are generated from 1900 to the present",
      "https://geonetwork.nci.org.au/geonetwork/srv/eng/catalog.search#/metadata/f2576_7854_4065_1457", NA_character_

  )

  # layers  ------

  ras_layers <- source("data-raw/layers.R")[[1]] |>
    tibble::as_tibble()
