# farewell() errors for invalid arguments

    Code
      farewell(0)
    Condition
      Error in `farewell()`:
      ! `n` must be a single positive whole number.

---

    Code
      farewell(mood = "furious")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "sincere", "grumpy", "cheerful", "dramatic"

---

    Code
      farewell(profanity = "extreme")
    Condition
      Error in `match.arg()`:
      ! 'arg' should be one of "none", "tame", "mild", "strong", "weird"

---

    Code
      farewell(shakespearean = "yes")
    Condition
      Error in `farewell()`:
      ! `shakespearean` must be `TRUE` or `FALSE`.

