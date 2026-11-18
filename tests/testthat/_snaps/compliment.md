# compliment() errors for invalid n

    Code
      compliment(0)
    Condition
      Error in `compliment()`:
      ! `n` must be a single positive whole number.
      i Half a compliment is just an insult with good timing.

---

    Code
      compliment(-1)
    Condition
      Error in `compliment()`:
      ! `n` must be a single positive whole number.
      i Half a compliment is just an insult with good timing.

---

    Code
      compliment("a")
    Condition
      Error in `compliment()`:
      ! `n` must be a single positive whole number.
      i Half a compliment is just an insult with good timing.

# compliment() errors for invalid weirdness

    Code
      compliment(weirdness = -0.1)
    Condition
      Error in `compliment()`:
      ! `weirdness` must be a single number between 0 and 1.
      i Even the weird ones have limits.

---

    Code
      compliment(weirdness = 1.1)
    Condition
      Error in `compliment()`:
      ! `weirdness` must be a single number between 0 and 1.
      i Even the weird ones have limits.

---

    Code
      compliment(weirdness = "high")
    Condition
      Error in `compliment()`:
      ! `weirdness` must be a single number between 0 and 1.
      i Even the weird ones have limits.

# compliment() errors for invalid mood, profanity, and shakespearean

    Code
      compliment(mood = "furious")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "sincere", "grumpy", "cheerful", "dramatic"

---

    Code
      compliment(profanity = "extreme")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "none", "tame", "mild", "strong", "weird"

---

    Code
      compliment(shakespearean = "yes")
    Condition
      Error in `compliment()`:
      ! `shakespearean` must be `TRUE` or `FALSE`.

