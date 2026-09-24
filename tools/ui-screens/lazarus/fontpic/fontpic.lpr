program fontpic;
{$mode objfpc}{$H+}
uses Interfaces, Forms, Graphics, SysUtils, LCLType, Classes;
var b: TBitmap; p: TPortableNetworkGraphic; w, h: Integer; t: string;
begin
  Application.Initialize;
  t := 'Book seats for the school play - R150, 0123456789';
  if ParamCount >= 3 then begin with TStringList.Create do begin LoadFromFile(ParamStr(3)); t := Text; Free; end; t := Trim(t); end;
  b := TBitmap.Create;
  b.SetSize(10, 10);
  b.Canvas.Font.Name := ParamStr(1);
  b.Canvas.Font.Height := -34;
  b.Canvas.Font.Quality := fqCleartype;
  w := b.Canvas.TextWidth(t) + 12; h := b.Canvas.TextHeight(t) + 8;
  b.SetSize(w, h);
  b.Canvas.Brush.Color := clWhite; b.Canvas.FillRect(0, 0, w, h);
  b.Canvas.Font.Color := $141414;
  b.Canvas.TextOut(6, 4, t);
  p := TPortableNetworkGraphic.Create; p.Assign(b); p.SaveToFile(ParamStr(2));
  p.Free; b.Free;
end.
