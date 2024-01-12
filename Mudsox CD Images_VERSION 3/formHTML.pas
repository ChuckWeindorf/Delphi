unit formHTML;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Gauges, ExtCtrls, OleCtrls, isp3, Buttons, procMudsoxImage,
  procRoutines, Psock, NMFtp;

type
  TfrmHTML = class(TForm)
    pnlFiles: TPanel;
    lstImages: TListBox;
    pnlMain: TPanel;
    edtServer: TEdit;
    edtLogin: TEdit;
    edtPassword: TEdit;
    gag1: TGauge;
    edtDirectory: TEdit;
    memComments: TMemo;
    edtTitle: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    memConstants: TMemo;
    pnlOld: TPanel;
    lstImagesOld: TListBox;
    lbl8: TLabel;
    cmdDeleteOld: TSpeedButton;
    lbl9: TLabel;
    imgHTML: TImage;
    cmdDeleteNew: TSpeedButton;
    cmdUpload: TBitBtn;
    ftpServer: TNMFTP;
    procedure cmdUploadClick(Sender: TObject);
//    procedure ftpServerProtocolStateChanged(Sender: TObject;
//      ProtocolState: Smallint);
    procedure lstImagesClick(Sender: TObject);
    procedure ftpServerError(Sender: TObject; Number: Smallint;
      var Description: WideString; Scode: Integer; const Source,
      HelpFile: WideString; HelpContext: Integer;
      var CancelDisplay: WordBool);
    procedure ftpServerCreateDir(Sender: TObject);
    procedure ftpServerChangeDir(Sender: TObject);
    procedure ftpServerType_(Sender: TObject);
    procedure lstImagesOldClick(Sender: TObject);
    procedure cmdDeleteNewClick(Sender: TObject);
    procedure cmdDeleteOldClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    vstrlocalPath, vstrErrorType, vstrHTMLName: string;
    vbolTransactionsReady, vbolBypassError, vbolError: boolean;
    { Public declarations }
  end;

var
  frmHTML: TfrmHTML;

implementation

{$R *.DFM}

procedure TfrmHTML.cmdUploadClick(Sender: TObject);
var vintLoop, vintLoop2: integer;
    vstlHTML: tstringlist;
//  Procedure TransWait;
//    begin
//    while (not vbolTransactionsReady) or ftpServer.Busy do
//        begin
//        sleep(500);
//        application.processmessages;
//        end;
//    vbolTransactionsReady:= false;
//    end;
begin
screen.cursor := crHourglass;
vstlHTML:= tstringlist.create;
try
vbolError:= false;
vbolBypassError:= false;
vbolTransactionsReady:= false;
gag1.MaxValue:= lstImages.items.count + 1;
gag1.Minvalue:= 0;
gag1.Progress:= 0;
gag1.visible:= true;
lbl9.visible:= true;
application.processmessages;
//if ftpServer.State = prcConnected then
//   ftpServer.quit;
ftpServer.Host:= edtServer.Text;
ftpServer.UserID:= edtLogin.text;
ftpServer.Password:= edtPassword.text;
vstrErrorType:='Could not connect to the server';
ftpServer.Connect;
//(ftpServer.RemoteHost, ftpServer.RemotePort);
//TransWait;
If vbolError then exit;
vbolBypassError:= true;
ftpServer.MakeDirectory(edtDirectory.text);
//TransWait;
vbolBypassError:= false;
vstrErrorType:='Could not create or go to directory';
ftpServer.ChangeDir(edtDirectory.text);
//TransWait;
If vbolError then exit;
//ftpServer.Type_(3);
ftpserver.Mode(3);
//TransWait;
If vbolError then exit;
vstrErrorType:='Could not upload an image file';
For vintLoop:= 0 to lstImages.items.Count - 1 do
   begin
   ftpServer.upload(lstImages.items[vintLoop],
                     extractfilename(lstImages.items[vintLoop]));
   vbolTransactionsReady:= true;
   //TransWait;
   If vbolError then exit;
   gag1.progress:= gag1.progress + 1;
   end;
vintLoop:=0;
while copy(memConstants.lines[vintLoop], 1, 3) <> '|||' do
  begin
  If memConstants.lines[vintLoop] = 'HEADER' then
     vstlHTML.add(edtTitle.text)
  else
  If memConstants.lines[vintLoop] = 'DESCRIPTION' then
     vstlHTML.add('<BR>' + memComments.text + '<BR>')
  else
     vstlHTML.add(memConstants.lines[vintLoop]);
  inc(vintLoop);
  end;
