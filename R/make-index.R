prices <- arrow::read_parquet("data/survey-prices.parquet")

weights <- arrow::read_parquet("data/weights.parquet")

geks <- arrow::read_parquet("data/geks.parquet")

elementals <- prices |>
  piar::elemental_index(
    price / back_price ~ period + factor(business, levels = weights$business),
    product = product,
    contrib = TRUE
  )

elementals[paste0("B", 990:999), geks$period] <- geks$value

index <- aggregate(elementals, weights)

arrow::write_parquet(as.data.frame(index), "data/index.parquet")

arrow::write_parquet(
  piar::contrib2DF(index, level = levels(index)),
  "data/contributions.parquet"
)

