Program PlayBookingsGui;

{$H+}

Uses
  Interfaces, Forms, Windows, SysUtils, uBookingForm, shotutil;

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
  Application.CreateForm (TfrmBooking, frmBooking);
  If ParamStr (1) = 'shots' Then
  Begin
    OutDir := ExtractFilePath (ParamStr (0)) + 'out\';
    ForceDirectories (OutDir);
    frmBooking.Show;
    Settle (500);
    CaptureForm (frmBooking, 'good-empty');
    frmBooking.edtName.SetFocus;
    TypeInto (frmBooking.edtName.Handle, 'Thabo Mokoena');
    frmBooking.medCell.SetFocus;
    Settle (100);
    frmBooking.medCell.SelStart := 0;
    TypeInto (frmBooking.medCell.Handle, '082123');
    frmBooking.sedTickets.Value := 2;
    frmBooking.rgpSeats.ItemIndex := 1;
    Settle (100);
    frmBooking.btnBook.Click;
    CaptureForm (frmBooking, 'good-error');
    frmBooking.medCell.SelStart := 0;
    frmBooking.medCell.Clear;
    frmBooking.medCell.SelStart := 0;
    TypeInto (frmBooking.medCell.Handle, '0821234567');
    frmBooking.sedTickets.Value := 2;
    frmBooking.rgpSeats.ItemIndex := 1;
    frmBooking.btnBook.Click;
    TypeInto (frmBooking.edtName.Handle, 'Lebo Dlamini');
    frmBooking.medCell.SetFocus;
    frmBooking.medCell.SelStart := 0;
    TypeInto (frmBooking.medCell.Handle, '0719876543');
    frmBooking.sedTickets.Value := 4;
    frmBooking.btnBook.Click;
    TypeInto (frmBooking.edtName.Handle, 'Pieter van der Merwe');
    frmBooking.medCell.SetFocus;
    frmBooking.medCell.SelStart := 0;
    TypeInto (frmBooking.medCell.Handle, '0835550101');
    frmBooking.btnBook.Click;
    TypeInto (frmBooking.edtName.Handle, 'Aisha Patel');
    frmBooking.medCell.SetFocus;
    frmBooking.medCell.SelStart := 0;
    TypeInto (frmBooking.medCell.Handle, '0605552020');
    frmBooking.sedTickets.Value := 3;
    frmBooking.rgpSeats.ItemIndex := 1;
    Settle (100);
    CaptureForm (frmBooking, 'good-saved');
    frmBooking.Free;
  End
  Else
  Begin
    Application.Run;
  End;
End.
