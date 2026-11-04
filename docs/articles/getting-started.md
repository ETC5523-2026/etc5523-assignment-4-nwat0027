# Getting Started with genderforce

The **genderforce** package provides clean International Labour
Organization (ILOSTAT) data and tools to analyze how marital status
impacts the gender gap in labor force participation across countries,
age brackets, and time.

## 1. Installation

You can install the development version of `genderforce` from GitHub:

``` r

# install.packages("remotes") 
remotes::install_github("ETC5523-2026/etc5523-assignment-4-nwat0027")
```

## 2. Exploring the Dataset and Helper Functions

Load the package and examine the cleaned `labor_force_marital` dataset:

``` r

library(genderforce)

# Inspect the dataset structure
head(labor_force_marital)
#>       country             survey_source  sex age_group
#> 1 Afghanistan LFS - Labour Force Survey Male       15+
#> 2 Afghanistan LFS - Labour Force Survey Male       15+
#> 3 Afghanistan LFS - Labour Force Survey Male     15-24
#> 4 Afghanistan LFS - Labour Force Survey Male     15-24
#> 5 Afghanistan LFS - Labour Force Survey Male     25-54
#> 6 Afghanistan LFS - Labour Force Survey Male     25-54
#>                 marital_status year participation_rate data_status
#> 1  Single / Widowed / Divorced 2021             55.049        <NA>
#> 2 Married / Union / Cohabiting 2021             85.944        <NA>
#> 3  Single / Widowed / Divorced 2021             53.754        <NA>
#> 4 Married / Union / Cohabiting 2021             84.321        <NA>
#> 5  Single / Widowed / Divorced 2021             74.381        <NA>
#> 6 Married / Union / Cohabiting 2021             92.715        <NA>
```

### Computing Gender Gaps

Use
[`calc_labor_gap()`](https://nwat0027.github.io/ETC5523-2026/etc5523-assignment-4-nwat0027/reference/calc_labor_gap.md)
to compute percentage-point gaps between male and female participation
rates for a specific country and age group:

``` r

# Calculate gender gaps for Australia (Prime working age: 25-54)
gap_data <- calc_labor_gap(
  target_country = "Australia",
  target_age = "25-54"
)

head(gap_data)
#> # A tibble: 6 × 5
#>    year marital_status                Male Female gender_gap
#>   <dbl> <chr>                        <dbl>  <dbl>      <dbl>
#> 1  2025 Single / Widowed / Divorced   82.0   80.8       1.23
#> 2  2025 Married / Union / Cohabiting  95.1   84.5      10.6 
#> 3  2024 Single / Widowed / Divorced   81.7   80.1       1.55
#> 4  2024 Married / Union / Cohabiting  95.2   84.1      11.1 
#> 5  2023 Single / Widowed / Divorced   83.9   80.6       3.26
#> 6  2023 Married / Union / Cohabiting  95.0   83.5      11.5
```

## 3. Launching the Interactive Application

The package includes an interactive Shiny application designed for
public health researchers, policymakers, and advocates. Launch it
directly using:

``` r

genderforce::run_app()
```

## 4. Interpreting App Outputs

### Trend Plot Interpretation

- **Line Comparisons:** Solid lines represent married/cohabiting
  individuals, while dashed lines represent single/divorced individuals.
- **The Marital Penalty:** Observe whether married women exhibit lower
  participation than married men and whether that gap narrows among
  single workers.
- **Data Quality Indicators (▲):** Years flagged with a triangle (**▲**)
  indicate an ILO *“Break in series”* (a national survey methodology
  update), advising caution when interpreting sudden single-year shifts.

### Summary Table Interpretation

- **Gender Gap Metric:** Calculated as
  `Male Participation Rate (%) - Female Participation Rate (%)`.
- **Positive Values:** Indicate higher male participation relative to
  female participation.
