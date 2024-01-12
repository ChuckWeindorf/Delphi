unit formPickListQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Menus, Qrctrls, Buttons, ToolWin, dataMainDataModule,
  ComCtrls, Db, DBTables, StdCtrls, Mask, DBCtrls;

type
  TfrmPickListQR = class(TForm)
    pnlBack: TPanel;
    rptPickList: TQuickRep;
    QRSubDetail1: TQRSubDetail;
    PageHeaderBand1: TQRBand;
    lbl_10007: TQRLabel;
    SysDate: TQRSysData;
    lbl_00003: TQRLabel;
    lbl_00004: TQRLabel;
    lbl_00005: TQRLabel;
    lbl_10001: TQRLabel;
    lbl_00002: TQRLabel;
    imgLogo2: TQRImage;
    imgLogo1: TQRImage;
    lbl_00001: TQRLabel;
    lbl_00006: TQRLabel;
    lbl_00007: TQRLabel;
    shaBlueLine: TQRShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor create(Aowner : TComponent); override;
  end;

var
  frmPickListQR: TfrmPickListQR;

implementation
  uses procSharedDataModuleCalls;
{$R *.DFM}

constructor TfrmPickListQR.Create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
  rptPicklist.DataSet := vqryQuickReport;
  qrsubdetail1.DataSet := vqryQuickReport;
  lbl_00002.caption:= vqryQuickReport.fieldbyname('ListField').asstring;
end;

procedure TfrmPickListQR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmPickListQR.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  lbl_00003.caption := vqryQuickReport.fieldbyname('ListValue').asstring;
  lbl_00004.caption := vqryQuickReport.fieldbyname('ListCode').asstring;
  lbl_00005.caption := vqryQuickReport.fieldbyname('ListExpiration').asstring;
end;

end.
