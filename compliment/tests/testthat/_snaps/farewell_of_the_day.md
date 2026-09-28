# farewell_of_the_day() errors for an invalid date

    Code
      farewell_of_the_day("not a date")
    Condition
      Error in `farewell_of_the_day()`:
      ! `date` must be a Date, or coercible to one.

---

    Code
      farewell_of_the_day(c("2026-01-01", "2026-01-02"))
    Condition
      Error in `farewell_of_the_day()`:
      ! `date` must be a single date.

