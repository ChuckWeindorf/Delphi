unit formMainMenu;
{Author: Chuck Weindorf
 Description: Control the display of all screens within the MMOM system.  Search
 the database for many categories of information.  Track and manipulate all open
 screens.

 Date: 08/20/1999 - CEW - New
  }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Menus, ExtCtrls, ComCtrls, ToolWin, StdCtrls, Grids,
  DBGrids, dbtables, QuickRpt;

type
  TfrmMainMenu = class(TForm)
    mnuMainMenu: TMainMenu;
    mnuFile: TMenuItem;
    mnuClose: TMenuItem;
    mnuExit: TMenuItem;
    mnuHelp: TMenuItem;
    tbrTools: TToolBar;
    pnlDisplay: TPanel;
    mnuNew: TMenuItem;
    cmdNew: TSpeedButton;
    cmdCloseAll: TSpeedButton;
    cmdClinicReports: TSpeedButton;
    cmdexit: TSpeedButton;
    grdSearchResults: TDBGrid;
    cmdScheduler: TSpeedButton;
    mnuVideo: TMenuItem;
    cmdPickList: TSpeedButton;
    mnuView: TMenuItem;
    mnuPickList: TMenuItem;
    cmdSurveyBuilder: TSpeedButton;
    imgLogo: TImage;
    imgLogo2: TImage;
    mnuSurveys: TMenuItem;
    cmdWindowsOpen: TSpeedButton;
    cmdSearchView: TSpeedButton;
    pnlSearchTab: TPanel;
    tabPanel: TTabControl;
    lbl_00100: TLabel;
    cmdSearch: TSpeedButton;
    edtSearch: TEdit;
    cboSearchSort: TComboBox;
    stgWindowsOpen: TStringGrid;
    mnuOnline: TMenuItem;
    cmdQuery: TSpeedButton;
    mnuQuery: TMenuItem;
    mnuScheduler: TMenuItem;
    cmdSpecial: TSpeedButton;
    cmdQuickAppt: TSpeedButton;
    cmdInsurance: TSpeedButton;
    cmdAccounting: TSpeedButton;
    mnuAccounting: TMenuItem;
    cmdBilling: TSpeedButton;
    edtPassword: TEdit;
    lbl_10001: TLabel;
    lbl_10002: TLabel;
    cmdCindy: TSpeedButton;
    cmd30_60_90: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseAllClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdVideoClick(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AssignSearchSortItems(Sender: TObject);
    procedure cmdPickListClick(Sender: TObject);
    procedure grdSearchResultsDblClick(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure cmdWindowsOpenClick(Sender: TObject);
    procedure cmdSearchViewClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure stgWindowsOpenDblClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdClinicReportsClick(Sender: TObject);
    procedure CreateSubsystemForm;
    Procedure CheckButtonEvent;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdSurveyBuilderClick(Sender: TObject);
    procedure cmdSchedulerClick(Sender: TObject);
    procedure cmdQueryClick(Sender: TObject);
    procedure cmdSpecialClick(Sender: TObject);
    procedure cmdQuickApptClick(Sender: TObject);
    procedure cmdInsuranceClick(Sender: TObject);
    procedure cmdAccountingClick(Sender: TObject);
    procedure cmdBillingClick(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure cmdCindyClick(Sender: TObject);
    procedure cmd30_60_90Click(Sender: TObject);
  private
    { Private declarations }
    procedure CheckToolbarEnable;
    procedure CreateScheduler;
    procedure CreateHousehold;
    procedure CreatePatient;
    procedure CreateAppointment;
    procedure CreateReminder;
    procedure CreateSurvey;
    procedure CreateQuery;
    procedure CreateStaff;
    procedure CreateRoom;
    procedure CreateEquipment;
    procedure CreateInsurance;
    procedure CreateClinicReports;
    procedure CreateCompanyBilling;
    procedure CreateFinance;
    procedure CreatePatSummary;
    procedure CreateCindySummary;
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

{$R *.DFM}

uses procSharedDatamoduleCalls,
     formPickList,
     formPatient,
     formAppointment,
     formHousehold,
     formSurvey,
     formStaff,
     formFacility,
     formEquipment,
     formReminder,
     formSurveyCreate,
     formNewSurveyRule,
     formScheduler,
     formQuery,
     formSpecialUtilities,
     formInsurance,
     formFinanceSummary,
     formPatientHistory,
     formClinicReports,
     formCompanyBilling,
     formCindySummary,
     form30_60_90;

{Close down all open forms on the desktop}
procedure TfrmMainMenu.cmdCloseAllClick(Sender: TObject);
begin
CloseAllForms;
CheckButtonEvent;
end;

{------------- Exiting the System --------------}
procedure TfrmMainMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action := caFree;
{Free any allocated memory items before exiting the system}
SystemShutDown;
end;

procedure TfrmMainMenu.cmdexitClick(Sender: TObject);
begin
Close;
end;

{Call the movie clip for this screen}
procedure TfrmMainMenu.cmdVideoClick(Sender: TObject);
begin
  PlayMovie('tuffy.mpg');
end;

procedure TfrmMainMenu.edtSearchChange(Sender: TObject);
begin
end;

{Do the search based on the tab selections and criteria}
procedure TfrmMainMenu.cmdSearchClick(Sender: TObject);
  var vstlSQL: tstringList;
      vstrHoldWhere: string;
      vstrWork: string;
begin
vstlSQL := TstringList.Create;
try
grdSearchResults.Datasource := nil;
grdSearchResults.Columns[0].Title.Caption := 'Name';
grdSearchResults.Columns[0].FieldName := 'EntityDescription';

vstrHoldWhere := '';
If length(edtSearch.text) > 0 then
  If (tabPanel.TabIndex = 1) then
    begin
    if ((edtSearch.text[1] > '0')
        and (edtSearch.text[1] <= '9')) then
        begin
        try
          vstrWork:= inttostr(strtoint(edtSearch.text));
         except
         vstrWork:= '0';
         end;
        cboSearchSort.ItemIndex := 3;
        vstrHoldWhere := 'Entity.' + cboSearchSort.Text
              + ' = ' + vstrWork + ' and';
        end
    else
    if cboSearchSort.Text = 'Entity' then
        begin
        cboSearchSort.ItemIndex := 0;
        vstrHoldWhere := 'Entity.' + cboSearchSort.Text
              + ' like "' + edtSearch.text + '%" and';
        end
    else
        vstrHoldWhere := 'Entity.' + cboSearchSort.Text
              + ' like "' + edtSearch.text + '%" and';
    end
  else
    vstrHoldWhere := 'Entity.' + cboSearchSort.Text
              + ' like "' + edtSearch.text + '%" and';

If tabPanel.TabIndex = 0 then
   begin
   vstlSQL.Add('Select Distinct Entity, EntityDescription');
   If pos(cboSearchSort.Text,  vstlSQL[0]) = 0 then
      vstlSQL[0]:= vstlSQL[0] + ', ' + cboSearchSort.Text;
   vstlSQL.Add('From Entity');
   vstlSQL.Add('Where');
   vstlSQL.Add(vstrHoldWhere);
   vstlSQL.Add('EntityCategory = "Household"');
   vstlSQL.Add('Order by ' + cboSearchSort.Text);
   If pos('EntityDescription',  vstlSQL[5]) = 0 then
      vstlSQL[5] := vstlSQL[5] + ', EntityDescription';
   end
else
If tabPanel.TabIndex = 1 then
   begin
   vstlSQL.Add('Select Distinct Entity, EntityDescription, EntityHousehold');
   If pos(cboSearchSort.Text,  vstlSQL[0]) = 0 then
      vstlSQL[0]:= vstlSQL[0] + ', ' + cboSearchSort.Text;
   vstlSQL.Add('From Entity');
   vstlSQL.Add('Where');
   vstlSQL.Add(vstrHoldWhere);
   vstlSQL.Add('EntityCategory = "Patient"');
   vstlSQL.Add('Order by ' + cboSearchSort.Text);
   If pos('EntityDescription',  vstlSQL[5]) = 0 then
      vstlSQL[5] := vstlSQL[5] + ', EntityDescription';
   end
else
If tabPanel.TabIndex = 2 then
   begin
   vstlSQL.Add('Select Distinct Entity, EntityDescription');
   vstlSQL.Add('From Entity');
   vstlSQL.Add('Where (Entity > ' + inttostr(cintEntityStaff) + ')');
   vstlSQL.Add(' and (Entity < ' + inttostr(cintEntityStaff + 99999) + ')');
   vstlSQL.Add('Order by EntityDescription');
   end
else
If tabPanel.TabIndex = 3 then
   begin
   vstlSQL.Add('Select Distinct Entity, EntityDescription');
   vstlSQL.Add('From Entity');
   vstlSQL.Add('Where (Entity > ' + inttostr(cintEntityRoom) + ')');
   vstlSQL.Add(' and (Entity < ' + inttostr(cintEntityRoom + 99999) + ')');
   vstlSQL.Add('Order by EntityDescription');
   end
else
If tabPanel.TabIndex = 4 then
   begin
   vstlSQL.Add('Select Distinct Entity, EntityDescription');
   vstlSQL.Add('From Entity');
   vstlSQL.Add('Where (Entity > ' + inttostr(cintEntityEquipment) + ')');
   vstlSQL.Add(' and (Entity < ' + inttostr(cintEntityEquipment + 99999) + ')');
   vstlSQL.Add('Order by EntityDescription');
   end
{else
If (tabPanel.TabIndex = 5) and (length(edtSearch.text) > 0) then
   begin
   vstlSQL.Add('Select Distinct Appointment.ApptTicket, Appointment.Entity,');
   vstlSQL.Add('Entity.EntityDescription');
   vstlSQL.Add('From Appointment, Entity');
   vstlSQL.Add('Where (Appointment.' + cboSearchSort.Text
              + ' = ' + edtSearch.text + ')');
   vstlSQL.Add('and (Appointment.Entity = ' + 'Entity.Entity)');
   vstlSQL.Add('Order by ' + cboSearchSort.Text);
   end
else
If (tabPanel.TabIndex = 6) and (length(edtSearch.text) > 0) then
   begin
   vstlSQL.Add('Select Distinct SurveyNumber, SurveyID, SurveyEdition');
   vstlSQL.Add('From Survey');
   vstlSQL.Add('Where SurveyNumber = ' + edtSearch.text);
   vstlSQL.Add('Order by ' + cboSearchSort.Text);
   grdSearchResults.Columns[0].Title.Caption := 'Survey ID';
   grdSearchResults.Columns[0].FieldName := 'SurveyID';
   end }
else
If tabPanel.TabIndex = 5 then
   begin
   if (edtSearch.text < '00/') or (edtSearch.text > '12/') then
       edtSearch.text := datetostr(date);
   vstlSQL.Add('Select Distinct ReminderTicket, ReminderDate,' +
                                                   ' ReminderCategory, Entity');
   vstlSQL.Add('From Reminder');
   vstlSQL.Add('Where ReminderDate <= "' + edtSearch.text + '"');
   vstlSQL.Add(' and ReminderActive = true');
   vstlSQL.Add('Order by ' + cboSearchSort.Text);
   grdSearchResults.Columns[0].Title.Caption := 'ReminderCategory';
   grdSearchResults.Columns[0].FieldName := 'ReminderCategory';
   end;

{No query was built - get out of the loop}
If vstlSQL.count > 0 then
  begin
  PerformSQLStatemtent(vstlSQL);
  {Hide the answer grid if there are no matches}
  If vqryMainSearch.RecordCount = 0 then
     grdSearchResults.Visible := false
  else
     grdSearchResults.Visible := true;
  {Assign the datasource the first time through}
  If grdSearchResults.Datasource = nil then
     grdSearchResults.Datasource := vdtsMainSearch;
  end;
finally
  {Protect against a memory leak by always freeing the memory.}
  vstlSQL.Free;
  end;
CheckToolbarEnable;
end;

{Start up the system and form here}
procedure TfrmMainMenu.FormCreate(Sender: TObject);
begin
vfrmMainMenu := Self;
InitializeApplicationEvent;
imgLogo.Picture.LoadFromFile(vstrApplicationDirectory + 'Pictures\Mheds.bmp');
imgLogo2.Picture.LoadFromFile(vstrApplicationDirectory + 'Pictures\Mheds2.bmp');
tabPanel.TabIndex := 1;
AssignSearchSortItems(Nil);
end;

Procedure TfrmMainMenu.AssignSearchSortItems(Sender: TObject);
begin
vbolNewItem:= false;
vqryMainSearch.close;
grdSearchResults.Visible := false;
cboSearchSort.Items.Clear;
cboSearchSort.Enabled := false;
edtSearch.Enabled := true;
edtPassword.Visible:= false;
lbl_10001.Visible:= false;
lbl_10001.Visible:= false;
{HouseHold, Patient and Staff are stored by name}
edtSearch.Text := '';
If tabPanel.TabIndex = 0 then
   begin
   cmdNew.Hint := 'New Household';
   edtSearch.Enabled := true;
   cboSearchSort.Items.Add('EntityDescription');
   cboSearchSort.Enabled := false;
   end
else
If tabPanel.TabIndex = 1 then
   begin
   cmdNew.Hint := 'New Patient - Same Household as selected Patient';
   edtSearch.Enabled := true;
   cboSearchSort.Items.Add('EntityLastName');
   cboSearchSort.Items.Add('EntityFirstName');
   cboSearchSort.Items.Add('EntityDescription');
   cboSearchSort.Items.Add('Entity');
   cboSearchSort.Enabled := true;
   end
else
If tabPanel.TabIndex = 2 then
   begin
   cmdNew.Hint := 'New Staff';
   edtSearch.Enabled := false;
   cmdSearchClick(Self);
   end
else
If tabPanel.TabIndex = 3 then
   begin
   cmdNew.Hint := 'New Room';
   edtSearch.Enabled := false;
   cmdSearchClick(Self);
   end
else
If tabPanel.TabIndex = 4 then
   begin
   cmdNew.Hint := 'New Equipment';
   edtSearch.Enabled := false;
   cmdSearchClick(Self);
   end
{else
If tabPanel.TabIndex = 5 then
   begin
   cmdNew.Hint := 'Add Appointment from Patient Window';
   cboSearchSort.Items.Add('ApptTicket');
   end
else
If tabPanel.TabIndex = 6 then
   begin
   cmdNew.Hint := 'Add Survey from Patient Window';
   cboSearchSort.Items.Add('SurveyNumber');
   end         }
else
If tabPanel.TabIndex = 5 then
   begin
   cmdNew.Hint := 'Add Reminder from Patient Window';
   cboSearchSort.Items.Add('ReminderDate');
   cboSearchSort.ItemIndex := 0;
   edtSearch.text := datetostr(date);
   cmdSearchClick(Self);
   end
else
If tabPanel.TabIndex = 6 then
   begin
   cmdNew.Hint := '';
   edtSearch.Enabled := false;
   edtPassword.Visible:= true;
   lbl_10001.Visible:= true;
   lbl_10002.Visible:= true;
   lbl_10002.caption:= '';
   edtPassword.setfocus;
   end;


cboSearchSort.ItemIndex := 0;
CheckToolbarEnable;
{If the user selects a new type of sort, focus the search edit box}
If (edtSearch.enabled = true) and
   (frmMainMenu.visible = true) then
    edtSearch.SetFocus;
end;

{Show the pick list manager as a modal form so no other work can take place
until the utility is complete}
procedure TfrmMainMenu.cmdPickListClick(Sender: TObject);
begin
application.Createform(tfrmPickLists, frmPickLists);
try
frmPickLists.ShowModal;
finally
  frmPickLists.Release;
  frmPickLists:= nil;
  end;
end;

procedure TfrmMainMenu.grdSearchResultsDblClick(Sender: TObject);
var vintHoldNumber: longInt;
begin
{Set the key field that will be used to search the open form array.}
If tabPanel.TabIndex = 5 then
   vintHoldNumber := vqryMainSearch.fieldbyname('ReminderTicket').asinteger
{else
If tabPanel.TabIndex = 6 then
   vintHoldNumber := vqryMainSearch.fieldbyname('SurveyNumber').asinteger
else
If tabPanel.TabIndex = 5 then
   vintHoldNumber := vqryMainSearch.fieldbyname('ApptTicket').asinteger }
else
   vintHoldNumber := vqryMainSearch.fieldbyname('Entity').asinteger;
{See if the Entity or Appt form exists and display}
If FocusForm(vintHoldNumber) then
else
{The instance of the entity does not exists so create it from scratch}
{Create the Household form}
If tabPanel.TabIndex = 0 then
   begin
   vintCurrentEntity := vqryMainSearch.fieldbyname('Entity').asinteger;
   CreateHousehold;
   end
else
{Create the Patient Form}
If tabPanel.TabIndex = 1 then
   begin
   vintCurrentEntity := vqryMainSearch.fieldbyname('Entity').asinteger;
   CreatePatient;
   end
else
{Create the Staff Form}
If tabPanel.TabIndex = 2 then
   begin
   vintCurrentEntity := vqryMainSearch.fieldbyname('Entity').asinteger;
   CreateStaff;
   end
else
{Create the Room Form}
If tabPanel.TabIndex = 3 then
   begin
   vintCurrentEntity := vqryMainSearch.fieldbyname('Entity').asinteger;
   CreateRoom;
   end
else
{Create the Room Form}
If tabPanel.TabIndex = 4 then
   begin
   vintCurrentEntity := vqryMainSearch.fieldbyname('Entity').asinteger;
   CreateEquipment;
   end
{else
If tabPanel.TabIndex = 5 then
   begin
   vintCurrentApptTicket := vqryMainSearch.fieldbyname('ApptTicket').asinteger;
   vintCurrentEntity := vqryMainSearch.fieldbyname('Entity').asinteger;
   CreateAppointment;
   end
else
If tabPanel.TabIndex = 6 then
   begin
   vintCurrentSurvey := vqryMainSearch.fieldbyname('SurveyNumber').asinteger;
   vstrCurrentSurveyID := vqryMainSearch.fieldbyname('SurveyID').asstring;
   vdatCurrentSurveyEdition := vqryMainSearch.fieldbyname
                                                  ('SurveyEdition').asdatetime;
   CreateSurvey;
   end     }
else
{Create the Reminder Form}
If tabPanel.TabIndex = 5 then
   begin
   vintCurrentReminder :=
                         vqryMainSearch.fieldbyname('ReminderTicket').asinteger;
   CreateReminder;
   end;
vintCurrentEntity := 0;
vintCurrentApptTicket := 0;
vintCurrentSurvey := 0;
vintCurrentReminder := 0;
end;

{Create the single allowable copy of the scheduler as non-modal form}
procedure TfrmMainMenu.CreateScheduler;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := cintScheduler;
   varrCreatedForms[vintFormLocation] := TfrmScheduler.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

{Create the single allowable copy of the scheduler as non-modal form}
procedure TfrmMainMenu.CreateInsurance;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := cintEntityInsCompany;
   varrCreatedForms[vintFormLocation] := TfrmInsurance.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

{Create the single allowable copy of the scheduler as non-modal form}
procedure TfrmMainMenu.CreateClinicReports;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := cintClinicReports;
   varrCreatedForms[vintFormLocation] := TfrmClinicReports.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.CreateCompanyBilling;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := cintCompanyBilling;
   varrCreatedForms[vintFormLocation] := TfrmCompanyBilling.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

{Create the entity copy of the finance as non-modal form}
procedure TfrmMainMenu.CreateFinance;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentEntity;
   vintCurrentEntity:= vintCurrentEntity - cintFinance;
//   varrCreatedForms[vintFormLocation] := TfrmAccounting.Create(nil);
   varrCreatedForms[vintFormLocation] := TfrmFinanceSummary.Create(nil);
   TfrmFinanceSummary(varrCreatedForms[vintFormLocation]).vintCurrentPatient :=
                                 vintCurrentEntity;
{   TfrmFinanceSummary(varrCreatedForms[vintFormLocation]).vintCurrentHousehold:=
                        vqryMainSearch.fieldbyname('EntityHousehold').asinteger;}
   varrCreatedForms[vintFormLocation].Show;
end;

{Create the entity copy of the finance as non-modal form}
procedure TfrmMainMenu.CreatePatSummary;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentEntity;
   vintCurrentEntity:= vintCurrentEntity - cintPatSummary;
   varrCreatedForms[vintFormLocation] := TfrmPatientHistory.Create(nil);
   TfrmPatientHistory(varrCreatedForms[vintFormLocation]).vintCurrentPatient :=
                                 vintCurrentEntity;
   varrCreatedForms[vintFormLocation].Show;
end;

{Create the single allowable copy of the query window as non-modal form}
procedure TfrmMainMenu.CreateQuery;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := cintQuery;
   varrCreatedForms[vintFormLocation] := TfrmQuery.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

{Shared routines between the grid double click and the activate event for
calling forms for other screens}
procedure TfrmMainMenu.CreateHouseHold;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentEntity;
   varrCreatedForms[vintFormLocation] := TfrmHousehold.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.CreatePatient;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentEntity;
   varrCreatedForms[vintFormLocation] := TfrmPatient.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.CreateStaff;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentEntity;
   varrCreatedForms[vintFormLocation] := TfrmStaff.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.CreateRoom;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentEntity;
   varrCreatedForms[vintFormLocation] := TfrmFacility.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.CreateEquipment;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentEntity;
   varrCreatedForms[vintFormLocation] := TfrmEquipment.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.CreateAppointment;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentApptTicket;
   varrCreatedForms[vintFormLocation] := TfrmAppointment.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.CreateReminder;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentReminder;
   varrCreatedForms[vintFormLocation] := TfrmReminder.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.CreateSurvey;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := vintCurrentSurvey;
   varrCreatedForms[vintFormLocation] := TfrmSurvey.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

{Enter key in the search text box will trigger the query}
procedure TfrmMainMenu.edtSearchKeyPress(Sender: TObject; var Key: Char);
begin
{#13 is the enter keystroke}
If key = #13 then
   begin
   {Do the query and nullify the keystroke}
   cmdSearchClick(Self);
   Key := #00;
   end;
end;

{Allow the user to see all windows that are current open in a summary format}
procedure TfrmMainMenu.cmdWindowsOpenClick(Sender: TObject);
var vintLoop, vintLoop2: Integer;
begin
{Modify the visible items to show the string grid}
tabPanel.visible := false;
grdSearchResults.visible := false;
stgWindowsOpen.visible := true;
{Clear the string grid}
For vintLoop := 1 to cintMaxForms do
  begin
  stgWindowsOpen.Cells[0,vintLoop] := '';
  stgWindowsOpen.Cells[1,vintLoop] := '';
  end;
vintLoop2 := 1;
{Set the headings}
stgWindowsOpen.Cells[0,0] := 'Open Windows';
stgWindowsOpen.Cells[1,0] := 'Entity #';
{Loop through all forms to build the string grid of all open windows}
For vintLoop := 1 to cintMaxForms do
  begin
  If varrCreatedFormsEntity[vintLoop] > 0 then
     begin
     stgWindowsOpen.Cells[0,vintLoop2] :=
                                      tform(varrCreatedForms[vintLoop]).caption;
     stgWindowsOpen.Cells[1,vintLoop2] :=
         format('%6d', [varrCreatedFormsEntity[vintLoop]]);
     inc(vintLoop2);
     end;
  end;
CheckToolbarEnable;
end;

{Show the Search View tabs}
procedure TfrmMainMenu.cmdSearchViewClick(Sender: TObject);
begin
tabPanel.visible := true;
{Hide the answer grid if there are no matches}
If not vqryMainSearch.active then
   grdSearchResults.Visible := false
else
If vqryMainSearch.RecordCount = 0 then
   grdSearchResults.Visible := false
else
   grdSearchResults.Visible := true;
stgWindowsOpen.visible := false;
CheckToolbarEnable;
end;

{Enable and disable toolbar buttons based on the state of the MainMenu}
procedure TfrmMainMenu.CheckToolbarEnable;
var vintLoop: integer;
begin
{Appointments are only available from the patient tab, otherwise new active?}
cmdNew.Enabled := true;
If (not tabPanel.Visible) then
   cmdNew.Enabled := false;
{Appointments, surveys and reminders are not added here}
If (tabPanel.TabIndex = 5) or
   (tabPanel.TabIndex = 6) or
   (tabPanel.TabIndex = 7) then
     cmdNew.Enabled := false
else
{Patients must have search results in order to add new patients}
If tabPanel.TabIndex = 1 then
  If not vqryMainSearch.Active then
     cmdNew.Enabled := false
  else
  If vqryMainSearch.recordCount = 0 then
     cmdNew.Enabled := false;

cmdQuickAppt.enabled := false;
If tabPanel.TabIndex = 1 then
  If vqryMainSearch.Active then
     If vqryMainSearch.recordCount > 0 then
        cmdQuickAppt.Enabled := true;

cmdAccounting.enabled := false;
If tabPanel.TabIndex = 1 then
  If vqryMainSearch.Active then
     If vqryMainSearch.recordCount > 0 then
        cmdAccounting.Enabled := true;

{See if there are any open windows created by the MainMenu}
cmdCloseAll.Enabled := false;
cmdWindowsOpen.Enabled := false;
For vintLoop := 1 to cintMaxForms do
  If varrCreatedFormsEntity[vintLoop] <> 0 then
    begin
    cmdWindowsOpen.Enabled := true;
    cmdCloseAll.Enabled := true;
    break;
    end;
end;

Procedure TfrmMainMenu.CheckButtonEvent;
begin
{If the last form was just cleaned up, make sure the search view is showing}
If cmdWindowsOpen.Down then
   If not cmdWindowsOpen.Enabled then
      begin
      cmdSearchView.Down := true;
      cmdSearchViewClick(Self);
      end
   else
      cmdWindowsOpenClick(Self);
end;

procedure TfrmMainMenu.FormActivate(Sender: TObject);
begin
CheckToolbarEnable;
CheckButtonEvent;

If tabpanel.Visible then
  begin
  If edtSearch.enabled then
      Self.ActiveControl := edtSearch;
  If length(edtSearch.text) > 0 then
      cmdSearchClick(Sender);
  end;
end;

{Use this public event as a way for client forms to tell the main form to
open a new form...}
procedure TfrmMainMenu.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
If Sender = Self then
else
{For true, forms are being freed and the main menu button events should trigger}
If vbolRefreshOnly = true then
   begin
   CheckToolbarEnable;
   CheckButtonEvent;
   end
else
{Bring up the schedule from one of the subsystem forms}
If vbolSchedulerDisplay then
  cmdSchedulerClick(self)
else
   {Forms are being requested by the sub-system.  The main menu activates them}
   CreateSubsystemForm;
{Default setting for the routine}
vbolRefreshOnly := false;
vbolSchedulerDisplay:= false;
end;

{Other forms may be activating this one in order to bring up another instance
 of a form.  If so, we want to activate the form and then send to back.
 At the end of the Constructor in each of these forms, the vintCurrent switches
 all need to be set back to 0 or the form will continue to 'bounce' on the
 screen}
procedure TfrmMainMenu.CreateSubsystemForm;
begin
{A reminder form is ready to be displayed if there is a number in the shared
variables.}
If vintCurrentReminder > 0 then
    begin
    If FocusForm(vintCurrentReminder) then
    else
       CreateReminder;
    end
else
{A survey is ready to go...}
If vintCurrentSurvey > 0 then
    begin
    If FocusForm(vintCurrentSurvey) then
    else
       CreateSurvey;
    end
else
{An Appointment is ready to display}
If vintCurrentApptTicket > 0 then
    begin
    If FocusForm(vintCurrentApptTicket) then
    else
       CreateAppointment;
    end
else
{All other forms are based on entity.  Start with patient}
If (vintCurrentEntity > 200000) and (vintCurrentEntity < 300000) then
    begin
    If FocusForm(vintCurrentEntity) then
    else
       CreatePatient;
    end
else
{All other forms are based on entity.  This is Household}
If (vintCurrentEntity > 100000) and (vintCurrentEntity < 200000) then
    begin
    If FocusForm(vintCurrentEntity) then
    else
       CreateHousehold;
    end
else
{All other forms are based on entity.  This is Household}
If (vintCurrentEntity > 300000) and (vintCurrentEntity < 400000) then
    begin
    If FocusForm(vintCurrentEntity) then
    else
       CreateStaff;
    end
else
{All other forms are based on entity.  This is Facility Room}
If (vintCurrentEntity > 800000) and (vintCurrentEntity < 900000) then
    begin
    If FocusForm(vintCurrentEntity) then
    else
       CreateRoom;
    end
else
{All other forms are based on entity.  This is Equipment}
If (vintCurrentEntity > 900000) and (vintCurrentEntity < 1000000) then
    begin
    If FocusForm(vintCurrentEntity) then
    else
       CreateEquipment;
    end
else
{All other forms are based on entity.  This is Fanance screen (patient+6000000}
If (vintCurrentEntity > 6200000) and (vintCurrentEntity < 6300000) then
    begin
    If FocusForm(vintCurrentEntity) then
    else
       CreateFinance;
    end
else
{All other forms are based on entity.  This is Finance screen (patient+7000000}
If (vintCurrentEntity > 7200000) and (vintCurrentEntity < 7300000) then
    begin
    If FocusForm(vintCurrentEntity) then
    else
       CreatePatSummary;
    end;
vintCurrentEntity := 0;
vintCurrentApptTicket := 0;
vintCurrentSurvey := 0;
vintCurrentReminder := 0;
end;

{Return a Window to the Active front based on the grid selection}
procedure TfrmMainMenu.stgWindowsOpenDblClick(Sender: TObject);
begin
If length(stgWindowsOpen.cells[1, stgWindowsOpen.Row]) > 1 then
   FocusForm(strtoint(stgWindowsOpen.cells[1, stgWindowsOpen.Row]));
end;

{Control all database additions from this spot}
procedure TfrmMainMenu.cmdNewClick(Sender: TObject);
begin
{This switch is set to force the new screen to go to Auto-edit mode}
vbolNewItem := true;
{The active tab determines the type of Entity being created}
If tabPanel.TabIndex = 0 then
  begin
  {Tab 0 is the Household}
  vintCurrentEntity := NewRecord(cintEntityHousehold,
                                 0, '', 0);
  If vintCurrentEntity > 0 then
      CreateHousehold;
  end
else
If tabPanel.TabIndex = 1 then
  begin
  {Tab 1 is the patient - The household entity is passed to the new record
  routine in order to set up the Patient within the current household}
  vintCurrentEntity := NewRecord(cintEntityPatient,
                vqryMainSearch.fieldbyname('EntityHousehold').asinteger,
                '', 0);
  If vintCurrentEntity > 0 then
     CreatePatient;
  end
else
If tabPanel.TabIndex = 2 then
  begin
  {Tab 2 is the staff}
  vintCurrentEntity := NewRecord(cintEntityStaff, 0, '', 0);
  If vintCurrentEntity > 0 then
      CreateStaff;
  end
else
If tabPanel.TabIndex = 3 then
  begin
  {Tab 3 is the Room}
  vintCurrentEntity := NewRecord(cintEntityRoom, 0, '', 0);
  If vintCurrentEntity > 0 then
      CreateRoom;
  end
else
If tabPanel.TabIndex = 4 then
  begin
  {Tab 4 is the Equipment}
  vintCurrentEntity := NewRecord(cintEntityEquipment, 0, '', 0);
  If vintCurrentEntity > 0 then
      CreateEquipment;
  end;
end;

procedure TfrmMainMenu.cmdClinicReportsClick(Sender: TObject);
begin
  If FocusForm(cintClinicReports) then
  else
     CreateClinicReports;
end;

procedure TfrmMainMenu.cmdSurveyBuilderClick(Sender: TObject);
begin
application.Createform(tfrmNewSurveyRule, frmNewSurveyRule);
try
frmNewSurveyRule.ShowModal;
finally
  If frmNewSurveyRule <> nil then
     frmNewSurveyRule.release;
  frmNewSurveyRule := nil;
  end;
{The user chose not to create a survey. Exit before the Survey Rule screen is
called}
If vstrCurrentSurveyID = '' then
   exit;
application.Createform(tfrmSurveyCreate, frmSurveyCreate);
try
frmSurveyCreate.ShowModal;
finally
  If frmSurveyCreate <> nil then
     frmSurveyCreate.release;
  frmSurveyCreate := nil;
  end;
end;

procedure TfrmMainMenu.cmdSchedulerClick(Sender: TObject);
begin
  If FocusForm(cintScheduler) then
  else
     CreateScheduler;
end;

procedure TfrmMainMenu.cmdQueryClick(Sender: TObject);
begin
  If FocusForm(cintQuery) then
  else
     CreateQuery;
end;

procedure TfrmMainMenu.cmdSpecialClick(Sender: TObject);
begin
application.Createform(tfrmSpecialUtilities, frmSpecialUtilities);
try
frmSpecialUtilities.ShowModal;
finally
  frmSpecialUtilities.Release;
  frmSpecialUtilities:= nil;
  end;
end;

procedure TfrmMainMenu.cmdQuickApptClick(Sender: TObject);
begin
  NewRecord(cintAppointment,
            vqryMainSearch.fieldbyname('Entity').asinteger,
            'Schedule', 0);
  cmdSchedulerClick(self);
end;

procedure TfrmMainMenu.cmdInsuranceClick(Sender: TObject);
begin
  If FocusForm(cintEntityInsCompany) then
  else
     CreateInsurance;
end;

procedure TfrmMainMenu.cmdAccountingClick(Sender: TObject);
begin
  If FocusForm(cintFinance +
                            vqryMainSearch.fieldbyname('Entity').asinteger) then
  else
     begin
     vintCurrentEntity :=
                   cintFinance + vqryMainSearch.fieldbyname('Entity').asinteger;
     CreateFinance;
     end;
end;

procedure TfrmMainMenu.cmdBillingClick(Sender: TObject);
begin
  If FocusForm(cintCompanyBilling) then
  else
     CreateCompanyBilling;
end;

procedure TfrmMainMenu.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
If key = #13 then
  begin
  If uppercase(edtPassword.text) = 'MONEYMHEDS' then
     begin
     vbolFinanceView:= true;
     lbl_10002.caption:= 'Acct - OK';
     end
  else
     vbolFinanceView:= false;
  edtPassword.text:='';
  end;
end;

procedure TfrmMainMenu.cmdCindyClick(Sender: TObject);
begin
  If FocusForm(cintCindySummary) then
  else
     CreateCindySummary;
end;

{Create the single allowable copy of the scheduler as non-modal form}
procedure TfrmMainMenu.CreateCindySummary;
var vintFormLocation: integer;
begin
   vintFormLocation:= FindFormLocation;
   {There is no more memory to display additional forms}
   If vintFormLocation = -1 then
       exit;
   {Otherwise, OK to create an instance}
   varrCreatedFormsEntity[vintFormLocation] := cintCindySummary;
   varrCreatedForms[vintFormLocation] := TfrmCindySummary.Create(nil);
   varrCreatedForms[vintFormLocation].Show;
end;

procedure TfrmMainMenu.cmd30_60_90Click(Sender: TObject);
begin
application.Createform(tfrm30_60_90, frm30_60_90);
try
frm30_60_90.ShowModal;
finally
  frm30_60_90.Release;
  frm30_60_90:= nil;
  end;
end;

Initialization;
  InitializeDatabaseSettings;
end.
