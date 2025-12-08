#' Launch the Landslides Warnings Shiny Application
#'
#' This function launches the Shiny application included in the
#' **ditwahLandslide** package. The app must be located in
#' `inst/app/` within the package source. When installed, this
#' directory is available via `system.file()`.
#'
#' @param ... Additional arguments passed to `shiny::runApp()`.
#'
#' @return The Shiny app is launched; no R object is returned.
#' @examples
#' \dontrun{
#'   run_app()
#' }
#'
#' @importFrom shiny runApp
#' @export
run_app <- function(...) {

  appDir <- system.file("app", package = "ditwahLandslide")

  if (appDir == "" || !dir.exists(appDir)) {
    stop(
      "Could not find the Shiny app directory.\n",
      "Make sure `inst/app/` exists in the package and reinstall `ditwahLandslide`."
    )
  }

  shiny::runApp(appDir, ...)
}
