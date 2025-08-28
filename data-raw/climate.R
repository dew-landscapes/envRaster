

climate <- tibble::tibble(
  #~layer, ~description, ~units, ~indicates,
  layer = c("evap", "rain", "tavg", "tmax", "tmin", "vpd")
  , description = c("monthly class A pan evaporation", "monthly total rainfall"
                    , "monthly average temperature", "monthly maximum temperature"
                    , "monthly minimum temperature", "monthly vapour pressure deficit"
                    )
  , units = c("mm", "mm", "deg C", "deg C", "deg C", "hPa")
  , indicates = c("soil water balance, plant growth, crop yield"
                  , "soil water balance, plant growth, crop yield"
                  , "plant growth, crop yield"
                  , "temperature extremes, plant growth, crop yield"
                  , "temperature extremes, plant growth, crop yield"
                  , "hydrological cycle, plant growth, crop yield"
                  )
  , method_ref = c("https://dx.doi.org/10.25914/60a10b02a7ea8"
                   , "https://dx.doi.org/10.25914/60a10acd183a2"
                   , "https://dx.doi.org/10.25914/60a10ae960313"
                   , "https://dx.doi.org/10.25914/60a10addedcf8"
                   , "https://dx.doi.org/10.25914/60a10ae350889"
                   , "https://dx.doi.org/10.25914/60a10af667bbe"
                   )
  ) |>
  dplyr::mutate(description = tolower(description))
