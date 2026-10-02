# compliment (development version)

* `compliment()` gains a `weirdness` argument (`0`-`1`) that places content on a three-tier spectrum (classic, quirky, bizarre) and independently draws each component (template, adjective, subject) from a tier with triangular weights centered on `weirdness`, so intermediate values blend the two adjacent tiers.
* `compliment()` no longer duplicates an adjective that already appears in the chosen template (e.g. "inspiring ... truly inspiring").
* `compliment()` and `farewell()` gain funny-clean profanity options: `profanity` now has five levels — `"none"` (default), `"tame"` (e.g. "fudging", "oh, fudge-muffins"), `"mild"`, `"strong"`, and `"weird"` (e.g. "blorping", "you magnificent space walrus").
* `compliment()` gains `mood` ("sincere", "grumpy", "cheerful", "dramatic"; "grumpy" gives backhanded compliments), `profanity` ("none", "mild", "strong"), and `shakespearean` arguments; `weirdness` now blends each mood's bank into the shared quirky and bizarre tiers.
* `compliment_of_the_day()` now forwards `mood`, `profanity`, and `shakespearean` to `compliment()`.
* New `farewell()` generates randomized goodbyes with `mood`, `profanity`, and `shakespearean` options.
* New `farewell_of_the_day()` returns a single farewell that is deterministic for a given date, without disturbing the global RNG state.
* Fixed subject-verb disagreement caused by plural subjects (e.g. "Thy vapours is...") by singularizing all subject-bank entries.
* The documentation now notes that the `"strong"` profanity tier ships explicit language in the package source.
* New `compliment_of_the_day()` returns a single compliment that is deterministic for a given date, without disturbing the global RNG state.
* Initial CRAN submission.
