unit formStaff;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Mask, dataMainDatamodule, procSharedDatamoduleCalls,
  DBCtrls, jpeg, ExtCtrls, Buttons, ToolWin, Menus, procImageSupport,
  Grids, DBGrids;

type
  TfrmStaff = class(TForm)
    pnlInfoAddress: TPanel;
    pnlInfo: TPanel;
    lbl_10002: TLabel;
    lbl_10003: TLabel;
    lbl_10004: TLabel;
    lbl_10001: TLabel;
    edtEntityFirstName: TDBEdit;
    edtEntityMiddle: TDBEdit;
    edtEntityName: TDBEdit;
    pnlAddress: TPanel;
    tabAddress: TTabControl;
    lbl_10005: TLabel;
    lbl_10006: TLabel;
    lbl_10007: TLabel;
    lbl_10015: TLabel;
    edtAddressLine1: TDBEdit;
    edtAddressLine2: TDBEdit;
    edtAddressCity: TDBEdit;
    edtAddressState: TDBEdit;
    edtAddressZip: TDBEdit;
    edtAddressZip4: TDBEdit;
    pnlPicturePhone: TPanel;
    pnlPicture: TPanel;
    imgPicture: TImage;
    pnlPhone: TPanel;
    tabPhone: TTabControl;
    lbl_10008: TLabel;
    lbl_10009: TLabel;
    edtPhoneNumber: TDBEdit;
    edtPhoneExtension: TDBEdit;
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
    cboPosition: TDBComboBox;
    cmdDeleteStaff: TSpeedButton;
    mnuDeleteStaff: TMenuItem;
    cmdNewImage: TSpeedButton;
    grdImage: TDBGrid;
    lbl_10010: TLabel;
    chkSchedule: TDBCheckBox;
    procedure tabAddressChange(Sender: TObject);
    procedure tabPhoneChange(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure ButtonControl(const cbolOn: boolean);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdDeleteStaffClick(Sender: TObject);
    procedure cmdNewImageClick(Sender: TObject);
    procedure grdImageDblClick(Sender: TObject);
    procedure imgPictureDblClick(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
  public
    //variable used to determine wich entity is the current entity
    vintEntityNum: Integer;
    constructor Create(AOwner :TComponent); override;
  end;

var
  frmStaff: TfrmStaff;

implementation

{$R *.DFM}

constructor TfrmStaff.Create(AOwner :TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin
  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintEntityStaff;
  vintEntityNum:=vintCurrentEntity;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  {Set all datasources}
  //fill comboboxes
  FillPickList('StaffPosition',cboPosition.Items);
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;
  //set the caption for the form
  Self.Caption := 'Staff: ' +
         dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring;
  If dtmMainLocal.qryStaff.RecordCount = 0 then
     begin
     dtmMainLocal.qryStaff.Append;
     dtmMainLocal.qryStaff.Fieldbyname('Entity').asinteger := vintEntityNum;
     PostEvent(dtmMainLocal.qryStaff);
     end;
tabPhoneChange(Self);
tabAddressChange(Self);
If vbolNewItem then
  begin
  vbolNewItem := false;
  cmdEditClick(Self);
  end;
  If dtmMainLocal.qryPicture.recordcount > 0 then
     grdImageDblClick(Self);
end;

procedure TfrmStaff.tabAddressChange(Sender: TObject);
begin
  //Change Record with tab control
  if not
    dtmMainLocal.qryAddress.Locate('Entity;AddressType',VarArrayOf([vintEntityNum,
                 tabAddress.Tabs[tabAddress.TabIndex]]),[])  then
    begin
      dtmMainLocal.qryAddress.Insert;
      dtmMainLocal.qryAddress.fieldbyname('Entity').asinteger := vintEntityNum;
      dtmMainLocal.qryAddress.fieldbyname('AddressType').asstring :=
                                           tabAddress.Tabs[tabAddress.TabIndex];
      PostEvent(dtmMainLocal.qryAddress);
    end;
end;

procedure TfrmStaff.tabPhoneChange(Sender: TObject);
begin
//Change Record with tab change
  If not
  dtmMainLocal.qryPhoneNumber.Locate('Entity;PhoneCategory',VarArrayOf
                    ([vintEntityNum,tabPhone.Tabs[tabPhone.TabIndex]]),[]) then
     begin
       dtmMainLocal.qryPhoneNumber.Insert;
       dtmMainLocal.qryPhoneNumber.fieldbyname('Entity').asinteger :=
                                                                  vintEntityNum;
       dtmMainLocal.qryPhoneNumber.fieldbyname('PhoneCategory').asstring :=
                                           tabPhone.Tabs[tabPhone.TabIndex];
       PostEvent(dtmMainLocal.qryPhoneNumber);
     end;
end;

procedure TfrmStaff.cmdCancelClick(Sender: TObject);
begin
  //cancel the information and close
  RollbackDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmStaff.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //apply the changes and close the datamodule
  if cmdSave.Enabled then
    cmdSaveClick(Sender);
  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(vintEntityNum);
  Action := caFree;
end;

procedure TfrmStaff.cmdEditClick(Sender: TObject);
begin
  //set edit on or off
  EditDataSets(dtmMainLocal);
  ButtonControl(false);
end;

procedure TfrmStaff.cmdSaveClick(Sender: TObject);
var vstrHoldName: string;
begin
  {Combine the individual names into the EntityDescription field}
  PostEvent(dtmMainLocal.qryEntity);
  vstrHoldName := CombineEntityName(
                dtmMainLocal.qryEntity.Fieldbyname('EntityFirstName').asstring,
                dtmMainLocal.qryEntity.Fieldbyname('EntityMiddle').asstring,
                dtmMainLocal.qryEntity.Fieldbyname('EntityLastName').asstring);
  If vstrHoldName <>
           dtmMainLocal.qryEntity.FieldByName('EntityDescription').asstring then
      begin
      dtmMainLocal.qryEntity.edit;
      dtmMainLocal.qryEntity.FieldByName('EntityDescription').asstring:=
                                                                   vstrHoldName;
      PostEvent(dtmMainLocal.qryEntity);
      end;
  //save the changes
  ApplyDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmStaff.mnuExitClick(Sender: TObject);
begin
  //cancel and close
  close;
end;

procedure TfrmStaff.ButtonControl(const cbolOn: boolean);
begin
{On of true turns the edit button on, others off}
If cbolOn then
  begin
  cmdEdit.Enabled:= true;
  mnuChange.Enabled:= true;
  cmdSave.Enabled:= false;
  mnuSave.Enabled:= false;
  cmdDeleteStaff.Enabled:= false;
  mnuDeleteStaff.Enabled:= false;
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
  cmdDeleteStaff.Enabled:= true;
  mnuDeleteStaff.Enabled:= true;
  cmdCancel.Enabled:= true;
  mnuCancel.Enabled:= true;
  end;
end;

procedure TfrmStaff.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmStaff.cmdDeleteStaffClick(Sender: TObject);
begin
if MessageDlg('This Staff member will be removed permanently. OK?',
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

procedure TfrmStaff.cmdNewImageClick(Sender: TObject);
begin
DisplayImageImport(dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger);
dtmMainLocal.qryPicture.close;
dtmMainLocal.qryPicture.Open;
dtmMainLocal.qryPicture.Last;
grdImageDblClick(Self);
end;

procedure TfrmStaff.grdImageDblClick(Sender: TObject);
begin
If dtmMainLocal.qryPicture.recordcount > 0 then
    FillImageBox(imgPicture,
             false,
             166,
             136,
             ExtractImagePath(dtmMainLocal));
end;

procedure TfrmStaff.imgPictureDblClick(Sender: TObject);
begin
{Show the full size version of an image}
ViewFullImage(dtmMainLocal);
end;

end.
