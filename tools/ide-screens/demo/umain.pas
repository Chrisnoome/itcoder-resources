Unit uMain;

{$mode objfpc}{$H+}

Interface

Uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

Type
  TfrmMain = Class (TForm)
    btnGreet    : TButton;
    edtName     : TEdit;
    lblName     : TLabel;
    lblGreeting : TLabel;
    Procedure btnGreetClick (Sender : TObject);
  End;

Var
  frmMain : TfrmMain;

Implementation

{$R *.lfm}

{ Greets the pupil by the name typed in the box. }
Procedure TfrmMain.btnGreetClick (Sender : TObject);
Begin
  lblGreeting.Caption := 'Hello, ' + edtName.Text + '!';
End;

End.
