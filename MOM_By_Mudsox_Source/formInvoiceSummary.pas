unit formInvoiceSummary;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, dbtables, db;

type
  TrptInvoiceSummary = class(TQuickRep)
    bndHeader: TQRBand;
    imgLogo1: TQRImage;
    lbl_100001: TQRLabel;
    lbl_0007: TQRLabel;
    lbl_10008: TQRLabel;
    lbl_10010: TQRLabel;
    lbl_10012: TQRLabel;
    bndDetail: TQRSubDetail;
    lblInvoice: TQRDBText;
    lblCompany: TQRDBText;
    lblDepartment: TQRDBText;
    lblDate: TQRDBText;
    lbl_20003: TQRLabel;
    lbl_2004: TQRLabel;
    lblAmount: TQRDBText;
    lbl_2005: TQRLabel;
    lblBalance: TQRDBText;
    lbl_2006: TQRLabel;
    lblPayment: TQRDBText;
  private

  public
    vqryTemp: Tquery;
    constructor create(Aowner : TComponent); override;
    destructor destroy; override;

  end;

var
  rptInvoiceSummary: TrptInvoiceSummary;

implementation

  uses procSharedDataModuleCalls;

{$R *.DFM}
constructor TrptInvoiceSummary.Create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
end;

destructor TrptInvoiceSummary.destroy;
begin
  Inherited destroy;
end;

end.
