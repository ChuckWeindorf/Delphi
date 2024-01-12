unit formEquipment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dataMainDataModule, StdCtrls, DBCtrls, Mask, jpeg, Menus, ExtCtrls,
  Buttons, ToolWin, ComCtrls, procSharedDatamoduleCalls;

type
  TfrmEquipment = class(TForm)
    pnlCommentsPicture: TPanel;
    pnlComments: TPanel;
    memEquipmentComments: TDBMemo;
    lbl_10008: TLabel;
    pnlPicture: TPanel;
    imgPicture: TImage;
    ListBox1: TListBox;
    pnlinfo: TPanel;
    lbl_10001: TLabel;
    lbl_10002: TLabel;
    lbl_10003: TLabel;
    lbl_10004: TLabel;
    lbl_10005: TLabel;
    lbl_10006: TLabel;
    lbl_10007: TLabel;
    edtEquipmentType: TDBEdit;
    edtEquipmentWarrenty: TDBEdit;
    edtEquipmentWarrentyExp: TDBEdit;
    edtEquipmentModel: TDBEdit;
    edtEquipmentSerial: TDBEdit;
    edtEquipmentValue: TDBEdit;
    cboEquipmentContact: TDBComboBox;
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
    lbl_10009: TLabel;
    edtDescription: TDBEdit;
    cmdDeleteEquipment: TSpeedButton;
    mnuDeleteEquipment: TMenuItem;
    lbl_10010: TLabel;
    chkSchedule: TDBCheckBox;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure ButtonControl(const cbolOn: boolean);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdDeleteEquipmentClick(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
  public
    //variable used to determine wich entity is the current entity
    vintEntityNum: Integer;
    constructor Create(AOwner :TComponent); override;
  end;

var
  frmEquipment: TfrmEquipment;

implementation

{$R *.DFM}

constructor TfrmEquipment.Create(AOwner :TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin
  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintEntityEquipment;
  vintEntityNum:=vintCurrentEntity;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  {Set all datasources}
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;
  //set the forms caption
  Self.Caption := 'Equipment: ' +
         dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring;
  If dtmMainLocal.qryEquipment.RecordCount = 0 then
     begin
     dtmMainLocal.qryEquipment.Append;
     dtmMainLocal.qryEquipment.Fieldbyname('Entity').asinteger := vintEntityNum;
     PostEvent(dtmMainLocal.qryEquipment);
     end;
  If vbolNewItem then
    begin
    vbolNewItem := false;
    cmdEditClick(Self);
    end;
end;

procedure TfrmEquipment.cmdCancelClick(Sender: TObject);
begin
  //cancel the information and close
  RollbackDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmEquipment.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //apply datasets if needed and close the datamodule
   if cmdSave.Enabled then
    ApplyDataSets(dtmMainLocal);

  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(vintEntityNum);
  Action := caFree;
end;

procedure TfrmEquipment.cmdEditClick(Sender: TObject);
begin
  //switch edit mode on or off
  EditDataSets(dtmMainLocal);
  ButtonControl(false);
end;

procedure TfrmEquipment.cmdSaveClick(Sender: TObject);
begin
  //xave changes to database
  ApplyDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmEquipment.mnuExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmEquipment.ButtonControl(const cbolOn: boolean);
begin
{On of true turns the edit button on, others off}
If cbolOn then
  begin
  cmdEdit.Enabled:= true;
  mnuChange.Enabled:= true;
  cmdSave.Enabled:= false;
  mnuSave.Enabled:= false;
  cmdDeleteEquipment.Enabled:= false;
  mnuDeleteEquipment.Enabled:= false;
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
  cmdDeleteEquipment.Enabled:= true;
  mnuDeleteEquipment.Enabled:= true;
  cmdCancel.Enabled:= true;
  mnuCancel.Enabled:= true;
  end;
end;
procedure TfrmEquipment.cmdexitClick(Sender: TObject);
begin
close;
end;

{Delete the equipment and any cascades}
procedure TfrmEquipment.cmdDeleteEquipmentClick(Sender: TObject);
begin
if MessageDlg('This Equipment will be removed permanently. OK?',
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
