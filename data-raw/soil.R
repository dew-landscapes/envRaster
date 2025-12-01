
meta_data <- SLGACloud::getProductMetaData() |>
  tibble::as_tibble() |>
  dplyr::filter(isCurrentVersion == 1)

soil <- meta_data |>
  dplyr::select(source = Source
                , collection = Product
                , type = DataType
                , layer = Code
                , units = Units
                , description = Description
                , method_ref = OriginalDataSource
                , data_ref = MetadataLink
                ) |>
  dplyr::distinct() |>
  dplyr::add_count(layer) |>
  dplyr::filter(n == 1) |>
  dplyr::select(- n)
