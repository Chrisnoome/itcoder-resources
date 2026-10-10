# Grade 8 Club website (`clubweb`) art style: comic panels, isometric blocks, Tag and Gat

Chris chose these on 10 October 2026, from the board
(https://claude.ai/artifact/FPiQQ8cvkryVYXtBCwdjFV, source `brand/clubweb-art-board.html`):
- **"f and h combined"**, the comic book and the isometric blocks;
- the mascots **Tag and Gat**;
- **real screenshots** for "the page the club wants".

No other course uses this look. Each course's style is its own.

## The look: comic panels with isometric blocks inside

- **Comic panels.** Each figure is one or more comic panels: thick black ink borders
  (`#111`, 4 px at 520 wide), flat primary-colour panel backgrounds, and speech bubbles with
  tails.
  - **Panel colours:** yellow `#ffe14d`, sky `#7fd3ff`, pink `#ff8fa3`, plus white `#ffffff`.
  - **Accent red:** `#e63b2e`.
  - **Captions and speech:** **Rubik Mono One** in capitals for short captions and shouts;
    **Inter Tight** for anything longer in a bubble.
  - A story moment is a strip of two to four panels.
- **Isometric blocks inside the panels.** HTML elements are drawn as 3D isometric blocks:
  - **Nesting is stacking.** A block sits on top of the block it is inside. `<body>` is the
    base slab; `<h1>`, `<p>`, `<ul>` and `<img>` sit on it; `<li>` blocks sit on the `<ul>`.
  - **One colour per kind of element**, the same in every figure: base slabs (html/body)
    in `#d8e1f0` with darker sides; headings violet `#6c5ce7`; text blocks (p) teal `#2ec4b6`;
    lists amber `#ffb84d`; images coral `#ff7a59`; links blue `#3b82f6`; tables green
    `#7bc96f`.
  - **Labels:** blocks are labelled with their tag in **Space Mono**, with a dashed leader
    line.
- **SVG, drawn by the chats.** Scripts go in `AIResources/tools/clubweb/`; the figures go
  in `AIPascalCourse/public/assets/doodles/clubweb-*.svg`. No ComfyUI.

## Tag and Gat

The mascots are two angle brackets with faces: **Tag**, the opening bracket `<` (blue
`#2f6fde`), and **Gat**, the closing bracket `>` (pink `#ff4f7a`). They are always together,
because every tag that is opened must be closed.

Their jobs:
- **In the comic strips,** Tag and Gat explain things in speech bubbles.
- **In the margin doodles,** one-line captions (content-voice-and-pedagogy.md §5b).
- **In the gags,** Gat gets lost when a tag is left unclosed, and Tag shouts the headings.

They are drawn in the comic ink style: a thick outline, flat colour and simple faces.

## "The page the club wants"

These are **real screenshots** of the model page in a browser, never drawn, so pupils compare
like with like. Take them in the VM or headless Chrome at a fixed width (800 px), framed in a
simple browser window. The HTML block's own live preview is unchanged.
