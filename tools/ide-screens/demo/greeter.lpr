Program Greeter;

{$mode objfpc}{$H+}

Uses
  Interfaces, Forms, uMain;

{$R *.res}

Begin
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm (TfrmMain, frmMain);
  Application.Run;
End.
