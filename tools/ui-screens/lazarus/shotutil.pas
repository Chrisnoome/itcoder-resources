unit shotutil;
{$mode objfpc}{$H+}
interface
uses Windows, Classes, SysUtils, Forms, Controls, Graphics, StdCtrls;
procedure MakeAware;
procedure Fit(aForm: TForm);
procedure Settle(ms: Integer);
procedure CaptureForm(aForm: TForm; const aName: string);
var OutDir: string;
implementation
function PrintWindow(hwnd: HWND; hdcBlt: HDC; nFlags: UINT): BOOL; stdcall; external 'user32.dll';
function SetProcessDpiAwarenessContext(v: PtrInt): BOOL; stdcall; external 'user32.dll';
procedure MakeAware;
begin
  SetProcessDpiAwarenessContext(-4);
end;
procedure Fit(aForm: TForm);
begin
  aForm.AutoAdjustLayout(lapAutoAdjustForDPI, 96, Screen.PixelsPerInch, 0, 0);
end;
function DwmGetWindowAttribute(hwnd: HWND; dwAttribute: DWORD; pvAttribute: Pointer; cbAttribute: DWORD): HRESULT; stdcall; external 'dwmapi.dll';

procedure Settle(ms: Integer);
var t: QWord;
begin
  t := GetTickCount64;
  while GetTickCount64 - t < QWord(ms) do begin Application.ProcessMessages; Sleep(15); end;
end;

procedure DumpControls(aParent: TWinControl; ox, oy: Integer; sl: TStringList);
var i: Integer; c: TControl; p: TPoint;
begin
  for i := 0 to aParent.ControlCount - 1 do
  begin
    c := aParent.Controls[i];
    if not c.Visible then continue;
    p := c.ClientToScreen(Point(0, 0));
    sl.Add(Format('{"name":"%s","cls":"%s","x":%d,"y":%d,"w":%d,"h":%d},',
      [c.Name, c.ClassName, p.X - ox, p.Y - oy, c.Width, c.Height]));
    if c is TWinControl then DumpControls(TWinControl(c), ox, oy, sl);
  end;
end;

procedure CaptureForm(aForm: TForm; const aName: string);
var cdc, mdc: HDC; hb, hb2, old, old2: HBITMAP; ok: BOOL; wr, fr: TRect; full, crop: TBitmap; png: TPortableNetworkGraphic; sl: TStringList; s: string;
begin
  Settle(900);
  GetWindowRect(aForm.Handle, wr);
  if DwmGetWindowAttribute(aForm.Handle, 9, @fr, SizeOf(fr)) <> 0 then fr := wr;
  full := TBitmap.Create; crop := TBitmap.Create; png := TPortableNetworkGraphic.Create; sl := TStringList.Create;
  try
    mdc := CreateCompatibleDC(0);
    hb := CreateCompatibleBitmap(GetDC(0), wr.Right - wr.Left, wr.Bottom - wr.Top);
    old := SelectObject(mdc, hb);
    ok := PrintWindow(aForm.Handle, mdc, 2);
    cdc := CreateCompatibleDC(0);
    hb2 := CreateCompatibleBitmap(GetDC(0), fr.Right - fr.Left, fr.Bottom - fr.Top);
    old2 := SelectObject(cdc, hb2);
    BitBlt(cdc, 0, 0, fr.Right - fr.Left, fr.Bottom - fr.Top, mdc, fr.Left - wr.Left, fr.Top - wr.Top, SRCCOPY);
    SelectObject(cdc, old2); DeleteDC(cdc);
    SelectObject(mdc, old); DeleteObject(hb); DeleteDC(mdc);
    crop.Handle := hb2;
    sl.Add('// printwindow ' + BoolToStr(ok, True));
    png.Assign(crop);
    png.SaveToFile(OutDir + aName + '.png');
    sl.Add('[');
    DumpControls(aForm, fr.Left, fr.Top, sl);
    s := sl[sl.Count - 1]; if s[Length(s)] = ',' then sl[sl.Count - 1] := Copy(s, 1, Length(s) - 1);
    sl.Add(']');
    sl.SaveToFile(OutDir + aName + '.json');
  finally
    full.Free; crop.Free; png.Free; sl.Free;
  end;
end;
end.
