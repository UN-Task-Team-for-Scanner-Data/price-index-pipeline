# Pipeline with dvc

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
Rscript make-prices.R 2019-12 2024-12
```

Version control with dvc.

```
dvc add data/raw-prices data/weights.parquet
```

## Step 2: Make index

Process raw prices and make a time series of index values and product
contribution in \output.

```
dvc repro
```

Put under version control.

```
git add .
git commit -m "Index for 2024-12"
git tag -a "2024-12" -m "Index for 2024-12"
```

## Step 3: Add more data

Simulate new data (with revisions).

```
Rscript make-prices.R 2024-07 2025-01
```

Run the pipeline.

```
dvc repro
```

```
git add .
git commit -m "Index for 2025-01"
git tag -a "2025-01" -m "Index for 2025-01"
```

## Step 4: Time travel

```
git checkout 2024-12
dvc checkout
```