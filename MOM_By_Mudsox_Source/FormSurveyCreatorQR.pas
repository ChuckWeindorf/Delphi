unit FormSurveyCreatorQR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Menus, Qrctrls, Buttons, ToolWin, dataMainDataModule,
  ComCtrls, Db, DBTables, StdCtrls, Mask, DBCtrls;

type
  TfrmSurveyCreatorQR = class(TForm)
    pnlBack: TPanel;
    rptCreaterQR: TQuickRep;
    PageHeaderBand1: TQRBand;
    lbl_10007: TQRLabel;
    txtID: TQRDBText;
    SysDate: TQRSysData;
    bndMain: TQRBand;
    lbl_10001: TQRLabel;
    lbl_10003: TQRLabel;
    txtEdition: TQRDBText;
    lbl_10005: TQRLabel;
    memSurveyInstructions: TQRDBText;
    imgLogo1: TQRImage;
    imgLogo2: TQRImage;
    bndQuestion: TQRSubDetail;
    txtQuestionNum: TQRDBText;
    txtQuestionText: TQRDBText;
    txtSurveyID: TQRDBText;
    memSelections: TQRMemo;
    shpAnswer: TQRShape;
    shpComm1: TQRShape;
    shpComm2: TQRShape;
    shpComm3: TQRShape;
    txtComment: TQRLabel;
    shpAnswer2: TQRShape;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bndQuestionBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
//    vintSurveyNum: Integer;
//    dtmMainLocal : tdtmMain;
    constructor create(Aowner : TComponent); override;
  end;

var
  frmSurveyCreatorQR: TfrmSurveyCreatorQR;
  dtmMainLocal : tdtmMain;

implementation
  uses procSharedDataModuleCalls;
{$R *.DFM}

constructor TfrmSurveyCreatorQR.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vcmpComponent: TComponent;
  vstrOz: string;
begin
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  imgLogo1.Picture.LoadFromFile(vstrApplicationDirectory +
                                                'Pictures\Mheds_no_border.bmp');
  imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory +
                                               'Pictures\Mheds2_no_border.bmp');
  rptCreaterQR.DataSet := vdtmQuickReport.qrySurveyRule;
  bndQuestion.DataSet := vdtmQuickReport.qrySurveyQuestion;

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

procedure TfrmSurveyCreatorQR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmSurveyCreatorQR.bndQuestionBeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
If vdtmQuickReport.qrySurveyQuestion.fieldbyname
                              ('SurveyResponseType').asstring = 'Selection' then
   begin
   memSelections.enabled := true;
   FillPickList(vdtmQuickReport.qrySurveyQuestion.fieldbyname
                                                ('SurveyPickList').asstring,
                                                  memSelections.Lines);
   bndQuestion.Height := (13 * memSelections.lines.Count) + 26;
   memSelections.Height := (13 * memSelections.lines.Count) + 2;
   shpAnswer.Enabled := true;
   shpAnswer.Height := (14 * memSelections.lines.Count);
   shpAnswer.Top := 19;
   shpAnswer.Width := 190;
   shpAnswer.shape := qrsRectangle;
   end
else
   begin
   shpAnswer.Enabled := false;
   memSelections.enabled := false;
   end;

If vdtmQuickReport.qrySurveyQuestion.fieldbyname
                              ('SurveyResponseType').asstring = 'Entry' then
   begin
   bndQuestion.Height := 50;
   shpAnswer2.Enabled := true;
   shpAnswer2.Width := 190;
   shpAnswer2.shape := qrsHorLine;
   shpAnswer2.Top := 48;
   end
else
   begin
   shpAnswer2.Enabled := false;
   end;

If vdtmQuickReport.qrySurveyQuestion.fieldbyname
                           ('SurveyCommentAllowed').asboolean = true then
   begin
   shpComm1.enabled := true;
   shpComm2.enabled := true;
   shpComm3.enabled := true;
   txtComment.enabled := true;
   If bndQuestion.Height < 80 then
          bndQuestion.Height := 80;
   end
else
   begin
   shpComm1.enabled := false;
   shpComm2.enabled := false;
   shpComm3.enabled := false;
   txtComment.enabled := False;
   end;
end;

end.
