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
  other_tiers <- "brilliant|admirable|meticulous|underrated|playlist"
  expect_false(any(grepl(other_tiers, result)))
})

test_that("weirdness = 0.5 always draws every component from the quirky pool", {
  result <- compliment(20, weirdness = 0.5)
  other_tiers <- "brilliant|admirable|raccoon|eldritch|cosmic"
  expect_false(any(grepl(other_tiers, result)))
})

test_that("intermediate weirdness blends the two adjacent tiers", {
  low <- withr::with_seed(4812, compliment(40, weirdness = 0.25))
  expect_true(any(grepl("brilliant|admirable|thoughtful", low)))
  expect_true(any(grepl("meticulous|underrated|playlist", low)))
  expect_false(any(grepl("raccoon|eldritch|cosmic", low)))

  high <- withr::with_seed(4812, compliment(40, weirdness = 0.75))
  expect_true(any(grepl("raccoon|eldritch|cosmic", high)))
  expect_true(any(grepl("meticulous|underrated|playlist", high)))
  expect_false(any(grepl("brilliant|admirable|thoughtful", high)))
})

test_that("stems_clash() compares every word on four letters", {
  expect_true(pleasantry:::stems_clash("glorious", "glory"))
  expect_true(pleasantry:::stems_clash("wonderful", "sense of wonder"))
  expect_true(pleasantry:::stems_clash("mildly prophetic", "ankle prophecy"))
  expect_true(pleasantry:::stems_clash(
    "passable",
    "thy {subject} is passing {adjective}."
  ))
  expect_false(pleasantry:::stems_clash("brilliant", "mind"))
  # The placeholders are not words: every template holds them.
  expect_false(pleasantry:::stems_clash("adjective", "{adjective} {subject}"))
})

test_that("compliment() avoids repeated words in all three slots", {
  bank <- list(
    templates = c(
      "Your {adjective} {subject} echoes.",
      "Plain {adjective} {subject}."
    ),
    adjectives = c("glorious", "echoing", "plain", "steady"),
    subjects = c("glory", "echo", "plainness", "hat")
  )
  local_mocked_bindings(
    compliment_banks = \(mood, shakespearean) {
      list(tiers = list(mood = bank), positions = c(mood = 0), bandwidth = 1)
    }
  )
  withr::local_seed(4)
  result <- compliment(200)
  expect_false(any(grepl("glorious glory", result)))
  expect_false(any(grepl("echoing .*echoes|echo echoes", result)))
  expect_false(any(grepl("Plain .*plain", result)))
})

test_that("compliment() errors instead of hanging when every draw repeats a word", {
  bank <- list(
    templates = "Your {adjective} {subject}.",
    adjectives = "glorious",
    subjects = "glory"
  )
  local_mocked_bindings(
    compliment_banks = \(mood, shakespearean) {
      list(tiers = list(mood = bank), positions = c(mood = 0), bandwidth = 1)
    }
  )
  expect_error(compliment(), "avoids repeated words")
})

test_that("profanity skips words the sentence already has (magnificent bastard)", {
  withr::local_seed(11)
  result <- replicate(
    200,
    pleasantry:::apply_profanity(
      "Your magnificent legacy.",
      "strong",
      "magnificent"
    )
  )
  expect_false(any(grepl("magnificent bastard", result)))
  expect_true(any(grepl(", (and I|no)", result)))

  # With every intensifier and suffix ruled out, the sentence is unchanged.
  taken <- "Fucking goddamn: I mean it, magnificent bastard, no bullshit."
  expect_identical(
    pleasantry:::apply_profanity(taken, "strong", "magnificent"),
    taken
  )
})

test_that("group adjectives only appear in their group's templates", {
  withr::local_seed(2718)
  grumpy <- c(
    compliment(300, mood = "grumpy"),
    compliment(300, mood = "grumpy", weirdness = 0.25)
  )
  blunt_words <- "onerous|uninspired|lackluster|underwhelming|joyless|tiresome"
  blunt_templates <- "Nobody asked for|filed a complaint"
  expect_identical(grepl(blunt_words, grumpy), grepl(blunt_templates, grumpy))
  expect_true(any(grepl(blunt_words, grumpy)))

  sincere <- compliment(300)
  strong <- sincere[grepl("nothing short of", sincere)]
  expect_gt(length(strong), 0)
  expect_match(
    strong,
    "of (brilliant|wonderful|inspiring|impressive|radiant)\\.$"
  )
})

