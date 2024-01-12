unit rptOpenBills;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, dbtables;

type
  TrptAllOpenBills = class(TQuickRep)
    bndHeader: TQRBand;
    imgLogo1: TQRImage;
    lbl_100001: TQRLabel;
    lbl_10010: TQRLabel;
    lbl_2005: TQRLabel;
    QRLabel1: TQRLabel;
    bndDetail: TQRSubDetail;
    lblCompany: TQRDBText;
    lblBalance: TQRDBText;
    lblEntity: TQRDBText;
    bndFooter: TQRBand;
    lblBalTot: TQRLabel;
    QRShape1: TQRShape;
    lbl_1001: TQRLabel;
    procedure bndDetailAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
  private
    reaMoney: real;
  public
    qryTemp: tquery;
    constructor create(Aowner : TComponent); override;
    destructor destroy; override;
  end;

var
  rptAllOpenBills: TrptAllOpenBills;

implementation
     uses procSharedDataModuleCalls;
     
{$R *.DFM}
constructor TrptAllOpenBills.Create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
end;

destructor TrptAllOpenBills.destroy;
begin
  Inherited destroy;
end;

procedure TrptAllOpenBills.bndDetailAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
reaMoney:= reaMoney + qryTemp.fieldbyName('PatientBalance').asfloat;
 lblBalTot.caption:= format('%6.2m', [reaMoney]);
end;

end.
