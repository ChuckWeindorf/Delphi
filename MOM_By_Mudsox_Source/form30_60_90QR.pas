unit form30_60_90QR;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, dbtables, db;

type
  Trpt30_60_90 = class(TQuickRep)
    bndHeader: TQRBand;
    imgLogo1: TQRImage;
    lbl_100001: TQRLabel;
    lbl_0007: TQRLabel;
    lbl_10010: TQRLabel;
    lbl_10012: TQRLabel;
    lbl_20003: TQRLabel;
    lbl_2005: TQRLabel;
    bndDetail: TQRSubDetail;
    lblInvoice: TQRDBText;
    lblCompany: TQRDBText;
    lblDate: TQRDBText;
    lblBalance: TQRDBText;
    bndFooter: TQRBand;
    lblBalTot: TQRLabel;
    QRShape1: TQRShape;
    lbl_1001: TQRLabel;
    tblTemp: TTable;
    QRLabel1: TQRLabel;
    lblEntity: TQRDBText;
  private
    vreaBal: real;
  public
    constructor create(Aowner : TComponent); override;
    destructor destroy; override;
  end;

var
  rpt30_60_90: Trpt30_60_90;

implementation
  uses procSharedDataModuleCalls;


{$R *.DFM}
constructor Trpt30_60_90.Create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  vreaBal:= 0;
end;

destructor Trpt30_60_90.destroy;
begin
  Inherited destroy;
end;

end.
