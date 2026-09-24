Program FontDemo;

{$H+}

Uses
  Interfaces, Forms, SysUtils, uMain, shotutil;

{$R *.res}

Begin
  If ParamStr (1) <> '' Then
  Begin
    MakeAware;
  End;
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm (TfrmMain, frmMain);
  If ParamStr (1) <> '' Then
  Begin
    OutDir := ExtractFilePath (ParamStr (0)) + 'out\';
    ForceDirectories (OutDir);
    frmMain.Show;
    CaptureForm (frmMain, ParamStr (1));
    frmMain.Free;
  End
  Else
  Begin
    Application.Run;
  End;
End.
