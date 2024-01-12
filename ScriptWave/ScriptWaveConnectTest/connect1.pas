unit connect1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SBSimpleSftp, ExtCtrls, SBSSHConstants, SBSSHKeyStorage, SBSftpCommon;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    sftp: TElSimpleSFTPClient;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    vbolCommunicate: boolean;
    procedure ThreadDirectoryListFTP;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
try
If not vbolCommunicate then
  begin
  edit1.text:= 'Start';
  application.processmessages;
  vbolCommunicate:= true;
  try
  If not sftp.Active then
    begin
    edit1.text:= 'Connect';
    application.processmessages;
    sftp.Open;
    end;
  ThreadDirectoryListFTP;
  edit1.text:= 'Done';
  application.processmessages;
  finally
    vbolCommunicate:= false;
    end;
  end;
except
  edit1.text:= 'Cannot Connect';
  application.processmessages;
  end;
end;

procedure TForm1.ThreadDirectoryListFTP;
      var dirHandle: string;
      procedure BuildList;
           var Info : TElSftpFileInfo;
           vintLoop: integer;
           vlst: Tlist;
        begin
          vlst:= tlist.create;
          sftp.ReadDirectory(dirHandle, vlst);
          try
            for vintLoop:= 0 to vlst.Count - 1 do
              begin
              Info := TElSftpFileInfo.Create;
              try
               TElSftpFileInfo(vlst.Items[vintLoop]).CopyTo(Info);
               TElSftpFileInfo(vlst.Items[vintLoop]).Free;
               memo1.lines.add(format('%-10.0d',[Info.Attributes.size])+ Info.Name);
               finally
                 Info.free;
                 end;
              end;
            finally
              vlst.free;
              end;
        end;
begin
  try
  try
    dirHandle:= sftp.OpenDirectory('/home/mudsoxco/ScriptWave/A001/');
    memo1.lines.clear;
      edit1.text:= 'Try List';
      application.processmessages;
    BuildList;
    application.processmessages;
      except
      edit1.text:= 'List Fail';
      application.processmessages;
          end;
    finally
      sftp.CloseHandle(dirHandle);
      end;
end;

end.
