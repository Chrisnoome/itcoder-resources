Program PlayBookings;

{$H+}

Uses SysUtils, Crt;

Const
  standardPrice = 80;
  vipPrice      = 150;
  maxBookings   = 20;
  messageRow    = 22;

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

  TBookingArray = Array [1..maxBookings] Of TBooking;

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

// Clears the screen, writes a title bar across the top and the keys along the bottom.
// aTitle - the words in the title bar
// aKeys  - the keys that work on this screen
Procedure WriteScreen (aTitle : String; aKeys : String);
Begin
  TextBackground (Black);
  ClrScr;
  TextBackground (Blue);
  TextColor (White);
  GotoXY (1, 1);
  ClrEol;
  GotoXY (3, 1);
  Write ('THE SCHOOL PLAY  -  ', aTitle);
  TextBackground (Black);
  TextColor (DarkGray);
  GotoXY (3, 24);
  Write (aKeys);
  TextColor (LightGray);
End; // WriteScreen

// Writes a message on the message line, wiping whatever was there before.
// aMessage - the words to show
// aColour  - LightRed for a problem, LightGreen for good news
Procedure WriteMessage (aMessage : String; aColour : Integer);
Begin
  GotoXY (3, messageRow);
  ClrEol;
  TextColor (aColour);
  Write (aMessage);
  TextColor (LightGray);
End; // WriteMessage

// Reads what is typed at one place on the screen, after wiping anything typed there before.
// aColumn - the column where typing starts
// aRow    - the row to type on
// Gives back: what was typed, without spaces at either end
Function ReadField (aColumn : Integer; aRow : Integer) : String;
Var
  typed : String;
Begin
  GotoXY (aColumn, aRow);
  ClrEol;
  Readln (typed);
  Result := Trim (typed);
End; // ReadField

// Waits for Y or N (capitals or not). Esc counts as N.
// Gives back: True for Y
Function ReadYesNo : Boolean;
Var
  key : Char;
