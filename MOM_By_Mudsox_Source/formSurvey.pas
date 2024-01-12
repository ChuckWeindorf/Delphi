unit formSurvey;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Mask, ExtCtrls, Menus, ToolWin, ComCtrls,
  dataMainDataModule, DB, Buttons;
type
  TfrmSurvey = class(TForm)
    PNLheading: TPanel;
    edtNumber: TDBEdit;
    edtEdition: TDBEdit;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    edtID: TDBEdit;
    pnlTool: TPanel;
    ToolBar1: TToolBar;
    lbl_10026: TLabel;
    lbl_10021: TLabel;
    lbl_10023: TLabel;
    lbl_10022: TLabel;
    lbl_10024: TLabel;
    cmdSave: TSpeedButton;
    cmdUnsave: TSpeedButton;
    Help1: TMenuItem;
    spl1: TSplitter;
    cmdExit: TSpeedButton;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    cmdEdit: TSpeedButton;
    cmdPrint: TSpeedButton;
    Splitter1: TSplitter;
    pnlQuestionBase: TPanel;
    scrMain: TScrollBar;
    pnlMain: TPanel;
    memInstructions: TDBMemo;
    edtPatient: TEdit;
    lbl_10025: TLabel;
    edtSurveyTitle: TDBEdit;
    lbl_10027: TLabel;
    edtDate: TDBEdit;
    cmdDelete: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdUnsaveClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure scrMainChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vintSurveyNum: Integer;
    constructor create(Aowner : TComponent); override;
  end;

var
  frmSurvey: TfrmSurvey;
  dtmMainLocal : tdtmMain;
  varrCombo: Array[1..20] of TComboBox;
  varrCheck: Array[1..20] of TCheckBox;
  varrEditRate: Array[1..20] of TEdit;
  varrEntry: Array[1..20] of TEdit;
  varrEditLow: Array[1..20] of TEdit;
  varrEditHigh: Array[1..20] of TEdit;
  varrMemo: Array[1..20] of TMemo;

implementation
  uses procSharedDataModuleCalls, FormSurveyQR;

{$R *.DFM}
constructor TfrmSurvey.create(AOwner : TComponent);
var vintLoop: integer;
    varrPanels: Array[1..20] of TPanel;
    vcmpComponent: tcomponent;

