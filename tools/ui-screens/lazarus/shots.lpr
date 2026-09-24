program shots;
{$mode objfpc}{$H+}
// Builds each lesson 23 screenshot form in code, shows it, captures it
// (shotutil.CaptureForm), and closes it. Run: shots.exe
uses Windows, Interfaces, Forms, Controls, StdCtrls, ExtCtrls, ComCtrls, Buttons, Spin,
  MaskEdit, Grids, Menus, Graphics, Calendar, DateTimePicker, SysUtils, DateUtils,
  shotutil;

{$R *.res}

const
  NoteColour = $00505050;
var
  NoteX: Integer = 0;

function NewForm(const aCaption: string; aW, aH: Integer): TForm;
begin
  Result := TForm.CreateNew(nil);
  Result.Caption := aCaption;
  Result.Position := poScreenCenter;
  Result.Width := aW; Result.Height := aH;
  Result.Font.Name := 'Segoe UI'; Result.Font.Height := -12;
end;

function Lbl(aParent: TWinControl; const aName, aCaption: string; aL, aT: Integer): TLabel;
begin
  Result := TLabel.Create(aParent.Owner); Result.Parent := aParent;
  if aName <> '' then Result.Name := aName;
  Result.Caption := aCaption; Result.Left := aL; Result.Top := aT;
end;

// A grey note to the right of a control, saying what it is.
procedure Note(aControl: TControl; const aText: string);
var l: TLabel;
begin
  l := TLabel.Create(aControl.Owner); l.Parent := aControl.Parent;
  l.Caption := aText; l.Font.Name := 'Consolas'; l.Font.Height := -12; l.Font.Color := NoteColour;
  l.Left := aControl.Left + aControl.Width + 14;
  if NoteX > l.Left then l.Left := NoteX;
  l.Top := aControl.Top + (aControl.Height - 15) div 2;
end;

procedure Place(c: TControl; aParent: TWinControl; const aName: string; aL, aT, aW: Integer);
begin
  c.Parent := aParent; c.Name := aName; c.Left := aL; c.Top := aT;
  if aW > 0 then c.Width := aW;
end;

procedure ShowAndShoot(f: TForm; const aName: string);
var i: Integer;
begin
  Fit(f);
  f.Show;
  Settle(200);
  SetForegroundWindow(f.Handle);
  for i := 0 to f.ComponentCount - 1 do
    if f.Components[i] is TCustomEdit then TCustomEdit(f.Components[i]).SelLength := 0;
  CaptureForm(f, aName);
  NoteX := 0;
end;

procedure SceneText;
var f: TForm; e: TEdit; m: TMaskEdit; mm: TMemo; l: TLabel;
begin
  f := NewForm('Typing text', 560, 330); NoteX := 240;
  l := Lbl(f, 'lblHeading', 'A label shows words', 20, 18); l.Font.Height := -16; l.Font.Style := [fsBold];
  Note(l, 'TLabel      lblHeading');
  e := TEdit.Create(f); Place(e, f, 'edtName', 20, 56, 190); e.Text := 'Thabo Mokoena';
  Note(e, 'TEdit       edtName');
  e := TEdit.Create(f); Place(e, f, 'edtSurname', 20, 92, 190); e.TextHint := 'Surname, like Dlamini'; e.Text := '';
  Note(e, 'TEdit       TextHint');
  e := TEdit.Create(f); Place(e, f, 'edtPassword', 20, 128, 190); e.PasswordChar := '*'; e.Text := 'secret123';
  Note(e, 'TEdit       PasswordChar = *');
  e := TEdit.Create(f); Place(e, f, 'edtTotal', 20, 164, 190); e.ReadOnly := True; e.Color := clBtnFace; e.Text := 'R300.00';
  Note(e, 'TEdit       ReadOnly');
  m := TMaskEdit.Create(f); Place(m, f, 'medCell', 20, 200, 190); m.EditMask := '000 000 0000;0;_'; m.Text := '082123';
  Note(m, 'TMaskEdit   medCell');
  mm := TMemo.Create(f); Place(mm, f, 'memNotes', 20, 236, 190); mm.Height := 60; mm.ScrollBars := ssVertical;
  mm.Lines.Text := 'Many lines of text.'#13#10'Lines[0], Lines[1]...'#13#10'A third line.';
  Note(mm, 'TMemo       memNotes');
  ShowAndShoot(f, 'text');
  f.Free;
