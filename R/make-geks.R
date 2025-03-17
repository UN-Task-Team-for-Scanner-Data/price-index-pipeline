scanner_prices <- arrow::read_parquet("data/scanner-prices.parquet")

prices <- scanner_prices |>
  dplyr::mutate(unit_price = sales / quantity)

geks <- with(
  prices,
  gpindex::fisher_geks(unit_price, quantity, period, product, window = 13)
) |>
  gpindex::splice_index()

arrow::write_parquet(
  data.frame(period = names(geks), value = geks),
  "data/geks.parquet"
)