Program PlayBookingsGui;

{$H+}

Uses
  Interfaces, Forms, Windows, SysUtils, uMain, shotutil;

{$R *.res}

Procedure TypeInto (aControl : THandle; aText : String);
Var
  index : Integer;
Begin
  For index := 1 To Length (aText) Do
  Begin
    PostMessage (aControl, WM_CHAR, Ord (aText[index]), 0);
    Settle (20);
  End;
End;

Begin
  If ParamStr (1) = 'shots' Then
  Begin
    MakeAware;
  End;
  RequireDerivedFormResource := True;
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm (TfrmMain, frmMain);
  If ParamStr (1) = 'shots' Then
  Begin
    OutDir := ExtractFilePath (ParamStr (0)) + 'out\';
    ForceDirectories (OutDir);
    frmMain.Show;
    Settle (500);
    CaptureForm (frmMain, 'good-empty');
    frmMain.edtName.SetFocus;
    TypeInto (frmMain.edtName.Handle, 'Thabo Mokoena');
    frmMain.medCell.SetFocus;
    Settle (100);
    frmMain.medCell.SelStart := 0;
    TypeInto (frmMain.medCell.Handle, '082123');
    frmMain.sedTickets.Value := 2;
    frmMain.rgpSeats.ItemIndex := 1;
    Settle (100);
    frmMain.btnBook.Click;
    CaptureForm (frmMain, 'good-error');
    frmMain.medCell.SelStart := 0;
    frmMain.medCell.Clear;
    frmMain.medCell.SelStart := 0;
    TypeInto (frmMain.medCell.Handle, '0821234567');
    frmMain.sedTickets.Value := 2;
    frmMain.rgpSeats.ItemIndex := 1;
    frmMain.btnBook.Click;
    TypeInto (frmMain.edtName.Handle, 'Lebo Dlamini');
    frmMain.medCell.SetFocus;
    frmMain.medCell.SelStart := 0;
    TypeInto (frmMain.medCell.Handle, '0719876543');
    frmMain.sedTickets.Value := 4;
    frmMain.btnBook.Click;
    TypeInto (frmMain.edtName.Handle, 'Pieter van der Merwe');
    frmMain.medCell.SetFocus;
    frmMain.medCell.SelStart := 0;
    TypeInto (frmMain.medCell.Handle, '0835550101');
    frmMain.btnBook.Click;
    TypeInto (frmMain.edtName.Handle, 'Aisha Patel');
    frmMain.medCell.SetFocus;
    frmMain.medCell.SelStart := 0;
    TypeInto (frmMain.medCell.Handle, '0605552020');
    frmMain.sedTickets.Value := 3;
    frmMain.rgpSeats.ItemIndex := 1;
    Settle (100);
    CaptureForm (frmMain, 'good-saved');
    frmMain.Free;
  End
  Else
  Begin
    Application.Run;
  End;
End.
