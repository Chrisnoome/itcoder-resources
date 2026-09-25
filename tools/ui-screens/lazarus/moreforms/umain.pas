Unit uMain;

{$H+}

Interface

Uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  uBooking;

Const
  maxBookings  = 20;
  bookingsFile = 'bookings.txt';

Type
  TBookingArray = Array [1..maxBookings] Of TBooking;

  TfrmMain = Class (TForm)
    pnlTop      : TPanel;
    lblTitle    : TLabel;
    lstBookings : TListBox;
    btnDetails  : TButton;
    btnFind     : TButton;
    btnSeats    : TButton;
    btnSave     : TButton;
    btnLoad     : TButton;
    Procedure FormCreate (Sender : TObject);
    Procedure FormDestroy (Sender : TObject);
    Procedure btnDetailsClick (Sender : TObject);
    Procedure btnFindClick (Sender : TObject);
    Procedure btnSeatsClick (Sender : TObject);
    Procedure btnSaveClick (Sender : TObject);
    Procedure btnLoadClick (Sender : TObject);
  private
    bookings : TBookingArray;
    count    : Integer;
    Procedure AddBooking (aName : String; aCell : String; aTickets : Integer; aIsVip : Boolean);
  End; // TfrmMain

Var
  frmMain : TfrmMain;

Implementation

{$R *.lfm}

Uses
  uDetails, uSeats;

// Makes a booking, keeps it, and shows it in the list.
// aName    - the name and surname
// aCell    - the cell number
// aTickets - how many tickets
// aIsVip   - True for VIP seats
Procedure TfrmMain.AddBooking (aName : String; aCell : String; aTickets : Integer; aIsVip : Boolean);
Var
  booking : TBooking;
Begin
  booking := TBooking.Create;
  booking.SetName (aName);
  booking.SetCellNumber (aCell);
  booking.SetTickets (aTickets);
  booking.SetIsVip (aIsVip);
  count := count + 1;
  bookings[count] := booking;
  lstBookings.Items.Add (booking.ToString);
End; // TfrmMain.AddBooking

// Starts with four bookings already made.
// Sender - the form
Procedure TfrmMain.FormCreate (Sender : TObject);
Begin
  count := 0;
  AddBooking ('Thabo Mokoena', '0821234567', 2, True);
  AddBooking ('Lebo Dlamini', '0719876543', 4, False);
  AddBooking ('Pieter van der Merwe', '0835550101', 1, False);
  AddBooking ('Aisha Patel', '0605552020', 3, True);
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

// Shows the chosen booking on the details form, and waits until it is closed.
// Sender - the Details button
Procedure TfrmMain.btnDetailsClick (Sender : TObject);
Begin
  If lstBookings.ItemIndex = -1 Then
  Begin
    ShowMessage ('Click a booking in the list first.');
  End // if
  Else
  Begin
    frmDetails.SetBooking (bookings[lstBookings.ItemIndex + 1]);
    frmDetails.ShowModal;
  End; // else
End; // TfrmMain.btnDetailsClick

// Asks for a name, and says how many tickets that person has.
// Sender - the Find button
Procedure TfrmMain.btnFindClick (Sender : TObject);
Var
  wanted : String;
  index  : Integer;
  found  : Boolean;
Begin
  wanted := InputBox ('Find a booking', 'Type the name to look for:', '');
  found := False;
  index := 1;
  While (index <= count) And (Not found) Do
  Begin
    If SameText (bookings[index].GetName, Trim (wanted)) Then
    Begin
      found := True;
    End // if
    Else
    Begin
      index := index + 1;
    End; // else
  End; // while
  If found Then
  Begin
    lstBookings.ItemIndex := index - 1;
    ShowMessage (bookings[index].GetName + ' has booked ' + IntToStr (bookings[index].GetTickets) + ' tickets.');
  End // if
  Else
  Begin
    ShowMessage ('Nobody called "' + wanted + '" has booked.');
  End; // else
End; // TfrmMain.btnFindClick

// Opens the seating plan, and carries on without waiting for it.
// Sender - the Seating plan button
Procedure TfrmMain.btnSeatsClick (Sender : TObject);
Begin
  frmSeats.Show;
End; // TfrmMain.btnSeatsClick

// Saves every line of the list to a text file.
// Sender - the Save button
Procedure TfrmMain.btnSaveClick (Sender : TObject);
Begin
  lstBookings.Items.SaveToFile (bookingsFile);
  ShowMessage ('Saved ' + IntToStr (lstBookings.Items.Count) + ' lines to ' + bookingsFile + '.');
End; // TfrmMain.btnSaveClick

// Fills the list from the text file, one line per item.
// Sender - the Load button
Procedure TfrmMain.btnLoadClick (Sender : TObject);
Begin
  If FileExists (bookingsFile) Then
  Begin
    lstBookings.Items.LoadFromFile (bookingsFile);
    btnDetails.Enabled := False;   // the list is only text now, not bookings
  End // if
  Else
  Begin
    ShowMessage ('There is no ' + bookingsFile + ' yet. Click Save first.');
  End; // else
End; // TfrmMain.btnLoadClick

End.
