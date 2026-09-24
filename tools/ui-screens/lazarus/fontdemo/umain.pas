Unit uMain;

{$H+}

Interface

Uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Windows,
  Registry, FileUtil;

Const
  FR_PRIVATE = $10;

Type
  TfrmMain = Class (TForm)
    lblTitle   : TLabel;
    lblMessage : TLabel;
    Procedure FormCreate (Sender : TObject);
    Procedure FormDestroy (Sender : TObject);
  private
    fontFile : String;
  End; // TfrmMain

Function AddFontResourceEx (aFileName : PWideChar; aFlags : DWORD; aReserved : Pointer) : Integer;
  StdCall; External 'gdi32.dll' Name 'AddFontResourceExW';
Function RemoveFontResourceEx (aFileName : PWideChar; aFlags : DWORD; aReserved : Pointer) : BOOL;
  StdCall; External 'gdi32.dll' Name 'RemoveFontResourceExW';
Function InstallFontForUser (aFontFile : String; aFontName : String) : Boolean;

Var
  frmMain : TfrmMain;

Implementation

{$R *.lfm}

// Loads the font that comes with the program, for this program only - nothing
// is installed. If the font file is missing, it uses Segoe UI instead.
// Sender - the form
Procedure TfrmMain.FormCreate (Sender : TObject);
Begin
  fontFile := ExtractFilePath (Application.ExeName) + 'FreeSerif.ttf';
  If FileExists (fontFile) And (AddFontResourceEx (PWideChar (UnicodeString (fontFile)), FR_PRIVATE, Nil) > 0) Then
  Begin
    lblTitle.Font.Name := 'FreeSerif';
    lblMessage.Caption := 'FreeSerif.ttf was loaded for this program only.';
  End // if
  Else
  Begin
    lblTitle.Font.Name := 'Segoe UI';
    lblMessage.Caption := 'FreeSerif.ttf is missing - using Segoe UI instead.';
  End; // else
End; // TfrmMain.FormCreate

// Lets go of the font when the program closes.
// Sender - the form
Procedure TfrmMain.FormDestroy (Sender : TObject);
Begin
  If FileExists (fontFile) Then
  Begin
    RemoveFontResourceEx (PWideChar (UnicodeString (fontFile)), FR_PRIVATE, Nil);
  End; // if
End; // TfrmMain.FormDestroy

// Installs a font for this Windows user only (no administrator needed), after
// asking first. It copies the file into the user's own Fonts folder and records
// it in the registry, the way Windows' own Install button does.
// aFontFile - the .ttf file that came with the program
// aFontName - the font's name, such as FreeSerif
// Gives back: True if it was installed
Function InstallFontForUser (aFontFile : String; aFontName : String) : Boolean;
Var
  fontsFolder : String;
  target      : String;
  registry    : TRegistry;
Begin
  Result := False;
  If MessageDlg ('This program looks best with the font ' + aFontName
                 + '. Install it for your Windows user?', mtConfirmation, [mbYes, mbNo], 0) = mrYes Then
  Begin
    fontsFolder := SysUtils.GetEnvironmentVariable ('LOCALAPPDATA') + '\Microsoft\Windows\Fonts\';
    ForceDirectories (fontsFolder);
    target := fontsFolder + ExtractFileName (aFontFile);
    If CopyFile (aFontFile, target) Then
    Begin
      registry := TRegistry.Create;
      Try
        registry.RootKey := HKEY_CURRENT_USER;
        If registry.OpenKey ('Software\Microsoft\Windows NT\CurrentVersion\Fonts', True) Then
        Begin
          registry.WriteString (aFontName + ' (TrueType)', target);
          Result := AddFontResource (PChar (target)) > 0;
          SendMessage (HWND_BROADCAST, WM_FONTCHANGE, 0, 0);
        End; // if
      Finally
        registry.Free;
      End; // try
    End; // if
  End; // if
End; // InstallFontForUser

End.
