

bioclim <- tibble::tribble(
  ~layer, ~description, ~units, ~indicates,
  "bio01", "Annual Mean Temperature", "dec C", "annual trends",
  "bio02", "Mean Diurnal Range (Mean of monthly (max temp - min temp))", "dec C", "seasonality",
  "bio03", "Isothermality (bio02 / bio07) (× 100)", NA, "seasonality",
  "bio04", "Temperature Seasonality (standard deviation × 100)", NA, "seasonality",
  "bio05", "Max Temperature of Warmest Month", "dec C", "extreme or limiting environmental factors",
  "bio06", "Min Temperature of Coldest Month", "dec C", "extreme or limiting environmental factors",
  "bio07", "Temperature Annual Range (bio05 - bio06)", "dec C", "annual trends",
  "bio08", "Mean Temperature of Wettest Quarter", "dec C", "extreme or limiting environmental factors",
  "bio09", "Mean Temperature of Driest Quarter", "dec C", "extreme or limiting environmental factors",
  "bio10", "Mean Temperature of Warmest Quarter", "dec C", "extreme or limiting environmental factors",
  "bio11", "Mean Temperature of Coldest Quarter", "dec C", "extreme or limiting environmental factors",
  "bio12", "Annual Precipitation", "mm", "seasonality",
  "bio13", "Precipitation of Wettest Month", "mm", "extreme or limiting environmental factors",
  "bio14", "Precipitation of Driest Month", "mm", "extreme or limiting environmental factors",
  "bio15", "Precipitation Seasonality (Coefficient of Variation)", NA, "seasonality",
  "bio16", "Precipitation of Wettest Quarter", "mm", "extreme or limiting environmental factors",
  "bio17", "Precipitation of Driest Quarter", "mm", "extreme or limiting environmental factors",
  "bio18", "Precipitation of Warmest Quarter", "mm", "extreme or limiting environmental factors",
  "bio19", "Precipitation of Coldest Quarter", "mm", "extreme or limiting environmental factors",
  "bio28", "Annual Mean Vapour Pressure Deficit", "hPa", "annual trends",
  "bio29", "Highest Monthly Vapour Pressure Deficit", "hPa", "extreme or limiting environmental factors",
  "bio30", "Lowest Monthly Vapour Pressure Deficit", "hPa", "extreme or limiting environmental factors",
  "bio31", "Vapour Pressure Deficit Seasonality", NA, "seasonality",
  "bio32", "Mean Vapour Pressure Deficit in Lowest Quarter", "hPa", "extreme or limiting environmental factors",
  "bio33", "Mean Vapour Pressure Deficit of Highest Quarter", "hPa", "extreme or limiting environmental factors",
  "bio34", "Mean Vapour Pressure Deficit of Warmest Quarter", "hPa", "extreme or limiting environmental factors",
  "bio35", "Mean Vapour Pressure Deficit of Coldest Quarter", "hPa", "extreme or limiting environmental factors"
) |>
  dplyr::mutate(description = tolower(description))