Begin
  Repeat
    key := UpCase (ReadKey);
  Until (key = 'Y') Or (key = 'N') Or (key = #27); // repeat
  Result := key = 'Y';
End; // ReadYesNo

// Asks for every part of a new booking, one field at a time, until each one is right.
// Gives back: the new booking, or Nil if it was not saved
Function ReadBooking : TBooking;
Var
  typed   : String;
  tickets : Integer;
  isValid : Boolean;
Begin
  tickets := 0;
  Result := TBooking.Create;
  WriteScreen ('NEW BOOKING', 'Enter  Next answer');
  GotoXY (3, 4);
  Write ('Name and surname  : ');
  GotoXY (3, 6);
  Write ('Cell number       : ');
  GotoXY (3, 8);
  Write ('Tickets (1 to 6)  : ');
  GotoXY (3, 10);
  Write ('VIP seats? (Y/N)  : ');
  TextColor (DarkGray);
  GotoXY (3, 12);
  Write ('Standard seats R', standardPrice, ' each, VIP seats R', vipPrice, ' each.');
  TextColor (LightGray);

  // The name
  Repeat
    Try
      Result.SetName (ReadField (23, 4));
      isValid := True;
    Except
      On problem : Exception Do
      Begin
        WriteMessage (problem.Message, LightRed);
        isValid := False;
      End; // on
    End; // try
  Until isValid; // repeat
  WriteMessage ('', LightGray);

  // The cell number
  Repeat
    Try
      Result.SetCellNumber (ReadField (23, 6));
      isValid := True;
    Except
      On problem : Exception Do
      Begin
        WriteMessage (problem.Message, LightRed);
        isValid := False;
      End; // on
    End; // try
  Until isValid; // repeat
  WriteMessage ('', LightGray);

  // The tickets
  Repeat
    typed := ReadField (23, 8);
    isValid := False;
    Try
      tickets := StrToInt (typed);
      isValid := True;
    Except
      WriteMessage ('"' + typed + '" is not a number. Type the tickets as digits, like 2.', LightRed);
    End; // try
    If isValid Then
    Begin
      Try
        Result.SetTickets (tickets);
      Except
        On problem : Exception Do
        Begin
          WriteMessage (problem.Message, LightRed);
          isValid := False;
        End; // on
      End; // try
    End; // if
  Until isValid; // repeat
  WriteMessage ('', LightGray);

  // VIP or not - one key, no Enter
  GotoXY (23, 10);
  Result.SetIsVip (ReadYesNo);
  If Result.GetIsVip Then
  Begin
    Write ('Yes');
  End // if
  Else
  Begin
    Write ('No');
  End; // else

  // Check before saving
  TextColor (Yellow);
  GotoXY (3, 15);
  Write (Result.ToString);
  TextColor (LightGray);
  GotoXY (3, 17);
  Write ('Save this booking? (Y/N) ');
  If Not ReadYesNo Then
  Begin
    Result.Free;
    Result := Nil;
  End; // if
End; // ReadBooking

// Lists every booking in columns, with the total at the bottom.
// aBookings - the bookings
// aCount    - how many there are
Procedure ShowBookings (aBookings : TBookingArray; aCount : Integer);
Var
  index   : Integer;
  total   : Integer;
  seats   : String;
  money   : String;
  booking : TBooking;
Begin
  WriteScreen ('ALL BOOKINGS', 'Any key  Back to the menu');
  total := 0;
  TextColor (Yellow);
  GotoXY (3, 3);
  Write (Format ('%-22s %-12s %7s  %-9s %7s', ['Name', 'Cell', 'Tickets', 'Seats', 'Total']));
  GotoXY (3, 4);
  Write (StringOfChar ('-', 62));
  TextColor (LightGray);
  For index := 1 To aCount Do
  Begin
    booking := aBookings[index];
    seats := 'Standard';
    If booking.GetIsVip Then
    Begin
      seats := 'VIP';
    End; // if
    money := 'R' + IntToStr (booking.GetTotal);
    GotoXY (3, 4 + index);
    Write (Format ('%-22s %-12s %7d  %-9s %7s', [booking.GetName, booking.GetCellNumber, booking.GetTickets, seats, money]));
    total := total + booking.GetTotal;
  End; // for
  TextColor (Yellow);
  GotoXY (3, 5 + aCount);
  Write (StringOfChar ('-', 62));
  GotoXY (3, 6 + aCount);
  Write (Format ('%-54s %7s', [IntToStr (aCount) + ' bookings', 'R' + IntToStr (total)]));
  TextColor (LightGray);
  ReadKey;
End; // ShowBookings

// Shows the help screen until a key is pressed.
Procedure ShowHelp;
Begin
  WriteScreen ('HELP', 'Any key  Back to the menu');
  GotoXY (3, 4);
  Write ('Press 1 to book seats. Type each answer and press Enter.');
  GotoXY (3, 5);
  Write ('If an answer is wrong, a red message says how to fix it.');
  GotoXY (3, 7);
  Write ('Press 2 to see every booking and the money taken.');
  GotoXY (3, 9);
  Write ('Press Esc on the menu to finish.');
  ReadKey;
End; // ShowHelp

Var
  bookings : TBookingArray;
  count    : Integer;
  booking  : TBooking;
  key      : Char;
  isDone   : Boolean;
  index    : Integer;

Begin
  count := 0;
  isDone := False;

  // The menu, until Esc is pressed and confirmed
  Repeat
    WriteScreen ('MENU', 'F1  Help     Esc  Quit');
    GotoXY (30, 8);
    Write ('1    New booking');
    GotoXY (30, 10);
    Write ('2    All bookings');
    GotoXY (30, 12);
    Write ('F1   Help');
    GotoXY (30, 14);
    Write ('Esc  Quit');
    GotoXY (30, 17);
    Write ('Press a key: ');
    key := ReadKey;
    Case key Of
      '1' :
      Begin
        If count = maxBookings Then
        Begin
          WriteMessage ('The play is full - no more bookings.', LightRed);
          Delay (2000);
        End // if
        Else
        Begin
          booking := ReadBooking;
          If booking <> Nil Then
          Begin
            count := count + 1;
            bookings[count] := booking;
            WriteMessage ('Booking saved.', LightGreen);
          End // if
          Else
          Begin
            WriteMessage ('Booking not saved.', Yellow);
          End; // else
          Delay (1500);
        End; // else
      End; // 1
      '2' : ShowBookings (bookings, count);
      #0 :
      Begin
        key := ReadKey;
        If key = #59 Then
        Begin
          ShowHelp;
        End; // if F1
      End; // #0
      #27 :
      Begin
        WriteMessage ('Quit? The bookings are not kept. (Y/N) ', Yellow);
        isDone := ReadYesNo;
      End; // Esc
    Else
      Begin
        WriteMessage ('Press 1, 2, F1 or Esc.', LightRed);
        Delay (1500);
      End; // else
    End; // case
  Until isDone; // repeat

  // Free every booking
  For index := 1 To count Do
  Begin
    bookings[index].Free;
  End; // for
  TextBackground (Black);
  ClrScr;
  Writeln ('Goodbye - ', count, ' bookings made.');
End.
