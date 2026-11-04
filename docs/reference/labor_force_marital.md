# Labor Force Participation Rate by Sex, Age, and Marital Status

A curated dataset derived from International Labour Organization
(ILOSTAT) database (Indicator: EAP_DWAP_SEX_AGE_MTS_RT_A). Contains
annual labor force participation rates in percent across countries,
broken down by sex, aggregate age groups, and aggregate marital status
categories.

## Usage

``` r
labor_force_marital
```

## Format

A tibble with 8 variables:

- country:

  Character. Country or territory name.

- survey_source:

  Character. Name of the underlying national household survey or census.

- sex:

  Character. Sex category ("Male", "Female", "Other").

- age_group:

  Character. Aggregate age band (e.g., "15–24", "25–54", "55–64"). Note:
  '15+' represents the total aggregate working-age population.

- marital_status:

  Character. Aggregated marital status ("Married / Union / Cohabiting",
  "Single / Widowed / Divorced").

- year:

  Numeric. Calendar year of the observation.

- participation_rate:

  Numeric. Labour force participation rate in percent.

- data_status:

  Character. Data quality flag or status (e.g., "Break in series",
  `NA`).

## Source

International Labour Organization (ILOSTAT) database: Indicator
`EAP_DWAP_SEX_AGE_MTS_RT_A`: <https://ilostat.ilo.org/>

## Details

The raw ILOSTAT dataset was cleaned as follows:

- Filtered for non-missing participation rates and excluded records
  flagged as "Unreliable".

- Records flagged with "Break in series" (methodological updates to
  national household surveys) were retained to preserve longitudinal
  continuity.

- Retained only aggregate age bands and aggregate marital status
  categories.

- Removed non-specific aggregate categories including "Total" (for sex
  and marital status) and "Not elsewhere classified".

- Stripped category label prefixes (e.g., "Age (Aggregate bands): ") for
  cleaner visual plotting.
