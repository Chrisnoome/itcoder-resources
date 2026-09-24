Program BoxMenu;

{$H+}

Uses Crt;

// Draws a hollow box on the screen, then goes back to the normal colours.
// aLeft       - the column of the top-left corner
// aTop        - the row of the top-left corner
// aWidth      - how many characters wide the box is
// aHeight     - how many rows tall the box is
// aTextColour - the colour of the box's lines
// aBackColour - the colour behind the lines
Procedure DrawBox (aLeft, aTop, aWidth, aHeight, aTextColour, aBackColour : Integer);
Var
  column : Integer;
  row    : Integer;
  right  : Integer;
  bottom : Integer;
Begin
  right := aLeft + aWidth - 1;
  bottom := aTop + aHeight - 1;
  TextColor (aTextColour);
  TextBackground (aBackColour);
  // The top and bottom edges
  For column := aLeft To right Do
  Begin
    GotoXY (column, aTop);
    Write ('-');
    GotoXY (column, bottom);
    Write ('-');
  End; // for column
  // The left and right edges
  For row := aTop To bottom Do
  Begin
    GotoXY (aLeft, row);
    Write ('|');
    GotoXY (right, row);
    Write ('|');
  End; // for row
  // The four corners
  GotoXY (aLeft, aTop);
  Write ('+');
  GotoXY (right, aTop);
  Write ('+');
  GotoXY (aLeft, bottom);
  Write ('+');
  GotoXY (right, bottom);
  Write ('+');
  // Back to the normal colours
  TextColor (LightGray);
  TextBackground (Black);
End; // DrawBox

Var
  key : Char;

Begin
  ClrScr;
  DrawBox (25, 5, 30, 11, Yellow, Black);
  TextColor (Yellow);
  GotoXY (33, 6);
  Write ('TUCK SHOP MENU');
  TextColor (LightGray);
  GotoXY (29, 8);
  Write ('1   Buy something');
  GotoXY (29, 9);
  Write ('2   See today''s sales');
  GotoXY (29, 10);
  Write ('3   Change a price');
  GotoXY (29, 12);
  Write ('Esc Quit');
  GotoXY (29, 14);
  Write ('Press a key: ');
  key := ReadKey;
  GotoXY (1, 18);
  Writeln ('You pressed #', Ord (key), '.');
End.