end;

procedure SceneChoose;
var f: TForm; c: TCheckBox; r: TRadioGroup; cb: TComboBox; lb: TListBox; rb: TRadioButton;
begin
  f := NewForm('Choosing', 600, 380); NoteX := 280;
  c := TCheckBox.Create(f); Place(c, f, 'chkBus', 20, 20, 0); c.Caption := 'I need the school bus'; c.Checked := True;
  Note(c, 'TCheckBox    chkBus');
  rb := TRadioButton.Create(f); Place(rb, f, 'radMale', 20, 56, 0); rb.Caption := 'Morning';
  rb := TRadioButton.Create(f); Place(rb, f, 'radFemale', 110, 56, 0); rb.Caption := 'Afternoon'; rb.Checked := True;
  Note(rb, 'TRadioButton (two)');
  r := TRadioGroup.Create(f); Place(r, f, 'rgpHouse', 20, 90, 230); r.Height := 80; r.Caption := 'House';
  r.Columns := 2; r.Items.Add('Red'); r.Items.Add('Blue'); r.Items.Add('Green'); r.Items.Add('Yellow'); r.ItemIndex := 1;
  Note(r, 'TRadioGroup  rgpHouse');
  cb := TComboBox.Create(f); Place(cb, f, 'cmbProvince', 20, 186, 230); cb.Style := csDropDownList;
  cb.Items.Add('Eastern Cape'); cb.Items.Add('Free State'); cb.Items.Add('Gauteng'); cb.Items.Add('KwaZulu-Natal'); cb.ItemIndex := 2;
  Note(cb, 'TComboBox    cmbProvince');
  lb := TListBox.Create(f); Place(lb, f, 'lstSubjects', 20, 224, 230); lb.Height := 108;
  lb.Items.Add('Accounting'); lb.Items.Add('Information Technology'); lb.Items.Add('Mathematics');
  lb.Items.Add('Physical Sciences'); lb.Items.Add('Visual Arts'); lb.ItemIndex := 1;
  Note(lb, 'TListBox     lstSubjects');
  ShowAndShoot(f, 'choose');
  f.Free;
end;

procedure SceneNumbers;
var f: TForm; s: TSpinEdit; fs: TFloatSpinEdit; t: TTrackBar; d: TDateTimePicker; cal: TCalendar;
begin
  f := NewForm('Numbers and dates', 600, 420); NoteX := 260;
  s := TSpinEdit.Create(f); Place(s, f, 'sedTickets', 20, 20, 70); s.MinValue := 1; s.MaxValue := 6; s.Value := 2;
  Note(s, 'TSpinEdit        sedTickets');
  fs := TFloatSpinEdit.Create(f); Place(fs, f, 'fseMass', 20, 58, 90); fs.DecimalPlaces := 1; fs.MinValue := 0.1; fs.MaxValue := 30; fs.Increment := 0.5; fs.Value := 2.5;
  Note(fs, 'TFloatSpinEdit   fseMass');
  t := TTrackBar.Create(f); Place(t, f, 'trkVolume', 14, 94, 200); t.Min := 0; t.Max := 10; t.Position := 7; t.Height := 36;
  Note(t, 'TTrackBar        trkVolume');
  d := TDateTimePicker.Create(f); Place(d, f, 'dtpBirthday', 20, 142, 130); d.Kind := dtkDate; d.Date := EncodeDate(2010, 3, 21);
  Note(d, 'TDateTimePicker  dtpBirthday');
  cal := TCalendar.Create(f); Place(cal, f, 'calConcert', 20, 184, 0); cal.DateTime := EncodeDate(2026, 10, 16);
  Note(cal, 'TCalendar        calConcert');
  ShowAndShoot(f, 'numbers');
  f.Free;
end;

procedure SceneButtons;
const
  Kinds: array[0..7] of TBitBtnKind = (bkOK, bkCancel, bkHelp, bkYes, bkNo, bkClose, bkRetry, bkAbort);
  Names: array[0..7] of string = ('bkOK', 'bkCancel', 'bkHelp', 'bkYes', 'bkNo', 'bkClose', 'bkRetry', 'bkAbort');
