unit MhedsTransfer1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, pmVariablesConstants, pmScriptWave_mudCryptor, pmScriptWaveFTP_II,
  pmScriptWaveShare, pmUtilities, pmScriptWaveShareVariable, ExtCtrls,
  TNShellNotifyIcon, ImgList, Menus, ShellAPI;

type
  TfrmTransfer = class(TForm)
    imgImagelist: TImageList;
    shnShellNotify: TTNShellNotifyIcon;
    tmrBlink: TTimer;
    tmrMain: TTimer;
    popTrayMenu: TPopupMenu;
    cmdShow: TMenuItem;
    cmdHide: TMenuItem;
    cmdShutdown: TMenuItem;
    memLog: TMemo;
    cmdClear: TMenuItem;
    cmdRestart: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure cmdShowClick(Sender: TObject);
    procedure cmdHideClick(Sender: TObject);
    procedure cmdShutdownClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrMainTimer(Sender: TObject);
    procedure shnShellNotifyDblClick(Sender: TObject;
      Button: TMouseButton);
    procedure FormPaint(Sender: TObject);
    procedure popTrayMenuPopup(Sender: TObject);
    procedure tmrBlinkTimer(Sender: TObject);
    procedure cmdClearClick(Sender: TObject);
    procedure cmdRestartClick(Sender: TObject);
  private
    { Private declarations }
    vbolshutdown: boolean;
    vbolStart: boolean;
    vintBlinkCount: integer;
    vbolBlink: boolean;
    vintChecks: integer;
    procedure pollfolder;
    procedure getftp;
  public
    { Public declarations }
    vstrHH_folder: string;
  end;

var
  frmTransfer: TfrmTransfer;

implementation

{$R *.DFM}

procedure tfrmTransfer.pollfolder;
 var
  SR: TSearchRec;
  vstrTransmitName: string;
  vintOldSize: int64;
