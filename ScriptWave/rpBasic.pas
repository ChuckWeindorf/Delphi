unit rpBasic;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TrptReport = class(TQuickRep)
    bndHeader: TQRBand;
    bndDetail: TQRBand;
    memReportDetail: TQRRichText;
    bndSummary: TQRBand;
    lblTitle: TQRLabel;
    lblTitle2: TQRLabel;
    lblCompany: TQRLabel;
    lblCompany2: TQRLabel;
    shpLine1: TQRShape;
    QRLabel1: TQRLabel;
    lblImportT: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape1: TQRShape;
    QRLabel4: TQRLabel;
    lblDictationTotal: TQRLabel;
    lblTransTotal: TQRLabel;
    lblTypist: TQRLabel;
    lblTypistName: TQRLabel;
    QRLabel5: TQRLabel;
  private

  public

  end;

var
  rptReport: TrptReport;

implementation

{$R *.DFM}

end.
