unit formFacility;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dataMainDataModule, StdCtrls, DBCtrls, Mask, jpeg, ExtCtrls, Menus,
  Buttons, ToolWin, ComCtrls, procSharedDatamoduleCalls;

type
  TfrmFacility = class(TForm)
    pnlInfoPicture: TPanel;
    pnlFacilityInfo: TPanel;
    lbl_10001: TLabel;
    lbl_10002: TLabel;
    lbl_10003: TLabel;
    edtFacilityCapacity: TDBEdit;
    edtFacilityDimensions: TDBEdit;
    pnlPicture: TPanel;
    imgPicture: TImage;
    ListBox1: TListBox;
    pnlCapabilitiesComments: TPanel;
    pnlCapabilities: TPanel;
    memFacilityCapabiliy: TDBMemo;
    lbl_10004: TLabel;
    pnlComments: TPanel;
    memFacilityComments: TDBMemo;
    lbl_10005: TLabel;
    tbrHousehold: TToolBar;
    cmdEdit: TSpeedButton;
    cmdSave: TSpeedButton;
    cmdCancel: TSpeedButton;
    spl2: TSplitter;
    spl3: TSplitter;
    cmdexit: TSpeedButton;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    mnuHousehold: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    mnuEdit: TMenuItem;
    mnuChange: TMenuItem;
    mnuSave: TMenuItem;
    mnuCancel: TMenuItem;
    mnuHelp: TMenuItem;
    mnuVideo: TMenuItem;
    mnuOnline: TMenuItem;
    cboFacilityCategory: TDBComboBox;
    edtRoomName: TDBEdit;
    lbl_10006: TLabel;
    cmdDeleteFacility: TSpeedButton;
    mnuDeleteFacility: TMenuItem;
    lbl_10010: TLabel;
    chkSchedule: TDBCheckBox;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure ButtonControl(const cbolOn: boolean);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdDeleteFacilityClick(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
  public
    //variable used to determine wich entity is the current entity
    vintEntityNum: Integer;
    constructor Create(AOwner :TComponent); override;
  end;

var
  frmFacility: TfrmFacility;

implementation

{$R *.DFM}

constructor TfrmFacility.Create(AOwner :TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin
  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintEntityRoom;
  vintEntityNum:=vintCurrentEntity;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  FillPickList('FacilityCategory',cboFacilityCategory.Items);
  {Set all datasources}
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;
  //set the forms caption
  Self.Caption := 'Facility: ' +
         dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring;
  If dtmMainLocal.qryFacilityRoom.RecordCount = 0 then
     begin
     dtmMainLocal.qryFacilityRoom.Append;
     dtmMainLocal.qryFacilityRoom.Fieldbyname('Entity').asinteger :=
                                                                  vintEntityNum;
     PostEvent(dtmMainLocal.qryFacilityRoom);
     end;
  If vbolNewItem then
    begin
    vbolNewItem := false;
    cmdEditClick(Self);
    end;
end;

procedure TfrmFacility.cmdCancelClick(Sender: TObject);
begin
  //cancel the information and close
  RollbackDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmFacility.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //apply datasets if needed and close datamodule
  if cmdSave.Enabled then
    ApplyDataSets(dtmMainLocal);

  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(vintEntityNum);
  Action := caFree;
end;

procedure TfrmFacility.cmdEditClick(Sender: TObject);
begin
  //switch edit mode on or off
  EditDataSets(dtmMainLocal);
  ButtonControl(false);
end;

procedure TfrmFacility.cmdSaveClick(Sender: TObject);
begin
  //save changes
  ApplyDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmFacility.mnuExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmFacility.ButtonControl(const cbolOn: boolean);
begin
{On of true turns the edit button on, others off}
If cbolOn then
  begin
  cmdEdit.Enabled:= true;
  mnuChange.Enabled:= true;
  cmdSave.Enabled:= false;
  mnuSave.Enabled:= false;
  cmdDeleteFacility.Enabled:= false;
  mnuDeleteFacility.Enabled:= false;
  cmdCancel.Enabled:= false;
  mnuCancel.Enabled:= false;
  end
else
{Edit button off, others on}
  begin
  cmdEdit.Enabled:= false;
  mnuChange.Enabled:= false;
  cmdSave.Enabled:= true;
  mnuSave.Enabled:= true;
  cmdDeleteFacility.Enabled:= true;
  mnuDeleteFacility.Enabled:= true;
  cmdCancel.Enabled:= true;
  mnuCancel.Enabled:= true;
  end;
end;

procedure TfrmFacility.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmFacility.cmdDeleteFacilityClick(Sender: TObject);
begin
if MessageDlg('This Facility will be removed permanently. OK?',
    mtWarning, [mbYes, mbCancel], 0) = mrYes then
  begin
  if cmdSave.Enabled then
     begin
     RollbackDataSets(dtmMainLocal);
     ButtonControl(true);
     end;
  DeleteAllEntity(dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger);
  close;
  end;
end;

end.
