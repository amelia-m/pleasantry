# Open items

For Amelia to decide:

- Should agent commits in this repository carry AI attribution (a `Co-Authored-By:` trailer and a PR footer)? There is no `.agents/project-profile.md` recording the answer, so commits leave it out until you say. Should a profile be created to hold it?
- The repository has no `.gitattributes`, and the machine has `core.autocrlf=true`, so the working tree is CRLF and snapshot files can differ between checkouts. Add the standard file as its own commit, on a clean tree, with `git add --renormalize .`?
- The repository has no `air.toml` and has not been Air-formatted. Add one and run Air as its own commit?
- `NEWS.md` still has an older em dash, in the bullet where `profanity` gains five levels. Replace it? It was left alone because it predates the review that found the newer one; `dev-history.md` also has em dashes, and those record history.
- The other tests call `set.seed()` directly, leaking RNG state between tests. Only the article test was moved to `withr::local_seed()`. Convert the rest?
- The existing bizarre adjective "barely legal" has an adult-content association that sits badly with the package's kind tone. Replace it?
- Existing mass nouns read awkwardly after "a": kindness, creativity and energy ("Few people have a kindness as ..."), and attendance, small talk and work ("that is a remarkably adequate small talk"). Generated output now also gives "a remarkably onerous small talk". Replace them, or fix the templates that put "a" before a subject?
- Existing multi-word adjectives such as "surprisingly decent" and "not entirely terrible" read oddly after "remarkably" ("a remarkably not entirely terrible ..."). Replace them, or stop using "remarkably" with that bank?
- The expanded word lists were chosen by an agent and no person has read them. Do you want to review them before they ship?
- Re-rendering `README.Rmd` adds a blank line between the badge comments, which was removed by hand in the word-list commit and will come back on the next render. Leave it, or accept the blank line?
