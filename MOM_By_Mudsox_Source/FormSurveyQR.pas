unit FormSurveyQR;      

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Menus, Qrctrls, Buttons, ToolWin, dataMainDataModule,
  ComCtrls, Db, DBTables, StdCtrls, Mask, DBCtrls;

type
  TfrmSurveyQR = class(TForm)
    pnlBack: TPanel;
    rptSurvey: TQuickRep;
    bndMain: TQRBand;
    lbl_10001: TQRLabel;
    lbl_10002: TQRLabel;
    txtNumber: TQRDBText;
    lbl_10003: TQRLabel;
    lbl_10004: TQRLabel;
    txtEdition: TQRDBText;
    lbl_10005: TQRLabel;
    memSurveyInstructions: TQRDBText;
    QRSubDetail1: TQRSubDetail;
    txtQuestionNum: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    PageHeaderBand1: TQRBand;
    lbl_10007: TQRLabel;
    txtID: TQRDBText;
    SysDate: TQRSysData;
    txtQuestionText: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    txtEntity: TQRLabel;
    imgLogo1: TQRImage;
    imgLogo2: TQRImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
//    vintSurveyNum: Integer;
//    dtmMainLocal : tdtmMain;
    constructor create(Aowner : TComponent); override;
    procedure QRSetup;
  end;

var
  frmSurveyQR: TfrmSurveyQR;
  varrBand: Array [1..20] of TQRBand;
  dtmMainLocal : tdtmMain;

implementation
  uses procSharedDataModuleCalls;
{$R *.DFM}

constructor TfrmSurveyQR.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vcmpComponent: TComponent;
  vintEntitynum: Integer;
  vstrOz: string;
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
  rptSurvey.DataSet := vdtmQuickReport.qrySurvey;
  qrsubdetail1.DataSet := vdtmQuickReport.qrySurveyAnswer;


  vintEntitynum := vdtmQuickReport.QRYSurvey.FieldByName('Entity').asinteger;
  txtEntity.Caption := FindEntityName(vintEntitynum);

  {Assign the tags to datasources.}
  For vintLoop := 0 to ComponentCount - 1 do
     begin
     vcmpComponent := Components[vintLoop];
     If vcmpComponent.tag > 10 then
        begin
        vstrOz := vcmpComponent.name;
        AssignDataSources(vcmpComponent,
                          vdtmQuickReport);
        end;
     end;
end;

procedure TfrmSurveyQR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmSurveyQR.QRSetup;
begin

  {Set data in database}
//  dtmMainLocal.QrySurveyQuestion.First;
  {Create Bands to create report}
//  for vintloop := 1 to dtmMainLocal.QRYSurveyQuestion.recordcount do
//  begin
    {create components to go on the band}
//    with TQRLabel.Create(self) do
//      begin {Question Number}
//      top := 10;//100 + (vintloop * 100);
//      left := 50;
//      Height := 21;
//      Width := 21;
//      Parent := bndInfo;
//      Name := 'lbl_1000' + inttostr(vintloop) + 'a';
//      Font.Size := 10;
//      Font.Color := clBlue;
//      Caption := dtmMainLocal.QRYSurveyQuestion.fieldbyname
//                                           ('SurveyQuestion').asstring + '.';
//      end;

//    with TQRMemo.Create(self) do
//     begin {Question Text}
//      Top := 10;//100 + (vintloop * 100);
//      left := 70;
//      Height := 19;
//      Width := 592;
//      Parent := bndInfo;
//      Name := 'memques' + inttostr(vintloop);
//      Font.Size := 8;
//      Lines.Clear;
//      Lines.add(dtmMainLocal.QRYSurveyQuestion.fieldbyname
//                                               ('SurveyQuestionText').asstring);
//      end;

 //   dtmMainLocal.QrySurveyQuestion.next;
  //end;

end;

procedure TfrmSurveyQR.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
vdtmQuickReport.qrySurveyAnswer.Locate
     ('SurveyQuestion',
      vdtmQuickReport.qrySurveyQuestion.fieldbyName('SurveyQuestion').asinteger,
      []);

end;

end.
