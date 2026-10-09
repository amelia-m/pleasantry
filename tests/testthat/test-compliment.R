test_that("compliment() returns a single character string by default", {
  result <- compliment()
  expect_type(result, "character")
  expect_length(result, 1)
})

test_that("compliment() returns n compliments", {
  result <- compliment(5)
  expect_length(result, 5)
})

test_that("compliment() errors for invalid n", {
  expect_snapshot(compliment(0), error = TRUE)
  expect_snapshot(compliment(-1), error = TRUE)
  expect_snapshot(compliment("a"), error = TRUE)
})

test_that("compliment() errors for invalid weirdness", {
  expect_snapshot(compliment(weirdness = -0.1), error = TRUE)
  expect_snapshot(compliment(weirdness = 1.1), error = TRUE)
  expect_snapshot(compliment(weirdness = "high"), error = TRUE)
})

test_that("weirdness = 0 always draws every component from the classic pool", {
  result <- compliment(20, weirdness = 0)
  expect_false(any(grepl(
    "raccoon|eldritch|cosmic|meticulous|underrated",
    result
  )))
})

test_that("weirdness = 1 always draws every component from the bizarre pool", {
  result <- compliment(20, weirdness = 1)
  other_tiers <- "brilliant|creative|meticulous|underrated|playlist"
  expect_false(any(grepl(other_tiers, result)))
})

test_that("weirdness = 0.5 always draws every component from the quirky pool", {
  result <- compliment(20, weirdness = 0.5)
  other_tiers <- "brilliant|creative|raccoon|eldritch|cosmic"
  expect_false(any(grepl(other_tiers, result)))
})

test_that("intermediate weirdness blends the two adjacent tiers", {
  set.seed(4812)
  low <- compliment(40, weirdness = 0.25)
  expect_true(any(grepl("brilliant|creative|thoughtful", low)))
  expect_true(any(grepl("meticulous|underrated|playlist", low)))
  expect_false(any(grepl("raccoon|eldritch|cosmic", low)))

  set.seed(4812)
  high <- compliment(40, weirdness = 0.75)
  expect_true(any(grepl("raccoon|eldritch|cosmic", high)))
  expect_true(any(grepl("meticulous|underrated|playlist", high)))
  expect_false(any(grepl("brilliant|creative|thoughtful", high)))
})

test_that("adjectives already present in a template are not duplicated", {
  set.seed(9021)
  result <- compliment(50)
  expect_false(any(grepl("inspiring.*inspiring", result)))
})

test_that("mood = \"grumpy\" produces backhanded compliments", {
  set.seed(3692)
  result <- compliment(20, mood = "grumpy")
  expect_true(any(grepl(
    "considering|I'll give you that|least of your problems",
    result
  )))
  expect_false(any(grepl("truly inspiring|People admire", result)))
})

test_that("shakespearean = TRUE produces pseudo-Shakespearean language", {
  set.seed(7531)
  result <- compliment(20, shakespearean = TRUE)
  expect_true(any(grepl("thy|thou|thee|doth|prithee", result)))
  expect_false(any(grepl("raccoon|NASA|spreadsheet", result)))
})

test_that("profanity adds intensifiers or trailing clauses", {
  set.seed(8642)
  result <- compliment(20, profanity = "strong")
  expect_true(any(grepl("fucking|goddamn|bastard|bullshit", result)))
})

test_that("subjects are singular to agree with template verbs", {
  set.seed(5150)
  result <- c(
    compliment(100, mood = "grumpy"),
    compliment(100, mood = "cheerful"),
    compliment(100, weirdness = 0.5),
    compliment(100, shakespearean = TRUE, mood = "grumpy"),
    compliment(100, shakespearean = TRUE, mood = "dramatic"),
    compliment(100, shakespearean = TRUE, weirdness = 1)
  )
  plurals <- "habits|skills|moves|excuses|jests|labors|capers|deeds|vapours"
  expect_false(any(grepl(plurals, result)))
})

test_that("profanity = \"tame\" uses funny clean words", {
  set.seed(6789)
  result <- compliment(20, profanity = "tame")
  expect_true(any(grepl("fudging|flipping|biscuit|bullhonky|fudge", result)))
  expect_false(any(grepl("fucking|goddamn|bastard|bullshit", result)))
})

test_that("profanity = \"weird\" uses the extra-weird set", {
  set.seed(6789)
  result <- compliment(20, profanity = "weird")
  weird_words <- "blorping|squidging|walrus|gravy|googly|wombat"
  expect_true(any(grepl(weird_words, result)))
  expect_false(any(grepl("fucking|goddamn|bastard|bullshit", result)))
  expect_false(any(grepl("fudging|biscuit", result)))
})

test_that("compliment() errors for invalid mood, profanity, and shakespearean", {
  expect_snapshot(compliment(mood = "furious"), error = TRUE)
  expect_snapshot(compliment(profanity = "extreme"), error = TRUE)
  expect_snapshot(compliment(shakespearean = "yes"), error = TRUE)
})

test_that("indefinite articles agree with the word that follows", {
  expect_equal(pleasantry:::indefinite_article("energy"), "an")
  expect_equal(pleasantry:::indefinite_article("wit"), "a")
  expect_equal(pleasantry:::indefinite_article("Attitude"), "an")
  # Spelled with a vowel, pronounced with a consonant, and the reverse.
  expect_equal(pleasantry:::indefinite_article("unicorn"), "a")
  expect_equal(pleasantry:::indefinite_article("one-liner"), "a")
  expect_equal(pleasantry:::indefinite_article("hour"), "an")
  expect_equal(pleasantry:::indefinite_article("honest"), "an")
  expect_equal(pleasantry:::indefinite_article("haircut"), "a")

  expect_equal(pleasantry:::apply_articles("have {a} energy here"), "have an energy here")
  expect_equal(pleasantry:::apply_articles("have {a} wit here"), "have a wit here")
  expect_equal(pleasantry:::apply_articles("{A} energy so epic!"), "An energy so epic!")
  expect_equal(pleasantry:::apply_articles("{A} wit so epic!"), "A wit so epic!")
  # The profanity intensifier is inserted between the article and the
  # adjective, so the article has to agree with the intensifier.
  expect_equal(
    pleasantry:::apply_articles("what {a} fudging eldritch familiar"),
    "what a fudging eldritch familiar"
  )
})

test_that("generated compliments never mismatch an indefinite article", {
  set.seed(1)
  bad <- character()
  for (mood in c("sincere", "grumpy", "cheerful", "dramatic")) {
    for (shakespearean in c(FALSE, TRUE)) {
      for (weirdness in c(0, 0.5, 1)) {
        for (profanity in c("none", "tame", "weird")) {
          out <- compliment(
            120,
            weirdness = weirdness, mood = mood,
            profanity = profanity, shakespearean = shakespearean
          )
          bad <- c(
            bad,
            grep("\\ba (?=[aeiou])|\\ban (?=[^aeiou ])|\\{[aA]\\}",
                 out, perl = TRUE, value = TRUE)
          )
        }
      }
    }
  }
  expect_equal(bad, character())
})
