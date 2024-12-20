args <- commandArgs(TRUE)

businesses <- sprintf("B%03d", 0:999)
products <- sprintf("P%04d", 0:9999)

periods <- seq(
  as.Date(paste(args[1], "01", sep = "-")),
  as.Date(paste(args[2], "01", sep = "-")),
  by = "month"
)

prices <- data.frame(
  period = rep(periods, each = 1e4),
  business = rep(businesses, each = 10),
  product = products,
  price = runif(1e4 * length(periods), 0.5, 2),
  back_price = runif(1e4 * length(periods), 0.5, 2)
)

prices |>
  dplyr::group_by(period) |>
  arrow::write_dataset(
    "data/raw-prices",
    existing_data_behavior = "delete_matching"
  )
