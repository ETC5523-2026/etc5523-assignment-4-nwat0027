# genderforce

The genderforce R package provides curated International Labour
Organization (ILOSTAT) data and interactive visual tools to explore
global labour force participation rates by gender, age, and marital
status.

## Installation

You can install the development version of genderforce from
[GitHub](https://github.com/) with:

``` r

# install.packages("remotes") 
remotes::install_github("ETC5523-2026/etc5523-assignment-4-nwat0027")
```

## Dataset Overview

The package includes the `labor_force_marital` dataset, containing
annual labour force participation rates (%) across various countries
from 2015 onwards:

``` r

library(genderforce) 
library(dplyr)

# View dataset structure 
glimpse(labor_force_marital) 
#> Rows: 19,518
#> Columns: 8
#> $ country            <chr> "Afghanistan", "Afghanistan", "Afghanistan", "Afgha…
#> $ survey_source      <chr> "LFS - Labour Force Survey", "LFS - Labour Force Su…
#> $ sex                <chr> "Male", "Male", "Male", "Male", "Male", "Male", "Ma…
#> $ age_group          <chr> "15+", "15+", "15-24", "15-24", "25-54", "25-54", "…
#> $ marital_status     <chr> "Single / Widowed / Divorced", "Married / Union / C…
#> $ year               <dbl> 2021, 2021, 2021, 2021, 2021, 2021, 2021, 2021, 202…
#> $ participation_rate <dbl> 55.049, 85.944, 53.754, 84.321, 74.381, 92.715, 48.…
#> $ data_status        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
```

## Example: Calculating the Gender Participation Gap

The package exports
[`calc_labor_gap()`](https://etc5523-2026.github.io/etc5523-assignment-4-nwat0027/reference/calc_labor_gap.md)
to summarize male versus female participation rates and calculate the
gender gap (percentage points) across marital status categories:

``` r

# Calculate gender gap for Australia in prime working age (25-54) 

calc_labor_gap(target_country = "Australia", target_age = "25-54") 
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

## Interactive Explorer (Shiny App)

`genderforce` comes with a built-in interactive Shiny application that
features dynamic country/age dropdowns, year range sliders, trend
visualisations, and an executive summary card.

To launch the app:

``` r

run_app() 
```

------------------------------------------------------------------------
