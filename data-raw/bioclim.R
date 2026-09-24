

bioclim <- tibble::tribble(
  ~layer, ~description, ~units, ~indicates, ~scale, ~offset,
  "bio01", "Annual Mean Temperature", "dec C", "annual trends", 0.001602222, 2.5,
  "bio02", "Mean Diurnal Range (Mean of monthly (max temp - min temp))", "dec C", "seasonality", 0.0007629627, 25,
  "bio03", "Isothermality (bio02 / bio07) (× 100)", NA, "seasonality", 0.001525925, 50,
  "bio04", "Temperature Seasonality (standard deviation × 100)", NA, "seasonality", 0.07629627, 2500,
  "bio05", "Max Temperature of Warmest Month", "dec C", "extreme or limiting environmental factors", 0.001602222, 2.5,
  "bio06", "Min Temperature of Coldest Month", "dec C", "extreme or limiting environmental factors", 0.001602222, 2.5,
  "bio07", "Temperature Annual Range (bio05 - bio06)", "dec C", "annual trends", 0.001602222, 2.5,
  "bio08", "Mean Temperature of Wettest Quarter", "dec C", "extreme or limiting environmental factors", 0.001602222, 2.5,
  "bio09", "Mean Temperature of Driest Quarter", "dec C", "extreme or limiting environmental factors", 0.001602222, 2.5,
  "bio10", "Mean Temperature of Warmest Quarter", "dec C", "extreme or limiting environmental factors", 0.001602222, 2.5,
  "bio11", "Mean Temperature of Coldest Quarter", "dec C", "extreme or limiting environmental factors", 0.001602222, 2.5,
  "bio12", "Annual Precipitation", "mm", "seasonality", 0.1983703, 6500,
  "bio13", "Precipitation of Wettest Month", "mm", "extreme or limiting environmental factors", 0.0839259, 2750,
  "bio14", "Precipitation of Driest Month", "mm", "extreme or limiting environmental factors", 0.0839259, 2750,
  "bio15", "Precipitation Seasonality (Coefficient of Variation)", NA, "seasonality", 0.004043703, 132.5,
  "bio16", "Precipitation of Wettest Quarter", "mm", "extreme or limiting environmental factors", 0.0839259, 2750,
  "bio17", "Precipitation of Driest Quarter", "mm", "extreme or limiting environmental factors", 0.0839259, 2750,
  "bio18", "Precipitation of Warmest Quarter", "mm", "extreme or limiting environmental factors", 0.0839259, 2750,
  "bio19", "Precipitation of Coldest Quarter", "mm", "extreme or limiting environmental factors", 0.0839259, 2750
) |>
  dplyr::mutate(description = tolower(description))