inc(vintLoop);
For vintLoop2:= 0 to lstImages.items.Count - 1 do
   vstlHTML.add('<tr><td><a href="' +
                extractfilename(lstImages.items[vintLoop2]) + '">' +
                copy(vstlNewHTML[vintLoop2], 1,
                                        pos('||', vstlNewHTML[vintLoop2]) - 1) +
                '</a></td><td>' +
                copy(vstlNewHTML[vintLoop2],
                                   pos('||', vstlNewHTML[vintLoop2]) + 2, 999) +
                '</td></tr>');
For vintLoop2:= 0 to lstImagesOld.items.Count - 1 do
   If lstImages.items.indexof(lstImagesOld.items[vintLoop2]) = -1 then
       vstlHTML.add('<tr><td><a href="' +
                extractfilename(lstImagesOld.items[vintLoop2]) + '">' +
                copy(vstlOldHTML[vintLoop2], 1,
                                        pos('||', vstlOldHTML[vintLoop2]) - 1) +
                '</a></td><td>' +
                copy(vstlOldHTML[vintLoop2],
                                   pos('||', vstlOldHTML[vintLoop2]) + 2, 999) +
                '</td></tr>');
while memConstants.lines.count <> vintLoop do
  begin
  vstlHTML.add(memConstants.lines[vintLoop]);
  inc(vintLoop);
  end;
gag1.progress:= gag1.progress + 1;
vstlHTML.savetofile(vstrLocalPath + '\mudsox.html');
//ftpServer.Type_(1);
ftpserver.Mode(1);
//TransWait;
If vbolError then exit;
vstrErrorType:='Could not upload the HTML page';
ftpServer.Upload(vstrLocalPath + '\mudsox.html', 'index.html');
vbolTransactionsReady:= true;
//TransWait;
If vbolError then exit;
For vintLoop:= 0 to lstImages.items.count - 1 do
   If lstImagesOld.Items.IndexOf(lstImages.items[vintLoop]) = -1 then
      lstImagesOld.Items.add(lstImages.items[vintLoop]);
lstImagesOLD.items.Savetofile(vstrLocalPath + '\' + vstrHTMLName);
vstlNewHTML.clear;
vstlNewImages.Clear;
lstImages.Items.clear;
finally
  gag1.visible:= false;
  lbl9.visible:= false;
  vstlHTML.free;
//  if ftpServer.State = prcConnected then
  ftpServer.Disconnect;
  screen.cursor:= crDefault;
  end;
end;

procedure TfrmHTML.lstImagesClick(Sender: TObject);
begin
FillImageBox(imgHTML,
             false,
             228,
             65,
             lstImages.Items[lstImages.Itemindex]);
end;

procedure TfrmHTML.ftpServerError(Sender: TObject; Number: Smallint;
  var Description: WideString; Scode: Integer; const Source,
  HelpFile: WideString; HelpContext: Integer; var CancelDisplay: WordBool);
begin
  If vbolBypassError then
  else
    begin
    vbolError:= true;
    Showmessage(vstrErrorType);
    end;
vbolTransactionsReady:= true;
end;

procedure TfrmHTML.ftpServerCreateDir(Sender: TObject);
begin
    vbolTransactionsReady:= true;
end;

procedure TfrmHTML.ftpServerChangeDir(Sender: TObject);
begin
    vbolTransactionsReady:= true;
end;

procedure TfrmHTML.ftpServerType_(Sender: TObject);
begin
    vbolTransactionsReady:= true;
end;

procedure TfrmHTML.lstImagesOldClick(Sender: TObject);
begin
FillImageBox(imgHTML,
             false,
             228,
             65,
             lstImagesOld.Items[lstImagesOld.Itemindex]);
end;

procedure TfrmHTML.cmdDeleteNewClick(Sender: TObject);
var vintWork: integer;
begin
If lstImages.ItemIndex > -1 then
  begin
  vintWork:= lstImages.ItemIndex;
  lstImages.Items.Delete(vintWork);
  vstlNewHTML.delete(vintWork);
  imgHTML.picture:= nil;
  end;
end;

procedure TfrmHTML.cmdDeleteOldClick(Sender: TObject);
var vintWork: integer;
begin
If lstImagesOld.ItemIndex > -1 then
  begin
  vintWork:= lstImagesOld.ItemIndex;
  lstImagesOld.Items.Delete(vintWork);
  vstlOldHTML.delete(vintWork);
  imgHTML.picture:= nil;
  end;
end;

procedure TfrmHTML.FormCreate(Sender: TObject);
begin
lstImages.Items.assign(vstlNewImages);
end;

end.
