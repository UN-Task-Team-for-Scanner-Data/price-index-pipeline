raw_prices <- arrow::open_dataset("data/raw-prices")

prices <- raw_prices |>
  dplyr::filter(
    dplyr::between(price, 0.1, 1.9),
    dplyr::between(back_price, 0.1, 1.9)
  ) |>
  dplyr::collect() |>
  dplyr::group_by(period) |>
  dplyr::filter(!gpindex::quartile_method(price / back_price))

prices |>
  dplyr::group_by(period) |>
  arrow::write_dataset(
    "data/prices",
    existing_data_behavior = "delete_matching"
  )