begin
  {The type of datamodule is determined by the constant}
  vintSurveyNum := vintCurrentSurvey;
  vintDatamoduleInstance := cintSurvey;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);

  {Create all form components and other start-up activities}
  Inherited create(AOwner);

  edtPatient.text := FindEntityName
                       (dtmMainLocal.qrySurvey.fieldbyname('Entity').asinteger);

 {create desired number of panels and decide the question types to go with them}
  dtmMainLocal.QrySurveyQuestion.First;
  for vintloop := 1 to dtmMainLocal.QRYSurveyQuestion.recordcount do
    begin
    varrPanels[vintloop] := TPanel.Create(Self);
    with varrPanels[vintloop] do
        begin
        align := albottom;
        Name := 'pnl' + inttostr(vintloop);
        Height := 75;
        Parent := pnlMain;
        Caption := '';
        align := altop;
        end;

    {create components to go on the Panel}
    with TLabel.Create(varrPanels[vintloop]) do
        begin {Question Number}
        top := 1;
        left := 1;
        Height := 21;
        Width := 21;
        Parent := varrPanels[vintloop];
        Name := 'lbl_1000' + inttostr(vintloop) + 'a';
        Font.Size := 10;
        Font.Color := clBlue;
        Caption := dtmMainLocal.QRYSurveyQuestion.fieldbyname
                                              ('SurveyQuestion').asstring + '.';
        end;

    with TMemo.Create(varrPanels[vintloop]) do
        begin {Question Text}
        Top := 3;
        left := 21;
        Height := 47;
        Width := 290;
        Parent := varrPanels[vintloop];
        Name := 'memques' + inttostr(vintloop);
        Text := dtmMainLocal.QRYSurveyQuestion.fieldbyname
                                                ('SurveyQuestionText').asstring;
        BorderStyle := bsNone;
        Readonly := True;
        Color := clScrollBar;
        Font.Color := clBlack;
        Font.Size := 10;
        end;

    {Decide what type of answer is needed}
    if (dtmMainLocal.QrySurveyQuestion.fieldbyName
                      ('SurveyResponseType').asstring = 'Selection') = true then
        begin
        varrCombo[vintloop] := TComboBox.Create(varrPanels[vintloop]);
        with varrCombo[vintloop] do
            begin {Combo Box Answer}
            top := 48;
            left := 90;
            Height := 21;
            Width := 220;
            Parent := varrPanels[vintloop];
            Name := 'cmbSelection' + inttostr(vintloop);
            Enabled := False;
            Font.Size := 10;
            FillPickList(dtmMainLocal.QRYSurveyQuestion.fieldbyname
                                            ('SurveyPickList').asstring, Items);
            Text := dtmMainLocal.QRYSurveyAnswer.fieldbyname
                                                   ('SurveySelection').asstring;
            end;
        end
    else if (dtmMainLocal.QrySurveyQuestion.fieldbyName
                      ('SurveyResponseType').asstring = 'Yes or No') = True then
        begin
        varrCheck[vintloop] := TCheckBox.Create(varrPanels[vintloop]);
        with varrCheck[vintloop] do
            begin {Check Box Answer}
            top := 48;
            left := 90;
            Height := 21;
            Width := 200;
            Parent := varrPanels[vintloop];
            Name := 'chkYesNo' + inttostr(vintloop);
            Caption := '';
            Enabled := False;
            Checked := dtmMainLocal.QRYSurveyAnswer.fieldbyname
                                                      ('SurveyYesNo').asboolean;
            end;
        end
    else if (dtmMainLocal.QrySurveyQuestion.fieldbyName
                         ('SurveyResponseType').asstring = 'Entry') = True then
        begin
        varrEntry[vintloop] := TEdit.Create(varrPanels[vintloop]);
        with varrEntry[vintloop] do
            begin {Entry Answer}
            top := 48;
            left := 90;
            Height := 21;
            Width := 220;
            Parent := varrPanels[vintloop];
            Name := 'edtEntry' + inttostr(vintloop);
            Font.Size := 10;
            readonly := true;
            Text := dtmMainLocal.QRYSurveyAnswer.fieldbyname
                                                   ('SurveySelection').asstring;
            end;
        end
    else if (dtmMainLocal.QrySurveyQuestion.fieldbyName
                         ('SurveyResponseType').asstring = 'Rating') = True then
        begin
        varrEditRate[vintloop] := TEdit.Create(varrPanels[vintloop]);
        with varrEditRate[vintloop] do
            begin {Rating Answer}
            top := 48;
            left := 90;
            Height := 21;
            Width := 100;
            Parent := varrPanels[vintloop];
            Name := 'edtRate' + inttostr(vintloop);
            Font.Size := 10;
            readonly := true;
            Text := dtmMainLocal.QRYSurveyAnswer.fieldbyname
                                                      ('SurveyRating').asstring;
            end;
        end
    else if (dtmMainLocal.QrySurveyQuestion.fieldbyName
                          ('SurveyResponseType').asstring = 'Range') = True then
        begin
        varrEditLow[vintloop] := TEdit.Create(varrPanels[vintloop]);
        with varrEditLow[vintloop] do
            begin {Range Answers}
            top := 48;
            left := 90;
            Height := 21;
            Width := 100;
            Parent := varrPanels[vintloop];
            Name := 'edtRangeLow' + inttostr(vintloop);
            Font.Size := 10;
            readonly := true;
            Text := dtmMainLocal.QRYSurveyAnswer.fieldbyname
                                                    ('SurveyRangeLow').asstring;
            end;
        varrEditHigh[vintloop] := TEdit.Create(varrPanels[vintloop]);
        with varrEditHigh[vintloop] do
            begin {Range Answers}
            top := 48;
            left := 200;
            Height := 21;
            Width := 100;
            Parent := varrPanels[vintloop];
            Name := 'edtRangeHigh' + inttostr(vintloop);
            Font.Size := 10;
            readonly := true;
            Text := dtmMainLocal.QRYSurveyAnswer.fieldbyname
                                                   ('SurveyRangeHigh').asstring;
            end;
        end;

    {label for question}
    with TLabel.Create(self) do
    begin
      top := 50;
      left := 34;
      Name := 'lbl_1000' + inttostr(vintloop) + 'a';
      Caption := 'Answer:';
      Parent := varrPanels[vintloop];
      font.color := clblue;
      font.size := 10;
    end;

    if (dtmMainLocal.QrySurveyQuestion.fieldbyName
                          ('SurveyCommentAllowed').asboolean = True) = True then
        begin
        varrMemo[vintloop] := TMemo.Create(varrPanels[vintloop]);
        with varrMemo[vintloop] do
            begin {Comment Memo}
            Top := 22;
            Left := 325;
            Height := 50;
            Parent := varrPanels[vintloop];
            Name := 'memComment' + inttostr(vintloop);
            Text := dtmMainLocal.QRYSurveyAnswer.fieldbyname
                                                     ('SurveyComment').asstring;
            Font.Size := 8;
            readonly := true;
            Width := 280;
            end;
        with TLabel.Create(varrPanels[vintloop]) do
            begin {label to go with comment memo}
            top := 2;
            left := 325;
            Height := 21;
            Parent := varrPanels[vintloop];
            Name := 'lbl_1000' + inttostr(vintloop) + 'b';
            Caption := 'Comments:';
            Font.Size := 10;
            Font.Color := clBlue;
            width := 70;
            end;
        end;
    DtmMainLocal.QrySurveyQuestion.Next;
    dtmMainlocal.qrySurveyAnswer.Locate('SurveyNumber;SurveyQuestion',
       VarArrayOf([dtmMainLocal.QRYSurvey.fieldbyname('SurveyNumber').asinteger,
       dtmMainLocal.QRYSurveyQuestion.fieldbyname('SurveyQuestion').asinteger]),
          [loCaseInsensitive]);
    end;

  {Resize the main panel to match the number of question panels}
  pnlMain.height := (dtmMainLocal.QRYSurveyQuestion.recordcount * 150) + 2;

  {Assign the tags to datasources.}
  For vintLoop := 0 to ComponentCount - 1 do
  begin
     vcmpComponent := Components[vintLoop];
     If vcmpComponent.tag > 10 then
        AssignDataSources(vcmpComponent,
                          dtmMainLocal);
  end;
  If vbolNewItem then
    begin
    vbolNewItem := false;
    cmdEditClick(Self);
    end;
