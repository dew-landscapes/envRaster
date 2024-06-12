
  # source -----

  ras_source <- tibble::tribble(
    ~source, ~source_name, ~source_url, ~source_notes,
    "DEA", "Digital Earch Australia", "https://www.dea.ga.gov.au/", NA_character_,
    "NCI", "National Computational Infrastructure", "https://nci.org.au/", NA_character_
  )


  # collection ------

  ras_collection <- tibble::tribble(
    ~source, ~type, ~collection, ~coll_name, ~coll_url, ~coll_notes,

    # Landsat 5
    "DEA", "baseline satellite data", "ga_ls5t_ard_3",
      "Geoscience Australia Landsat 5 Thematic Mapper Analysis Ready Data Collection 3",
      "https://explorer.dev.dea.ga.gov.au/products/ga_ls5t_ard_3", NA_character_,

    # Landsat 7
    "DEA", "baseline satellite data", "ga_ls7e_ard_3",
      "Geoscience Australia Landsat 7 Enhanced Thematic Mapper Plus Analysis Ready Data Collection 3",
      "https://explorer.dev.dea.ga.gov.au/products/ga_ls7e_ard_3", NA_character_,

    # Landsat 8
    "DEA", "baseline satellite data", "ga_ls8c_ard_3",
      "Geoscience Australia Landsat 8 Operational Land Imager and Thermal Infra-Red Scanner Analysis Ready Data Collection 3",
      "https://explorer.sandbox.dea.ga.gov.au/products/ga_ls8c_ard_3", NA_character_,

    # Landsat 9
    "DEA", "baseline satellite data", "ga_ls9c_ard_3",
      "Geoscience Australia Landsat 9 Operational Land Imager and Thermal Infra-Red Scanner Analysis Ready Data Collection 3",
      "https://explorer.dev.dea.ga.gov.au/products/ga_ls9c_ard_3", NA_character_,


    # WOFS
    "DEA", "inland water", "ga_ls_wo_fq_myear_3",
      "Geoscience Australia Landsat Water Observations Frequency Multi Year Collection 3",
      "https://explorer.dea.ga.gov.au/products/ga_ls_wo_fq_myear_3", NA_character_,

    # Barest earth
    "DEA", "land and vegetation", "landsat_barest_earth",
      "Landsat 30+ Barest Earth",
      "https://explorer.dev.dea.ga.gov.au/products/landsat_barest_earth", NA_character_,

    # Indices
    "DEA", "derived satellite indices", "ga_ls8c_ard_3--ga_ls9c_ard_3",
    "GDVI, NDVI, NBR and NBR2",
    NA_character_, "(a - b) / (a + b)",

    # Climate
    "NCI", "climate", "ANUClimate",
      "Monthly mean climate data from at least 1970 to present. Rainfall grids are generated from 1900 to the present",
      "https://geonetwork.nci.org.au/geonetwork/srv/eng/catalog.search#/metadata/f2576_7854_4065_1457", NA_character_

  )


  # layer -------

  if(FALSE) {

    ras_layer <- tibble::tribble(
      ~source, ~type, ~layer, ~layer_name, ~units, ~layer_notes,

      # Satellite
      "DEA", "satellite", ""



    )

  }
