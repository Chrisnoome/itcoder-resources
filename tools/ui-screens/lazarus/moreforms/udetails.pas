Unit uDetails;

{$H+}

Interface

Uses
  Classes, SysUtils, Forms, Controls, Graphics, StdCtrls, uBooking;

Type
  TfrmDetails = Class (TForm)
    lblNameText    : TLabel;
    lblName        : TLabel;
    lblCellText    : TLabel;
    lblCell        : TLabel;
    lblTicketsText : TLabel;
    lblTickets     : TLabel;
    lblTotalText   : TLabel;
    lblTotal       : TLabel;
    btnOK          : TButton;
    Procedure FormShow (Sender : TObject);
  private
    booking : TBooking;
  public
    Procedure SetBooking (aBooking : TBooking);
  End; // TfrmDetails

Var
  frmDetails : TfrmDetails;

Implementation

{$R *.lfm}

// Remembers which booking to show. The main form still owns it.
// aBooking - the booking to show
Procedure TfrmDetails.SetBooking (aBooking : TBooking);
Begin
  booking := aBooking;
End; // TfrmDetails.SetBooking

// Fills in the labels every time the form is shown.
// Sender - the form
Procedure TfrmDetails.FormShow (Sender : TObject);
Begin
  lblName.Caption := booking.GetName;
  lblCell.Caption := booking.GetCellNumber;
  lblTickets.Caption := IntToStr (booking.GetTickets);
  If booking.GetIsVip Then
  Begin
    lblTickets.Caption := lblTickets.Caption + ' VIP';
  End; // if
  lblTotal.Caption := 'R' + IntToStr (booking.GetTotal);
End; // TfrmDetails.FormShow

End.
