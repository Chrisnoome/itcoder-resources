Program EventOrder;

{$H+}

// Lesson 23: which form events fire, in which order. Writes events.txt.

Uses
  Interfaces, Forms, Classes, SysUtils, Controls, ExtCtrls;

Type
  TLogForm = Class (TForm)
  public
    timer : TTimer;
    Procedure DoCreate2 (Sender : TObject);
    Procedure DoShow2 (Sender : TObject);
    Procedure DoActivate2 (Sender : TObject);
    Procedure DoDeactivate2 (Sender : TObject);
    Procedure DoCloseQuery2 (Sender : TObject; Var CanClose : Boolean);
    Procedure DoClose2 (Sender : TObject; Var CloseAction : TCloseAction);
    Procedure DoHide2 (Sender : TObject);
    Procedure DoDestroy2 (Sender : TObject);
    Procedure Tick (Sender : TObject);
  End;

Var
  log  : TStringList;
  form : TLogForm;

Procedure TLogForm.DoCreate2 (Sender : TObject); Begin log.Add ('OnCreate'); End;
Procedure TLogForm.DoShow2 (Sender : TObject); Begin log.Add ('OnShow'); End;
Procedure TLogForm.DoActivate2 (Sender : TObject); Begin log.Add ('OnActivate'); End;
Procedure TLogForm.DoDeactivate2 (Sender : TObject); Begin log.Add ('OnDeactivate'); End;
Procedure TLogForm.DoCloseQuery2 (Sender : TObject; Var CanClose : Boolean); Begin log.Add ('OnCloseQuery'); End;
Procedure TLogForm.DoClose2 (Sender : TObject; Var CloseAction : TCloseAction); Begin log.Add ('OnClose'); End;
Procedure TLogForm.DoHide2 (Sender : TObject); Begin log.Add ('OnHide'); End;
Procedure TLogForm.DoDestroy2 (Sender : TObject); Begin log.Add ('OnDestroy'); log.SaveToFile ('events.txt'); End;
Procedure TLogForm.Tick (Sender : TObject);
Begin
  timer.Enabled := False;
  log.Add ('-- closing');
  Close;
End;

Begin
  log := TStringList.Create;
  Application.Initialize;
  form := TLogForm.CreateNew (Nil);
  form.OnCreate := @form.DoCreate2;   // too late for CreateNew - logged by hand below
  form.OnShow := @form.DoShow2;
  form.OnActivate := @form.DoActivate2;
  form.OnDeactivate := @form.DoDeactivate2;
  form.OnCloseQuery := @form.DoCloseQuery2;
  form.OnClose := @form.DoClose2;
  form.OnHide := @form.DoHide2;
  form.OnDestroy := @form.DoDestroy2;
  form.timer := TTimer.Create (form);
  form.timer.Interval := 500;
  form.timer.OnTimer := @form.Tick;
  log.Add ('-- ShowModal 1');
  form.timer.Enabled := True;
  form.ShowModal;
  log.Add ('-- back from ShowModal 1');
  log.Add ('-- ShowModal 2');
  form.timer.Enabled := True;
  form.ShowModal;
  log.Add ('-- back from ShowModal 2');
  form.Free;
End.
