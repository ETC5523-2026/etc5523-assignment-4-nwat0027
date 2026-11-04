# Calculate Gender Labor Force Participation Gap

Computes the percentage-point labor force participation gap between
males and females for a specified country and age group using the
`labor_force_marital` dataset.

## Usage

``` r
calc_labor_gap(
  data = genderforce::labor_force_marital,
  target_country = "Australia",
  target_age = "25-54"
)
```

## Arguments

- data:

  A data frame containing labor force participation data. Defaults to
  [`genderforce::labor_force_marital`](https://nwat0027.github.io/ETC5523-2026/etc5523-assignment-4-nwat0027/reference/labor_force_marital.md).

- target_country:

  Character string specifying the country name.

- target_age:

  Character string specifying the age group (e.g., "25-54").

## Value

A tibble with columns:

- year:

  Observation year.

- marital_status:

  Marital status category.

- Male:

  Male labor force participation rate.

- Female:

  Female labor force participation rate.

- gender_gap:

  Male participation rate minus female participation rate.

## Examples

``` r
calc_labor_gap(
  target_country = "Australia",
  target_age = "25-54"
)
#> # A tibble: 22 × 5
#>     year marital_status                Male Female gender_gap
#>    <dbl> <chr>                        <dbl>  <dbl>      <dbl>
#>  1  2025 Single / Widowed / Divorced   82.0   80.8       1.23
#>  2  2025 Married / Union / Cohabiting  95.1   84.5      10.6 
#>  3  2024 Single / Widowed / Divorced   81.7   80.1       1.55
#>  4  2024 Married / Union / Cohabiting  95.2   84.1      11.1 
#>  5  2023 Single / Widowed / Divorced   83.9   80.6       3.26
#>  6  2023 Married / Union / Cohabiting  95.0   83.5      11.5 
#>  7  2022 Single / Widowed / Divorced   82.8   79.9       2.91
#>  8  2022 Married / Union / Cohabiting  94.7   82.9      11.8 
#>  9  2021 Single / Widowed / Divorced   82.0   78.1       3.89
#> 10  2021 Married / Union / Cohabiting  94.7   81.7      13.0 
#> # ℹ 12 more rows
```
