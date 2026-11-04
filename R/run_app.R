#' Launch the GenderForce Interactive Shiny Application
#'
#' Launches the built-in Shiny application included in the package for
#' exploring global labor force participation rates by gender and marital status.
#'
#' @return Launches an interactive Shiny application.
#' @export
#'
#' @examples
#' \dontrun{
#' run_app()
#' }

run_app <- function() {
app_dir <- system.file("app", package = "genderforce")
if (app_dir == "") {
  stop("Could not find app directory. Try re-installing `genderforce`.", call. = FALSE)
}
shiny::runApp(app_dir, display.mode = "normal")
}
