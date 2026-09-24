Program GoodPrompts;

{$H+}

Var
  name    : String;
  tickets : Integer;
  total   : Integer;

Begin
  Writeln ('SCHOOL PLAY TICKETS');
  Writeln ('Tickets cost R80 each.');
  Writeln;
  Write ('Your name and surname: ');
  Readln (name);
  Write ('Number of tickets (1 to 6): ');
  Readln (tickets);
  total := tickets * 80;
  Writeln;
  Writeln (name, ', your ', tickets, ' tickets cost R', total, '.');
  Writeln ('Pay at the school office before Friday.');
End.
