unit fmInstaller;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, filectrl, ShellApi, FastShellLink, SBSimpleSftp,
  ExtCtrls, pmVariablesConstants;

type
  TfrmActivation = class(TForm)
    memProgress: TMemo;
    fslLinkControl: TFastShellLink;
    ftpTransfer: TElSimpleSFTPClient;
    Panel1: TPanel;
    edtActivation: TEdit;
    lbl1: TLabel;
    btnActivate: TButton;
    Panel2: TPanel;
    chkLicenseAgree: TCheckBox;
    procedure btnActivateClick(Sender: TObject);
    procedure chkLicenseAgreeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmActivation: TfrmActivation;

implementation

{$R *.DFM}

procedure TfrmActivation.btnActivateClick(Sender: TObject);
  const cSCW: string = '/home/mudsoxco/ScriptWave/Activation/';
begin
memProgress.Lines.add('PLEASE WAIT...');

try
forcedirectories('C:\ScriptWave');
ftpTransfer.address := '24.210.202.110';
ftpTransfer.Username:= 'mudsoxco';
ftpTransfer.Password:=
 copy(cstrScam12,7,1) +
 //copy(cstrScam18,3,1) +
 copy(cstrScam04,2,1) +
 copy(cstrScam04,2,1) +
 copy(cstrScam01,8,1) +
 copy(cstrScam03,4,1) +
 copy(cstrScam06,17,1) +
 copy(cstrScam10,1,1) +
 copy(cstrScam06,17,1) +
 copy(cstrScam10,1,1);
// copy(cstrScam19,1,1);

ftpTransfer.open;
memProgress.Lines.add('Login OK');
ftpTransfer.Password := '';
try
ftpTransfer.DownloadFile(cSCW + edtActivation.text,
                         'c:\ScriptWave\ScriptWaveAccount_' +
                                         copy(edtActivation.text,6,1) + '.cry');
except
   showmessage('This is not a valid activation code!');
   ftpTransfer.close;
   exit;
   end;
memProgress.Lines.add('Account OK');

memProgress.Lines.add('DOWNLOADING...Please wait');
ftpTransfer.DownloadFile(cSCW + 'ScriptWaveProself.exe',
                'c:\ScriptWave\ScriptWaveProself.exe');
memProgress.Lines.add('Proself OK');

memProgress.Lines.add('DOWNLOADING...Please wait');

If (copy(edtActivation.text,6,1) = 'P') or
   (copy(edtActivation.text,6,1) = 'O') then
  begin
  ftpTransfer.DownloadFile(cSCW + 'ScriptWavePhysicianTransfer.exe',
                'c:\ScriptWave\ScriptWavePhysicianTransfer.exe');
  memProgress.Lines.add('Physician OK');
  ShellExecute(Handle, 'open',
                        pchar('c:\ScriptWave\ScriptWavePhysicianTransfer.exe'),
                        nil, nil, SW_SHOWNORMAL);
  fslLinkControl.linkname := 'ScriptWave Transcription Transfer';
  fslLinkControl.linktarget := 'c:\ScriptWave\ScriptWavePhysicianTransfer.exe';
  end
else
If copy(edtActivation.text,6,1) = 'T' then
  begin
  ftpTransfer.DownloadFile(cSCW + copy(edtActivation.text,1,4) + '_entity',
                  'c:\ScriptWave\ScriptWaveEntity.txt');
  ftpTransfer.DownloadFile(cSCW + 'ScriptWaveTypistTransfer.exe',
                'c:\ScriptWave\ScriptWaveTypistTransfer.exe');
  memProgress.Lines.add('Typist OK');
  ShellExecute(Handle, 'open',
                        pchar('c:\ScriptWave\ScriptWaveTypistTransfer.exe'),
                        nil, nil, SW_SHOWNORMAL);
  fslLinkControl.linkname := 'ScriptWave Transcription Transfer';
  fslLinkControl.linktarget := 'c:\ScriptWave\ScriptWaveTypistTransfer.exe';
  end;
  
memProgress.Lines.add('Creating Shortcuts');
try
  fslLinkControl.CreateIn.ShellFolder := sfDesktop;
  fslLinkControl.Execute;
  fslLinkControl.CreateIn.ShellFolder := sfProgramsMenu;
  fslLinkControl.Execute;
  fslLinkControl.CreateIn.ShellFolder := sfStartup;
  fslLinkControl.Execute;
  memProgress.Lines.add('Shortcuts OK');
  except
  memProgress.lines.add('Shortcuts already exist');
  end;

ftpTransfer.renamefile(cSCW + edtActivation.text,
                       cSCW + 'activated_'+ edtActivation.text);
memProgress.Lines.add('Cleanup complete');

ftpTransfer.close;
showmessage('Completed!  See ScriptWave icon in Toolbar');
except
   Showmessage('Problems in installation - try again or contact tech support');
   end;
close;
end;

procedure TfrmActivation.chkLicenseAgreeClick(Sender: TObject);
begin
Sleep(2000);
panel2.visible:= false;
panel1.visible:= true;
memProgress.text := 'License Approved' + #13#10;
end;

end.
