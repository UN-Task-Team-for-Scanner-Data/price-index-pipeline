# Price index RAP

A simple pipeline to make a price index with dvc.

## Setup

```
conda env create -f environment.yml
conda activate price-index-pipeline

dvc init
```

## Step 1: Make initial data

Make aggregation weights and raw price quotes from businesses in \data.

```
Rscript make-weights.R
Rscript make-prices.R 2020-01 2024-12
```

Version control with dvc.

```
dvc add data/raw-survey-prices.parquet data/scanner-prices.parquet data/weights.parquet
```

## Step 2: Make index

Process raw prices and make a time series of index values and product
contribution in \data.

```
dvc repro
```

Put under version control.

```
git add .
git commit -m "Index for 2024-12"
git tag -a "2024-12" -m "Index for 2024-12"
```