Unit uMain;

{$H+}

Interface

Uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, MaskEdit, Spin, LCLType, uBooking;

Const
  maxBookings = 20;

Type
  TBookingArray = Array [1..maxBookings] Of TBooking;

  TfrmMain = Class (TForm)
    pnlTop       : TPanel;
    lblTitle     : TLabel;
    gbxBooking   : TGroupBox;
    lblName      : TLabel;
    edtName      : TEdit;
    lblCell      : TLabel;
    medCell      : TMaskEdit;
    lblTickets   : TLabel;
    sedTickets   : TSpinEdit;
    rgpSeats     : TRadioGroup;
    lblTotalText : TLabel;
    lblTotal     : TLabel;
    lblMessage   : TLabel;
    btnBook      : TButton;
    btnClear     : TButton;
    gbxBookings  : TGroupBox;
    lstBookings  : TListBox;
    stbStatus    : TStatusBar;
    Procedure FormCreate (Sender : TObject);
    Procedure FormDestroy (Sender : TObject);
    Procedure FormKeyDown (Sender : TObject; Var Key : Word; Shift : TShiftState);
    Procedure btnBookClick (Sender : TObject);
    Procedure btnClearClick (Sender : TObject);
    Procedure sedTicketsChange (Sender : TObject);
    Procedure rgpSeatsClick (Sender : TObject);
  private
    bookings : TBookingArray;
    count    : Integer;
    Procedure ShowTotal;
    Procedure ShowMessageLine (aMessage : String; aColour : TColor);
  End; // TfrmMain

Var
  frmMain : TfrmMain;

Implementation

{$R *.lfm}

// Starts with no bookings and the total for one standard seat.
// Sender - the form
Procedure TfrmMain.FormCreate (Sender : TObject);
Begin
  count := 0;
  ShowTotal;
End; // TfrmMain.FormCreate

// Frees every booking when the form closes.
// Sender - the form
Procedure TfrmMain.FormDestroy (Sender : TObject);
Var
  index : Integer;
Begin
  For index := 1 To count Do
  Begin
    bookings[index].Free;
  End; // for
End; // TfrmMain.FormDestroy

// F1 shows the help, wherever the cursor is.
// Sender - the form
// Key    - the key pressed
// Shift  - Shift, Ctrl or Alt held down
Procedure TfrmMain.FormKeyDown (Sender : TObject; Var Key : Word; Shift : TShiftState);
Begin
  If Key = VK_F1 Then
  Begin
    ShowMessage ('Fill in the name, the cell number and the number of tickets, choose the seats, then click Book (or press Enter). Esc clears the form.');
  End; // if
End; // TfrmMain.FormKeyDown

// Writes a message under the form in a colour.
// aMessage - the words to show
// aColour  - clRed for a problem, clGreen for good news
Procedure TfrmMain.ShowMessageLine (aMessage : String; aColour : TColor);
Begin
  lblMessage.Font.Color := aColour;
  lblMessage.Caption := aMessage;
End; // TfrmMain.ShowMessageLine

// Shows what the chosen seats cost - the class works it out, not the form.
Procedure TfrmMain.ShowTotal;
Var
  booking : TBooking;
Begin
  booking := TBooking.Create;
  booking.SetTickets (sedTickets.Value);
  booking.SetIsVip (rgpSeats.ItemIndex = 1);
  lblTotal.Caption := 'R' + IntToStr (booking.GetTotal);
  booking.Free;
End; // TfrmMain.ShowTotal

// A new number of tickets - show the new total.
// Sender - the spin edit
Procedure TfrmMain.sedTicketsChange (Sender : TObject);
Begin
  ShowTotal;
End; // TfrmMain.sedTicketsChange

// Other seats - show the new total.
// Sender - the radio group
Procedure TfrmMain.rgpSeatsClick (Sender : TObject);
Begin
  ShowTotal;
End; // TfrmMain.rgpSeatsClick

// Reads the form into a new booking. The class checks every value; if it
// refuses one, its message is shown and the cursor goes back to that box.
// Sender - the Book button
Procedure TfrmMain.btnBookClick (Sender : TObject);
Var
  booking : TBooking;
  box     : TWinControl;
Begin
  If count = maxBookings Then
  Begin
    ShowMessageLine ('The play is full - no more bookings.', clRed);
  End // if
  Else
  Begin
    booking := TBooking.Create;
    box := edtName;
    Try
      booking.SetName (edtName.Text);
      box := medCell;
      booking.SetCellNumber (medCell.Text);
      box := sedTickets;
      booking.SetTickets (sedTickets.Value);
      booking.SetIsVip (rgpSeats.ItemIndex = 1);

      // Keep it, show it, and clear the form for the next one
      count := count + 1;
      bookings[count] := booking;
      lstBookings.Items.Add (booking.ToString);
      ShowMessageLine ('Booking saved.', clGreen);
      btnClearClick (Sender);
    Except
      On problem : Exception Do
      Begin
        booking.Free;
        ShowMessageLine (problem.Message, clRed);
        box.SetFocus;
      End; // on
    End; // try
  End; // else
End; // TfrmMain.btnBookClick

// Empties the form for a new booking.
// Sender - the Clear button, or Esc
Procedure TfrmMain.btnClearClick (Sender : TObject);
Begin
  edtName.Clear;
  medCell.Clear;
  sedTickets.Value := 1;
  rgpSeats.ItemIndex := 0;
  edtName.SetFocus;
End; // TfrmMain.btnClearClick

End.
