Program ColourMeaning;

{$H+}

Uses Crt;

Begin
  ClrScr;

  // Colour with a meaning
  TextColor (LightRed);
  Writeln ('Error: a cell number is 10 digits, like 0821234567.');
  TextColor (LightGreen);
  Writeln ('Booking saved.');
  TextColor (Yellow);
  Writeln ('Only 3 seats left.');
  TextColor (LightGray);
  Writeln ('Plain text stays light grey.');
  Writeln;

  // Colours that are hard to read
  TextColor (Blue);
  Writeln ('Dark blue on black is hard to read.');
  TextColor (Red);
  TextBackground (Green);
  Writeln ('Red on green hurts - and some people can''t tell them apart.');
  TextColor (Yellow);
  TextBackground (LightGray);
  Writeln ('Yellow on light grey almost vanishes.');

  // Back to normal
  TextColor (LightGray);
  TextBackground (Black);
  Writeln;
End.