var f: TForm; b: TButton; bb: TBitBtn; i: Integer; l: TLabel;
begin
  f := NewForm('Buttons', 560, 290);
  b := TButton.Create(f); Place(b, f, 'btnBook', 20, 20, 90); b.Caption := '&Book';
  Note(b, 'TButton   Caption = &Book');
  l := Lbl(f, '', 'TBitBtn - a button with a picture. Kind =', 20, 64); l.Font.Name := 'Consolas'; l.Font.Color := NoteColour;
  for i := 0 to 7 do
  begin
    bb := TBitBtn.Create(f); Place(bb, f, 'bmb' + IntToStr(i), 20 + (i mod 4) * 130, 92 + (i div 4) * 76, 110);
    bb.Kind := Kinds[i]; bb.Height := 30;
    l := Lbl(f, '', Names[i], bb.Left + 2, bb.Top + 36); l.Font.Name := 'Consolas'; l.Font.Color := NoteColour;
  end;
  ShowAndShoot(f, 'buttons');
  f.Free;
end;

procedure SceneContainers;
var f: TForm; p: TPanel; g: TGroupBox; pc: TPageControl; ts: TTabSheet; sg: TStringGrid; sb: TStatusBar;
    mm: TMainMenu; mi: TMenuItem; sh: TShape; e: TEdit; i: Integer;
const Tabs: array[0..2] of string = ('Details', 'Marks', 'Photo');
  Menus4: array[0..3] of string = ('&File', '&Edit', '&View', '&Help');
begin
  f := NewForm('Containers and grids', 800, 470); NoteX := 280;
  mm := TMainMenu.Create(f); f.Menu := mm;
  for i := 0 to 3 do begin mi := TMenuItem.Create(mm); mi.Caption := Menus4[i]; mm.Items.Add(mi); end;
  p := TPanel.Create(f); Place(p, f, 'pnlSearch', 20, 16, 250); p.Height := 60; p.Caption := '';
  Lbl(p, '', 'Surname', 10, 20); e := TEdit.Create(f); Place(e, p, 'edtSearch', 70, 16, 160); e.Text := 'Dlamini';
  Note(p, 'TPanel        pnlSearch');
  g := TGroupBox.Create(f); Place(g, f, 'gbxContact', 20, 92, 250); g.Height := 90; g.Caption := 'Contact details';
  Lbl(g, '', 'Cell', 10, 12); e := TEdit.Create(f); Place(e, g, 'edtCell', 70, 8, 160); e.Text := '071 987 6543';
  Lbl(g, '', 'Email', 10, 42); e := TEdit.Create(f); Place(e, g, 'edtEmail', 70, 38, 160); e.Text := '';
  Note(g, 'TGroupBox     gbxContact');
  sh := TShape.Create(f); Place(sh, f, 'shpLight', 30, 196, 26); sh.Height := 26; sh.Shape := stCircle; sh.Brush.Color := clLime;
  Note(sh, 'TShape  shpLight');
  pc := TPageControl.Create(f); Place(pc, f, 'pgcPupil', 20, 234, 250); pc.Height := 150;
  for i := 0 to 2 do begin ts := TTabSheet.Create(pc); ts.PageControl := pc; ts.Caption := Tabs[i]; end;
  pc.ActivePageIndex := 1;
  Lbl(pc.Pages[1], '', 'Each tab is a TTabSheet.', 10, 10);
  Note(pc, 'TPageControl  pgcPupil');
  sg := TStringGrid.Create(f); Place(sg, f, 'sgdMarks', 500, 16, 270); sg.Height := 172;
  sg.ColCount := 3; sg.RowCount := 6; sg.DefaultColWidth := 84; sg.DefaultRowHeight := 26;
  sg.Cells[0, 0] := 'Name'; sg.Cells[1, 0] := 'Test'; sg.Cells[2, 0] := 'Exam';
  sg.Cells[0, 1] := 'Thabo'; sg.Cells[1, 1] := '67'; sg.Cells[2, 1] := '72';
  sg.Cells[0, 2] := 'Lebo'; sg.Cells[1, 2] := '81'; sg.Cells[2, 2] := '78';
  sg.Cells[0, 3] := 'Pieter'; sg.Cells[1, 3] := '54'; sg.Cells[2, 3] := '61';
  sg.Cells[0, 4] := 'Aisha'; sg.Cells[1, 4] := '90'; sg.Cells[2, 4] := '88';
  sg.FixedCols := 0;
  with Lbl(f, '', 'TStringGrid  sgdMarks', 500, 194) do begin Font.Name := 'Consolas'; Font.Color := NoteColour; end;
  sb := TStatusBar.Create(f); sb.Parent := f; sb.Name := 'stbStatus'; sb.SimplePanel := False;
  with sb.Panels.Add do begin Text := '4 pupils'; Width := 120; end;
  with sb.Panels.Add do begin Text := 'Saved 10:42'; Width := 140; end;
  with sb.Panels.Add do begin Text := 'TStatusBar - panels'; Width := 200; end;
  with Lbl(f, '', 'TMainMenu - the menu bar at the top', 500, 230) do begin Font.Name := 'Consolas'; Font.Color := NoteColour; end;
  ShowAndShoot(f, 'containers');
  f.Free;
