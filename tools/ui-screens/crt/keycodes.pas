Program KeyCodes;

{$H+}

Uses Crt;

Var
  key : Char;

Begin
  Writeln ('Press keys to see their codes. Esc stops.');
  Repeat
    key := ReadKey;
    If key = #0 Then
    Begin
      key := ReadKey;
      Writeln ('A special key: #0, then #', Ord (key));
    End // if
    Else
    Begin
      Writeln ('#', Ord (key));
    End; // else
  Until key = #27; // repeat
End.
