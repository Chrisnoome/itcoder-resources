Program MoreForms;

{$H+}

// Lesson 23's second form, components made in code, a TTimer, InputBox and
// ShowMessage. Run with no parameter to use it; with "shots" it takes the
// screenshots into out\ and quits (see ../../README.md).

Uses
  Interfaces, Forms, Windows, Classes, SysUtils, Controls, StdCtrls, ExtCtrls,
  uMain, uDetails, uSeats, shotutil;

{$R *.res}

Type
  TShooter = Class (TObject)
    step  : String;
    timer : TTimer;
    Procedure Tick (Sender : TObject);
  End;

Var
  shooter : TShooter;

Function FindChild (aParent : TWinControl; aClass : TClass) : TControl;
Var
  index : Integer;
Begin
  Result := Nil;
  For index := 0 To aParent.ControlCount - 1 Do
  Begin
    If (Result = Nil) And (aParent.Controls[index] Is aClass) Then
      Result := aParent.Controls[index];
    If (Result = Nil) And (aParent.Controls[index] Is TWinControl) Then
      Result := FindChild (TWinControl (aParent.Controls[index]), aClass);
  End;
End;

Procedure TShooter.Tick (Sender : TObject);
Var
  form : TForm;
  edit : TControl;
  box  : HWND;
Begin
  timer.Enabled := False;
  If step = 'details' Then
  Begin
    CaptureForm (frmDetails, 'forms-details');
    frmDetails.ModalResult := mrOk;
  End
  Else If step = 'input' Then
  Begin
    form := Screen.ActiveForm;
    edit := FindChild (form, TEdit);
    If edit <> Nil Then
      TEdit (edit).Text := 'lebo dlamini';
    CaptureHandle (form.Handle, 'forms-inputbox');
    step := 'message';
    form.ModalResult := mrOk;
    timer.Enabled := True;
  End
  Else If step = 'message' Then
  Begin
    box := GetForegroundWindow;
    CaptureHandle (box, 'forms-message');
    PostMessage (box, WM_CLOSE, 0, 0);
  End;
End;

Procedure ClickSeat (aCaption : String);
Var
  index : Integer;
Begin
  For index := 0 To frmSeats.pnlSeats.ControlCount - 1 Do
    If TButton (frmSeats.pnlSeats.Controls[index]).Caption = aCaption Then
      TButton (frmSeats.pnlSeats.Controls[index]).Click;
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
  Application.CreateForm (TfrmDetails, frmDetails);
  Application.CreateForm (TfrmSeats, frmSeats);
  If ParamStr (1) = 'shots' Then
  Begin
    OutDir := ExtractFilePath (ParamStr (0)) + 'out\';
    ForceDirectories (OutDir);
    shooter := TShooter.Create;
    shooter.timer := TTimer.Create (Nil);
    shooter.timer.Enabled := False;
    shooter.timer.Interval := 700;
    shooter.timer.OnTimer := @shooter.Tick;

    frmMain.Show;
    frmMain.lstBookings.ItemIndex := 0;
    Settle (500);
    CaptureForm (frmMain, 'forms-main');

    shooter.step := 'details';
    shooter.timer.Enabled := True;
    frmMain.btnDetails.Click;

    shooter.step := 'input';
    shooter.timer.Enabled := True;
    frmMain.btnFind.Click;
    Settle (300);

    frmSeats.Show;
    Settle (300);
    ClickSeat ('B4');
    ClickSeat ('B5');
    ClickSeat ('A6');
    frmSeats.btnSpot.Click;
    Settle (1200);
    CaptureForm (frmSeats, 'forms-seats');
    frmSeats.btnSpot.Click;
    frmMain.Close;
  End
  Else
  Begin
    Application.Run;
  End;
End.
