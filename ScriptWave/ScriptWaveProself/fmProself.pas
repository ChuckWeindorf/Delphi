unit fmProself;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, shellapi;

type
  TfrmProself = class(TForm)
    lbl1: TLabel;
    tmrCopy: TTimer;
    procedure FormShow(Sender: TObject);
    procedure tmrCopyTimer(Sender: TObject);
  private
    { Private declarations }
    vstrAppBaseFolder: string;
  public
    { Public declarations }
  end;

var
  frmProself: TfrmProself;

implementation

{$R *.DFM}

procedure TfrmProself.FormShow(Sender: TObject);
begin
vstrAppBaseFolder := extractfilepath(Application.ExeName);
end;

procedure TfrmProself.tmrCopyTimer(Sender: TObject);
begin
If Fileexists(vstrAppBaseFolder + 'ScriptWavePhysicianTransfer.exe') then
  begin
  If Fileexists(vstrAppBaseFolder + 'ScriptWavePhysicianTransfer.new') then
     begin
     If Fileexists(vstrAppBaseFolder + 'ScriptWavePhysicianTransfer.old') then
        deletefile(vstrAppBaseFolder + 'ScriptWavePhysicianTransfer.old');
     renameFile(vstrAppBaseFolder + 'ScriptWavePhysicianTransfer.exe',
               vstrAppBaseFolder + 'ScriptWavePhysicianTransfer.old');
     renameFile(vstrAppBaseFolder + 'ScriptWavePhysicianTransfer.new',
               vstrAppBaseFolder + 'ScriptWavePhysicianTransfer.exe');
     end;
  ShellExecute(Handle, 'open', pchar(vstrAppBaseFolder
                 + 'ScriptWavePhysicianTransfer.exe'), nil, nil, SW_SHOWNORMAL);
  end;

If Fileexists(vstrAppBaseFolder + 'ScriptWaveTypistTransfer.exe') then
  begin
  If Fileexists(vstrAppBaseFolder + 'ScriptWaveTypistTransfer.new') then
     begin
     If Fileexists(vstrAppBaseFolder + 'ScriptWaveTypistTransfer.old') then
        deletefile(vstrAppBaseFolder + 'ScriptWaveTypistTransfer.old');
     renameFile(vstrAppBaseFolder + 'ScriptWaveTypistTransfer.exe',
               vstrAppBaseFolder + 'ScriptWaveTypistTransfer.old');
     renameFile(vstrAppBaseFolder + 'ScriptWaveTypistTransfer.new',
               vstrAppBaseFolder + 'ScriptWaveTypistTransfer.exe');
     end;
  ShellExecute(Handle, 'open', pchar(vstrAppBaseFolder
                    + 'ScriptWaveTypistTransfer.exe'), nil, nil, SW_SHOWNORMAL);
  end;

close;
end;

end.
