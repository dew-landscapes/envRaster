

bioclim <- tibble::tribble(
  ~layer, ~description, ~units, ~indicates, ~scale, ~offset,
  "bio01", "Annual Mean Temperature", "dec C", "annual trends", 10, 0,
  "bio02", "Mean Diurnal Range (Mean of monthly (max temp - min temp))", "dec C", "seasonality", 1, 0,
  "bio03", "Isothermality (bio02 / bio07) (× 100)", NA, "seasonality", 1, 0,
  "bio04", "Temperature Seasonality (standard deviation × 100)", NA, "seasonality", 1, 0,
  "bio05", "Max Temperature of Warmest Month", "dec C", "extreme or limiting environmental factors", 10, 0,
  "bio06", "Min Temperature of Coldest Month", "dec C", "extreme or limiting environmental factors", 10, 0,
  "bio07", "Temperature Annual Range (bio05 - bio06)", "dec C", "annual trends", 10, 0,
  "bio08", "Mean Temperature of Wettest Quarter", "dec C", "extreme or limiting environmental factors", 10, 0,
  "bio09", "Mean Temperature of Driest Quarter", "dec C", "extreme or limiting environmental factors", 10, 0,
  "bio10", "Mean Temperature of Warmest Quarter", "dec C", "extreme or limiting environmental factors", 10, 0,
  "bio11", "Mean Temperature of Coldest Quarter", "dec C", "extreme or limiting environmental factors", 10, 0,
  "bio12", "Annual Precipitation", "mm", "annual trends", 1, 0,
  "bio13", "Precipitation of Wettest Month", "mm", "extreme or limiting environmental factors", 1, 0,
  "bio14", "Precipitation of Driest Month", "mm", "extreme or limiting environmental factors", 1, 0,
  "bio15", "Precipitation Seasonality (Coefficient of Variation)", NA, "seasonality", 1, 0,
  "bio16", "Precipitation of Wettest Quarter", "mm", "extreme or limiting environmental factors", 1, 0,
  "bio17", "Precipitation of Driest Quarter", "mm", "extreme or limiting environmental factors", 1, 0,
  "bio18", "Precipitation of Warmest Quarter", "mm", "extreme or limiting environmental factors", 1, 0,
  "bio19", "Precipitation of Coldest Quarter", "mm", "extreme or limiting environmental factors", 1, 0
) |>
  dplyr::mutate(description = tolower(description))
