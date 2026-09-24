Unit uBooking;

{$H+}

Interface

Uses SysUtils;

Const
  standardPrice = 80;
  vipPrice      = 150;

Type
  TBooking = Class (TObject)
  private
    name       : String;
    cellNumber : String;
    tickets    : Integer;
    isVip      : Boolean;

  public
    Constructor Create;
    Procedure SetName (aName : String);
    Procedure SetCellNumber (aCellNumber : String);
    Procedure SetTickets (aTickets : Integer);
    Procedure SetIsVip (aIsVip : Boolean);
    Function GetName : String;
    Function GetCellNumber : String;
    Function GetTickets : Integer;
    Function GetIsVip : Boolean;
    Function GetTotal : Integer;
    Function ToString : String; Override;
  End; // TBooking

Implementation

// Makes an empty booking for one standard ticket.
Constructor TBooking.Create;
Begin
  Inherited Create;
  name := '';
  cellNumber := '';
  tickets := 1;
  isVip := False;
End; // TBooking.Create

// Stores the name, or raises an exception that says how to fix it.
// aName - the name and surname of the person booking
Procedure TBooking.SetName (aName : String);
Begin
  If Trim (aName) = '' Then
  Begin
    Raise Exception.Create ('Type a name - it can''t be empty.');
  End; // if
  name := Trim (aName);
End; // TBooking.SetName

// Stores the cell number, or raises an exception that says how to fix it.
// aCellNumber - 10 digits, starting with 0
Procedure TBooking.SetCellNumber (aCellNumber : String);
Var
  index    : Integer;
  isDigits : Boolean;
Begin
  isDigits := True;
  For index := 1 To Length (aCellNumber) Do
  Begin
    If Not (aCellNumber[index] In ['0'..'9']) Then
    Begin
      isDigits := False;
    End; // if
  End; // for
  If (Length (aCellNumber) <> 10) Or (Not isDigits) Or (Copy (aCellNumber, 1, 1) <> '0') Then
  Begin
    Raise Exception.Create ('A cell number is 10 digits starting with 0, like 0821234567.');
  End; // if
  cellNumber := aCellNumber;
End; // TBooking.SetCellNumber

// Stores the number of tickets, or raises an exception that says how to fix it.
// aTickets - from 1 to 6
Procedure TBooking.SetTickets (aTickets : Integer);
Begin
  If (aTickets < 1) Or (aTickets > 6) Then
  Begin
    Raise Exception.Create ('You can book from 1 to 6 tickets.');
  End; // if
  tickets := aTickets;
End; // TBooking.SetTickets

// Stores whether the seats are VIP seats.
// aIsVip - True for VIP seats, False for standard seats
Procedure TBooking.SetIsVip (aIsVip : Boolean);
Begin
  isVip := aIsVip;
End; // TBooking.SetIsVip

// Gives back the name.
// Gives back: the name and surname
Function TBooking.GetName : String;
Begin
  Result := name;
End; // TBooking.GetName

// Gives back the cell number.
// Gives back: the 10-digit cell number
Function TBooking.GetCellNumber : String;
Begin
  Result := cellNumber;
End; // TBooking.GetCellNumber

// Gives back the number of tickets.
// Gives back: from 1 to 6
Function TBooking.GetTickets : Integer;
Begin
  Result := tickets;
End; // TBooking.GetTickets

// Gives back whether the seats are VIP seats.
// Gives back: True for VIP seats
Function TBooking.GetIsVip : Boolean;
Begin
  Result := isVip;
End; // TBooking.GetIsVip

// Works out what the booking costs.
// Gives back: the total in rand
Function TBooking.GetTotal : Integer;
Begin
  If isVip Then
  Begin
    Result := tickets * vipPrice;
  End // if
  Else
  Begin
    Result := tickets * standardPrice;
  End; // else
End; // TBooking.GetTotal

// Describes the booking in one line.
// Gives back: such as "Thabo Mokoena: 2 VIP tickets, R300"
Function TBooking.ToString : String;
Var
  seats : String;
Begin
  seats := 'standard';
  If isVip Then
  Begin
    seats := 'VIP';
  End; // if
  If tickets = 1 Then
  Begin
    seats := seats + ' ticket';
  End // if
  Else
  Begin
    seats := seats + ' tickets';
  End; // else
  Result := name + ': ' + IntToStr (tickets) + ' ' + seats + ', R' + IntToStr (GetTotal);
End; // TBooking.ToString

End.
