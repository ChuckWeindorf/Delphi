unit qr_1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TrptCert = class(TQuickRep)
    QRBand1: TQRBand;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRMemo1: TQRMemo;
    QRMemo2: TQRMemo;
    QRShape3: TQRShape;
  private

  public

  end;

var
  rptCert: TrptCert;

implementation

{$R *.DFM}

end.
