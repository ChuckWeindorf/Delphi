unit formReminder;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, Menus, ExtCtrls, Grids, DBGrids, Db, DBTables,
  Buttons, StdCtrls, DBCtrls, Mask, dataMainDatamodule;

type
  TfrmReminder = class(TForm)
    pnl1: TPanel;
    mnuMain: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    tbrMain: TToolBar;
    cmdEdit: TSpeedButton;
    cmdCancel: TSpeedButton;
    mnuEdit: TMenuItem;
    mnuHelp: TMenuItem;
    mnuChange: TMenuItem;
    mnuSave: TMenuItem;
    mnuCancel: TMenuItem;
    cmdexit: TSpeedButton;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    cmdSave: TSpeedButton;
    mnuVideo: TMenuItem;
    mnuOnline: TMenuItem;
    spl1: TSplitter;
    pnl3: TPanel;
    memComments: TDBMemo;
    chkActive: TDBCheckBox;
    lbl_00002: TLabel;
    lbl_00003: TLabel;
    memNewText: TMemo;
    lbl_00001: TLabel;
    edtDiaryDate: TDBEdit;
    cboCategory: TDBComboBox;
    edtPatient: TEdit;
    lbl_00004: TLabel;
    btnPrev: TSpeedButton;
    cmdPatient: TSpeedButton;
    spl2: TSplitter;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdVideoClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdPatientClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
    { Private declarations }
  public
    vintReminderNum: Integer;
    constructor create(Aowner : TComponent); override;
    { Public declarations }
  end;

var
  frmReminder: TfrmReminder;

implementation
 uses procSharedDatamoduleCalls, FormReminderQR;
{$R *.DFM}

constructor TfrmReminder.Create(AOwner: TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin
  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintReminder;
  vintReminderNum := vintCurrentReminder;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);

  {Create all form components and other start-up activities}
  Inherited create(AOwner);

  //fill combobox and other non-datalinked items
  FillPickList('ReminderCategory',cboCategory.Items);

  {Set all datasources}
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;

  Self.Caption := 'Reminder: ' +
         dtmMainLocal.qryReminder.fieldbyname('ReminderCategory').asstring;

  edtPatient.text :=
       FindEntityName(dtmMainLocal.qryReminder.fieldbyname('Entity').asinteger);
  vintCurrentReminder := 0;
  If vbolNewItem then
    begin
    vbolNewItem := false;
    cmdEditClick(Self);
    end;
end;

procedure TfrmReminder.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //Save Changes
  If cmdSave.Enabled then
     cmdSaveClick(Sender);
  {Free the memory from this instance of the datamodule}
  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(vintReminderNum);
  Action := caFree;
end;

procedure TfrmReminder.cmdVideoClick(Sender: TObject);
begin
  PlayMovie('tuffy.mpg');
end;

procedure TfrmReminder.cmdexitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmReminder.cmdEditClick(Sender: TObject);
begin
  //set database in edit mode
  EditDataSets(dtmMainLocal);
  cboCategory.enabled := true;
  cmdEdit.Enabled := false;
  cmdSave.Enabled := true;
  cmdCancel.Enabled := true;
  memNewText.Enabled :=true;
//  memNewText.SetFocus;
end;

procedure TfrmReminder.cmdCancelClick(Sender: TObject);
begin
  //Cancel Changes
  RollbackDataSets(dtmMainLocal);
  cboCategory.enabled := false;
  memNewText.Enabled := false;
  cmdEdit.Enabled := true;
  cmdSave.Enabled := false;
  cmdCancel.Enabled := false;
  memNewText.Lines.Clear;
end;

procedure TfrmReminder.cmdSaveClick(Sender: TObject);
var vstlComments: tstringlist;
begin
  vstlComments := tstringlist.Create;
  try
  //Save Changes
  If dtmMainLocal.qryReminder.state = dsBrowse then
      dtmMainLocal.qryReminder.edit;
  vstlComments.text := dtmMainLocal.qryReminder['ReminderComment'];
  If memNewText.Lines.Count > 0 then
     begin
     vstlComments.add('-------------------- ' + DateTimeToStr(now)
                                                     + ' --------------------');
     vstlComments.append(memNewText.text);
     end;
  dtmMainLocal.qryReminder['ReminderComment'] := vstlComments.text;
  ApplyDataSets(dtmMainLocal);
  cboCategory.enabled := false;
  memNewText.Enabled := false;
  cmdEdit.Enabled := true;
  cmdSave.Enabled := false;
  cmdCancel.Enabled := false;
  memNewText.Lines.Clear;
  Finally
    vstlComments.free;
    end;
end;

procedure TfrmReminder.cmdPatientClick(Sender: TObject);
var vbolDummy: boolean;
begin
  vintCurrentEntity := dtmMainLocal.qryReminder.fieldbyname('Entity').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmReminder.btnPrevClick(Sender: TObject);
begin
{Set the temporary datamodule for use by the quickreport creation events}
vdtmQuickReport := dtmMainLocal;
frmReminderQR := tfrmReminderQR.Create(nil);
try
  frmReminderQR.rptReminderQR.Preview;
finally
  frmReminderQR.release;
  frmReminderQR := nil;
  vdtmQuickReport := nil;
  end;
end;

end.
