#' Generate a random goodbye
#'
#' Generates a randomized farewell whose tone is controlled by the `mood`
#' argument, with optional profanity and pseudo-Shakespearean styling.
#'
#' @param n Number of farewells to generate. Defaults to `1`.
#' @param mood The tone of the farewell: `"sincere"` (default),
#'   `"grumpy"` (curt, passive-aggressive), `"cheerful"` (over-the-top
#'   warmth), or `"dramatic"` (theatrical, life-or-death stakes).
#' @param profanity Profanity level: `"none"` (default, no profanity),
#'   `"tame"` (funny clean words like "fudging" and "oh, fudge-muffins"),
#'   `"mild"` (e.g. "damn", "heck"), `"strong"` (four-letter words; note
#'   this tier ships explicit language in the package source), or
#'   `"weird"` (an extra-weird clean set, e.g. "blorping", "you
#'   magnificent space walrus"). Profanity is added as a trailing clause.
#' @param shakespearean If `TRUE`, use pseudo-Shakespearean language and
#'   structure. Each mood has its own Shakespearean farewells.
#'
#' @returns A character vector of length `n`.
#' @export
#'
#' @examples
#' farewell()
#' farewell(3, mood = "grumpy")
#' farewell(3, mood = "dramatic", shakespearean = TRUE)
#' farewell(mood = "grumpy", profanity = "strong")
#' farewell(mood = "grumpy", profanity = "weird")
farewell <- function(
  n = 1,
  mood = c("sincere", "grumpy", "cheerful", "dramatic"),
  profanity = c("none", "tame", "mild", "strong", "weird"),
  shakespearean = FALSE
) {
  if (!is.numeric(n) || length(n) != 1 || n < 1 || n != as.integer(n)) {
    cli::cli_abort("{.arg n} must be a single positive whole number.")
  }
  mood <- match.arg(mood)
  profanity <- match.arg(profanity)
  if (
    !is.logical(shakespearean) ||
      length(shakespearean) != 1 ||
      is.na(shakespearean)
  ) {
    cli::cli_abort("{.arg shakespearean} must be `TRUE` or `FALSE`.")
  }
  bank <- farewell_banks(mood, shakespearean)
  vapply(
    seq_len(n),
    \(i) apply_profanity(sample(bank, 1), profanity),
    character(1)
  )
}
