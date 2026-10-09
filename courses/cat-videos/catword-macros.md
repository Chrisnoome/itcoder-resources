# catword lesson 26: Macros (IEB) - videos

Lesson: `content/catword/macros.php` (Grade 12, IEB). Screen recordings in
the CAT VM (Word 365), starting from Committee letter.docx (G:\My
Drive\CAT\Word). Record the demonstration macro in the document (Store
macro in: the document) and close it without saving afterwards, so the
VM's Normal.dotm is not changed; never open or enable a macro from a file
that did not come from this lesson. Never show the title bar's account.
Board scenes in the CAT marker style with Clicky; yellow highlighter on
what is talked about. Say once, early: the IEB asks for macros in Grade 12;
CAPS does not. Never "in the exam".

## catword-26.1 Recording and running a macro (about 8 min)

**Goes:** after the match `mVba`, before section `#save` (the comment
`// VIDEO catword-26.1`).
**The pupil can afterwards:** record a macro with a name, a shortcut key
and a place to store it; stop it; run it (shortcut, Alt+F8); look at its
code in the Visual Basic editor; save it in a .docm; and decide whether to
click Enable Content.
**Thumbnail:** tag `CAT · WORD`, title "Teach Word *one* trick"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Twelve letters a
   week, the same sign-off typed twelve times.
   > Board: Clicky typing the same line on a stack of letters, the stack
   > growing; then a robot (the macro) doing it with one key.
2. **What a macro is (0:40-1:30).** Recorded steps, played back; VBA, which
   the recorder writes; good jobs for a macro.
3. **Recording (1:30-3:30).** Click at the end of the letter; View > Macros
   arrow > Record Macro; name SignOff (no spaces); Store macro in; Keyboard:
   the Customize Keyboard box, press Alt+Ctrl+S, Currently assigned to:
   [unassigned], Assign, Close; type the sign-off; Stop Recording (or the
   square on the status bar). Keyboard, not mouse dragging, while
   recording.
   > Screen: each box; yellow highlighter on Currently assigned to.
4. **Running (3:30-4:30).** Undo the typed sign-off; Alt+Ctrl+S - it types
   itself. Alt+F8 > SignOff > Run. Ctrl+J was Justify: a key taken over.
5. **Viewing (4:30-5:40).** Alt+F8 > Edit: the Visual Basic editor; Sub
   SignOff() ... End Sub; TypeText, TypeParagraph; close without changing.
   > Board: the code as a recipe card, each line a step.
6. **Keeping it (5:40-6:40).** Normal.dotm or the document; Save As > Word
   Macro-Enabled Document (.docm); the warning when saving as .docx.
7. **Security (6:40-7:40).** A macro is a program; the yellow SECURITY
   WARNING bar; Enable Content only for a file you expected from someone you
   trust; Trust Center > Macro Settings.
   > Board: a Trojan horse made of a .docm icon, Gogo shaking her head.
8. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| what a macro is; VBA | `#what` |
| Record Macro: name, store in, stop | `#record` |
| Keyboard and the Customize Keyboard box | `#shortcut` |
| shortcut, Alt+F8, Run | `#run` |
| the Visual Basic editor | `#view` |
| .docm, Normal.dotm | `#save` |
| Enable Content, Trust Center | `#security` |
