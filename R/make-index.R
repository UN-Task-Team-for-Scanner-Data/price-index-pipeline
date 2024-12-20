prices <- arrow::open_dataset("data/prices")

weights <- arrow::read_parquet("data/weights.parquet")

index <- as.data.frame(prices) |>
  piar::elemental_index(
    price / back_price ~ period + business,
    contrib = TRUE
  ) |>
  aggregate(weights)

as.data.frame(index) |>
  dplyr::group_by(period) |>
  arrow::write_dataset(
    "output/index",
    existing_data_behavior = "delete_matching"
  )

piar::contrib2DF(index, level = levels(index)) |>
  dplyr::group_by(period) |>
  arrow::write_dataset(
    "output/contrib",
    existing_data_behavior = "delete_matching"
  )
