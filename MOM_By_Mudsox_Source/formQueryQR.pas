unit formQueryQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, quickrpt, Qrctrls, TeEngine, Series, TeeProcs, Chart, DBChart,
  QrTee;

type
  TfrmQueryQR = class(TForm)
    rptQuery: TQuickRep;
    bndHeader: TQRBand;
    lbl_10001: TQRLabel;
    lbl_10002: TQRSysData;
    imgLogo1: TQRImage;
    imgLogo2: TQRImage;
    bndData: TQRSubDetail;
    txtData1: TQRDBText;
    txtData2: TQRDBText;
    txtData3: TQRDBText;
    txtData4: TQRDBText;
    txtData5: TQRDBText;
    txtReportName: TQRLabel;
    txtReport: TQRLabel;
    lblTxt1: TQRLabel;
    lblTxt2: TQRLabel;
    lblTxt3: TQRLabel;
    lblTxt4: TQRLabel;
    lblTxt5: TQRLabel;
    memSurveyQuestion: TQRMemo;
    shpLine: TQRShape;
    bndGraph: TQRBand;
    QRDBChart1: TQRDBChart;
    crtPie: TQRChart;
    Series1: TPieSeries;
    txtLines: TQRLabel;
    txtCounter: TQRLabel;
    procedure rptQueryBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    constructor create(Aowner : TComponent); override;
  end;

var
  frmQueryQR: TfrmQueryQR;

implementation

uses procShareddatamodulecalls;
{$R *.DFM}

constructor TfrmQueryQR.create(AOwner: TComponent);
begin
  {Create all form components and other start-up activities}

  Inherited create(AOwner);
  //fill images
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
  //set the report name and center it
  txtReportName.left:=txtReportName.left-3*(length(txtReportName.caption)-1);
  txtReport.left:=txtReport.left-3*(length(txtReportName.caption)-1);
  //needed to make the sub detail show on the form
  rptQuery.DataSet:=vqryQuickReport;
  bndData.DataSet:=vqryQuickReport;
end;

procedure TfrmQueryQR.rptQueryBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
var vintLoop1, vintLoop2, vintLoop3, vintDisplay: integer;
begin
  If bndGraph.enabled then
     begin
     crtPie.chart.Series[0].DataSource:=vqryQuickReport;
     crtPie.chart.Series[0].yvalues.ValueSource:='counter';
     crtPie.chart.Series[0].xlabelssource:=
                                          vqryQuickReport.fields[0].displayname;
     end;
  vintDisplay := 1;
  {Dynamically loop through the available dataset fields and assign values or
  datalinked properties}
  for vintLoop1 := 0 to vqryQuickReport.fieldcount - 1 do
    begin
    {For each field in the dataset, loop to find the matching column label}
    for vintLoop2 := 0 to frmQueryQR.ComponentCount - 1 do
      If frmQueryQR.components[vintLoop2].name =
                                        'lblTxt' + inttostr(vintLoop1 + 1) then
         begin
         tqrLabel(frmQueryQR.components[vintLoop2]).enabled := true;
         tqrLabel(frmQueryQR.components[vintLoop2]).caption :=
                   copy(vqryQuickReport.fields[vintLoop1].FieldName,
                   1, vqryQuickReport.fields[vintLoop1].DisplayWidth);
         tqrLabel(frmQueryQR.components[vintLoop2]).left := vintDisplay;
         break;
         end;
    {For each field in the dataset, loop to find the matching column label}
    for vintLoop3 := 0 to frmQueryQR.ComponentCount - 1 do
      If frmQueryQR.components[vintLoop3].name =
                                        'txtData' + inttostr(vintLoop1 + 1) then
         begin
         tqrdbtext(frmQueryQR.components[vintLoop3]).enabled := true;
         tqrdbtext(frmQueryQR.components[vintLoop3]).dataset := vqryQuickReport;
         tqrdbtext(frmQueryQR.components[vintLoop3]).datafield :=
                                    vqryQuickReport.fields[vintLoop1].FieldName;
         tqrdbtext(frmQueryQR.components[vintLoop3]).left := vintDisplay;
         break;
         end;
    vintDisplay := vintDisplay +
                           (vqryQuickReport.fields[vintLoop1].DisplayWidth * 8);
    end;
end;


end.
