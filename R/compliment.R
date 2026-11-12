#' Generate a random compliment
#'
#' Combines a random template, adjective, and subject to produce an
#' encouraging, randomized compliment. Tone and style are controlled by
#' the `mood`, `profanity`, and `shakespearean` arguments, while
#' `weirdness` moves the content along a spectrum from sincere to surreal.
#'
#' @param n Number of compliments to generate. Defaults to `1`.
#' @param weirdness A number between `0` and `1`. Content is organized in
#'   tiers: the chosen mood's bank (position 0), a quirky tier (0.5), and
#'   a bizarre tier (1). Each component of a compliment (template,
#'   adjective, and subject) is independently drawn from a tier, with
#'   triangular weights centered on `weirdness`: `0` (the default) draws
#'   only mood content, `0.5` draws only quirky content, `1` draws only
#'   bizarre content, and intermediate values blend the two adjacent
#'   tiers. When `shakespearean = TRUE`, the quirky tier is omitted and
#'   `weirdness` blends linearly between the mood's Shakespearean bank and
#'   a bizarre Shakespearean bank. A few templates only take adjectives
#'   chosen for them, such as the plainer insults in the `"grumpy"` mood;
#'   their adjective then comes from the template's own tier rather than
#'   being drawn independently.
#' @param mood The tone of the compliment: `"sincere"` (default),
#'   `"grumpy"` (backhanded compliments), `"cheerful"` (over-the-top
#'   warmth), or `"dramatic"` (epic, life-or-death stakes).
#' @param profanity Profanity level: `"none"` (default, no profanity),
#'   `"tame"` (funny clean words like "fudging" and "oh, fudge-muffins"),
#'   `"mild"` (e.g. "damn", "heck"), `"strong"` (four-letter words; note
#'   this tier ships explicit language in the package source), or
#'   `"weird"` (an extra-weird clean set, e.g. "blorping", "you
#'   magnificent space walrus"). Profanity is added as an intensifier
#'   before the adjective or a trailing clause.
#' @param shakespearean If `TRUE`, use pseudo-Shakespearean language and
#'   structure. Each mood has its own Shakespearean bank.
#'
#' @returns A character vector of length `n`.
#' @export
#'
#' @examples
#' compliment()
#' compliment(3)
#' compliment(3, weirdness = 0.5)
#' compliment(3, mood = "grumpy")
#' compliment(3, mood = "dramatic", shakespearean = TRUE)
#' compliment(3, mood = "grumpy", profanity = "tame")
#' compliment(3, mood = "grumpy", profanity = "weird")
compliment <- function(
  n = 1,
  weirdness = 0,
  mood = c("sincere", "grumpy", "cheerful", "dramatic"),
  profanity = c("none", "tame", "mild", "strong", "weird"),
  shakespearean = FALSE
) {
  check_n(n)
  if (
    !is.numeric(weirdness) ||
      length(weirdness) != 1 ||
      !is.finite(weirdness) ||
      weirdness < 0 ||
      weirdness > 1
  ) {
    cli::cli_abort("{.arg weirdness} must be a single number between 0 and 1.")
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
  spec <- compliment_banks(mood, shakespearean)
  # Each component is drawn from a tier with triangular weights centered
  # on the requested weirdness, so adjacent tiers blend at intermediate
  # values.
  weights <- pmax(
    0,
    1 - abs(spec$positions - weirdness) / spec$bandwidth
  )

  pick_bank <- \() spec$tiers[[sample(names(spec$tiers), 1, prob = weights)]]

  # A bank's groups hold templates that only take their own adjectives. Every
  # template is equally likely, whichever group it sits in.
  pick_group <- \(bank) {
    groups <- c(list(bank), bank$groups)
    sizes <- lengths(lapply(groups, `[[`, "templates"))
    groups[[sample(length(groups), 1, prob = sizes)]]
  }

  build_one <- \() {
    group <- pick_group(pick_bank())
    template <- sample(group$templates, 1)
    # The template stays the same across redraws, so its stems are worked out
    # once here rather than on every pass through the loop.
    template_stems <- word_stems(template)
    tries <- 0
    repeat {
      # A bank where every draw repeats a word would otherwise never return.
      tries <- tries + 1
      if (tries > 100) {
        cli::cli_abort(
          "No draw for {.val {template}} avoids repeated words.",
          .internal = TRUE
        )
      }
      # Groups carry no subjects, which is how they differ from a whole bank.
      adjectives <- if (is.null(group$subjects)) {
        group$adjectives
      } else {
        pick_bank()$adjectives
      }
      adjective <- sample(adjectives, 1)
      subject <- sample(pick_bank()$subjects, 1)
      # Avoid repeated words across the adjective, subject and template (e.g.
      # "glorious" and "glory", or "inspiring" in "truly inspiring"). Same
      # test as stems_clash(), on stems computed once per draw.
      adjective_stems <- word_stems(adjective)
      subject_stems <- word_stems(subject)
      if (
        !any(adjective_stems %in% subject_stems) &&
          !any(adjective_stems %in% template_stems) &&
          !any(subject_stems %in% template_stems)
      ) {
        break
      }
    }
    template <- sub("{adjective}", adjective, template, fixed = TRUE)
    text <- sub("{subject}", subject, template, fixed = TRUE)
    # Articles last: the profanity intensifier lands between {a} and the
    # adjective, so it is the word the article has to agree with.
    apply_articles(apply_profanity(text, profanity, adjective))
  }

  vapply(seq_len(n), \(i) build_one(), character(1))
}

# Shared by compliment() and farewell(). Finiteness comes before any
# comparison, so NA, NaN and Inf get the package's message rather than R's
# "missing value where TRUE/FALSE needed"; trunc() rather than as.integer(),
# which warns and gives NA beyond the integer range.
check_n <- function(n, call = parent.frame()) {
  if (
    !is.numeric(n) ||
      length(n) != 1 ||
      !is.finite(n) ||
      n < 1 ||
      n != trunc(n)
  ) {
    cli::cli_abort("{.arg n} must be a single positive whole number.", call = call)
  }
  if (n > .Machine$integer.max) {
    cli::cli_abort(
      "{.arg n} must be at most {(.Machine$integer.max)}.",
      call = call
    )
  }
  invisible(n)
}
