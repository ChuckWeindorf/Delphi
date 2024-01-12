unit FormImmunizationQR;
{Author:Chuck Weindorf
Description: Report for a summary of immunizations

Date:11/17/99}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Menus, Qrctrls, Buttons, ToolWin, dataMainDataModule,
  ComCtrls, Db, DBTables, StdCtrls, Mask, DBCtrls;

type
  TfrmImmunizationQR = class(TForm)
    pnlBack: TPanel;
    rptImmunizationQR: TQuickRep;
    PageHeaderBand1: TQRBand;
    lbl_10007: TQRLabel;
    SysDate: TQRSysData;
    bndMain: TQRBand;
    lbl_10001: TQRLabel;
    imgLogo1: TQRImage;
    imgLogo2: TQRImage;
    bndImmunization: TQRSubDetail;
    txtImmunization: TQRDBText;
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    lbl_10003: TQRLabel;
    txtImmuneDate: TQRDBText;
    lbl_10004: TQRLabel;
    lbl_10005: TQRLabel;
    txtPatient: TQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bndImmunizationBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor create(Aowner : TComponent); override;
  end;

var
  frmImmunizationQR: TfrmImmunizationQR;

implementation
  uses procSharedDataModuleCalls;
{$R *.DFM}

constructor TfrmImmunizationQR.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vcmpComponent: TComponent;
  vstrOz: string;
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
  rptImmunizationQR.DataSet := vdtmQuickReport.qryImmunization;
  bndImmunization.DataSet := vdtmQuickReport.qryImmunization;

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

procedure TfrmImmunizationQR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmImmunizationQR.bndImmunizationBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
{Any specialized band code}
end;
end.
