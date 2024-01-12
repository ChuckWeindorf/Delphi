unit formInsurance;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, Buttons, ToolWin, ComCtrls, StdCtrls, Mask,
  DBCtrls, dataMainDatamodule, Menus;

type
  TfrmInsurance = class(TForm)
    tbrInsurance: TToolBar;
    pnlMain: TPanel;
    cmdEdit: TSpeedButton;
    cmdSave: TSpeedButton;
    cmdCancel: TSpeedButton;
    spl2: TSplitter;
    cmdDelete: TSpeedButton;
    cmdexit: TSpeedButton;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    spl1: TSplitter;
    grdInsurers: TDBGrid;
    lbl_0001: TLabel;
    edtCompany: TDBEdit;
    lbl_0002: TLabel;
    edtAddress1: TDBEdit;
    edtAddress2: TDBEdit;
    edtCity: TDBEdit;
    edtState: TDBEdit;
    edtZip: TDBEdit;
    edtZip4: TDBEdit;
    lbl_10015: TLabel;
    edtPhoneNumber: TDBEdit;
    lbl_10016: TLabel;
    edtPhoneExtension: TDBEdit;
    lbl_1001: TLabel;
    edtCopay: TDBEdit;
    cmdNew: TSpeedButton;
    mnuMain: TMainMenu;
    File1: TMenuItem;
    mnuExit: TMenuItem;
    Edit1: TMenuItem;
    mnuChange: TMenuItem;
    mnuSave: TMenuItem;
    mnuCancel: TMenuItem;
    mnuHelp: TMenuItem;
    mnuNew: TMenuItem;
    mnuDelete: TMenuItem;
    lbl_1009: TLabel;
    edtDepartment: TDBEdit;
    cmdInsurance: TSpeedButton;
    cmdOtherMed: TSpeedButton;
    spl3: TSplitter;
    lbl_1003: TLabel;
    cmdPhysician: TSpeedButton;
    lbl_1002: TLabel;
    edtRate: TDBEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdInsurersCellClick(Column: TColumn);
    procedure FormActivate(Sender: TObject);
    procedure grdInsurersKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdInsuranceClick(Sender: TObject);
    procedure cmdOtherMedClick(Sender: TObject);
    procedure cmdPhysicianClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCompanyChange(Sender: TObject);
  private
    { Private declarations }
    dtmMainLocal : tdtmMain;
    procedure ButtonControl(const cbolOn: boolean);
    procedure Locatecurrent;
  public
    { Public declarations }
    constructor Create(AOwner :TComponent); override;
  end;

var
  frmInsurance: TfrmInsurance;

implementation

{$R *.DFM}

uses procSharedDatamoduleCalls;

constructor TfrmInsurance.Create(AOwner :TComponent);
var
  vintloop: Integer;
  vtempcomp: TComponent;
begin
  {The type of datamodule is determined by the constant}
  vintDatamoduleInstance := cintEntityInsCompany;
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
end;

procedure TfrmInsurance.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if cmdSave.Enabled then
    ApplyDataSets(dtmMainLocal);

  CloseAndFreeFiles(dtmMainLocal);
  CloseThisEntity(cintEntityInsCompany);
  Action := caFree;
end;

procedure TfrmInsurance.cmdEditClick(Sender: TObject);
begin
  EditDataSets(dtmMainLocal);
  ButtonControl(false);
end;

procedure TfrmInsurance.cmdSaveClick(Sender: TObject);
begin
  ApplyDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmInsurance.ButtonControl(const cbolOn: boolean);
begin
{On of true turns the edit button on, others off}
If cbolOn then
  begin
  cmdEdit.Enabled:= true;
  mnuChange.Enabled:= true;
  cmdSave.Enabled:= false;
  mnuSave.Enabled:= false;
  cmdDelete.Enabled:= false;
  mnuDelete.Enabled:= false;
  cmdNew.Enabled:= false;
  mnuNew.Enabled:= false;
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
  cmdDelete.Enabled:= true;
  mnuDelete.Enabled:= true;
  cmdNew.Enabled:= true;
  mnuNew.Enabled:= true;
  cmdCancel.Enabled:= true;
  mnuCancel.Enabled:= true;
  end;
end;

procedure TfrmInsurance.cmdCancelClick(Sender: TObject);
begin
  RollbackDataSets(dtmMainLocal);
  ButtonControl(true);
end;