begin
vbolBlink:= true;
try
if FindFirst(vstrHH_folder + '*.tif', faAnyFile, SR) = 0 then
  repeat
  if (sr.name <> '.') and (sr.name <> '..') and
      not fileexists('.\backups\' + SR.Name) then
    begin
    vintOldSize:= 1;
    while vintOldSize <> Int64(sr.FindData.nFileSizeHigh) shl Int64(32) +
                         Int64(sr.FindData.nFileSizeLow) do
      begin
      vintOldSize:= Int64(sr.FindData.nFileSizeHigh) shl Int64(32) +
                  Int64(sr.FindData.nFileSizeLow);
      sleep(20);
      end;
    vstrTransmitName:= copy(sr.name,1,pos('.',SR.name)) + 'cwt';
    if CopyFile(Pchar(vstrHH_folder + SR.Name),
                Pchar('.\temp\' + vstrTransmitName), false) then
      begin
      if comScriptWaveComm.Crypt_Transmit('.\temp\' + vstrTransmitName,'') then
        begin
        comScriptWaveComm.DeleteFTPFile('go_' + vstrTransmitName + '_cry','');
        if comScriptWaveComm.RenameFile(vstrTransmitName + '_cry',
                                     'go_' + vstrTransmitName + '_cry', '') then
          begin
            copyfile(Pchar('.\temp\' + vstrTransmitName),
                   Pchar('.\backups\' + SR.Name),false);
            try
            deletefile('.\temp\' + vstrTransmitName);
            deletefile(vstrHH_folder + SR.Name);
              except end;
            memLog.Lines.add('Sent ' + vstrTransmitName);
          end
        else
          begin
          memLog.Lines.add('Error FTP Rename ' + vstrTransmitName);
          end
        end
      else
        begin
        memLog.Lines.add('Error FTP Sending ' + vstrTransmitName);
        end;
      end;
    end;
  until FindNext(SR) <> 0;
  FindClose(SR);
     finally
     vbolBlink:= false;
  end;
end;

procedure TfrmTransfer.getftp;
var vintLoop: integer;
    vstrFile: string;
    vstrNewFile: string;
    vstrReceiveName: string;
    vbolReceived: boolean;
begin
vbolBlink:= true;
vbolReceived:= false;
try
if comScriptWaveComm.DirectoryListFTP('') then
  begin
  for vintLoop := 0 to vstlDir.count - 1 do
   begin
   vstrFile:= copy(vstlDir[vintLoop],cintFTPDirOffset,999);
   if pos('go_', vstrFile) = 0 then
   else
    begin
    if comScriptWaveComm.Receive_UnCrypt('.\temp\' + vstrFile,
                        100000, '') then
     begin
     vstrNewFile:= copy(vstrFile,4,length(vstrfile)-7);
     vstrReceiveName:= copy(vstrNewFile,1,pos('.',vstrNewFile)) + 'tif';
     renamefile('.\temp\' + copy(vstrFile,1,length(vstrFile)-4),
                '.\temp\' + vstrNewFile);
     CopyFile(Pchar('.\temp\' + vstrNewFile),
              Pchar('.\fax_share\' + vstrReceiveName), false);
     deletefile('.\temp\' + vstrNewFile);
     If fileexists('.\fax_share\' + vstrReceiveName) then
       begin
       comScriptWaveComm.DeleteFTPFile(vstrFile,'');
       memLog.Lines.add('Received ' + copy(vstrReceiveName,4,length(vstrfile)-7));
       vbolReceived:= true;
       end
     else
       begin
       memLog.Lines.add('Cannot process ' + copy(vstrReceiveName,4,length(vstrfile)-7));
       end;
     end
    else
     begin
      memLog.Lines.add('Cannot Receive ' + copy(vstrFile,4,length(vstrfile)-7));
     end
    end;
    end;
   end
else
   begin
   //Directory list failure - free component and try again...
   comScriptWaveComm.shutdown;
   comScriptWaveComm.free;
   comScriptWaveComm:= nil;
   Application.processmessages;
   Sleep(1000);
   Application.processmessages;
   comScriptWaveComm:= tcomScriptWaveCommunicator.create;
   comScriptWaveComm.setup;
   end;
   If vbolReceived then
      Showmessage('Scans received from Harbor Homes');
   finally
   vbolBlink:= false;
   end;
end;

procedure TfrmTransfer.FormCreate(Sender: TObject);
begin
shnShellNotify.SetIconFromIconList(0);
comScriptWaveComm:= tcomScriptWaveCommunicator.create;
comScriptWaveComm.setup;
vbolStart:= true;
createdir('.\Temp');
if vstrSessionType = 'M' then
   cmdClear.enabled:= true;
vintChecks:= 0;
tmrMain.enabled:= true;
end;

procedure TfrmTransfer.cmdShowClick(Sender: TObject);
begin
frmTransfer.Visible:= true;
end;

procedure TfrmTransfer.cmdHideClick(Sender: TObject);
begin
frmTransfer.visible:= false;
end;

procedure TfrmTransfer.cmdShutdownClick(Sender: TObject);
begin
try
tmrBlink.enabled:= false;
tmrMain.enabled:= false;

comScriptWaveComm.shutdown;
comScriptWaveComm.free;
comScriptWaveComm:= nil;
vbolShutdown:= true;
except end;
frmTransfer.Close;
end;

procedure TfrmTransfer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
If not vbolShutdown then
   begin
   frmTransfer.hide;
   abort;
   end;
end;

procedure TfrmTransfer.tmrMainTimer(Sender: TObject);
begin
tmrMain.enabled:= false;
try
comScriptWaveComm.InitializeFTP;
if vstrSessionType = 'M' then
  begin
  getftp;
  vbolShutdown:= true;
 { tmrMain.interval:=15000;
  inc(vintChecks);
  If vintChecks > 300 then
     begin
     cmdRestartClick(self);
     end;  }
  end 
else
  begin
  pollfolder;       
  tmrMain.interval:=2000;
  end;

  finally
  If not vbolShutdown then
    tmrMain.enabled:= true;
  end;
If vbolShutdown then frmtransfer.close;
end;

procedure TfrmTransfer.shnShellNotifyDblClick(Sender: TObject;
  Button: TMouseButton);
begin
frmTransfer.visible:= true;
end;

procedure TfrmTransfer.FormPaint(Sender: TObject);
begin
if vbolStart then
   frmTransfer.visible:= false;
vbolStart:= false;
end;

procedure TfrmTransfer.popTrayMenuPopup(Sender: TObject);
begin
If frmTransfer.Visible = true then
  begin
  cmdShow.enabled:= false;
  cmdHide.enabled:= true;
  end
else
  begin
  cmdShow.enabled:= true;
  cmdHide.enabled:= false;
  end;
end;

procedure TfrmTransfer.tmrBlinkTimer(Sender: TObject);
begin

If vbolBlink then
  begin
  inc(vintBlinkCount);
  If vintBlinkCount = 2 then
      begin
      shnShellNotify.SetIconFromIconList(2);
      vintBlinkCount:= 0;
      end
  else
      shnShellNotify.SetIconFromIconList(0)
  end
else
  shnShellNotify.SetIconFromIconList(0);


end;

procedure TfrmTransfer.cmdClearClick(Sender: TObject);
var  SR: TSearchRec;
begin
if FindFirst('.\fax_share\' + '*.tif', faAnyFile, SR) = 0 then
  repeat
  try
    deletefile('.\fax_share\' + SR.Name);
       except end;
  until FindNext(SR) <> 0;
  FindClose(SR);
end;

procedure TfrmTransfer.cmdRestartClick(Sender: TObject);
begin
try
tmrBlink.enabled:= false;
tmrMain.enabled:= false;

comScriptWaveComm.shutdown;
comScriptWaveComm.free;
comScriptWaveComm:= nil;
vbolShutdown:= true;
except end;
ShellExecute(Handle, 'open', 'MHEDS_Transfer.exe', pchar(vstrSessionType), nil,
             SW_SHOWNORMAL) ;
frmTransfer.Close;
end;

end.