end;

procedure SceneAlign(const aName: string; aW, aH: Integer);
var f: TForm; top, details, buttons: TPanel; l: TLabel; lb: TListBox; sp: TSplitter; mm: TMemo; sb: TStatusBar; b: TButton;
begin
  f := NewForm('Pupils', aW, aH);
  top := TPanel.Create(f); top.Parent := f; top.Name := 'pnlTop'; top.Align := alTop; top.Height := 40; top.Caption := '';
  top.BevelOuter := bvNone; top.Color := $005F3A1F; top.ParentBackground := False;
  l := Lbl(top, 'lblTitle', 'pnlTop - Align = alTop', 12, 10); l.Font.Color := clWhite; l.Font.Style := [fsBold];
  sb := TStatusBar.Create(f); sb.Parent := f; sb.Name := 'stbStatus'; sb.SimpleText := '  stbStatus - Align = alBottom';
  lb := TListBox.Create(f); lb.Parent := f; lb.Name := 'lstPupils'; lb.Align := alLeft; lb.Width := 170;
  lb.BorderSpacing.Around := 8;
  lb.Items.Add('lstPupils - alLeft'); lb.Items.Add('Thabo Mokoena'); lb.Items.Add('Lebo Dlamini'); lb.Items.Add('Pieter van der Merwe'); lb.Items.Add('Aisha Patel');
  sp := TSplitter.Create(f); sp.Parent := f; sp.Name := 'splMiddle'; sp.Align := alLeft; sp.Left := 200; sp.Width := 6; sp.Color := clSilver;
  details := TPanel.Create(f); details.Parent := f; details.Name := 'pnlDetails'; details.Align := alClient; details.Caption := '';
  details.BevelOuter := bvNone;
  buttons := TPanel.Create(f); buttons.Parent := details; buttons.Name := 'pnlButtons'; buttons.Align := alBottom; buttons.Height := 42;
  buttons.BevelOuter := bvNone; buttons.Caption := '';
  b := TButton.Create(f); b.Parent := buttons; b.Name := 'btnCancel'; b.Caption := 'Cancel'; b.Width := 80;
  b.Anchors := [akTop, akRight]; b.Left := buttons.Width - 88; b.Top := 8;
  b := TButton.Create(f); b.Parent := buttons; b.Name := 'btnSave'; b.Caption := 'Save'; b.Width := 80;
  b.Anchors := [akTop, akRight]; b.Left := buttons.Width - 176; b.Top := 8;
  mm := TMemo.Create(f); mm.Parent := details; mm.Name := 'memDetails'; mm.Align := alClient; mm.BorderSpacing.Around := 8;
  mm.Lines.Text := 'memDetails - Align = alClient: it fills whatever space is left.'#13#10#13#10 +
    'splMiddle (the grey bar) is a TSplitter: drag it to make the list wider.'#13#10#13#10 +
    'Save and Cancel are anchored to the right, so they stay in the corner when the window grows.';
  mm.WordWrap := True;
  Fit(f);
  f.Show;
  Settle(300);
  // put the buttons in the right-hand corner now that the panel has its real width
  TButton(f.FindComponent('btnCancel')).Left := buttons.ClientWidth - TButton(f.FindComponent('btnCancel')).Width - 10;
  TButton(f.FindComponent('btnSave')).Left := TButton(f.FindComponent('btnCancel')).Left - TButton(f.FindComponent('btnSave')).Width - 8;
  Settle(200);
  CaptureForm(f, aName);
  f.Free;
