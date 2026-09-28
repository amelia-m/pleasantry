# Content banks for compliment() and farewell(). Internal, not exported.

compliment_banks <- function(mood, shakespearean) {
  modern <- list(
    sincere = list(
      templates = c(
        "Your {adjective} {subject} is truly inspiring.",
        "You have a remarkably {adjective} {subject}.",
        "People admire your {adjective} {subject}.",
        "Your {subject} is nothing short of {adjective}.",
        "Few people have a {subject} as {adjective} as yours."
      ),
      adjectives = c(
        "brilliant",
        "creative",
        "thoughtful",
        "remarkable",
        "inspiring",
        "generous",
        "resilient",
        "insightful",
        "radiant",
        "impressive"
      ),
      subjects = c(
        "mind",
        "sense of humor",
        "work ethic",
        "attitude",
        "curiosity",
        "kindness",
        "perspective",
        "creativity",
        "energy",
        "spirit"
      )
    ),
    grumpy = list(
      templates = c(
        "Your {adjective} {subject} almost makes up for everything else.",
        "It's honestly surprising how {adjective} your {subject} is, considering.",
        "Your {subject} is {adjective}. I'll give you that.",
        "For you, that is a remarkably {adjective} {subject}.",
        "Your {adjective} {subject} is the least of your problems. In a good way."
      ),
      adjectives = c(
        "adequate",
        "passable",
        "tolerable",
        "surprisingly decent",
        "competent-ish",
        "borderline impressive",
        "mildly acceptable",
        "not entirely terrible"
      ),
      subjects = c(
        "effort",
        "attempt",
        "excuse",
        "attendance",
        "typing speed",
        "meeting behavior",
        "small talk",
        "work"
      )
    ),
    cheerful = list(
      templates = c(
        "Your {adjective} {subject} just made my whole day!",
        "You absolute ray of sunshine -- that {adjective} {subject}!",
        "Your {subject} is so {adjective} it should be a national holiday!",
        "I am physically incapable of frowning around your {adjective} {subject}!",
        "Your {adjective} {subject} deserves a parade!"
      ),
      adjectives = c(
        "sparkling",
        "sunny",
        "bubbly",
        "dazzling",
        "joyful",
        "infectious",
        "peppy",
        "luminous"
      ),
      subjects = c(
        "laugh",
        "smile",
        "enthusiasm",
        "presence",
        "giggle",
        "high-five game",
        "hug energy",
        "dance move"
      )
    ),
    dramatic = list(
      templates = c(
        "Your {adjective} {subject} shall be sung of for a thousand years.",
        "Kings would abdicate for a {subject} as {adjective} as yours.",
        "The heavens themselves weep at your {adjective} {subject}.",
        "Never in recorded history has a {subject} been so {adjective}.",
        "Your {adjective} {subject} will echo through eternity."
      ),
      adjectives = c(
        "magnificent",
        "legendary",
        "towering",
        "immortal",
        "glorious",
        "epic",
        "sovereign",
        "mythic"
      ),
      subjects = c(
        "legacy",
        "destiny",
        "saga",
        "triumph",
        "glory",
        "reign",
        "ballad",
        "empire"
      )
    ),
    quirky = list(
      templates = c(
        "Your {adjective} {subject} deserves its own trophy shelf.",
        "Someone definitely brags about your {adjective} {subject} at parties.",
        "Your {subject} is the good kind of {adjective}.",
        "Not to be dramatic, but your {subject} is {adjective}.",
        "Your {adjective} {subject} has strong main-character energy.",
        "Your {adjective} {subject} could headline a very small festival."
      ),
      adjectives = c(
        "meticulous",
        "unreasonably organized",
        "delightfully specific",
        "chaotic-good",
        "quietly excellent",
        "impressively niche",
        "well-seasoned",
        "aggressively pleasant",
        "underrated",
        "award-worthy"
      ),
      subjects = c(
        "spreadsheet habit",
        "playlist curation",
        "snack selection",
        "calendar system",
        "bookmarks bar",
        "email sign-off",
        "plant collection",
        "mug collection",
        "parking skill",
        "group chat etiquette"
      )
    ),
    bizarre = list(
      templates = c(
        "Your {adjective} {subject} could summon a minor deity.",
        "Somewhere, a raccoon is taking notes on your {adjective} {subject}.",
        "Your {subject} radiates {adjective} energy that bends spoons.",
        "Scientists remain baffled by your {adjective} {subject}.",
        "If your {subject} were a smell, it would be {adjective} and illegal in three states.",
        "Your {adjective} {subject} has its own gravitational pull.",
        "A council of moths has declared your {subject} officially {adjective}.",
        "Your {subject} hums with a frequency only {adjective} whales can hear.",
        "NASA is quietly monitoring your {adjective} {subject} from orbit.",
        "Legend says your {subject} once made a houseplant achieve sentience, {adjective} as it is.",
        "Your {adjective} {subject} could win a staring contest with the sun.",
        "Cryptids have started a fan club for your {adjective} {subject}."
      ),
      adjectives = c(
        "eldritch",
        "cosmic",
        "unreasonably moist",
        "extraterrestrial",
        "haunted",
        "feral",
        "quantum",
        "suspiciously glowing",
        "prehistoric",
        "interdimensional",
        "barely legal",
        "tectonically unstable",
        "vaguely sentient",
        "chronologically confused",
        "spiritually caffeinated"
      ),
      subjects = c(
        "aura",
        "wifi signal",
        "elbow energy",
        "vibe geometry",
        "shadow",
        "left sock",
        "eyebrow game",
        "toaster intuition",
        "silhouette",
        "chakra alignment",
        "belly button lint",
        "aura's aura",
        "third eye's wifi bar",
        "kneecap wisdom",
        "haircut's magnetic field"
      )
    )
  )

  bard <- list(
    sincere = list(
      templates = c(
        "Thy {adjective} {subject} doth put the summer's day to shame.",
        "Verily, thy {subject} is most {adjective}.",
        "O, what a {adjective} {subject} thou dost possess!",
        "I prithee, never hide so {adjective} a {subject}."
      ),
      adjectives = c(
        "gentle",
        "noble",
        "sweet",
        "virtuous",
        "fair",
        "gallant"
      ),
      subjects = c(
        "countenance",
        "wit",
        "temper",
        "bearing",
        "tongue",
        "heart"
      )
    ),
    grumpy = list(
      templates = c(
        "Thy {adjective} {subject} is tolerable, I grant thee that much.",
        "For a knave, thy {subject} is passing {adjective}.",
        "Marry, thy {adjective} {subject} doth exceed my lowest expectations.",
        "Thy {subject} is {adjective} -- by thy standards, at least."
      ),
      adjectives = c(
        "passable",
        "saucy",
        "tolerable",
        "unburdensome",
        "scarce-offensive",
        "adequate"
      ),
      subjects = c(
        "jest",
        "prattle",
        "countenance",
        "labor",
        "company",
        "excuse"
      )
    ),
    cheerful = list(
      templates = c(
        "Huzzah! Thy {adjective} {subject} maketh the lark itself rejoice!",
        "O joy! O rapture! What a {adjective} {subject} thou hast!",
        "Thy {adjective} {subject} is a festival unto mine eyes!",
        "Zounds, thy {subject} is {adjective} beyond all measure!"
      ),
      adjectives = c(
        "merry",
        "jocund",
        "blithe",
        "radiant",
        "frolicsome",
        "gladsome"
      ),
      subjects = c(
        "laughter",
        "visage",
        "spirit",
        "song",
        "caper",
        "merriment"
      )
    ),
    dramatic = list(
      templates = c(
        "Thy {adjective} {subject} shall outlive the very stars!",
        "Behold! A {subject} so {adjective} the gods themselves do tremble!",
        "Eternity itself doth envy thy {adjective} {subject}.",
        "When empires fall, thy {adjective} {subject} shall remain."
      ),
      adjectives = c(
        "immortal",
        "mighty",
        "exalted",
        "thunderous",
        "sovereign",
        "eternal"
      ),
      subjects = c(
        "legend",
        "glory",
        "name",
        "triumph",
        "dominion",
        "deed"
      )
    ),
    bizarre = list(
      templates = c(
        "Thy {adjective} {subject} could summon sprites most foul.",
        "Forsooth, thy {subject} hums with {adjective} energies unknown to natural philosophy.",
        "The raccoons of the forest keep copious notes on thy {adjective} {subject}.",
        "Alchemy cannot explain thy {adjective} {subject}.",
        "Thy {adjective} {subject} bends the very fabric of the firmament."
      ),
      adjectives = c(
        "eldritch",
        "phantasmal",
        "uncanny",
        "spectral",
        "cosmicall",
        "unholy"
      ),
      subjects = c(
        "aura",
        "ether-signal",
        "shadowe",
        "vapour",
        "constellation",
        "familiar"
      )
    )
  )

  if (shakespearean) {
    tiers <- list(mood = bard[[mood]], bizarre = bard$bizarre)
    positions <- c(mood = 0, bizarre = 1)
  } else {
    tiers <- list(
      mood = modern[[mood]],
      quirky = modern$quirky,
      bizarre = modern$bizarre
    )
    positions <- c(mood = 0, quirky = 0.5, bizarre = 1)
  }

  list(tiers = tiers, positions = positions, bandwidth = min(diff(positions)))
}

