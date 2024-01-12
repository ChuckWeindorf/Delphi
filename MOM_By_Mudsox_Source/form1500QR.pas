unit form1500QR;
{Author: Chuck Weindorf
 Description: Print the 1500 form to allow the office to bypass the manual
 process of typing these fomrs manually.

 Date: 04/26/2000 - CEW - New
  }

interface

uses Classes, quickrpt, Qrctrls, Controls, ExtCtrls, forms, sysutils, dbtables;

type
  Tfrm1500QR = class(TForm)
    rpt1500: TQuickRep;
    QRBand1: TQRBand;
  private
    { Private declarations }
  public
  end;

var
  frm1500QR: Tfrm1500QR;

implementation


{$R *.DFM}
end.
