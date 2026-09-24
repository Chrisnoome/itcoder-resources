Program BadPrompts;

{$H+}

Var
  name    : String;
  tickets : Integer;
  total   : Integer;

Begin
  Writeln ('name');
  Readln (name);
  Writeln ('ENTER NUMBER');
  Readln (tickets);
  total := tickets * 80;
  Writeln (total);
End.
