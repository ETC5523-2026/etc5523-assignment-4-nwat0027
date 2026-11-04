#' Calculate Gender Labor Force Participation Gap
#'
#' Computes the percentage-point labor force participation gap between males
#' and females for a specified country and age group using the
#' \code{labor_force_marital} dataset.
#'
#' @param data A data frame containing labor force participation data.
#'   Defaults to \code{genderforce::labor_force_marital}.
#' @param target_country Character string specifying the country name.
#' @param target_age Character string specifying the age group
#'   (e.g., "25-54").
#'
#' @return A tibble with columns:
#' \describe{
#'   \item{year}{Observation year.}
#'   \item{marital_status}{Marital status category.}
#'   \item{Male}{Male labor force participation rate.}
#'   \item{Female}{Female labor force participation rate.}
#'   \item{gender_gap}{Male participation rate minus female participation rate.}
#' }
#'
#' @importFrom rlang .data
#' @export
#'
#' @examples
#' calc_labor_gap(
#'   target_country = "Australia",
#'   target_age = "25-54"
#' )
calc_labor_gap <- function(
    data = genderforce::labor_force_marital,
    target_country = "Australia",
    target_age = "25-54"
) {

  if (!target_country %in% data$country) {
    stop(
      "Specified country '", target_country,
      "' not found in dataset.",
      call. = FALSE
    )
  }

  if (!target_age %in% data$age_group) {
    stop(
      "Specified age group '", target_age,
      "' not found in dataset.",
      call. = FALSE
    )
  }

  data |>
    dplyr::filter(
      .data$country == target_country,
      .data$age_group == target_age,
      .data$sex %in% c("Male", "Female")
    ) |>
    dplyr::select(
      .data$year,
      .data$marital_status,
      .data$sex,
      .data$participation_rate
    ) |>
    tidyr::pivot_wider(
      names_from = .data$sex,
      values_from = .data$participation_rate
    ) |>
    dplyr::mutate(
      gender_gap = .data$Male - .data$Female
    )
}
