# BestLessons - logo and icons

The site is being rebranded from itcoder.co.za to **bestlessons.co.za** (Chris,
26 September 2026). These are the chosen designs; the site itself has not been
changed yet. Every idea considered, and the rounds that led here, are on the
design board: https://claude.ai/artifact/NNVpy8Gudz4oEBXRnL9e8N

## What was chosen

- **Wordmark "E":** "best" over "lessons", heavy black lowercase, both words
  exactly the same width; a blue line underneath that rises from the left and
  eases off to the right, with round ends; ".co.za" small in blue under the
  line's right end. Written as **BestLessons** in text.
- **App icon "2-1":** "bl" in heavy black with the blue line, on a white
  rounded tile - the main icon and the favicon.
- **Phone icon "2-2":** the same on black, with a light blue line.

## The rules

- **Typeface:** Montserrat - ExtraBold (800) for the words, Bold (700) for
  ".co.za", Black (900) for "bl". In the files the letters are outlines, so no
  font is needed to show them.
- **Colours:** ink `#111111`; blue `#1a55e3`; on dark backgrounds white and
  light blue `#7ea6ff`.
- **Never** stretch it, re-space it, recolour the words, or set ".co.za"
  anywhere but under the right end of the line. Keep clear space of at least
  the height of ".co.za" all round (the files already have it).
- Too small for ".co.za" to read (under about 120 px wide)? Use the icon
  instead of the wordmark.

## The files

| File | Use |
|---|---|
| `bestlessons-logo.svg` / `.png` (1886 x 1704) / `-small.png` | The wordmark on light backgrounds |
| `bestlessons-logo-on-dark.svg` / `.png` | The wordmark on dark backgrounds |
| `bestlessons-icon.svg`, `icon-512.png`, `icon-192.png` | The main icon (white tile); web app manifest "any" icons |
| `favicon.ico` (16, 32, 48), `favicon-32.png`, `favicon-16.png` | Browser tabs |
| `bestlessons-icon-phone.svg`, `icon-phone-512.png` | The black icon with rounded corners |
| `bestlessons-icon-phone-square.svg`, `apple-touch-icon.png` (180), `icon-512-maskable.png` | Phones: full-bleed squares, because iOS and Android round the corners themselves |

`source/` has the two scripts that made them: `brandbuild.py` draws the SVGs
from Montserrat (needs fontTools), `brandrender.py` renders the PNGs and the
.ico with headless Chrome and Pillow.
