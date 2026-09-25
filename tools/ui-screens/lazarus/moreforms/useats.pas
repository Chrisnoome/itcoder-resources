Unit uSeats;

{$H+}

Interface

Uses
  Classes, SysUtils, Forms, Controls, Graphics, StdCtrls, ExtCtrls;

Const
  noOfRows  = 3;
  seatsInRow = 8;

Type
  TfrmSeats = Class (TForm)
    pnlStage   : TPanel;
    shpSpot    : TShape;
    tmrSpot    : TTimer;
    btnSpot    : TButton;
    pnlSeats   : TPanel;
    lblMessage : TLabel;
    Procedure FormCreate (Sender : TObject);
    Procedure tmrSpotTimer (Sender : TObject);
    Procedure btnSpotClick (Sender : TObject);
  private
    stepSize : Integer;
    Procedure SeatClick (Sender : TObject);
  End; // TfrmSeats

Var
  frmSeats : TfrmSeats;

Implementation

{$R *.lfm}

// Makes one button per seat, in rows A to C, sized to fit the panel.
// Sender - the form
Procedure TfrmSeats.FormCreate (Sender : TObject);
Var
  row        : Integer;
  seat       : Integer;
  seatWidth  : Integer;
  seatHeight : Integer;
  seatButton : TButton;
Begin
  seatWidth := pnlSeats.ClientWidth Div seatsInRow;
  seatHeight := pnlSeats.ClientHeight Div noOfRows;
  For row := 1 To noOfRows Do
  Begin
    For seat := 1 To seatsInRow Do
    Begin
      seatButton := TButton.Create (Self);
      seatButton.Parent := pnlSeats;
      seatButton.Caption := Chr (Ord ('A') + row - 1) + IntToStr (seat);
      seatButton.Left := (seat - 1) * seatWidth + 4;
      seatButton.Top := (row - 1) * seatHeight + 4;
      seatButton.Width := seatWidth - 8;
      seatButton.Height := seatHeight - 8;
      seatButton.OnClick := @SeatClick;
    End; // for seat
  End; // for row
  stepSize := 6;
End; // TfrmSeats.FormCreate

// Books the seat whose button was clicked.
// Sender - the seat's button
Procedure TfrmSeats.SeatClick (Sender : TObject);
Var
  seatButton : TButton;
Begin
  seatButton := Sender As TButton;
  seatButton.Enabled := False;
  lblMessage.Caption := 'Seat ' + seatButton.Caption + ' is booked.';
End; // TfrmSeats.SeatClick

// Moves the spotlight a little, and turns it round at either edge of the stage.
// Sender - the timer
Procedure TfrmSeats.tmrSpotTimer (Sender : TObject);
Begin
  shpSpot.Left := shpSpot.Left + stepSize;
  If (shpSpot.Left + shpSpot.Width >= pnlStage.ClientWidth) Or (shpSpot.Left <= 0) Then
  Begin
    stepSize := -stepSize;
  End; // if
End; // TfrmSeats.tmrSpotTimer

// Switches the spotlight on or off.
// Sender - the spotlight button
Procedure TfrmSeats.btnSpotClick (Sender : TObject);
Begin
  tmrSpot.Enabled := Not tmrSpot.Enabled;
  If tmrSpot.Enabled Then
  Begin
    btnSpot.Caption := 'Stop the spotlight';
  End // if
  Else
  Begin
    btnSpot.Caption := 'Start the spotlight';
  End; // else
End; // TfrmSeats.btnSpotClick

End.
