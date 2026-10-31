test_that("farewell() returns n farewells", {
  result <- farewell(3)
  expect_type(result, "character")
  expect_length(result, 3)
})

test_that("farewell() moods produce distinct tones", {
  grumpy <- withr::with_seed(
    2468,
    farewell(20, mood = "grumpy", shakespearean = TRUE)
  )
  expect_true(any(grepl("knave|Begone|Get thee gone", grumpy)))
  cheerful <- withr::with_seed(2468, farewell(20, mood = "cheerful"))
  expect_true(any(grepl("sparkle|waving|wonderful", cheerful)))
})

test_that("farewell() errors for invalid arguments", {
  expect_snapshot(farewell(0), error = TRUE)
  expect_snapshot(farewell(mood = "furious"), error = TRUE)
  expect_snapshot(farewell(profanity = "extreme"), error = TRUE)
  expect_snapshot(farewell(shakespearean = "yes"), error = TRUE)
})

test_that("farewell() adds profanity when requested", {
  withr::local_seed(1357)
  result <- farewell(20, profanity = "strong")
  expect_true(any(grepl("fucking|goddamn|bastard|bullshit", result)))
})

test_that("farewell() profanity = \"tame\" uses funny clean words", {
  withr::local_seed(1357)
  result <- farewell(20, profanity = "tame")
  expect_true(any(grepl("fudging|flipping|biscuit|bullhonky|fudge", result)))
  expect_false(any(grepl("fucking|goddamn|bastard|bullshit", result)))
})

test_that("farewell() profanity = \"weird\" uses the extra-weird set", {
  withr::local_seed(1357)
  result <- farewell(20, profanity = "weird")
  weird_words <- "blorping|squidging|walrus|gravy|googly|wombat"
  expect_true(any(grepl(weird_words, result)))
  expect_false(any(grepl("fucking|goddamn|bastard|bullshit", result)))
})
