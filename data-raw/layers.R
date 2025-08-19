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
    "coastal_aerosol", "blue", "green", "red",
    "swir_1", "swir_2", "nir",
    "ndvi", "ndwi", "nbr", "ndmi", "nbr2",

    # climate
    "evap", "rain", "tavg", "tmax", "tmin", "vpd",

    # fourth climate stack
    ## reflectance
    "blue", "green", "red",
    "swir_1", "swir_2", "nir",
    ## indices
    "ndvi", "ndwi", "nbr", "ndmi", "nbr2",
    ## variability
    "edev", "sdev", "bcdev",

    #bioclim
    bioclim$layer
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
    bioclim$units

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
    ## surface reflectance
    "coastal aerosol (band 1) with wavelength	0.43-0.45 µm",
    "blue (band 2) with wavelength 0.450-0.515 µm",
    "green (band 3) with wavelength 0.53-0.59 µm",
    "red (band 4) with wavelength 0.64-0.67 µm",
    "near infrared (band 5) with wavelength 0.85-0.88 µm",
    "shortwave infrared 1 (band 6) with wavelength	1.57-1.65 µm",
    "shortwave infrared 2 (band 7) with wavelength 2.11-2.29 µm",
    ## indices
    "normalised difference vegetation index", "normalized difference water index",
    "normalized burn ratio", "normalized difference moisture index",
    "normalized burned ratio index 2",

    # climate
    "monthly class A pan evaporation",
    "monthly total rainfall", "monthly average temperature", "monthly maximum temperature",
    "monthly minimum temperature", "monthly vapour pressure deficit",

    # fourth satellite stack
    ## reflectance
    "blue (band 2) with wavelength 0.450-0.515 µm",
    "green (band 3) with wavelength 0.53-0.59 µm",
    "red (band 4) with wavelength 0.64-0.67 µm",
    "near infrared (band 5) with wavelength 0.85-0.88 µm",
    "shortwave infrared 1 (band 6) with wavelength	1.57-1.65 µm",
    "shortwave infrared 2 (band 7) with wavelength 2.11-2.29 µm",
    ## indices
    "normalised difference vegetation index",
    "normalized difference water index", "normalized burn ratio",
    "normalized difference moisture index", "normalized burned ratio index 2",
    ## variability
    "euclidean distance (edev)",
    "cosine (spectral) distance (sdev)",
    "Bray Curtis dissimilarity (bcdev)",

    # bioclim
    bioclim$description
  )

  # indicates --------
  , indicates = c(

    # third satellite stack
    ## reflectance
    "water quality parameters like chlorophyll concentration, sediment levels, and phytoplankton blooms in coastal and inland waters",
    "penetrates water to a greater depth than other visible light bands and assists in differentiating vegetation types",
    "soil colour, green cover",
    "soil colour, green cover",
    "assessing vegetation and soil moisture",
    "assessing vegetation and soil moisture and assists to differentiate rocks and soils that may appear similar in other bands",
    "chlorophyll has high reflectivity",
    ## indices
    "green cover, productivity",
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
    ## reflectance
    "creating natural-color images; penetrates water to a greater depth than other visible light bands and assists in differentiating vegetation types",
    "creating natural-color images; healthy vegetation absorbs most red light",
    "creating natural-color images; mapping vegetation; analyzing water quality",
    "assessing vegetation and soil moisture",
    "assessing vegetation and soil moisture; assists to differentiate rocks and soils that may appear similar in other bands",
    "healthy vegetation reflects most nir light",
    ## indices
    "indicates levels of photosynthesis",
    "enhances the visibility of water features",
    "indicates bare ground (and recently burnt areas)",
    "indicates plant health, particularly in relation to water stress",
    "more sensitive to changes in water content within vegetation than NBR, water stress",
    ## variability
    "indicates variability in albedo (reflectance) of a pixel across all bands",
    "invariant to albedo (reflectance) changes across all bands (e.g. can be used to track water bodies which have high variation in reflectance)",
    "variation from the mean in terms of distance based on factors such as brightness and spectra",

    # bioclim
    bioclim$indicates
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
    "https://dx.doi.org/10.25914/60a10b02a7ea8", "https://dx.doi.org/10.25914/60a10acd183a2",
    "https://dx.doi.org/10.25914/60a10ae960313", "https://dx.doi.org/10.25914/60a10addedcf8",
    "https://dx.doi.org/10.25914/60a10ae350889", "https://dx.doi.org/10.25914/60a10af667bbe",

    # fourth satellite stack
    ## reflectance
    rep("https://knowledge.dea.ga.gov.au/data/product/dea-geometric-median-and-median-absolute-deviation-landsat/?tab=description#technical-information", 6),
    ## indices
    rep(NA, 5),
    ## variability
    "https://docs.digitalearthafrica.org/en/latest/data_specs/GeoMAD_specs.html#Euclidean-MAD-(EMAD)",
    "https://docs.digitalearthafrica.org/en/latest/data_specs/GeoMAD_specs.html#Spectral-MAD-(SMAD)",
    "https://docs.digitalearthafrica.org/en/latest/data_specs/GeoMAD_specs.html#Bray-Curtis-MAD-(BCMAD)",

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
    ## reflectance and indices
    rep("https://knowledge.dea.ga.gov.au/notebooks/DEA_products/DEA_GeoMAD/", 14),

    # bioclim
    rep("https://dx.doi.org/10.25914/60a10aa56dd1b", nrow(bioclim))

  )
)
