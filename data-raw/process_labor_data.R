library(Rilostat)
library(tidyverse)

dataset_id <- "EAP_DWAP_SEX_AGE_MTS_RT_A"

raw_ilo_data <- get_ilostat(
  id = dataset_id,
  type = "label",
  filters = list(
    timefrom = 1980
  )
)



labor_force_marital <- raw_ilo_data |>
  select(
    country = ref_area.label,
    survey_source = source.label,
    sex = sex.label,
    age_group = classif1.label,
    marital_status = classif2.label,
    year = time,
    participation_rate = obs_value,
    data_status = obs_status.label ) |>
  # Remove missing participation values, unreliable data, keep only aggregate bands for age group
  filter(!is.na(participation_rate),
         is.na(data_status)| data_status != "Unreliable",
         str_detect(age_group, fixed("Age (Aggregate bands)")),,
         str_detect(marital_status, fixed("Marital status (Aggregate)")),
         !str_detect(marital_status, fixed("Total")),,
         !str_detect(sex, fixed("Total"))) |>
  # Convert year and rate to proper numeric types
  mutate(
    year = as.numeric(year),
    participation_rate = as.numeric(participation_rate),
          # Clean up the label text
    age_group = str_remove(age_group, fixed("Age (Aggregate bands): ")),
    marital_status = str_remove(marital_status, fixed("Marital status (Aggregate): ")
    )) |>
  filter(marital_status != "Not elsewhere classified")


# Export clean dataset to data labor_force_marital.rda
usethis::use_data(labor_force_marital, overwrite = TRUE)
message("Done! Clean dataset saved to data labor_force_marital.rda")