farewell_banks <- function(mood, shakespearean) {
  if (shakespearean) {
    return(switch(
      mood,
      sincere = c(
        "Fare thee well, good soul.",
        "I bid thee a most gentle adieu.",
        "Part we must, yet fondly.",
        "Go with grace, and may fortune attend thee."
      ),
      grumpy = c(
        "Get thee gone, knave.",
        "Farewell, and good riddance -- I mean, godspeed.",
        "Away! Thou hast exhausted mine patience.",
        "Begone, ere I say something I shall not regret."
      ),
      cheerful = c(
        "Huzzah, farewell! What a merry parting!",
        "Adieu, adieu! Remember me with a jig!",
        "Farewell, thou delight of the realm!",
        "Parting? Nay -- a celebration of thy next adventure!"
      ),
      dramatic = c(
        "Farewell! A thousand trumpets mark thy leaving!",
        "Adieu! Should we ne'er meet again, remember this moment!",
        "The stage grows dark. Exit, pursued by my undying regard.",
        "Goeth thou now, and let the heavens record this sorrow!"
      )
    ))
  }

  switch(
    mood,
    sincere = c(
      "Goodbye, and thank you for being you.",
      "Take care -- the world is better with you in it.",
      "Farewell, friend. Until next time.",
      "It was a genuine pleasure. Go well.",
      "Safe travels. You will be missed."
    ),
    grumpy = c(
      "Fine. Bye, then.",
      "Off you go. Don't make it weird.",
      "Goodbye. Try not to break anything on your way out.",
      "Leaving already? Best news I have heard all day.",
      "Bye. You were... present."
    ),
    cheerful = c(
      "Bye-bye, you wonderful human!",
      "Farewell!! Best goodbye ever!",
      "Toodles! Go spread that sparkle!",
      "Goodbye, goodbye! I will be waving until you are out of sight!",
      "See you soon! I am already counting the minutes!"
    ),
    dramatic = c(
      "Farewell... perhaps forever.",
      "Parting is such sweet sorrow. Mostly sorrow.",
      "Go. Go now, before my heart breaks entirely!",
      "Thus ends our chapter. The saga continues.",
      "Every goodbye is a small death. This one is enormous."
    )
  )
}

apply_profanity <- function(text, profanity, adjective = NULL) {
  if (profanity == "none") {
    return(text)
  }
  intensifiers <- switch(
    profanity,
    mild = c("damn", "darn", "blinking"),
    strong = c("fucking", "goddamn")
  )
  suffixes <- switch(
    profanity,
    mild = c("darn it", "as heck", "and I mean it, darn it"),
    strong = c(
      "and I fucking mean it",
      "you magnificent bastard",
      "no bullshit"
    )
  )

  if (!is.null(adjective) && sample(c(TRUE, FALSE), 1)) {
    return(sub(
      adjective,
      paste(sample(intensifiers, 1), adjective),
      text,
      fixed = TRUE
    ))
  }
  sub(
    "([.!?])$",
    paste0(", ", sample(suffixes, 1), "\\1"),
    text
  )
}
