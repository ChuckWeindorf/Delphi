unit formMudsoxAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, fmxutils, Buttons;

type
  TfrmAbout = class(TForm)
    pnl1: TPanel;
    memID: TMemo;
    memAbout: TMemo;
    cmdEmailMudsox: TBitBtn;
    cmdMudsoxWeb: TBitBtn;
    cmdEmailSupport: TBitBtn;
    procedure cmdEmailMudsoxClick(Sender: TObject);
    procedure cmdMudsoxWebClick(Sender: TObject);
    procedure cmdEmailSupportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.DFM}

procedure TfrmAbout.cmdEmailMudsoxClick(Sender: TObject);
begin
ExecuteFile('mailto:Charles.Weindorf@mudsox.com','','',0);
end;

procedure TfrmAbout.cmdMudsoxWebClick(Sender: TObject);
begin
ExecuteFile('http://www.mudsox.com/Shareware/MudsoxRegister.html','','',0);
end;

procedure TfrmAbout.cmdEmailSupportClick(Sender: TObject);
begin
ExecuteFile('mailto:Support@mudsox.com','','',0);
end;

end.
