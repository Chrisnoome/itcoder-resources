Program TitleBar;

{$H+}

Uses Crt;

Begin
  ClrScr;

  // A title bar: blue from one side of the screen to the other
  TextBackground (Blue);
  TextColor (White);
  GotoXY (1, 1);
  ClrEol;
  GotoXY (3, 1);
  Write ('MY PROGRAM');

  // A long line, then wipe it from column 22 to the end
  TextBackground (Black);
  TextColor (LightGray);
  GotoXY (3, 3);
  Write ('Hello, this line is far too long to keep.');
  GotoXY (22, 3);
  ClrEol;
  GotoXY (1, 5);
End.