test_that("mood = \"grumpy\" produces backhanded compliments", {
  withr::local_seed(3692)
  result <- compliment(20, mood = "grumpy")
  expect_true(any(grepl(
    "considering|I'll give you that|least of your problems",
    result
  )))
  expect_false(any(grepl("truly inspiring|People admire", result)))
})

test_that("shakespearean = TRUE produces pseudo-Shakespearean language", {
  withr::local_seed(7531)
  result <- compliment(20, shakespearean = TRUE)
  expect_true(any(grepl("thy|thou|thee|doth|prithee", result)))
  expect_false(any(grepl("raccoon|NASA|spreadsheet", result)))
})

test_that("profanity adds intensifiers or trailing clauses", {
  withr::local_seed(8642)
  result <- compliment(20, profanity = "strong")
  expect_true(any(grepl("fucking|goddamn|bastard|bullshit", result)))
})

test_that("subjects are singular to agree with template verbs", {
  withr::local_seed(5150)
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
  withr::local_seed(6789)
  result <- compliment(20, profanity = "tame")
  expect_true(any(grepl("fudging|flipping|biscuit|bullhonky|fudge", result)))
  expect_false(any(grepl("fucking|goddamn|bastard|bullshit", result)))
})

test_that("profanity = \"weird\" uses the extra-weird set", {
  withr::local_seed(6789)
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
  expect_equal(pleasantry:::indefinite_article("unique"), "a")
  expect_equal(pleasantry:::indefinite_article("usual"), "a")
  # The un- words and "onerous" start like those but take "an".
  expect_equal(pleasantry:::indefinite_article("uninspired"), "an")
  expect_equal(pleasantry:::indefinite_article("unimpressive"), "an")
  expect_equal(pleasantry:::indefinite_article("unidentified"), "an")
  expect_equal(pleasantry:::indefinite_article("onerous"), "an")
  expect_equal(pleasantry:::indefinite_article("hour"), "an")
  expect_equal(pleasantry:::indefinite_article("honest"), "an")
  expect_equal(pleasantry:::indefinite_article("haircut"), "a")

  expect_equal(
    pleasantry:::apply_articles("have {a} energy here"),
    "have an energy here"
  )
  expect_equal(
    pleasantry:::apply_articles("have {a} wit here"),
    "have a wit here"
  )
  expect_equal(
    pleasantry:::apply_articles("{A} energy so epic!"),
    "An energy so epic!"
  )
  expect_equal(
    pleasantry:::apply_articles("{A} wit so epic!"),
    "A wit so epic!"
  )
  # The profanity intensifier is inserted between the article and the
  # adjective, so the article has to agree with the intensifier.
  expect_equal(
    pleasantry:::apply_articles("what {a} fudging eldritch familiar"),
    "what a fudging eldritch familiar"
  )
})

test_that("generated compliments never mismatch an indefinite article", {
  withr::local_seed(1)
  out <- character()
  for (mood in c("sincere", "grumpy", "cheerful", "dramatic")) {
    for (shakespearean in c(FALSE, TRUE)) {
      for (weirdness in c(0, 0.5, 1)) {
        for (profanity in c("none", "tame", "mild", "strong", "weird")) {
          out <- c(
            out,
            compliment(
              120,
              weirdness = weirdness,
              mood = mood,
              profanity = profanity,
              shakespearean = shakespearean
            )
          )
        }
      }
    }
  }
  expect_equal(grep("\\{[aA]\\}", out, value = TRUE), character())

  # Each article is compared with indefinite_article() rather than a vowel
  # regex, so "a unicorn" passes and a capitalized "A energy" is caught.
  pairs <- unlist(regmatches(
    out,
    gregexpr("\\b[Aa]n? [^ ]+", out, perl = TRUE)
  ))
  expect_gt(length(pairs), 0)
  article <- tolower(sub(" .*", "", pairs))
  following <- sub("^[^ ]+ ", "", pairs)
  expected <- vapply(
    following,
    pleasantry:::indefinite_article,
    character(1),
    USE.NAMES = FALSE
  )
  expect_equal(pairs[article != expected], character())
})
