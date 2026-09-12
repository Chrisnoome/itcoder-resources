# Writing style for lesson prose - the base rules

These are the base rules for every word a pupil reads on itcoder.
[content-voice-and-pedagogy.md](content-voice-and-pedagogy.md) builds on them
with voice and pedagogy for new lessons; where the two overlap they agree.

Calibrated in September 2026 against Chris's own hardware notes (the InsAInity
`hw_*.docx` set, copies in `word documents/`). Match those, not an essay. This
matters more than anything else in a content file. Moved here from itcoder's
CLAUDE.md on 11 September 2026.

## The rules

- Plain, conversational English pitched at South African teenagers.
- Direct address - "you", not "the pupil".
- **Short sentences. Often one sentence per paragraph.** This is the single
  biggest thing. If a sentence has two clauses joined by a comma, try a full
  stop.
- **Bulleted lists for anything enumerable** - steps, parts, manufacturers,
  consequences, comparisons. Chris lists far more than most writers do.
- **Concrete physical analogies**, the more everyday the better. His own:
  "the head will smash into it like the side of a mountain", "cleaner than a
  hospital's operating theatre", "with 2 cores you could fit two brains inside
  your head!"
- **Exclamation marks are allowed** - for the surprising fact, not for
  enthusiasm about the topic.
- **`Warning:` and `Note:` callouts** (`<div class="callout">`) wherever there
  is a terminology confusion or a common mistake to head off. Chris uses these a
  lot.
- **A quote at the top of each lesson** (`<blockquote class="quote">` with a
  `<cite>`), matching the quote banks in his documents. Humour is welcome in
  them. `word documents/_ALL_QUOTES.docx` is the bank - see
  content-voice-and-pedagogy.md §5 for a data-quality trap in it.
- Hyphens, not em dashes.
- Local examples. Load shedding, the Springboks, rands, Afrikaans,
  Johannesburg. Not Silicon Valley. The pupils have English and some Afrikaans -
  isiZulu examples do not land with this group, so do not reach for them.
- No jargon without immediately unpacking it. "X stands for Y", plainly.
- Never talk down to them. The material is genuinely interesting; trust it.
- Say "pupil", not "learner", in all new copy (Chris, 11 September 2026).

## What to avoid

Writerly, essayistic constructions read fine in chat and are wrong on the page
for a fifteen-year-old. Phrases like "that word does a lot of hiding", "the
reason this lesson sits where it does", "this lesson opens it up", or "here is
the part that surprises people" were all cut in the September 2026 restyle. If a
sentence sounds like an author admiring their own structure, delete it and say
the thing instead.

## Two standing cautions

**Numbers go stale fast.** GPU prices, token prices and data centre figures move
month to month. Search for current South African pricing rather than writing
from memory, and prefer comparisons that survive ("about the price of a decent
second-hand car") over figures that don't.

**Don't invent YouTube IDs.** Half would be dead or wrong. A blank `youtubeId`
renders an amber box with a pre-built search link, and Chris fills it in after
vetting the video.
