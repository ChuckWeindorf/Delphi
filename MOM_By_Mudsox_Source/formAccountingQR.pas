unit formAccountingQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, TeeProcs, Chart, DBChart, QrTee, Qrctrls, quickrpt,
  ExtCtrls, dbtables;

type
  TfrmAccountingQR = class(TForm)
    rptAccounting: TQuickRep;
    bndHeader: TQRBand;
    lbl_10001: TQRLabel;
    imgLogo1: TQRImage;
    bndData: TQRSubDetail;
    bndGraph: TQRBand;
    lbl_1001: TQRLabel;
    edtTotal: TQRLabel;
    txtData1: TQRDBText;
    txtData2: TQRDBText;
    lbl_1002: TQRLabel;
    lbl_1003: TQRLabel;
    lbl_10002: TQRSysData;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor create(Aowner : TComponent); override;
  end;

var
  frmAccountingQR: TfrmAccountingQR;

implementation

uses procSharedDataModuleCalls;

{$R *.DFM}

constructor TfrmAccountingQR.create(AOwner: TComponent);
begin
  Inherited create(AOwner);
  rptAccounting.dataset:= vqryQuickReport;
  bndData.dataset:= vqryQuickReport;
  txtData1.dataset:= vqryQuickReport;
  txtData2.dataset:= vqryQuickReport;
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
end;

end.
