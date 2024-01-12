unit formEmail;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, SakMsg, SakSMTP, Buttons, Gauges, checklst,
  procMudsoxImage, formMudsoxFullImage, procRoutines;

type
  TfrmEmail = class(TForm)
    pnlTop: TPanel;
    edtServer: TEdit;
    edtSubject: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtFrom: TEdit;
    gag1: TGauge;
    lstRecipients: TCheckListBox;
    imgEmail: TImage;
    pnlRecipient: TPanel;
    lbl11: TLabel;
    edtNewRecipient: TEdit;
    cmdNewEmail: TBitBtn;
    cmdMail: TBitBtn;
    pnlEmailBottom: TPanel;
    memText: TMemo;
    lstImages: TListBox;
    pnlLeft: TPanel;
    lbl6: TLabel;
    lbl7: TLabel;
    cmdDelete: TSpeedButton;
    procedure cmdMailClick(Sender: TObject);
    procedure smtpMailerSendProgress(Sender: TObject; Percent: Word);
    procedure lstImagesClick(Sender: TObject);
    procedure imgEmailDblClick(Sender: TObject);
    procedure lstRecipientsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNewRecipientKeyPress(Sender: TObject; var Key: Char);
    procedure cmdNewEmailClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
  private
    { Private declarations }
    vintProgress: integer;
  public
    vstrLocalPath: string;
    { Public declarations }
  end;

var
  frmEmail: TfrmEmail;

implementation

{$R *.DFM}

procedure TfrmEmail.cmdMailClick(Sender: TObject);
var vintLoop: integer;
    SMTPMailer: TSakSMTP;
    SMTPMessage: TSAKMsg;
begin
screen.Cursor:= crHourglass;
SMTPMailer:= TsakSMTP.Create(nil);
SMTPMessage:= TsakMSG.Create(nil);
SMTPMailer.OnSendProgress:= smtpMailerSendProgress;
try
SMTPMailer.TimeOut:= 60000;
SMTPMailer.SendProgressStep:= 1;
vintProgress:= 0;
smtpMailer.Host:= edtServer.Text;
smtpMailer.Connect;
smtpMessage.sendto:= '';
If smtpMailer.Connected then
   begin
   smtpMessage.from:= edtFrom.text;
   If lstRecipients.Items.Count > 0 then
      begin
      for vintLoop:= 0 to lstRecipients.Items.Count - 1 do
         If lstRecipients.Checked[vintLoop] then
            smtpMessage.sendto := smtpMessage.sendto +
                               '<' + lstRecipients.Items[vintLoop] + '>' + ', ';
      smtpMessage.sendto:=
                      copy(smtpMessage.sendto, 1, length(smtpMessage.sendto)-2);
      end;
   smtpMessage.Subject:= edtSubject.text;
   smtpMessage.text.assign(memText.Lines);
   If lstImages.items.Count > 0 then
      for vintLoop:= 0 to lstImages.items.Count - 1 do
         smtpMessage.AttachedFiles.add(lstImages.items[vintLoop]);
   gag1.visible:= true;
   smtpMailer.SendTheMessage(smtpMessage);
   smtpMailer.disConnect;
   gag1.progress:= 0;
   gag1.visible:= false;
   close;
   end
else
   Showmessage('Unable to connect to Server - Check connection');
finally
  screen.Cursor:= crDefault;
  smtpMailer.free;
  smtpMessage.free;
  end
end;

procedure TfrmEmail.smtpMailerSendProgress(Sender: TObject; Percent: Word);
begin
gag1.progress:= vintProgress;
inc(vintProgress);
end;

procedure TfrmEmail.lstImagesClick(Sender: TObject);
begin
  FillImageBox(imgEmail,
             false,
             49,
             35,
             lstImages.items[lstImages.itemindex]);
end;

procedure TfrmEmail.imgEmailDblClick(Sender: TObject);
begin
If lstImages.itemindex = -1 then
    exit;
application.Createform(tfrmFullImage, frmFullImage);
try
frmFullImage.caption := 'Mudsox picture magnifier';
FillImageBox(frmFullImage.imgFullImage,
                      true, 0, 0,
                      lstImages.items[lstImages.itemindex]);
frmFullImage.vintImgWidth:= screen.Width;
frmFullImage.vintImgHeight:= screen.Height;
frmFullImage.ShowModal;
finally
  frmFullImage.Release;
  frmFullImage:= nil;
  end;
end;

procedure TfrmEmail.lstRecipientsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If key = 46 then
   If lstRecipients.itemindex <> -1 then
      begin
      lstImages.items.delete(lstImages.ItemIndex);
      imgEmail.picture:= nil;
      end
end;

procedure TfrmEmail.edtNewRecipientKeyPress(Sender: TObject;
  var Key: Char);
begin
If key = #13 then
   If pos('@', edtNewRecipient.text) > 0 then
      begin
      lstRecipients.Items.Add(edtNewRecipient.text);
      pnlRecipient.visible:= false;
      pnlTop.enabled:=true;
      end;
If key = #27 then
   begin
      pnlRecipient.visible:= false;
      pnlTop.enabled:=true;
   end;
end;

procedure TfrmEmail.cmdNewEmailClick(Sender: TObject);
begin
pnlTop.enabled := false;
pnlRecipient.visible:= true;
edtNewRecipient.setfocus;
end;

procedure TfrmEmail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
lstRecipients.Items.Savetofile(vstrLocalPath + '\Recipients.dat')
end;

procedure TfrmEmail.FormShow(Sender: TObject);
begin
If FileExists(vstrLocalPath + '\Recipients.dat') then
    lstRecipients.Items.Loadfromfile(vstrLocalPath + '\Recipients.dat')
end;

procedure TfrmEmail.FormCreate(Sender: TObject);
begin
lstImages.items.assign(vstlEmailImages);
end;

procedure TfrmEmail.cmdDeleteClick(Sender: TObject);
begin
   If lstImages.itemindex <> -1 then
      begin
      lstImages.items.delete(lstImages.ItemIndex);
      imgEmail.picture:= nil;
      end;
end;

end.
