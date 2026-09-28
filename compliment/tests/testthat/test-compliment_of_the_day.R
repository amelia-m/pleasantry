test_that("compliment_of_the_day() returns a single compliment", {
  result <- compliment_of_the_day("2026-01-01")
  expect_type(result, "character")
  expect_length(result, 1)
})

test_that("compliment_of_the_day() is reproducible for the same date", {
  a <- compliment_of_the_day("2026-03-14")
  b <- compliment_of_the_day("2026-03-14")
  expect_identical(a, b)
})

test_that("compliment_of_the_day() does not disturb the global RNG state", {
  set.seed(99)
  before <- runif(5)

  set.seed(99)
  compliment_of_the_day("2026-06-01")
  after <- runif(5)

  expect_identical(before, after)
})

test_that("compliment_of_the_day() errors for an invalid date", {
  expect_snapshot(compliment_of_the_day("not a date"), error = TRUE)
  expect_snapshot(
    compliment_of_the_day(c("2026-01-01", "2026-01-02")),
    error = TRUE
  )
})
