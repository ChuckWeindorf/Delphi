unit formInvoiceQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Qrctrls, quickrpt, ExtCtrls;

type
  TfrmInvoiceQR = class(TForm)
    rptInvoice: TQuickRep;
    lbl1: TQRLabel;
    memHeader: TQRMemo;
    memFooter: TQRMemo;
    lbl2: TQRLabel;
    lbl3: TQRLabel;
    memComments: TQRMemo;
    lblAmountDue: TQRLabel;
    lbl5: TQRLabel;
    memClientInfo: TQRMemo;
    lbl6: TQRLabel;
    lbl7: TQRLabel;
    lblInvoiceNumber: TQRLabel;
    lblPhysician: TQRLabel;
    lbl8: TQRLabel;
    lblDate: TQRLabel;
    lbl9: TQRLabel;
    lbl10: TQRLabel;
    lbl11: TQRLabel;
    lblFee: TQRLabel;
    lblPriorPay: TQRLabel;
    lblCopay: TQRLabel;
    imgLogo: TQRImage;
    QRBand1: TQRBand;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInvoiceQR: TfrmInvoiceQR;

implementation

uses procSharedDataModuleCalls;

{$R *.DFM}

procedure TfrmInvoiceQR.FormCreate(Sender: TObject);
begin
  imgLogo.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
end;

end.
