
if(!exists("bioclim")) source("data-raw/bioclim.R")
if(!exists("climate")) source("data-raw/climate.R")
if(!exists("soil")) source("data-raw/soil.R")

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
    rep("NCI", nrow(bioclim)),

    # coast distance
    "ABS",

    # wofs
    "DEA",

    # tc
    rep("DEA", 3),

    # watercourse
    "DEW"

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
    rep("ANUClimate2", nrow(bioclim)),

    # coast distance
    "AUS_2021_AUST_SHP_GDA2020",

    # wofs
    "ga_ls_wo_fq_cyear_3",

    # tc
    rep("ga_ls_tc_pc_cyear_3", 3),

    # watercourse
    "water_lines"

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

    # bioclim
    rep("derived", nrow(bioclim)),

    # coast distance
    "distance",

    # wofs
    "frequency",

    # tc
    rep("percent", 3),

    # watercourse
    "distance"

  )

  # layer ---------
  , layer = c(

    # third satellite stack
    "coastal_aerosol", "blue", "green", "red",
    "nir", "swir_1", "swir_2",
    "ndvi", "ndwi", "nbr", "ndmi", "nbr2",

    # climate
    climate$layer,

    # fourth climate stack
    ## reflectance
    "blue", "green", "red",
    "nir", "swir_1", "swir_2",
    ## indices
    "ndvi", "ndwi", "nbr", "ndmi", "nbr2",
    ## variability
    "edev", "sdev", "bcdev",

    #bioclim
    bioclim$layer,

    # coast distance
    "coast",

    # wofs
    "frequency",

    # tc
    "wet_pc_10", "wet_pc_50", "wet_pc_90",

    # watercourse
    "watercourse"

  )

  # method (function) ----------
  # now in file path

  # units -------
  , units = c(

    # third satellite stack
    rep(NA, 12),

    # climate
    climate$units,

    # fourth satellite stack
    rep(NA, 14),

    # bioclim
    bioclim$units,

    # coast distance
    "metres",

    # wofs
    NA,

    # tc
    rep("%", 3),

    # watercourse distance
    "metres"

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
    rep(NA, nrow(bioclim)),

    # coast distance
    NA,

    # wofs
    NA,

    # tc
    rep(10000, 3),

    # watercourse distance
    NA

  )

  # description ---------
  , description = c(

    # third satellite stack
    ## surface reflectance
    "coastal aerosol (band 1) with wavelength 0.43-0.45 µm",
    "blue (band 2) with wavelength 0.450-0.515 µm",
    "green (band 3) with wavelength 0.53-0.59 µm",
    "red (band 4) with wavelength 0.64-0.67 µm",
    "near infrared (band 5) with wavelength 0.85-0.88 µm",
    "shortwave infrared 1 (band 6) with wavelength 1.57-1.65 µm",
    "shortwave infrared 2 (band 7) with wavelength 2.11-2.29 µm",
    ## indices
    "normalised difference vegetation index", "normalized difference water index",
    "normalized burn ratio", "normalized difference moisture index",
    "normalized burned ratio index 2",

    # climate
    climate$description,

    # fourth satellite stack
    ## reflectance
    "blue (band 2) with wavelength 0.450-0.515 µm",
    "green (band 3) with wavelength 0.53-0.59 µm",
    "red (band 4) with wavelength 0.64-0.67 µm",
    "near infrared (band 5) with wavelength 0.85-0.88 µm",
    "shortwave infrared 1 (band 6) with wavelength 1.57-1.65 µm",
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
    bioclim$description,

    # coast distance
    "distance in metres from the coast",

    # wofs
    "how often surface water was observed by satellite",

    # tc
    "tasseled cap wetness index 10th percentile",
    "tasseled cap wetness index 50th percentile",
    "tasseled cap wetness index 90th percentile",

    # watercourse distance
    "distance in metres from a watercourse"

  )

  # indicates --------
  , indicates = c(

    # third satellite stack
    ## reflectance
    "water quality parameters like chlorophyll concentration, sediment levels, and phytoplankton blooms in coastal and inland waters",
    "penetrates water to a greater depth than other visible light bands and assists in differentiating vegetation types",
    "soil colour, green cover",
    "soil colour, green cover",
    "chlorophyll has high reflectivity",
    "assessing vegetation and soil moisture",
    "assessing vegetation and soil moisture and assists to differentiate rocks and soils that may appear similar in other bands",
    ## indices
    "green cover, productivity",
    "green cover in dryland environment",
    "identify burned areas and provide a measure of burn severity",
    "highlight water sensitivity in vegetation",
    "more sensitive to changes in water content within vegetation than NBR, water stress",

    # climate
    climate$indicates,

    # fourth climate stack
    ## reflectance
    "creating natural-color images; penetrates water to a greater depth than other visible light bands and assists in differentiating vegetation types",
    "creating natural-color images; healthy vegetation absorbs most red light",
    "creating natural-color images; mapping vegetation; analyzing water quality",
    "healthy vegetation reflects most nir light",
    "assessing vegetation and soil moisture",
    "assessing vegetation and soil moisture; assists to differentiate rocks and soils that may appear similar in other bands",
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
    bioclim$indicates,

    # coast distance
    "exposure to factors like salt spray and wind",

    # wofs
    "surface water",

    # tc
    "helps characterise: vegetated wetlands, salt flats, salt lakes and coastal land cover classes. Occaasionally wet",
    "helps characterise: vegetated wetlands, salt flats, salt lakes and coastal land cover classes. Frequently wet",
    "helps characterise: vegetated wetlands, salt flats, salt lakes and coastal land cover classes. Often wet",

    # watercourse distance
    "access to water, at least ephemerally"

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
    rep(NA, nrow(bioclim)),

    # coast distance
    NA,

    # wofs
    NA,

    # tc
    rep("transforms the six spectral bands of Landsat into three indexes describing greenness, wetness and brightness [wetness used here]. These indexes can be used to help understand complex ecosystems, such as wetlands or groundwater dependent ecosystems. Percentiles are used in preference to minimum, maximum and mean, as the min/max/mean statistical measures are more sensitive to undetected cloud/cloud shadow, and can be misleading for non-normally distributed data."
        , 3
        ),
    # watercourse distance
    NA

  )

  # method reference --------
  , method_ref = c(

    # third satellite stack
    rep(NA, 12),

    # climate
    climate$method_ref,

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
    rep("https://gepinillab.github.io/fastbioclim/", nrow(bioclim)),

    # coast distance
    "https://rspatial.github.io/terra/reference/distance.html",

    # wofs
    "https://doi.org/10.1016/j.rse.2015.11.003",

    # tc
    rep("https://doi.org/10.1016/0034-4257(85)90102-6", 3),

    # watercourse distance
    "https://rspatial.github.io/terra/reference/distance.html"
  )

  # data reference ---------
  , data_ref = c(

    # third satellite stack
    rep("https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3"
        , 12
        ),

    # climate
    climate$method_ref, # data_ref is the same as method_ref in this case

    # fourth satellite stack
    ## reflectance and indices
    rep("https://knowledge.dea.ga.gov.au/notebooks/DEA_products/DEA_GeoMAD/", 14),

    # bioclim
    rep("https://dx.doi.org/10.25914/60a10aa56dd1b", nrow(bioclim)),

    # coast distance
    "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files#downloads-for-gda2020-digital-boundary-files",

    # wofs
    "https://docs.dea.ga.gov.au/data/product/dea-water-observations-statistics-landsat/?tab=specifications",

    # tc
    rep("https://explorer.dea.ga.gov.au/products/ga_ls_tc_pc_cyear_3", 3),

    # watercourse distance
    "https://data.sa.gov.au/data/dataset/watercourses-in-south-australia"

  )
) |>
  dplyr::bind_rows(soil)
