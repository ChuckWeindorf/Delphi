unit FormReminderQR;
{Author:Chuck Weindorf
Description: Report for a summary of immunizations

Date:11/17/99}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Menus, Qrctrls, Buttons, ToolWin, dataMainDataModule,
  ComCtrls, Db, DBTables, StdCtrls, Mask, DBCtrls;

type
  TfrmReminderQR = class(TForm)
    pnlBack: TPanel;
    rptReminderQR: TQuickRep;
    pagReminder1: TQRBand;
    lbl_10007: TQRLabel;
    SysDate: TQRSysData;
    lbl_10001: TQRLabel;
    lbl_10004: TQRLabel;
    lbl_10005: TQRLabel;
    imgLogo2: TQRImage;
    imgLogo1: TQRImage;
    txtReminderDate: TQRDBText;
    txtReminderCat: TQRDBText;
    QRDBRichText1: TQRDBRichText;
    txtPatient: TQRLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bndReminderBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor create(Aowner : TComponent); override;
  end;

var
  frmReminderQR: TfrmReminderQR;

implementation
  uses procSharedDataModuleCalls;
{$R *.DFM}

constructor TfrmReminderQR.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vcmpComponent: TComponent;
  vstrOz: string;
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  txtPatient.caption:=
    FindEntityName(vdtmQuickReport.qryReminder.fieldbyname('Entity').asinteger);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
  {Assign the tags to datasources.}
  For vintLoop := 0 to ComponentCount - 1 do
     begin
     vcmpComponent := Components[vintLoop];
     If vcmpComponent.tag > 10 then
        begin
        vstrOz := vcmpComponent.name;
        AssignDataSources(vcmpComponent,
                          vdtmQuickReport);
        end;
     end;
end;

procedure TfrmReminderQR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmReminderQR.bndReminderBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
{Any specialized band code}
end;
end.
