survey_prices <- arrow::read_parquet("data/raw-survey-prices.parquet")

prices <- survey_prices |>
  dplyr::filter(
    dplyr::between(price, 0.1, 1.9),
    dplyr::between(back_price, 0.1, 1.9)
  ) |>
  dplyr::group_by(period) |>
  dplyr::filter(!gpindex::quartile_method(price / back_price))

arrow::write_parquet(prices, "data/survey-prices.parquet")