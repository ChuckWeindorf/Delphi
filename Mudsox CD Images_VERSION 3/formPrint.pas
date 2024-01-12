unit formPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, ExtCtrls;

type
  TfrmPrint = class(TForm)
    rptPrint: TQuickRep;
    QRBand1: TQRBand;
    imgQR: TQRImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrint: TfrmPrint;

implementation

{$R *.DFM}

end.
