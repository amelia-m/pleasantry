# pleasantry development history

A curated summary of the design decisions made while building the
`pleasantry` package (September–October 2026). This document is excluded
from the built package via `.Rbuildignore`.

## Package genesis

- Scaffolded with `usethis::create_package()`, MIT license, testthat
  edition 3, roxygen2 documentation.
- Initial API: `compliment(n)` generating randomized compliments from
  template/adjective/subject banks.
- `devtools::check()` has been clean throughout (0 errors, 0 warnings),
  with two standing benign NOTEs: a Windows temp-file artifact
  (`''NULL''`) and a NEWS.md heading-format quirk from the devtools
  development-version convention.

## Early correctness fixes

- **Word-stem deduplication**: adjective/subject pairs sharing a stem
  (e.g. "creative"/"creativity") read as redundant, so `compliment()`
  resamples until the stems differ.
- **`Depends: R (>= 4.1.0)`**: added explicitly after `R CMD build`
  flagged the use of base pipe and `\()` lambda syntax.
- **Duplicate adjective in template**: fixed outputs like "Your inspiring
  shadow is truly inspiring" by rejecting adjectives already present in
  the chosen template.
- **Subject-verb agreement**: a spot-check of Shakespearean blends
  exposed plural subjects ("vapours", "jests", "spreadsheet habits",
  etc.) colliding with singular-verb templates. Fixed by singularizing
  eight subject entries across all banks, with a 600-sample regression
  test.

## The weirdness saga

The `weirdness` argument went through four designs:

1. **Discrete `mode` argument** ("classic"/"unhinged") — worked, but
   binary.
2. **Single-draw whole-compliment probability** — one
   `runif(1) < weirdness` per compliment picked the entire bank. This
   caused a reproducibility quirk: `compliment_of_the_day()` seeds the
   RNG from the date, so the single draw was fixed per date, and
   different `weirdness` values on the same side of that threshold
   produced identical output (observed: `weirdness = 0` and `0.5` gave
   the same compliment).
3. **Per-component Bernoulli mixing** ("Option A") — template,
   adjective, and subject each independently drawn from classic vs.
   bizarre with probability `weirdness`. Fixed the tie issue and
   produced hybrids like "Your brilliant kneecap wisdom is truly
   inspiring."
4. **Three-tier spectrum with triangular weights** ("Option B") — added
   a hand-written "quirky" mid-tier between classic and bizarre. Each
   component is drawn from tier positions 0 / 0.5 / 1 with weights
   `max(0, 1 - |pos - weirdness| / 0.5)`, so intermediate values blend
   the two adjacent tiers and `0.5` is purely quirky.

## Mood, profanity, and Shakespearean styling

Design questions were posed and resolved with the recommended options:

- **`mood`**: `"sincere"` (default), `"grumpy"` (backhanded),
  `"cheerful"`, `"dramatic"`. Each mood has its own bank; `weirdness`
  blends the mood bank into the shared quirky/bizarre tiers.
- **`profanity`**: three levels (`"none"`, `"mild"`, `"strong"`) via a
  shared `apply_profanity()` helper — intensifier insertion before the
  adjective or a trailing clause before terminal punctuation.
- **`shakespearean`**: hand-written pseudo-Shakespearean banks per mood
  (chosen over procedural transformation, which produces poor results).
  When active, the quirky tier is dropped and `weirdness` blends
  linearly between the mood's Shakespearean bank and a bizarre
  Shakespearean bank.
- **Content architecture**: all banks live in `R/banks.R` as internal
  (non-exported) data functions.

## Farewells and of-the-day functions

- `farewell(n, mood, profanity, shakespearean)` mirrors `compliment()`'s
  API (no `weirdness` — farewells have no tiers). All 37 farewell
  entries were audited against the profanity-suffix path; suffixes
  attach cleanly to final sentences regardless of terminal punctuation.
- `compliment_of_the_day(date, ...)` and `farewell_of_the_day(date,
  ...)` seed the RNG deterministically from the date via `set.seed()`,
  saving and restoring `.Random.seed` so the global RNG stream is
  undisturbed. Date arguments are validated with clear `cli` errors.

## CRAN-readiness audit (DavisVaughan/extrachecks)

Ran every applicable check from the extrachecks list:

| Check | Result |
|---|---|
| `@returns` on all 4 exported functions | Pass |
| `@examples` on all 4 exported functions | Pass |
| No roxygen examples on un-exported helpers | Pass |
| No `\dontrun{}` / commented-out example code | Pass |
| DESCRIPTION Title (title case, <65 chars) | Pass |
| DESCRIPTION Description formatting rules | Pass |
| No URLs in package | Pass at the time; URL and BugReports were added later with the rename, and the URL 404s until Pages is deployed |
| LICENSE year current (2026) | Pass |
| `cph` role in Authors@R | **Fixed** — added, and LICENSE holder synced to Amelia Miramonti |
| `noSuggests` robustness | Accepted risk (only Suggests is testthat; rarely enforced) |

## API simplification (profanity/substitute merge)

The two-knob design (`profanity` level + `substitute` off/tame/weird)
was redundant: the substitute word lists never varied by profanity
level, so `profanity = "mild", substitute = TRUE` and
`profanity = "strong", substitute = TRUE` produced identical output. It
also caused confusion ("is 'off' profane?" — it was). The arguments were
merged into a single five-level `profanity` argument — `"none"`
(default), `"tame"`, `"mild"`, `"strong"`, `"weird"` — with a provably
exact behavior mapping and no loss of expressiveness. Done pre-release
(0.0.0.9000), when breaking the API is still cheap.

## Final state

- Exported API: `compliment()`, `compliment_of_the_day()`,
  `farewell()`, `farewell_of_the_day()`.
- 49/49 tests passing; `devtools::check()` at 0 errors, 0 warnings,
  2 benign NOTEs.
- Dependencies: `cli` only (plus `R (>= 4.1.0)`, `testthat` in
  Suggests).