end;

procedure TfrmSurvey.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{Free the memory from this instance of the datamodule}
CloseAndFreeFiles(dtmMainLocal);
CloseThisEntity(vintSurveyNum);
action := caFree;
end;

procedure TfrmSurvey.cmdSaveClick(Sender: TObject);
var vintloop: Integer;
begin

  dtmMainLocal.QRYSurveyQuestion.First;
  while not dtmMainLocal.QRYSurveyQuestion.EOF do
  begin
    {locate same area in Survey Answer}
    IF dtmMainlocal.qrySurveyAnswer.Locate('SurveyNumber;SurveyQuestion',
       VarArrayOf([dtmMainLocal.QRYSurvey.fieldbyname('SurveyNumber').asinteger,
       dtmMainLocal.QRYSurveyQuestion.fieldbyname('SurveyQuestion').asinteger]),
          [loCaseInsensitive]) then
          dtmMainLocal.QRYSurveyAnswer.Edit
    else
          dtmMainLocal.QRYSurveyAnswer.Append;

    vintLoop := dtmMainLocal.QRYSurveyQuestion.fieldbyname
                                                   ('SurveyQuestion').asinteger;
    {Set all key values here}
    dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyNumber').asinteger :=
                   dtmMainLocal.QRYSurvey.FieldbyName('SurveyNumber').asinteger;
    dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyQuestion').asinteger :=
         dtmMainLocal.QRYSurveyQuestion.fieldbyname('SurveyQuestion').asinteger;
    {Non-Key data here}
    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Selection' then
      dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveySelection').asstring :=
                                                       varrCombo[vintloop].Text;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Yes or No' then
      dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyYesNo').asboolean :=
                                                    varrCheck[vintloop].Checked;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                 ('SurveyResponseType').asstring = 'Entry' then
      dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveySelection').asstring :=
                                                       varrEntry[vintloop].Text;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                 ('SurveyResponseType').asstring = 'Rating' then
      dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyRating').asinteger :=
                                       TestInteger(varrEditRate[vintloop].Text);

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyResponseType').asstring = 'Range' then
    begin
      dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyRangeLow').asinteger :=
                                       TestInteger(varrEditLow[vintloop].Text);
      dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyRangeHigh').asinteger :=
                                       TestInteger(varrEditHigh[vintloop].Text);
    end;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyCommentAllowed').asboolean = True then
      dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyComment').asstring :=
                                                        varrMemo[vintloop].Text;
  dtmMainLocal.QRYSurveyQuestion.Next;
  end;

  ApplyDataSets(dtmMainLocal);

  {disable the components on the form}
  dtmMainLocal.QRYSurveyQuestion.First;

  while not dtmMainLocal.QRYSurveyQuestion.EOF do
  begin
    {locate same area in Survey Answer}
    dtmMainlocal.qrySurveyAnswer.Locate('SurveyNumber;SurveyQuestion',
       VarArrayOf([dtmMainLocal.QRYSurvey.fieldbyname('SurveyNumber').asinteger,
       dtmMainLocal.QRYSurveyQuestion.fieldbyname('SurveyQuestion').asinteger]),
          [loCaseInsensitive]);
    vintLoop := dtmMainLocal.QRYSurveyQuestion.fieldbyname
                                                   ('SurveyQuestion').asinteger;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Selection' then
      varrCombo[vintloop].Enabled := False;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyResponseType').asstring = 'Entry' then
      varrEntry[vintloop].readonly := true;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Yes or No' then
      varrCheck[vintloop].Enabled := False;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                 ('SurveyResponseType').asstring = 'Rating' then
      varrEditRate[vintloop].Readonly := True;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyResponseType').asstring = 'Range' then
    begin
      varrEditLow[vintloop].readonly := True;
      varrEditHigh[vintloop].readonly := True;
    end;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyCommentAllowed').asboolean = True then
      varrMemo[vintloop].Readonly := True;

    dtmMainLocal.QRYSurveyQuestion.Next;
  end;

  cmdEdit.Enabled := True;
  cmdSave.Enabled := False;
  cmdUnSave.Enabled := False;
  cmdDelete.Enabled:= false;
