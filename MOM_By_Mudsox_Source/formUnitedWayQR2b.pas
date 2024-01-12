unit formUnitedWayQR2b;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TrptUnitedWay2b = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    imgLogo1: TQRImage;
    QRBand2: TQRBand;
    qrmInterpret1: TQRMemo;
    qrmInterpret2: TQRMemo;
    qrmInterpret3: TQRMemo;
    QRShape1: TQRShape;
    qrmInterpret4: TQRMemo;
    qrmInterpret5: TQRMemo;
    qrmInterpret6: TQRMemo;
    QRLabel2: TQRLabel;
  private

  public

  end;

var
  rptUnitedWay2b: TrptUnitedWay2b;

implementation

{$R *.DFM}

end.
