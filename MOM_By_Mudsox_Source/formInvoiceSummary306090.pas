unit formInvoiceSummary306090;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, dbtables, db;

type
  TrptInvoiceSummary306090 = class(TQuickRep)
    bndHeader: TQRBand;
    imgLogo1: TQRImage;
    lbl_100001: TQRLabel;
    lbl_0007: TQRLabel;
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
    bndFooter: TQRBand;
    lblAmountTot: TQRLabel;
    lblPayTot: TQRLabel;
    lblBalTot: TQRLabel;
    QRShape1: TQRShape;
    lbl_1001: TQRLabel;
    procedure lblAmountPrint(sender: TObject; var Value: String);
    procedure lblPaymentPrint(sender: TObject; var Value: String);
    procedure lblBalancePrint(sender: TObject; var Value: String);
  private
    vreaAmt, vreaPay, vreaBal: real;
  public
    vqryTemp: Tquery;
    constructor create(Aowner : TComponent); override;
    destructor destroy; override;

  end;

var
  rptInvoiceSummary306090: TrptInvoiceSummary306090;

implementation

  uses procSharedDataModuleCalls;

{$R *.DFM}
constructor TrptInvoiceSummary306090.Create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  vreaAmt:= 0;
  vreaPay:= 0;
  vreaBal:= 0;
end;

destructor TrptInvoiceSummary306090.destroy;
begin
  Inherited destroy;
end;
procedure TrptInvoiceSummary306090.lblAmountPrint(sender: TObject;
  var Value: String);
begin
try
  vreaAmt:= vreaAmt + vqryTemp.fieldbyname('BillTotalAmount').asfloat;
  lblAmountTot.caption:= format('%5.2m',[vreaAmt]);
  except
  end;
end;

procedure TrptInvoiceSummary306090.lblPaymentPrint(sender: TObject;
  var Value: String);
begin
try
  vreaPay:= vreaPay + vqryTemp.fieldbyname('BillTotalPayment').asfloat;
  lblPayTot.caption:= format('%5.2m',[vreaPay]);
  except
  end;
end;

procedure TrptInvoiceSummary306090.lblBalancePrint(sender: TObject;
  var Value: String);
begin
try
  vreaBal:= vreaBal + vqryTemp.fieldbyname('BillTotalBalance').asfloat;
  lblBalTot.caption:= format('%5.2m',[vreaBal]);
  except
  end;
end;

end.
