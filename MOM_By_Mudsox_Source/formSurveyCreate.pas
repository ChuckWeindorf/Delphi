unit formSurveyCreate;
{Author: Tim Weindorf
 Description: Lets users create their own surveys with questions,
  comments, and question types

 Date: 10/16/99 - TCW
 }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolWin, ComCtrls, dataMainDataModule, DB,
  DBCtrls, Menus;

type
  TfrmSurveyCreate = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    tbrSurveyCreate: TToolBar;
    pnlHeading: TPanel;
    cmdQuesCreate: TSpeedButton;
    cmdQuesDel: TSpeedButton;
    cmdSave: TSpeedButton;
    lbl_10001: TLabel;
    edtSurveyType: TEdit;
    lbl_10003: TLabel;
    lbl_10002: TLabel;
    Splitter1: TSplitter;
    cmdExit: TSpeedButton;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    memComment: TMemo;
    memInstruct: TMemo;
    pnlQuestionBase: TPanel;
    pnlMain: TPanel;
    scrMain: TScrollBar;
    lbl_10004: TLabel;
    lbl_10005: TLabel;
    edtSurveyEdition: TEdit;
    edtSurveyTitle: TEdit;
    pnlSwap: TPanel;
    edtMove1: TEdit;
    edtMove2: TEdit;
    cmdMove: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    cmdPrint: TSpeedButton;
    procedure cmdQuesCreateClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure pnlMainEnter(Sender: TObject);
    procedure cmdQuesDelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure scrMainChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtMove1Change(Sender: TObject);
    procedure cmdMoveClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vintSurveyNum: Integer;
    constructor create(Aowner : TComponent); override;
  end;

var
  frmSurveyCreate: TfrmSurveyCreate;
  dtmMainLocal : tdtmMain; 
  varrPanels: Array[1..21] of TPanel;
  varrMemos: Array[1..21] of TMemo;
  varrCombo: Array[1..21] of TComboBox;
  varrCheck: Array [1..21] of TCheckBox;
  varrPickList: Array [1..21] of Tedit;
  vintloop2: Integer;
  vpnlFocus: Integer;
  vintSelectedMemo: Integer;
implementation
  uses procSharedDataModuleCalls, FormSurveyCreatorQR;