end;

procedure TfrmSurvey.cmdExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmSurvey.cmdEditClick(Sender: TObject);
var vintloop: Integer;
begin
  {Save Data into SurveyAnswer}
  EditDataSets(dtmMainLocal);

  {enable the components on the form}
  dtmMainLocal.QRYSurveyQuestion.First;

  while not dtmMainLocal.QRYSurveyQuestion.EOF do
  begin
    {locate same area in Survey Answer}
    dtmMainlocal.qrySurveyAnswer.Locate('SurveyNumber;SurveyQuestion',
       VarArrayOf([dtmMainLocal.QRYSurvey.fieldbyname('SurveyNumber').asinteger,
       dtmMainLocal.QRYSurveyQuestion.fieldbyname('SurveyQuestion').asinteger]),
          [loCaseInsensitive]);
    vintLoop := dtmMainLocal.QRYSurveyQuestion.fieldbyname
                                                   ('SurveyQuestion').asinteger;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Selection' then
      varrCombo[vintloop].Enabled := True;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Entry' then
      varrEntry[vintloop].readonly := false;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Yes or No' then
      varrCheck[vintloop].Enabled := True;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                 ('SurveyResponseType').asstring = 'Rating' then
      varrEditRate[vintloop].Readonly := False;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyResponseType').asstring = 'Range' then
      begin
      varrEditLow[vintloop].readonly := False;
      varrEditHigh[vintloop].readonly := False;
      end;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyCommentAllowed').asboolean = True then
      varrMemo[vintloop].Readonly := false;

  dtmMainLocal.QRYSurveyQuestion.Next;
  end;
  cmdEdit.Enabled := False;
  cmdSave.Enabled := True;
  cmdUnSave.Enabled := True;
  cmdDelete.Enabled:= True;
