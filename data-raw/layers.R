tibble::tibble(

  source = c("DEA", "DEA", "DEA", "DEA", "DEA",
"DEA", "DEA", "DEA", "DEA", "DEA", "DEA", "DEA", "NCI", "NCI",
"NCI", "NCI", "NCI", "NCI", "DEA", "DEA", "DEA", "DEA", "DEA",
"DEA", "DEA", "DEA", "DEA", "DEA", "DEA", "DEA", "DEA", "DEA",
"NCI", "NCI", "NCI", "NCI", "NCI", "NCI"
)

, collection = c("ga_ls8c_ard_3, ga_ls9c_ard_3", "ga_ls8c_ard_3, ga_ls9c_ard_3",
"ga_ls8c_ard_3, ga_ls9c_ard_3", "ga_ls8c_ard_3, ga_ls9c_ard_3",
"ga_ls8c_ard_3, ga_ls9c_ard_3", "ga_ls8c_ard_3, ga_ls9c_ard_3",
"ga_ls8c_ard_3, ga_ls9c_ard_3", "ga_ls8c_ard_3, ga_ls9c_ard_3",
"ga_ls8c_ard_3, ga_ls9c_ard_3", "ga_ls8c_ard_3, ga_ls9c_ard_3",
"ga_ls8c_ard_3, ga_ls9c_ard_3", "ga_ls8c_ard_3, ga_ls9c_ard_3",
"ANUClimate2", "ANUClimate2", "ANUClimate2", "ANUClimate2", "ANUClimate2",
"ANUClimate2", "ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3",
"ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3",
"ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3",
"ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3",
"ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3", "ga_ls8cls9c_gm_cyear_3",
"ANUClimate2", "ANUClimate2", "ANUClimate2", "ANUClimate2", "ANUClimate2",
"ANUClimate2"
)

, type = c("surface reflectance", "surface reflectance", "surface reflectance",
"surface reflectance", "surface reflectance", "surface reflectance",
"surface reflectance", "indice", "indice", "indice", "indice",
"indice", "climate", "climate", "climate", "climate", "climate",
"climate", "surface reflectance", "surface reflectance", "surface reflectance",
"surface reflectance", "surface reflectance", "surface reflectance",
"indice", "indice", "indice", "indice", "indice", "variability",
"variability", "variability",
"climate", "climate", "climate", "climate", "climate",
"climate"
)

, layer = c("blue", "red", "green",
"swir_1", "swir_2", "coastal_aerosol", "nir", "ndvi", "ndwi",
"nbr", "ndmi", "nbr2", "evap", "rain", "tavg", "tmax", "tmin",
"vpd", "blue", "red", "green", "swir_1", "swir_2", "nir", "ndvi",
"ndwi", "nbr", "ndmi", "nbr2", "sdev", "edev", "bcdev",
"evap", "rain", "tavg", "tmax", "tmin", "vpd"
)

, method = c("median",
"median", "median", "median", "median", "median", "median", "median",
"median", "median", "median", "median", "median", "median", "median",
"maximum", "minimum", "median", "median", "median", "median",
"median", "median", "median", "median", "median", "median", "median",
"median", "median", "median", "median",
"median", "median", "median", "maximum", "minimum", "median"
)

, units = c(NA, NA, NA, NA,
NA, NA, NA, NA, NA, NA, NA, NA, "mm", "mm", "deg C", "deg C",
"deg C", "hPa", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
NA, NA,
"mm", "mm", "deg C", "deg C", "deg C", "hPa"
)

, mult = c(10000, 10000, 10000, 10000, 10000, 10000, 10000,
10000, 10000, 10000, 10000, 10000, NA, NA, NA, NA, NA, NA, 10000,
10000, 10000, 10000, 10000, 10000, 1, 1, 1, 1, 1, 1, 1, 1,
NA, NA, NA, NA, NA, NA
)

, description = c("blue median",
"red median", "green median", "short-wave infrared 1 median",
"short-wave infrared 2 median", "coastal aerosol median", "near infrared median",
"normalised difference vegetation index", "normalized difference water index",
"normalized burn ratio", "normalized difference moisture index",
"normalized burned ratio index 2", "monthly class A pan evaporation",
"monthly total rainfall", "monthly average temperature", "monthly maximum temperature",
"monthly minimum temperature", "monthly vapour pressure deficit",
"blue median", "red median", "green median", "short-wave infrared 1 median",
"short-wave infrared 2 median", "near infrared median", "normalised difference vegetation index",
"normalized difference water index", "normalized burn ratio",
"normalized difference moisture index", "normalized burned ratio index 2",
"euclidean distance (EMAD)", "cosine (spectral) distance (SMAD)",
"Bray Curtis dissimilarity (BCMAD)",

"monthly class A pan evaporation", "monthly total rainfall", "monthly average temperature", "monthly maximum temperature",
"monthly minimum temperature", "monthly vapour pressure deficit"
)

, indicates = c("salt, water, soil colour",
"soil colour, green cover", "soil colour, green cover", "wetlands, green cover",
"wetlands, green cover", "salt", "wetlands, green cover", "green cover, productivity",
"green cover in dryland environment", "identify burned areas and provide a measure of burn severity",
"highlight water sensitivity in vegetation", "more sensitive to changes in water content within vegetation than NBR, water stress",
"soil water balance, plant growth, crop yield", "soil water balance, plant growth, crop yield",
"plant growth, crop yield", "temperature extremes, plant growth, crop yield",
"temperature extremes, plant growth, crop yield", "hydrological cycle, plant growth, crop yield",
"salt, water, soil colour", "soil colour, green cover", "soil colour, green cover",
"wetlands, green cover", "wetlands, green cover", "wetlands, green cover",
"green cover, productivity", "green cover in dryland environment",
"identify burned areas and provide a measure of burn severity",
"highlight water sensitivity in vegetation", "more sensitive to changes in water content within vegetation than NBR, water stress",
"variation from the mean in terms of distance based on factors such as brightness and spectra",
"variation from the mean in terms of distance based on factors such as brightness and spectra",
"variation from the mean in terms of distance based on factors such as brightness and spectra",

"soil water balance, plant growth, crop yield", "soil water balance, plant growth, crop yield",
"plant growth, crop yield", "temperature extremes, plant growth, crop yield",
"temperature extremes, plant growth, crop yield", "hydrological cycle, plant growth, crop yield"
)

, notes = c("unitless", "unitless", "unitless", "unitless",
"unitless", "unitless", "unitless", "unitless. nir and red",
"unitless. green and nir", "unitless. nir and swir_1", "unitless. nir and swir_2",
"unitless. swir_1 and swir_2", NA, NA, NA, NA, NA, NA, "unitless",
"unitless", "unitless", "unitless", "unitless", "unitless", "unitless. nir and red",
"unitless. green and nir", "unitless. nir and swir_1", "unitless. nir and swir_2",
"unitless. swir_1 and swir_2", NA, NA, NA,
NA, NA, NA, NA, NA, NA
)

, ref = c(NA, NA, NA,
NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA
, NA, NA, NA, NA, NA, NA
)

, data_ref = c("https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
"https://explorer.dea.ga.gov.au/products/ga_ls9c_ard_3, https://explorer.dea.ga.gov.au/products/ga_ls8c_ard_3",
NA, "https://dx.doi.org/10.25914/60a10b02a7ea8", "https://dx.doi.org/10.25914/60a10acd183a2",
"https://dx.doi.org/10.25914/60a10ae960313", "https://dx.doi.org/10.25914/60a10addedcf8",
"https://dx.doi.org/10.25914/60a10ae350889", "https://dx.doi.org/10.25914/60a10af667bbe",
"Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
"Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
"Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
"Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
"Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
"Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
NA, NA, NA, NA, NA, "Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
"Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
"Introduction to DEA Geomedian and Median Absolute Deviations - DEA Knowledge Hub",
"https://dx.doi.org/10.25914/60a10b02a7ea8", "https://dx.doi.org/10.25914/60a10acd183a2",
"https://dx.doi.org/10.25914/60a10ae960313", "https://dx.doi.org/10.25914/60a10addedcf8",
"https://dx.doi.org/10.25914/60a10ae350889", "https://dx.doi.org/10.25914/60a10af667bbe"
)
) |>
  dplyr::distinct()
