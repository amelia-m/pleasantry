# Open items

For Amelia to decide. The 57 findings behind most of these are in `_scratch/combo-review.md` (gitignored, 2026-10-31), with real generated sentences and per-1,000 rates. Its replacement words are suggestions, not checked against the banks.

- Replace "barely legal" in the modern bizarre adjectives? It carries a sexual connotation at the clean default and also gives "barely legal and illegal in three states". Suggestions: "legally distinct", "legally ambiguous", "technically permitted".
- Mass nouns after "a": replace the words, or stop those templates putting "a" before a subject? Sincere: kindness, creativity, curiosity, judgment, energy (together about 130 of every 1,000 plain `compliment()` calls). Grumpy: attendance, small talk, work, meeting behavior. Quirky, by blending: playlist curation, group chat etiquette. Shakespearean cheerful: merriment, laughter, revelry. Shakespearean sincere: constancy.
- "remarkably" with adjectives that already carry an adverb ("a remarkably not entirely terrible attendance"): drop "remarkably" from the sincere and grumpy templates and use `{a}`, or keep it for one-word adjectives only?
- Keep `onerous` and `uninspired`? You asked for them. The combo review finds they are the only grumpy adjectives with no praise in them, so templates like "almost makes up for everything else" contradict themselves. Together they are about 164 of every 1,000 grumpy calls. Options: keep, replace (suggested "unobjectionable", "serviceable"), or keep and rewrite those templates.
- Stutters: widen the check in `build_one()` to compare every word on a shorter prefix? It would catch glorious glory, merry merriment, eternal + Eternity, passable + passing, surprisingly decent + "surprising how", wonderful + sense of wonder, mildly prophetic + ankle prophecy, chaotic-good + "the good kind of". Untested: a shorter prefix may also block harmless pairs, so check it against the banks first. energy, hug energy and elbow energy with "main-character energy" and "radiates ... energy" need a separate choice of words or templates.
- Rewrite these templates? "nothing short of" lands on mild adjectives ("nothing short of steadfast"). Shakespearean "is tolerable" repeats adequate, passable and sufferable. "a festival unto mine eyes" meets sound subjects such as roundelay.
- Accidental insult in the sincere bank: "creative moral compass" and "creative work ethic". Keep `creative` away from those subjects, or drop it?
- `dance move` reads oddly in the singular (about 85 of every 1,000 cheerful calls). Replace it?
- Shakespearean vocabulary: change `labor` to `labour`, and `cosmicall` and `shadowe` to real words ("celestial", "shade")?
- Profanity: ", as heck" usually lands after a noun (about 1 in 6 mild outputs); move it to the intensifier path or drop it? Should an intensifier go before the last word of a multi-word adjective rather than the first ("your damn borderline impressive excuse")? Give Shakespearean its own intensifiers and suffixes, so "thy" and "you" stop colliding?
- Combo review findings marked keep or low priority still need your yes: glory, energy, raccoons in Shakespearean, ether-signal, thunderous, sunny + "ray of sunshine", unconquerable, radiant, -ly adjectives after "officially".
- Templates use a double hyphen (`--`) in places. Noticed, not reviewed. Keep it?
- The expanded word lists were chosen by an agent and no person has read them. Do you want to review them before they ship?
- `dev-history.md` has em dashes, kept because it records history. Replace them too?
