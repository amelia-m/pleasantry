
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pleasantry

<!-- badges: start -->

<!-- badges: end -->

pleasantry generates randomized compliments and farewells, from sincere
encouragement to backhanded grumbling to pseudo-Shakespearean absurdity.
Use it to add a bit of positivity (or hostility, or iambic flair) to
scripts, apps, and console output.

## Installation

You can install the development version of pleasantry like so:

``` r
# install.packages("pak")
pak::pak("path/to/pleasantry")
```

## Compliments

`compliment()` generates one or more random compliments:

``` r
library(pleasantry)

set.seed(101)
compliment()
#> [1] "Your resilient spirit is truly inspiring."
compliment(3)
#> [1] "Few people have a work ethic as generous as yours."
#> [2] "Your thoughtful sense of humor is truly inspiring."
#> [3] "Your mind is nothing short of inspiring."
```

### Weirdness

The `weirdness` argument moves content along a spectrum from sincere (0)
through quirky (0.5) to bizarre (1), with adjacent tiers blending at
intermediate values:

``` r
set.seed(202)
compliment(weirdness = 0.5)
#> [1] "Your aggressively pleasant email sign-off could headline a very small festival."
compliment(weirdness = 1)
#> [1] "Your belly button lint hums with a frequency only vaguely sentient whales can hear."
```

### Mood

The `mood` argument sets the tone: `"sincere"` (default), `"grumpy"`
(backhanded), `"cheerful"`, or `"dramatic"`:

``` r
set.seed(303)
compliment(mood = "grumpy")
#> [1] "Your passable work is the least of your problems. In a good way."
compliment(mood = "dramatic")
#> [1] "Your towering triumph will echo through eternity."
```

### Profanity and Shakespearean styling

`profanity` controls the spice level: `"none"` (default), `"tame"`
(funny clean words like “fudging” and “oh, fudge-muffins”), `"mild"`
(e.g. “damn”), `"strong"` (explicit), or `"weird"` (an extra-weird clean
set like “blorping” and “you magnificent space walrus”).
`shakespearean = TRUE` switches to pseudo-Shakespearean language. Both
compose with `mood` and `weirdness`:

**Note:** the `"strong"` tier ships explicit language in the package
source.

``` r
set.seed(404)
compliment(mood = "grumpy", profanity = "tame")
#> [1] "Your passable excuse almost makes up for everything else, you magnificent son of a biscuit."
compliment(mood = "grumpy", profanity = "weird")
#> [1] "Your adequate small talk is the least of your problems. In a good way, you magnificent space walrus."
compliment(mood = "dramatic", shakespearean = TRUE)
#> [1] "Thy immortal deed shall outlive the very stars!"
compliment(mood = "grumpy", shakespearean = TRUE, weirdness = 1)
#> [1] "Forsooth, thy shadowe hums with eldritch energies unknown to natural philosophy."
```

## Farewells

`farewell()` generates random goodbyes with the same `mood`,
`profanity`, and `shakespearean` options:

``` r
set.seed(505)
farewell()
#> [1] "Goodbye, and thank you for being you."
farewell(mood = "grumpy")
#> [1] "Leaving already? Best news I have heard all day."
farewell(mood = "cheerful", shakespearean = TRUE)
#> [1] "Parting? Nay -- a celebration of thy next adventure!"
```

## Compliment and farewell of the day

`compliment_of_the_day()` and `farewell_of_the_day()` return a single
result that is deterministic for a given date, without disturbing the
global RNG state:

``` r
compliment_of_the_day()
#> [1] "Few people have a energy as creative as yours."
farewell_of_the_day("2026-01-01", mood = "grumpy")
#> [1] "Off you go. Don't make it weird."
```