end;

procedure TfrmSurvey.cmdUnsaveClick(Sender: TObject);
var vintloop: Integer;
begin
  RollBackDataSets(dtmMainLocal);

  {Display Original Data}
  dtmMainLocal.QRYSurveyQuestion.First;
  while not dtmMainLocal.QRYSurveyQuestion.EOF do
  begin
    {locate same area in Survey Answer}
    dtmMainlocal.qrySurveyAnswer.Locate('SurveyNumber;SurveyQuestion',
       VarArrayOf([dtmMainLocal.QRYSurvey.fieldbyname('SurveyNumber').asinteger,
       dtmMainLocal.QRYSurveyQuestion.fieldbyname('SurveyQuestion').asinteger]),
          [loCaseInsensitive]);
    vintLoop := dtmMainLocal.QRYSurveyQuestion.fieldbyname
                                                   ('SurveyQuestion').asinteger;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Selection' then
      varrCombo[vintloop].Text :=
           dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveySelection').asstring;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyResponseType').asstring = 'Entry' then
      varrEntry[vintloop].Text :=
           dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveySelection').asstring;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                              ('SurveyResponseType').asstring = 'Yes or No' then
      varrCheck[vintloop].Checked :=
              dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyYesNo').asboolean;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                 ('SurveyResponseType').asstring = 'Rating' then
      varrEditRate[vintloop].Text :=
              dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyRating').asstring;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyResponseType').asstring = 'Range' then
    begin
      varrEditLow[vintloop].Text :=
            dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyRangeLow').asstring;
      varrEditHigh[vintloop].Text :=
           dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyRangeHigh').asstring;
    end;

    if dtmMainLocal.qrySurveyQuestion.FieldByName
                                  ('SurveyCommentAllowed').asboolean = True then
      varrMemo[vintloop].Text :=
             dtmMainLocal.QRYSurveyAnswer.FieldbyName('SurveyComment').asstring;
  dtmMainLocal.QRYSurveyQuestion.Next;
  end;
  
  cmdEdit.Enabled := True;
  cmdSave.Enabled := False;
  cmdUnSave.Enabled := False;
  cmdDelete.Enabled:= false;
end;

procedure TfrmSurvey.cmdPrintClick(Sender: TObject);
begin
{Set the temporary datamodule for use by the quickreport creation events}
vdtmQuickReport := dtmMainLocal;
frmSurveyQR := tfrmSurveyQR.Create(nil);
try
  frmSurveyQR.QRSetup;
  frmSurveyQR.rptSurvey.Preview;
  finally
  frmSurveyQR.release;
  frmSurveyQR := nil;
  vdtmQuickReport := nil;
  end;
end;

procedure TfrmSurvey.scrMainChange(Sender: TObject);
begin
pnlMain.Top := scrMain.Position * -1;
end;

procedure TfrmSurvey.FormResize(Sender: TObject);
begin
scrMain.Height := pnlQuestionBase.Height - 2;
end;

procedure TfrmSurvey.cmdDeleteClick(Sender: TObject);
begin
if MessageDlg('This Survey will be removed permanently. OK?',
    mtWarning, [mbYes, mbCancel], 0) = mrYes then
  begin
  DeleteAllSurvey(dtmMainLocal.qrySurvey.fieldbyname('SurveyNumber').asinteger);
  close;
  end;
end;

end.