{$R *.DFM}
constructor TfrmSurveyCreate.create(AOwner : TComponent);
var vintloop: Integer;
begin
  vintDatamoduleInstance := cintSurvey;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(nil);
  DatamoduleCreateEvent(dtmMainLocal);

  {Create all form components and other start-up activities}
  Inherited create(AOwner);

  vintSelectedMemo := 1;

  dtmMainLocal.qrySurveyQuestion.First;

  {Create hidden panels with their components}
  for vintloop := 1 to 21 do
  begin
    varrPanels[vintloop] := TPanel.create(self);
    with varrPanels[vintloop] do
    begin {panel create}
      parent := pnlMain;
      top := 2001;
      align := albottom;
      height := 100;
      name := 'pnl' + inttostr(vintloop);
      Caption := '';
      visible := False;
      OnEnter := pnlMainEnter;
      tag := vintloop;
      align := altop;
    end;

    with TLabel.create(self) do
    begin {question label}
      caption := 'Question ' + inttostr(vintloop) + ':';
      Font.Color := clblue;
      font.size := 10;
      left := 32;
      name := 'lbl_1000' + inttostr(vintloop) + 'a';
      parent := varrpanels[vintloop];
      top := 8;
    end;

    varrMemos[vintloop] := TMemo.create(self);
    with varrMemos[vintloop] do
    begin {question memo create}
      top := 5;
      left := 104;
      height := 62;
      Font.Size := 10;
      name := 'memques' + inttostr(vintloop);
      text := '';
      parent := varrPanels[vintloop];
      width := 504;
    end;

    with TLabel.create(self) do
    begin {question label}
      caption := 'Answer type:';
      Font.Color := clblue;
      font.size := 10;
      left := 23;
      name := 'lbl_1000' + inttostr(vintloop) + 'd';
      parent := varrpanels[vintloop];
      top := 73;
    end;

    varrCombo[vintloop] := TComboBox.create(self);
    with varrCombo[vintloop] do
    begin {question selection type}
      top := 71;
      left := 104;
      height := 21;
      width := 145;
      Font.Size := 10;
      name := 'cmbSelect' + inttostr(vintloop);
      parent := varrPanels[vintloop];
      text := dtmMainLocal.qrySurveyQuestion.fieldbyname('SurveyResponseType').asstring;
      FillPickList('SurveyQuestionTypes',items);
      {Can't get dropdownlist to work.  problem here?}
      style := csDropdown;
    end;

    with TLabel.create(self) do
    begin {question label}
      caption := 'List name:';
      Font.Color := clblue;
      font.size := 10;
      left := 285;
      name := 'lbl_1000' + inttostr(vintloop) + 'e';
      parent := varrpanels[vintloop];
      top := 73;
    end;

    {The picklist that will be used on the online and printed survey for a
     question}
    varrPicklist[vintloop] := Tedit.create(self);
    with varrPicklist[vintloop] do
    begin
      Name := 'edtPicklist' + inttostr(vintloop);
      text := '';
      width := 100;
      Left := 350;
      Font.Size := 10;
      Parent := varrPanels[vintloop];
      top := 71;
    end;

    with TLabel.create(self) do
    begin {comment allowed label}
      Caption := 'Allow Comments?';
      Font.Size := 10;
      font.Color := clblue;
      height := 16;
      left := 485;
      name := 'lbl_1000' + inttostr(vintloop) + 'c';
      parent := varrpanels[vintloop];
      top := 73;
      width := 105;
    end;

    varrCheck[vintloop] := TCheckBox.create(self);
    with varrCheck[vintloop] do
    begin {comment yes/no}
      Left := 595;
      width := 15;
      height := 21;
      Name := 'chkComment' + inttostr(vintloop);
      caption := '';
      Parent := varrPanels[vintloop];
      top := 71;
    end;

    If dtmMainLocal.qrySurveyQuestion.recordcount >= vintLoop then
      begin
      varrMemos[vintloop].text := dtmMainLocal.qrySurveyQuestion.FieldbyName
                                                ('SurveyQuestionText').asstring;
      varrCheck[vintloop].Checked := dtmMainLocal.qrySurveyQuestion.FieldbyName
                                             ('SurveyCommentAllowed').asboolean;
      varrPickList[vintloop].text := dtmMainLocal.qrySurveyQuestion.FieldbyName
                                                   ('SurveyPicklist').asstring;
      varrCombo[vintloop].text := dtmMainLocal.qrySurveyQuestion.FieldbyName
                                                ('SurveyResponseType').asstring;
      end;

    dtmMainLocal.qrySurveyQuestion.Next;
  end;

  {check to make sure correct number of question boxes are showing}
  for vintloop := 1 to dtmMainLocal.qrySurveyQuestion.Recordcount do
    varrPanels[vintloop].visible := True;
  if varrPanels[1].visible = False then
  begin
    varrpanels[1].visible := True;
    vintloop2 := 2;
  end
  else
    vintloop2 := 1 + dtmMainLocal.QrySurveyQuestion.Recordcount;

  {Set values in Header Panel}
  edtSurveyEdition.text := dtmMainLocal.qrysurveyrule.fieldbyname('SurveyEdition').asstring;
  edtSurveyType.text := dtmMainLocal.qrySurveyRule.FieldByName('SurveyID').asstring;
  edtSurveyTitle.Text := dtmMainLocal.qrySurveyRule.FieldByName('SurveyTitle').asstring;
  memComment.Text := dtmMainLocal.qrySurveyRule.FieldbyName('SurveyComments').asstring;
  memInstruct.Text := dtmMainLocal.qrySurveyRule.FieldbyName('SurveyInstructions').asstring;
end;

procedure TfrmSurveyCreate.cmdQuesCreateClick(Sender: TObject);
begin
  varrPanels[vintloop2].visible := True;
  vintloop2 := vintloop2 + 1;

  {disable button}
  if (vintloop2 = 21) then
    cmdQuesCreate.enabled := False;
end;

procedure TfrmSurveyCreate.cmdExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmSurveyCreate.pnlMainEnter(Sender: TObject);
begin
  vintSelectedMemo := TPanel(sender).tag;

  if (cmdQuesDel.enabled = False) and (vintloop2 > 2) then
    cmdQuesDel.enabled := True;
end;

procedure TfrmSurveyCreate.cmdQuesDelClick(Sender: TObject);
var vintloop: Integer;
begin {delete selected panel, move all others up}

  for vintloop := vintSelectedMemo to (vintloop2) do
  begin
  varrMemos[vintloop].Text := varrMemos[vintloop + 1].Text;
  varrCombo[vintloop].Text := varrCombo[vintloop + 1].Text;
  varrCheck[vintloop].Checked := varrCheck[vintloop + 1].Checked;
  varrMemos[vintloop2].Text := '';
  varrCombo[vintloop2].Text := '';
  varrCheck[vintloop2].Checked := false;
  end;

  vintloop2 := vintloop2 - 1;
  varrPanels[vintloop2].Visible := False;

  cmdQuesDel.Enabled := False;

  {try to enable cmdQuesCreate}
  if cmdQuesCreate.Enabled = False then
     cmdQuesCreate.Enabled := True;

  {Do not allow the value of vintSelectedMemo to the highest question}
  vintSelectedMemo := vintloop2 - 1;
end;

procedure TfrmSurveyCreate.cmdSaveClick(Sender: TObject);
var vintLoop: integer;
begin
  {make sure that all question types are selected}
  for vintloop := 1 to (vintloop2 - 1) do
  begin
    if varrCombo[vintloop].text = '' then
    begin
      ShowMessage('Question ' + inttostr(vintloop) +
                                     ' does not have a question type selected');
      exit;
    end;
  end;

  EditDataSets(dtmMainLocal);

  {Create new record, input new data}
  dtmMainLocal.qrySurveyRule.edit;

  dtmMainLocal.qrySurveyRule.FieldByName('SurveyID').asstring :=
                                                             edtSurveyType.Text;
  dtmMainLocal.qrySurveyRule.FieldByName('SurveyEdition').asdatetime :=
                                           strtodate(edtSurveyedition.text);
  dtmMainLocal.qrySurveyRule.FieldByName('SurveyInstructions').asstring :=
                                                               memInstruct.Text;
  dtmMainLocal.qrySurveyRule.FieldByName('SurveyComments').asstring :=
                                                                memComment.Text;
  dtmMainLocal.qrySurveyRule.FieldByName('SurveyTitle').asstring :=
                                                            edtSurveyTitle.Text;

  dtmMainLocal.QrySurveyRule.Post;

  {In order to use append to add all Question records, delete the old ones
  from the table}
  while dtmMainLocal.qrySurveyQuestion.recordcount > 0 do
         dtmMainLocal.qrySurveyQuestion.delete;

  for vintloop := 1 to (vintloop2 - 1) do
  begin
    dtmMainLocal.qrySurveyQuestion.append;
    dtmMainLocal.qrySurveyQuestion.FieldByName('SurveyID').asstring :=
                                                             edtSurveyType.Text;
    dtmMainLocal.qrySurveyQuestion.FieldbyName('SurveyEdition').asdatetime :=
                                             strtodate(edtSurveyedition.text);
    dtmMainLocal.qrySurveyQuestion.FieldbyName('SurveyQuestion').asinteger :=
                                                                       vintloop;
    dtmMainLocal.qrySurveyQuestion.FieldbyName('SurveyQuestionText').asstring :=
                                                       varrMemos[vintloop].Text;
    dtmMainLocal.qrySurveyQuestion.FieldbyName('SurveyResponseType').asstring :=
                                                       varrCombo[vintloop].Text;
    dtmMainLocal.qrySurveyQuestion.FieldbyName('SurveyPickList').asstring :=
                                                    varrPickList[vintloop].Text;
    dtmMainLocal.qrySurveyQuestion.FieldbyName('SurveyCommentAllowed').asboolean
                                                 := varrCheck[vintloop].checked;
    dtmMainLocal.QrySurveyQuestion.Post;
  end;

  ApplyDataSets(dtmMainLocal);
end;

procedure TfrmSurveyCreate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
end;

procedure TfrmSurveyCreate.scrMainChange(Sender: TObject);
begin
pnlMain.Top := scrMain.Position * -1;
end;

procedure TfrmSurveyCreate.FormResize(Sender: TObject);
begin
scrMain.Height := pnlQuestionBase.Height - 2;
end;

procedure TfrmSurveyCreate.edtMove1Change(Sender: TObject);
begin
  {test to see if 2 values have been entered into the move boxes}
  if (edtMove1.text <> '') and (edtMove2.text <> '') then
    cmdMove.Enabled := True;
  
end;

procedure TfrmSurveyCreate.cmdMoveClick(Sender: TObject);
var vstrMemoryQuestion: String;
    vstrMemoryQuestion2: String;
    vstrMemoryType: String;
    vstrMemoryType2: String;
    vbolMemoryCheck: Boolean;
    vbolMemoryCheck2: Boolean;
    vintMove1: Integer;
    vintMove2: Integer;
    vintloop: Integer;
begin
  {convert text numbers to variable numbers}
  vintMove1 := strtoint(edtMove1.text);
  vintMove2 := strtoint(edtMove2.text);

  {check to see if the numbers are valid}
  if (vintMove1 > vintloop2 - 1) or (vintMove1 <= 0) or
                            (vintMove2 > vintloop2 - 1) or (vintMove2 <= 0) then
    ShowMessage('You must use correct values in your move boxes.')
  else
  begin
    {store information in memory variables}
    vstrMemoryQuestion := varrMemos[vintMove1].text;
    vstrMemoryType := varrCombo[vintMove1].text;
    vbolMemoryCheck := varrCheck[vintMove1].checked;

    if vintMove1 > vintMove2 then
    begin
      for vintloop := (vintMove2 + 1) to vintMove1 do
      begin
        {store information in memory variables}
        vstrMemoryQuestion2 := varrMemos[vintloop].text;
        vstrMemoryType2 := varrCombo[vintloop].text;
        vbolMemoryCheck2 := varrCheck[vintloop].checked;

        {put in new information}
        varrMemos[vintloop].text := vstrMemoryQuestion;
        varrCombo[vintloop].text := vstrMemoryType;
        varrCheck[vintloop].checked := vbolMemoryCheck;

        {exchange information back}
        vstrMemoryQuestion := vstrMemoryQuestion2;
        vstrMemoryType := vstrMemoryType2;
        vbolMemoryCheck := vbolMemoryCheck2;
      end;
    end
    else if vintMove1 < vintMove2 then
    begin
      for vintloop := vintMove1 to (vintMove2 - 1) do
      begin
        {move information}
        varrMemos[vintloop].text := varrMemos[vintloop + 1].text;
        varrCombo[vintloop].text := varrCombo[vintloop + 1].text;
        varrCheck[vintloop].checked := varrCheck[vintloop + 1].checked;
      end;

      {give information for last panel}
      varrMemos[vintMove2].text := vstrMemoryQuestion;
      varrCombo[vintMove2].text := vstrMemoryType;
      varrCheck[vintMove2].checked := vbolMemoryCheck;
    end;
  end;
  {Disable this button and clear the values}
  cmdMove.Enabled := False;
  edtMove1.text := '';
  edtMove2.text := '';
end;

procedure TfrmSurveyCreate.cmdPrintClick(Sender: TObject);
begin
{save all information before printing}
cmdSaveClick(self);

dtmMainLocal.qrySurveyQuestion.First;

{Set the temporary datamodule for use by the quickreport creation events}
vdtmQuickReport := dtmMainLocal;
frmSurveyCreatorQR := tfrmSurveyCreatorQR.Create(nil);
try
  frmSurveyCreatorQR.rptCreaterQR.Preview;
finally
  frmSurveyCreatorQR.release;
  frmSurveyCreatorQR := nil;
  vdtmQuickReport := nil;
  end;
end;

end.
