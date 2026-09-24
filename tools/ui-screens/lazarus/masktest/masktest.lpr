program masktest;
{$mode objfpc}{$H+}
uses Windows, Interfaces, Forms, Classes, SysUtils, MaskEdit, StdCtrls;
var f: TForm; m: TMaskEdit; sl: TStringList;
procedure Pump; var i: Integer; begin for i := 1 to 20 do begin Application.ProcessMessages; Sleep(5); end; end;
procedure T(const mask, typed: string; viaEdit: Boolean);
var s: string; i: Integer;
begin
  m.EditMask := mask;
  m.Clear;
  m.SetFocus; Pump;
  m.SelStart := 0; m.SelLength := 0; Pump;
  for i := 1 to Length(typed) do begin PostMessage(m.Handle, WM_CHAR, Ord(typed[i]), 0); Pump; end;
  s := Format('%-24s | %-16s | EditText="%s" Text="%s"', [mask, typed, m.EditText, m.Text]);
  try
    m.ValidateEdit; s := s + ' | valid';
  except on e: Exception do s := s + ' | ValidateEdit: ' + e.ClassName + ': ' + e.Message; end;
  sl.Add(s);
end;
begin
  Application.Initialize;
  f := TForm.CreateNew(nil); m := TMaskEdit.Create(f); m.Parent := f; sl := TStringList.Create;
  f.Show;
  T('000 000 0000;0;_', '0821234567', False);
  T('000 000 0000;1;_', '0821234567', False);
  T('000 000 0000;0;_', '082123', False);
  T('000 000 0000;0;_', '082 123 45__', True);
  T('000000 0000 000;0;_', '0501015800088', False);
  T('0000;1;_', '2196', False);
  T('0000;1;_', '21', False);
  T('>LL 00 LL GP;1;_', 'ab12cdGP', False);
  T('>LL 00 LL GP;1;_', 'AB 12 CD GP', True);
  T('>LL 00 LL \G\P;1;_', 'AB 12 CD GP', True);
  T('!90:00;1;_', '7:30', True);
  T('00/00/0000;1;_', '24/09/2026', True);
  T('>L<llllllll;1;_', 'thabo', True);
  T('>L<cccccccc;1; ', 'thabo', True);
  T('99999;1;_', '12', True);
  T('#999;1;_', '-12', True);
  T('aaaa;1;_', 'a1', True);
  T('AAAA;1;_', 'a1', True);
  T('00000000;0;_', '1234abcd', False);
  T('000 000 0000;0;_', '082x1234567', False);
  T('>LL 00 LL GP;1;_', 'ab12cd', False);
  T('>L<llllllll;1;_', 'tHABO', False);
  T('!90:00;1;_', '0730', False);
  T('!90:00;1;_', '730', False);
  T('00/00/0000;1;_', '24092026', False);
  T('00/00/0000;0;_', '24092026', False);
  T('9999;1;_', '12', False);
  T('>AAA-000;1;_', 'gp1234x', False);
  T('>L0L 0L0;1;_', 'a1b2c3', False);
  T('>LL 00 LL \G\P;1;_', 'ab12cd', False);
  sl.Add('Default blank: ' + IntToStr(Ord(m.SpaceChar)));
  sl.SaveToFile('masks2.txt');
  f.Free;
end.
