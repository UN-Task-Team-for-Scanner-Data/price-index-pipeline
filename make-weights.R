businesses <- sprintf("B%03d", 0:999)

classification <- Reduce(
  paste0,
  expand.grid(1, 1:2, 1:5, 1:5),
  accumulate = TRUE
)

names(classification) <- paste0("level", 1:4)

weights <- data.frame(
  classification,
  business = businesses,
  weight = round(rlnorm(length(businesses)) * 1000)
)

arrow::write_parquet(weights, "data/weights.parquet")