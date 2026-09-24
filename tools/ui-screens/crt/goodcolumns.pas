Program GoodColumns;

{$H+}

Uses SysUtils;

Begin
  Writeln (Format ('%-22s', ['Name']), 'Tickets':8, 'Total':10);
  Writeln (StringOfChar ('-', 40));
  Writeln (Format ('%-22s', ['Thabo Mokoena']), 2:8, 300.0:10:2);
  Writeln (Format ('%-22s', ['Lebo Dlamini']), 4:8, 320.0:10:2);
  Writeln (Format ('%-22s', ['Pieter van der Merwe']), 1:8, 80.0:10:2);
  Writeln (StringOfChar ('-', 40));
  Writeln (Format ('%-22s', ['Total']), 7:8, 700.0:10:2);
End.
