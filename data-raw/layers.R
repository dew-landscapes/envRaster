tibble::tibble(

  # source --------
  source = c(

    # third satellite stack
    rep("DEA", 12),

    # climate
    rep("NCI", 6),

    # fourth satellite stack
    rep("DEA", 14),

    # bioclim
    rep("NCI", nrow(bioclim))

  )

  # collection ------
  , collection = c(

    # third satellite stack
    rep("ga_ls8c_ard_3--ga_ls9c_ard_3", 12),

    # climate
    rep("ANUClimate2", 6),

    # fourth satellite stack
    rep("ga_ls8cls9c_gm_cyear_3", 14),

    # bioclim
    rep("ANUClimate2", nrow(bioclim))

  )

  # type --------
  , type = c(

    # third satellite stack
    rep("surface reflectance", 7),
    rep("indice", 5),

    # climate
    rep("climate", 6),

    # fourth satellite stack
    rep("surface reflectance", 6),
    rep("indice", 5),
    rep("variability", 3),

    # biolim
    rep("derived", nrow(bioclim))

  )

  # layer ---------
  , layer = c(

    # third satellite stack
    "blue", "red", "green", "swir_1", "swir_2",
    "coastal_aerosol", "nir", "ndvi", "ndwi",
    "nbr", "ndmi", "nbr2",

    # climate
    "evap", "rain", "tavg", "tmax", "tmin", "vpd",

    # fourth climate stack
    "blue", "red", "green", "swir_1", "swir_2", "nir", "ndvi",
    "ndwi", "nbr", "ndmi", "nbr2", "sdev", "edev", "bcdev",

    #bioclim
    paste0("bio", stringr::str_pad(1:nrow(bioclim), 2, pad = 0))
  )

  # method (function) ----------
  , method = c(

    # third satellite stack
    rep("median", 12),

    # climate
    rep("mean", 6),

    # fourth satellite stack
    rep("median", 14),

    #bioclim
    rep(NA, nrow(bioclim))

  )

  # units -------
  , units = c(

    # third satellite stack
    rep(NA, 12),

    # climate
    "mm", "mm", "deg C", "deg C", "deg C", "hPa",

    # fourth satellite stack
    rep(NA, 14),

    # bioclim
    rep(NA, nrow(bioclim))

  )

  # multiplyer------
  , mult = c(

    # third satellite stack
    ## reflectance
    rep(10000, 7),
    ## indices
    rep(10000, 5),

    # climate
    rep(NA, 6),

    # fourth satellite stack
    # reflectance
    rep(10000, 6),
    ## indices & variability
    rep(NA, 8),

    # bioclim
    rep(NA, nrow(bioclim))
  )

  # description ---------
  , description = c(

    # third satellite stack
    "blue", "red", "green", "short-wave infrared 1",
    "short-wave infrared 2", "coastal aerosol", "near infrared",
    "normalised difference vegetation index", "normalized difference water index",
    "normalized burn ratio", "normalized difference moisture index",
    "normalized burned ratio index 2",

    # climate
    "monthly class A pan evaporation",
    "monthly total rainfall", "monthly average temperature", "monthly maximum temperature",
    "monthly minimum temperature", "monthly vapour pressure deficit",

    # fourth satellite stack
    "blue median", "red median", "green median", "short-wave infrared 1 median",
    "short-wave infrared 2 median", "near infrared median",
    "normalised difference vegetation index",
    "normalized difference water index", "normalized burn ratio",
    "normalized difference moisture index", "normalized burned ratio index 2",
    "euclidean distance (EMAD)", "cosine (spectral) distance (SMAD)",
    "Bray Curtis dissimilarity (BCMAD)",

    # bioclim
    bioclim$description
  )

  # indicates --------
  , indicates = c(

    # third satellite stack
    "salt, water, soil colour", "soil colour, green cover",
    "soil colour, green cover", "wetlands, green cover", "wetlands, green cover",
    "salt", "wetlands, green cover", "green cover, productivity",
    "green cover in dryland environment",
    "identify burned areas and provide a measure of burn severity",
    "highlight water sensitivity in vegetation",
    "more sensitive to changes in water content within vegetation than NBR, water stress",

    # climate
    "soil water balance, plant growth, crop yield",
    "soil water balance, plant growth, crop yield",
    "plant growth, crop yield", "temperature extremes, plant growth, crop yield",
    "temperature extremes, plant growth, crop yield",
    "hydrological cycle, plant growth, crop yield",

    # fourth climate stack
    "salt, water, soil colour", "soil colour, green cover",
    "soil colour, green cover", "wetlands, green cover", "wetlands, green cover",
    "wetlands, green cover", "green cover, productivity",
    "green cover in dryland environment",
    "identify burned areas and provide a measure of burn severity",
    "highlight water sensitivity in vegetation", "more sensitive to changes in water content within vegetation than NBR, water stress",
    "variation from the mean in terms of distance based on factors such as brightness and spectra",
    "variation from the mean in terms of distance based on factors such as brightness and spectra",
    "variation from the mean in terms of distance based on factors such as brightness and spectra",

    # bioclim
    rep(NA, nrow(bioclim))
  )

  # notes --------
  , notes = c(

    # third satellite stack
    ## reflectance
    rep("unitless", 7),
    ## indices
    "unitless. nir and red", "unitless. green and nir",
    "unitless. nir and swir_1", "unitless. nir and swir_2",
    "unitless. swir_1 and swir_2",

    # climate
    rep(NA, 6),

    # fourth satellite stack
    # reflectance
    rep("unitless", 6),
    # indices
    "unitless. nir and red", "unitless. green and nir",
    "unitless. nir and swir_1", "unitless. nir and swir_2",
    "unitless. swir_1 and swir_2",
    # variability
    rep("unitless", 3),


    # bioclim
    rep(NA, nrow(bioclim))

  )

  # method reference --------
  , method_ref = c(

    # third satellite stack
    rep(NA, 12),

    # climate
    rep(NA, 6),

    # fourth satellite stack
    rep(NA, 14),

    # bioclim
    rep("https://gepinillab.github.io/fastbioclim/", nrow(bioclim))

  )

  # data reference ---------
  , data_ref = c(

    # third satellite stack
    rep("https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3"
        , 12
        ),

    # climate
    "https://dx.doi.org/10.25914/60a10b02a7ea8", "https://dx.doi.org/10.25914/60a10acd183a2",
    "https://dx.doi.org/10.25914/60a10ae960313", "https://dx.doi.org/10.25914/60a10addedcf8",
    "https://dx.doi.org/10.25914/60a10ae350889", "https://dx.doi.org/10.25914/60a10af667bbe",

    # fourth satellite stack
    rep("https://knowledge.dea.ga.gov.au/notebooks/DEA_products/DEA_GeoMAD/", 14),

    # bioclim
    rep(NA, nrow(bioclim))

  )
)
