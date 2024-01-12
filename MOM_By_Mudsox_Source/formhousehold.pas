unit formhousehold;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  datamainDataModule, StdCtrls, Mask, DBCtrls, ExtCtrls, Menus, Buttons,
  ToolWin, ComCtrls, procSharedDatamoduleCalls, Grids, DBGrids;

type
  TfrmHousehold = class(TForm)
    mnuHousehold: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    mnuHelp: TMenuItem;
    pnlAddressPhone: TPanel;
    pnlAddress: TPanel;
    tabAddress: TTabControl;
    lbl_10011: TLabel;
    lbl_10012: TLabel;
    lbl_10013: TLabel;
    lbl_10014: TLabel;
    edtAddressLine1: TDBEdit;
    edtAddressLine2: TDBEdit;
    edtAddressCity: TDBEdit;
    edtAddressState: TDBEdit;
    edtAddressZip: TDBEdit;
    edtAddressZip4: TDBEdit;
    pnlPhone: TPanel;
    tabPhone: TTabControl;
    lbl_10015: TLabel;
    lbl_10016: TLabel;
    edtPhoneNumber: TDBEdit;
    edtPhoneExtension: TDBEdit;
    pnlTop: TPanel;
    pnlPicHouse: TPanel;
    pnlInfo: TPanel;
    lbl_10002: TLabel;
    lbl_10004: TLabel;
    lbl_10005: TLabel;
    edtHouseholdHead: TEdit;
    pnlPicture: TPanel;
    imgPicture: TImage;
    pnlPatinetList: TPanel;
    grdPatients: TDBGrid;
    tbrHousehold: TToolBar;
    cmdEdit: TSpeedButton;
    cmdSave: TSpeedButton;
    spl3: TSplitter;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    cboHouseholdPhysician: TComboBox;
    mnuVideo: TMenuItem;
    mnuOnline: TMenuItem;
    spl2: TSplitter;
    cmdexit: TSpeedButton;
    cmdCancel: TSpeedButton;
    lbl_10001: TLabel;
    pnlPatTop: TPanel;
    lbl_10006: TLabel;
    cmdHeadHousehold: TSpeedButton;
    cmdNewRecord: TSpeedButton;
    edtHousehold: TDBEdit;
    cboLanguage: TDBComboBox;
    mnuEdit: TMenuItem;
    mnuChange: TMenuItem;
    mnuSave: TMenuItem;
    mnuCancel: TMenuItem;
    grdImage: TDBGrid;
    cmdDeleteHousehold: TSpeedButton;
    mnuDeleteHousehold: TMenuItem;
    btnPrev: TSpeedButton;
    cmdNewImage: TSpeedButton;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tabAddressChange(Sender: TObject);
    procedure tabPhoneChange(Sender: TObject);
    procedure grdPatientsDblClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboHouseholdPhysicianChange(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdNewRecordClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmdHeadHouseholdClick(Sender: TObject);
    procedure FindHouseholdHead;
    procedure ButtonControl(const cbolOn: boolean);
    procedure grdImageDblClick(Sender: TObject);
    procedure cmdDeleteHouseholdClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure edtAddressCityEnter(Sender: TObject);
    procedure edtAddressStateEnter(Sender: TObject);
    procedure cmdNewImageClick(Sender: TObject);
    procedure imgPictureDblClick(Sender: TObject);
  private
    dtmMainLocal : tdtmMain;
  public
    //variable used to determine wich entity is the current entity
    vintEntityNum: Integer;
    vlstHHPhysicianEntity: TStringList;
    vbolPatientCalled: boolean;
    constructor Create(AOwner :TComponent); override;
  end;


var
  frmHousehold: TfrmHousehold;

implementation

uses formHouseholdQR, procImageSupport;

{$R *.DFM}

constructor TfrmHousehold.Create(AOwner :TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
  vstrname: String;
begin
  vlstHHPhysicianEntity:= TStringList.Create;
  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintEntityHouseHold;
  vintEntityNum := vintCurrentEntity;
  {Create the datamodule that is within the scope of this form}
  dtmMainLocal := Tdtmmain.create(application);
  DatamoduleCreateEvent(dtmMainLocal);
  {Create all form components and other start-up activities}
  Inherited create(AOwner);
  {Set all datasources}
  //fill the picklist data
  FillPickList('Physician',cboHouseHoldPhysician.Items);
  {---Special code to handle the conversion from entity to Physician name}
  //set the entity numbers for the physician
  for vintloop:=0 to cboHouseHoldPhysician.Items.Count-1  do
  begin
    vstrname:=cboHouseHoldPhysician.Items[vintloop];
    vlstHHPhysicianEntity.add(Copy(vstrname,Length(vstrname)-5,7));
    Delete(vstrname,Length(vstrname)-9,10);
    cboHouseHoldPhysician.Items[vintloop]:=vstrname;
  end;
  //set the combos to the data on the database
  cboHouseHoldPhysician.ItemIndex:=vlstHHPhysicianEntity.IndexOf(
         IntToStr(dtmMainLocal.qryHouseHold.FieldByName
                                             ('HouseHoldPhysician').asinteger));
  {Generic pick list generation}
  FillPickList('Language',cboLanguage.Items);
  {Assign all data-linked components to the correct dataset}
  for vintloop:=0 to ComponentCount-1 do
  begin
    vtempcomp:=Components[vintloop];
    AssignDataSources(vtempComp, dtmMainLocal);
  end;
//set the caption for the form
self.Caption:='Household: #' + dtmMainLocal.qryEntityHouseHold.fieldbyname
                                                ('Entity').asstring + ' - ' 
                            + dtmMainLocal.qryEntityHousehold.fieldbyname
                                                 ('EntityDescription').asstring;
{In order to make this linking of household information easier,
 create a household record if there is not one.  This is a direct match to the
 Entity record.}
  If dtmMainLocal.qryHouseHold.RecordCount = 0 then
     begin
     dtmMainLocal.qryHouseHold.Append;
     dtmMainLocal.qryHouseHold.Fieldbyname('Entity').asinteger :=
                             vintCurrentEntity;
     PostEvent(dtmMainLocal.qryHouseHold);
     end;
{Put a literal in place of the entity number}
FindHouseHoldHead;
{Get ready for new entries in the Phone and Adderess tables}
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

Procedure TfrmHousehold.FindHouseHoldHead;
begin
  //find the record for the household head so the name can be displayed
  If dtmMainLocal.qryEntity.Locate('Entity',
      dtmMainLocal.qryHousehold.fieldbyName('HouseHoldHead').asinteger,[]) then
     //display the name
     edtHouseholdhead.Text:=dtmMainLocal.qryEntity.FieldbyName
                                                 ('EntityDescription').asstring;
end;

procedure TfrmHousehold.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //apply if needed and close the datamodule
  if cmdSave.Enabled then
    ApplyDataSets(dtmMainLocal);

  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(vintEntityNum);
  Action := caFree;
end;

procedure TfrmHouseHold.tabAddressChange(Sender: TObject);
begin
  //Change Record with tab control
  {If there is no record for the associated tab, insert the record to give
  a blank record...}
  If not
     dtmMainLocal.qryAddress.Locate('Entity;AddressType',VarArrayOf
                 ([vintEntityNum,tabAddress.Tabs[tabAddress.TabIndex]]),[]) then
     begin
     dtmMainLocal.qryAddress.Insert;
     dtmMainLocal.qryAddress.fieldbyname('Entity').asinteger := vintEntityNum;
     dtmMainLocal.qryAddress.fieldbyname('AddressType').asstring :=
                                           tabAddress.Tabs[tabAddress.TabIndex];
     PostEvent(dtmMainLocal.qryAddress);
     end;
end;

procedure TfrmHouseHold.tabPhoneChange(Sender: TObject);
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

procedure TfrmHousehold.grdPatientsDblClick(Sender: TObject);
var vbolDummy: boolean;
begin
  //open the current patient form
  vbolPatientCalled := true;
  vintCurrentEntity := dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger;
  {This is the sneaky way to cann a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmHousehold.cmdCancelClick(Sender: TObject);
begin
  //cancel the information and close
  RollbackDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmHousehold.cmdEditClick(Sender: TObject);
begin
  //set edit on
  EditDataSets(dtmMainLocal);
  ButtonControl(false);
end;

procedure TfrmHousehold.cmdSaveClick(Sender: TObject);
begin
  //save info
  ApplyDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmHousehold.ButtonControl(const cbolOn: boolean);
begin
{On of true turns the edit button on, others off}
If cbolOn then
  begin
  cmdEdit.Enabled:= true;
  mnuChange.Enabled:= true;
  cmdSave.Enabled:= false;
  mnuSave.Enabled:= false;
  cmdDeleteHousehold.Enabled:= false;
  mnuDeleteHousehold.Enabled:= false;
  cmdCancel.Enabled:= false;
  mnuCancel.Enabled:= false;
  cmdHeadHousehold.Enabled:= false;
  end
else
{Edit button off, others on}
  begin
  cmdEdit.Enabled:= false;
  mnuChange.Enabled:= false;
  cmdSave.Enabled:= true;
  mnuSave.Enabled:= true;
  cmdDeleteHousehold.Enabled:= true;
  mnuDeleteHousehold.Enabled:= true;
  cmdCancel.Enabled:= true;
  mnuCancel.Enabled:= true;
  cmdHeadHousehold.Enabled:= true;
  end;
end;

procedure TfrmHousehold.FormDestroy(Sender: TObject);
begin
  //free the list of entity numbers
  vlstHHPhysicianEntity.free
end;

procedure TfrmHousehold.cboHouseholdPhysicianChange(Sender: TObject);
begin
  //change to info on the database to the selected physician
if cmdSave.enabled then
  begin
    dtmMainLocal.qryHouseHold.edit;
    dtmMainLocal.qryHouseHold.FieldByName('HouseHoldPhysician').asinteger:=
               StrToInt(vlstHHPhysicianEntity[cboHouseholdPhysician.ItemIndex]);
    PostEvent(dtmMainLocal.qryHouseHold);
//    dtmMainLocal.qryHouseHold.Open;
  end
else
    cboHouseHoldPhysician.ItemIndex:=vlstHHPhysicianEntity.IndexOf(
               IntToStr(dtmMainLocal.qryHouseHold.FieldByName
                                             ('HouseHoldPhysician').asinteger));
end;

procedure TfrmHousehold.mnuExitClick(Sender: TObject);
begin
close;
end;

procedure TfrmHousehold.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmHousehold.cmdNewRecordClick(Sender: TObject);
var vbolDummy: boolean;
begin
  {This switch is set to force the new screen to go to Auto-edit mode}
  vbolNewItem := true;
  vbolPatientCalled := true;
  vintCurrentEntity := NewRecord(cintEntityPatient,
        dtmMainLocal.qryEntityHousehold.fieldbyname('Entity').asinteger,
         '', 0);
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);
end;

procedure TfrmHousehold.FormActivate(Sender: TObject);
begin
{In case we are returning from a Patient screen, refresh the list of Patients.}
If vbolPatientCalled then
  begin
  dtmMainLocal.qryEntity.close;
  dtmMainLocal.qryEntity.open;
  vbolPatientCalled := false;
  end;
end;

procedure TfrmHousehold.cmdHeadHouseholdClick(Sender: TObject);
begin
If dtmMainLocal.qryEntity.RecordCount > 0 then
  If length(dtmMainLocal.qryEntity.fieldbyname
                                        ('EntityDescription').asstring) > 0 then
    begin
    dtmMainLocal.qryHouseHold.Edit;
    dtmMainLocal.qryHousehold.fieldbyname('HouseHoldHead').asinteger:=
              dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger;
    PostEvent(dtmMainLocal.qryHouseHold);
    FindHouseHoldHead;
    end;
end;

procedure TfrmHousehold.grdImageDblClick(Sender: TObject);
begin
If dtmMainLocal.qryPicture.recordcount > 0 then
    FillImageBox(imgPicture,
             false,
             143,
             112,
             ExtractImagePath(dtmMainLocal));
end;

procedure TfrmHousehold.cmdDeleteHouseholdClick(Sender: TObject);
begin
if MessageDlg('This Household will be removed permanently. OK?',
    mtWarning, [mbYes, mbCancel], 0) = mrYes then
  begin
  if cmdSave.Enabled then
     begin
     RollbackDataSets(dtmMainLocal);
     ButtonControl(true);
     end;
  dtmMainLocal.qryEntity.first;
  While not dtmMainLocal.qryEntity.eof do
    begin
    DeleteAllEntity(dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger);
    dtmMainLocal.qryEntity.refresh;
    end;
  DeleteAllEntity(dtmMainLocal.qryEntityHousehold.fieldbyname
                                                          ('Entity').asinteger);
  close;
  end;
end;

procedure TfrmHousehold.btnPrevClick(Sender: TObject);
begin
  vdtmQuickReport := dtmMainLocal;
  frmhouseholdQR := tfrmhouseholdQR.Create(nil);
  try
    frmhouseholdQR.rpthousehold.Preview;
  finally
    frmhouseholdQR.release;
    frmhouseholdQR := nil;
    vdtmQuickReport := nil;
  end;
end;

procedure TfrmHousehold.edtAddressCityEnter(Sender: TObject);
begin
{If the screen is in edit mode and the city is blank, attempt to get the default
and post it on entry to the field.}
If not cmdEdit.enabled and (length(edtAddressCity.text) = 0) then
   begin
   dtmMainLocal.qryAddress.edit;
   dtmMainLocal.qryAddress.fieldbyname('AddressCity').asstring :=
                                                     FillDefault('AddressCity');
   dtmMainLocal.qryAddress.post;
   end;
end;

procedure TfrmHousehold.edtAddressStateEnter(Sender: TObject);
begin
{If the screen is in edit mode and the city is blank, attempt to get the default
and post it on entry to the field.}
If not cmdEdit.enabled and (length(edtAddressState.text) = 0) then
   begin
   dtmMainLocal.qryAddress.edit;
   dtmMainLocal.qryAddress.fieldbyname('AddressState').asstring :=
                                                    FillDefault('AddressState');
   dtmMainLocal.qryAddress.post;
   end;
end;

{Bring up the screen that will import one image into this household's list of
images}
procedure TfrmHousehold.cmdNewImageClick(Sender: TObject);
begin
DisplayImageImport(dtmMainLocal.qryHousehold.fieldbyname('Entity').asinteger);
dtmMainLocal.qryPicture.close;
dtmMainLocal.qryPicture.Open;
dtmMainLocal.qryPicture.Last;
grdImageDblClick(Self);
end;

{Show the full size version of an image}
procedure TfrmHousehold.imgPictureDblClick(Sender: TObject);
begin
ViewFullImage(dtmMainLocal);
end;

end.
