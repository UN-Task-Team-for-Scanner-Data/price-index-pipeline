args <- commandArgs(TRUE)

businesses <- sprintf("B%03d", 0:989)
products <- sprintf("P%04d", 0:9899)

periods <- seq(
  as.Date(paste(args[1], "01", sep = "-")),
  as.Date(paste(args[2], "01", sep = "-")),
  by = "month"
)

prices <- data.frame(
  period = rep(as.factor(periods), each = length(products)),
  business = rep(as.factor(businesses), each = 10),
  product = products,
  price = runif(length(products) * length(periods), 0.5, 2),
  back_price = runif(length(products) * length(periods), 0.5, 2)
)

arrow::write_parquet(prices, "data/raw-survey-prices.parquet")

scanner_products <- sprintf("SP%04d", 0:99999)

periods <- c(trunc(periods[1] - 1, units = "month"), periods)

scanner_prices <- data.frame(
  period = rep(as.factor(periods), each = length(scanner_products)),
  product = as.factor(scanner_products),
  sales = 1000 * runif(length(scanner_products) * length(periods), 0.5, 2),
  quantity = sample(100:1000, length(scanner_products) * length(periods), replace = TRUE)
)

arrow::write_parquet(scanner_prices, "data/scanner-prices.parquet")
