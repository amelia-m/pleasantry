#' Generate a reproducible farewell for a given day
#'
#' The farewell companion to [compliment_of_the_day()]. Produces a single
#' goodbye that is deterministic for a given `date`: calling
#' `farewell_of_the_day()` more than once for the same day returns the
#' same farewell. Internally this seeds the random number generator with
#' [set.seed()], then restores whatever RNG state existed beforehand, so
#' it will not disturb reproducibility elsewhere in your session (e.g. a
#' `set.seed()` you called earlier).
#'
#' @param date A `Date`, or a string coercible to one via [as.Date()].
#'   Defaults to today's date.
#' @param mood,profanity,shakespearean See [farewell()].
#'
#' @returns A single farewell string.
#' @export
#'
#' @examples
#' farewell_of_the_day()
#' farewell_of_the_day("2026-01-01", mood = "dramatic")
#' farewell_of_the_day(Sys.Date(), mood = "grumpy", shakespearean = TRUE)
farewell_of_the_day <- function(
  date = Sys.Date(),
  mood = "sincere",
  profanity = "none",
  shakespearean = FALSE
) {
  if (length(date) != 1) {
    cli::cli_abort("{.arg date} must be a single date.")
  }
  date <- tryCatch(as.Date(date), error = function(e) NA)
  if (is.na(date)) {
    cli::cli_abort("{.arg date} must be a Date, or coercible to one.")
  }

  # Save and restore any existing RNG state so seeding for the day's
  # farewell doesn't affect random draws elsewhere in the session.
  has_seed <- exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE)
  old_seed <- if (has_seed) get(".Random.seed", envir = .GlobalEnv) else NULL
  on.exit({
    if (has_seed) {
      assign(".Random.seed", old_seed, envir = .GlobalEnv)
    } else if (exists(".Random.seed", envir = .GlobalEnv, inherits = FALSE)) {
      rm(".Random.seed", envir = .GlobalEnv)
    }
  })

  set.seed(as.integer(date))
  farewell(
    1,
    mood = mood,
    profanity = profanity,
    shakespearean = shakespearean
  )
}