procedure TfrmInsurance.cmdexitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmInsurance.mnuExitClick(Sender: TObject);
begin
Close;
end;

procedure TfrmInsurance.cmdDeleteClick(Sender: TObject);
begin
if MessageDlg('This Company will be removed permanently. OK?',
    mtWarning, [mbYes, mbCancel], 0) = mrYes then
  begin
  If dtmMainLocal.qryEntity.recordcount > 0 then
    begin
    DeleteAllEntity(dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger);
    dtmMainLocal.qryEntity.refresh;
    end;
  end;
end;

procedure TfrmInsurance.cmdNewClick(Sender: TObject);
var vintWork: integer;
begin
  If cmdInsurance.Down then
     vintWork:= NewRecord(cintEntityInsCompany, 0, '', 0)
  else
  If cmdPhysician.Down then
     vintWork:= NewRecord(cintEntityOtherPhys, 0, '', 0)
  else
     vintWork:= NewRecord(cintEntityMedCompany, 0, '', 0);
  dtmMainLocal.qryEntity.locate('Entity', vintWork, []);
  dtmMainLocal.qryEntity.edit;
  If cmdPhysician.Down then 
    dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring:=
                                                               '-New Physician'
  else
    dtmMainLocal.qryEntity.fieldbyname('EntityDescription').asstring:=
                                                                 '-New Company';
  PostEvent(dtmMainLocal.qryEntity);
  dtmMainLocal.qryInsurance.append;
  dtmMainLocal.qryInsurance.fieldbyname('Entity').asinteger:= vintWork;
  PostEvent(dtmMainLocal.qryInsurance);
  dtmMainLocal.qryAddress.append;
  dtmMainLocal.qryAddress.fieldbyname('Entity').asinteger:= vintWork;
  dtmMainLocal.qryAddress.fieldbyname('AddressType').asString:= 'Work';
  PostEvent(dtmMainLocal.qryAddress);
  dtmMainLocal.qryPhoneNumber.append;
  dtmMainLocal.qryPhoneNumber.fieldbyname('Entity').asinteger:= vintWork;
  dtmMainLocal.qryPhoneNumber.fieldbyname('PhoneCategory').asString:= 'Work';
  PostEvent(dtmMainLocal.qryPhoneNumber);
end;

procedure TfrmInsurance.grdInsurersCellClick(Column: TColumn);
begin
Locatecurrent;
end;

procedure TfrmInsurance.Locatecurrent;
begin
  dtmMainLocal.qryInsurance.locate('Entity',
                    dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger, []);
  dtmMainLocal.qryAddress.locate('Entity',
                    dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger, []);
  dtmMainLocal.qryPhoneNumber.locate('Entity',
                    dtmMainLocal.qryEntity.fieldbyname('Entity').asinteger, []);
end;

procedure TfrmInsurance.FormActivate(Sender: TObject);
begin
Locatecurrent;
end;

procedure TfrmInsurance.grdInsurersKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
Locatecurrent;
end;

procedure TfrmInsurance.cmdInsuranceClick(Sender: TObject);
begin
grdInsurers.columns[0].title.caption := 'Insurance Company';
dtmMainLocal.qryEntity.close;
dtmMainLocal.qryEntity.SQL[1] := 'Where Entity > 9999 and Entity < 19999';
dtmMainLocal.qryEntity.open;
Locatecurrent;
end;

procedure TfrmInsurance.cmdOtherMedClick(Sender: TObject);
begin
grdInsurers.columns[0].title.caption:= 'Medical Office';
dtmMainLocal.qryEntity.close;
dtmMainLocal.qryEntity.SQL[1] := 'Where Entity > 19999 and Entity < 29999';
dtmMainLocal.qryEntity.open;
Locatecurrent;
end;

procedure TfrmInsurance.cmdPhysicianClick(Sender: TObject);
begin
grdInsurers.columns[0].title.caption:= 'Other physicians';
dtmMainLocal.qryEntity.close;
dtmMainLocal.qryEntity.SQL[1] := 'Where Entity > 29999 and Entity < 39999';
dtmMainLocal.qryEntity.open;
Locatecurrent;
end;

procedure TfrmInsurance.FormCreate(Sender: TObject);
begin
If vbolFinanceView then
   edtRate.visible:= true;
cmdInsuranceclick(self);
end;

procedure TfrmInsurance.edtCompanyChange(Sender: TObject);
begin
Locatecurrent;
end;

end.