end;

procedure SceneFont(const aName, aFont: string);
var f: TForm; l: TLabel; e: TEdit; b: TButton;
  procedure Row(const aCaption: string; aTop: Integer);
  begin
    l := Lbl(f, '', aCaption, 16, aTop + 3); l.AutoSize := False; l.Width := 96; l.Height := 22;
    e := TEdit.Create(f); Place(e, f, '', 116, aTop, 150);
  end;
begin
  f := NewForm('Tuck shop', 300, 210);
  f.Font.Name := aFont; f.Font.Height := -17;
  l := Lbl(f, '', 'TUCK SHOP ORDER', 16, 10); l.Font.Height := -22; l.AutoSize := False; l.Width := 260; l.Height := 28;
  Row('Pupil name', 48);
  Row('Pies (max 3)', 84);
  Row('Cooldrinks', 120);
  b := TButton.Create(f); Place(b, f, '', 116, 158, 70); b.Caption := 'Order now';
  b := TButton.Create(f); Place(b, f, '', 196, 158, 70); b.Caption := 'Cancel order';
  ShowAndShoot(f, aName);
  f.Free;
end;

procedure SceneBad;
var f: TForm; l: TLabel; e: TEdit; b: TButton; m: TMemo;
begin
  f := NewForm('Form1', 560, 360);
  f.Color := clYellow; f.Font.Name := 'Comic Sans MS'; f.Font.Height := -13;
  l := Lbl(f, 'lblTitle', 'BOOKINGS!!!', 190, 6); l.Font.Name := 'Jokerman'; l.Font.Height := -26; l.Font.Color := clRed;
  Lbl(f, 'lblName', 'NAME:', 8, 62);
  e := TEdit.Create(f); Place(e, f, 'Edit1', 60, 58, 250);
  Lbl(f, 'lblCell', 'cell no', 8, 98);
  e := TEdit.Create(f); Place(e, f, 'Edit2', 84, 94, 120);
  Lbl(f, 'lblTickets', 'Numbr Of Tikets', 8, 134);
  e := TEdit.Create(f); Place(e, f, 'Edit3', 130, 130, 40);
  Lbl(f, 'lblSeats', 'Seat type? (type VIP or normal)', 8, 170);
  e := TEdit.Create(f); Place(e, f, 'Edit4', 250, 166, 90);
  Lbl(f, 'lblDate', 'Date of show', 8, 206);
  e := TEdit.Create(f); Place(e, f, 'Edit5', 110, 202, 150);
  b := TButton.Create(f); Place(b, f, 'Button1', 330, 250, 220); b.Caption := 'Click here to do the booking now!!!'; b.Height := 40;
  b := TButton.Create(f); Place(b, f, 'Button2', 8, 300, 60); b.Caption := 'Button2';
  b := TButton.Create(f); Place(b, f, 'Button3', 520, 8, 30); b.Caption := 'X';
  m := TMemo.Create(f); Place(m, f, 'Memo1', 350, 58, 200); m.Height := 150; m.Lines.Text := 'Memo1';
  m.Color := clLime; m.Font.Color := clRed;
  ShowAndShoot(f, 'bad');
  f.Free;
end;

begin
  MakeAware;
  Application.Initialize;
  OutDir := ExtractFilePath(ParamStr(0)) + 'out\';
  ForceDirectories(OutDir);
  SceneText;
  SceneChoose;
  SceneNumbers;
  SceneButtons;
  SceneContainers;
  SceneAlign('align-small', 520, 300);
  SceneAlign('align-big', 760, 400);
  SceneFont('font-installed', 'Agency FB');
  SceneFont('font-missing', 'Agency FB Condensed Pro');
  SceneBad;
end.
