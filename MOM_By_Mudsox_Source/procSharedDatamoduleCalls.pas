unit procSharedDatamoduleCalls;
{Author: Chuck Weindorf
 Description: Provide all intances of the main datamodule with function that
    are required for all SQL components or datasources.
                                                     
 Date: 08/04/1999 - CEW - New
  }

interface                                                  

uses {VCL based uses for maniplulating components}
     Forms, Sysutils, dbtables, db, DBCtrls, dbGrids, ExtCtrls, classes,
     Dialogs, mplayer, controls, BDE, quickrpt, Qrctrls, filectrl, shellAPI,
     {MMoM units required}
     dataMainDatamodule;

{Creating the datamodule and all table/datssource settings all the way back to
the form level}
Procedure InitializeDatabaseSettings;
Procedure InitializeApplicationEvent;
Procedure DatamoduleCreateEvent(var dtmMainLocal: tdtmMain);
Procedure InitializeTablesAndDataSources(var dtmMainLocal: tdtmMain);
Procedure CreateSQLList(var dtmMainLocal: tdtmMain;
                        const carrSQLComponents: array of string);
Procedure AssignDataSources(var vcmpCurrent: TComponent;
                            const dtmMainLocal: tdtmMain);
{Control of the Form Array}
Function FindFormLocation: integer;
Function FocusForm(cintNumber: LongInt):boolean;
Procedure CloseThisEntity(const cintEntity: LongInt);
Procedure CloseAllForms;
{Allow the editing, posting and rollback of entire datesets}
Function EditDataSets(var dtmMainLocal: tdtmMain): boolean;
Function ApplyDataSets(var dtmMainLocal: tdtmMain): boolean;
Function RollBackDataSets(var dtmMainLocal: tdtmMain): boolean;
{Field Calculations}
Function CombineEntityName
                        (const cstrFirst, cstrMiddle, cstrLast: string): string;
Function FindAge(const cdatBirthDay: tdatetime): integer;
Function FindAgeDates(const cdatBirthDay: tdatetime;
                      const cdatCurrentDay: tdatetime): integer;
Function TestInteger(const cstrString: string): integer;
{Other record maintenance routines}
function PostEvent(var vqryQuery: tquery): boolean;
procedure CloneRecords(var vqryQueryOld, vqryQueryNew: tquery;
                     const carrKeys: array of variant);
procedure DeleteAllEntity(const cintEntity: longint);
procedure DeleteAllAppointment(const cintApptTicket: longint);
procedure DeleteAllSurvey(const cintSurvey: longint);
{Search utilities for the main menu}
Procedure PerformSQLStatemtent(const vstlSQl: TstringList);
{Adding new records to the database}
Function NewRecord(const cintEntityType: LongInt;
                   const cintAdditionalEntity: LongInt;
                   const cstrSurveyID: string;
                   const cdatSurveyEdition: tdate): Longint;
{Multimedia}
Procedure PlayMovie(const cstrClipName: string);
function ExtractImagePath(dtmMainLocal: tdtmMain): string;
{PickLists}
function FillPickList(const cstrFieldName: string;
                      vstlPickList: tstrings):LongInt;
function FillDefault(const cstrFieldName: string):string;
function FindEntityName(const cintEntity: integer): string;
{Free and return resources from datamodules or system dynamic components}
Procedure CloseAndFreeFiles(var dtmMainLocal: tdtmMain);
function DeleteFiles(vstrFilePath, vstrMask : String): Boolean;
Procedure SystemShutDown;

 const
  cintMaxForms:           Integer = 20;
  {The trigger to view the scheduler or Query}
  cintScheduler:          LongInt = 0000001;
  cintQuery:              LongInt = 0000002;
  cintClinicReports:      LongInt = 0000003;
  cintCindySummary:       LongInt = 0000004;
  {These constants list the base entity number for each major division
   within the system}
  cintEntityInsCompany:   LongInt = 0010000;
  cintEntityMedCompany:   LongInt = 0020000;
  cintEntityOtherPhys:    LongInt = 0030000;
  cintEntityHouseHold:    LongInt = 0100000;
  cintEntityPatient:      LongInt = 0200000;
  cintEntityPatHistory:   LongInt = 0200001;
  cintEntityStaff:        LongInt = 0300000;
  cintEntityOutside:      LongInt = 0400000;
  cintEntityRoom:         LongInt = 0800000;
  cintEntityEquipment:    LongInt = 0900000;
  {The appointment base count}
  cintAppointment:        LongInt = 1000000;
  {The survey base count}
  cintSurvey:             LongInt = 2000000;
  {The reminder base count}
  cintReminder:           LongInt = 3000000;
  {The invoice base count}
  cintCompanyBilling:     LongInt = 4000000;
  {The pictures base count}
  cintPicture:            LongInt = 5000000;
  {Finance base is 6,000,000, but the real number is Patient + 6,000,000 so
  the Finance screen is unique from Patient screen}
  cintFinance:            LongInt = 6000000;
  {Patient summary base is 7,000,000, but the real number is Patient
  + 7,000,000 so the Patient Summary Finance screen is unique from Patient
  screen}
  cintPatSummary:         LongInt = 7000000;
  {Programs outside of the clinic on the ClinicReports screen}
  cintClinicReport:         LongInt = 8000000;
  {The constants for the tables contained in the main datamodule}
  cstrSQLAddress:         string = 'Address';
  cstrSQLAppointment:     string = 'Appointment';
  cstrSQLApptBilling:     string = 'ApptBilling';
  cstrSQLApptAccount:     string = 'ApptAccount';
  cstrSQL1500Form:        string = '1500Form';
  cstrSQLAppt1500Detail:  string = 'Appt1500Detail';
  cstrSQLEntity:          string = 'Entity';
  cstrSQLEquipment:       string = 'Equipment';
  cstrSQLRoom:            string = 'Room';
  cstrSQLEntityHouseHold: string = 'EntityHousehold';
  cstrSQLHousehold:       string = 'Household';
  cstrSQLImmunization:    string = 'Immunization';
  cstrSQLInsurance:       string = 'Insurance';
  cstrSQLInterpret:       string = 'Interpret';
  cstrSQLLabWork:         string = 'LabWork';
  cstrSQLMedication:      string = 'Medication';
  cstrSQLMedCompany:      string = 'MedicalCompany';
  cstrSQLOutsideResource: string = 'OutsideResource';
  cstrSQLOtherPhys:       string = 'OtherPhysician';
  cstrSQLPatient:         string = 'Patient';
  cstrSQLPatientChronic:  string = 'PatientChronic';
  cstrSQLPhoneNumber:     string = 'PhoneNumber';
  cstrSQLPicture:         string = 'Picture';
  cstrSQLProgram:         string = 'Program';
  cstrSQLReferral:        string = 'Referral';
  cstrSQLReminder:        string = 'Reminder';
  cstrSQLScheduleEntity:  string = 'ScheduleEntity';
  cstrSQLStaff:           string = 'Staff';
  cstrSQLSurvey:          string = 'Survey';
  cstrSQLSurveyAnswer:    string = 'SurveyAnswer';
  cstrSQLSurveyRule:      string = 'SurveyRule';
  cstrSQLSurveyQuestion:  string = 'SurveyQuestion';
  //cstrSQLUnScheduled:     string = 'UnScheduled';
 {Public level variables that can be set by routines outside of this unit.}
 var
  {The count of datamodules created for the duration of the session}
  vintDatamoduleCount: integer = 0;
  {The integer switches to maintain the next item to be displayed}
  vintDatamoduleInstance,
      vintCurrentEntity,
      vintCurrentSurvey,
      vintCurrentReminder,
      vintCurrentApptTicket: LongInt;
  vdatCurrentSurveyEdition{, vdatScheduleDate, vdatLastDate}: tdatetime;
  vstrApplicationDirectory,
      vstrLocalApplicationDirectory,
      vstrCurrentSurveyID: string;
  vbolRefreshOnly, vbolNewItem, vbolSchedulerDisplay: boolean;
{-----All main menu variables that must be cleaned up at system shutdown-----}
  vqryPickList, vqryMainSearch, vqryEntity: tquery;
  vdtsMainSearch: tdatasource;
  vmedMovie: TMediaPlayer;
    {This is the fake parent for all multimedia displays to allow the central
    display of media clips}
  vfrmMediaHolder: tForm;
  {Hold the main menu as a reference here to allow other forms to control the
   display of the menu}
  vfrmMainMenu: tForm;
  //Hold all instances of created forms to allow the navigator to control all
  // currently active forms.  The number in the array must be larger than the
  // cintMaxForms number constant above!
  varrCreatedForms: array [1..20] of tFORM;
  varrCreatedFormsEntity: array [1..20] of LongInt;
  //Hold one datamodule version for use by Quickreport creation events
  vdtmQuickReport: tdtmMain;
  //Same for a tQuery - placeholders for generic reports.
  vqryQuickReport: tQuery;
  vqryQuickReport2: tQuery;
  {password access to finance}
  vbolFinanceView: boolean;                                     


implementation

{First, take care of all BDE items - such as Alias, App Directory,
Net Directory}
Procedure InitializeDatabaseSettings;
var
  vstlAlias:  TStringList;
  vstlParams: TStringList;
begin
{Prepare the BDE at start-up to save time later in the screen creation and
datamodule initial query.}
bde.DbiInit(nil);
{Stringlists hold all alias info}
vstlAlias := tstringlist.create;
vstlParams := tstringlist.create;
try
{Focus the session on Alias Information only...}
Session.GetAliasNames(vstlAlias);
{There is no MMOM alias in the BDE configuration, set the C: as the default}
If vstlAlias.IndexOf('mmom') = -1 then
    begin
    vstrApplicationDirectory := 'C:\MMOM\';
    Session.ConfigMode := cmSession;
    Session.AddStandardAlias('mmom',
                              vstrApplicationDirectory,
                              'PARADOX');
    Session.ConfigMode := cmAll;
    end
else
{There is an MMOM entry - use the directory as the AppDir}
    begin
    Session.GetAliasParams('mmom', vstlParams);
    vstrApplicationDirectory := vstlParams.Values['PATH'];
    {If the manual overide alias does not end in a slash, add it}
    If copy(vstrApplicationDirectory,
                                length(vstrApplicationDirectory), 1) <> '\' then
        vstrApplicationDirectory := vstrApplicationDirectory + '\';
    end;
{Set up the other aliases required by the datamodule and procedures to access
server files}
Session.ConfigMode := cmSession;
Session.AddStandardAlias('mmom_maindatabase',
                          vstrApplicationDirectory + 'maindatabase',
                         'PARADOX');
Session.AddStandardAlias('mmom_reference',
                          vstrApplicationDirectory + 'reference',
                         'PARADOX');
Session.ConfigMode := cmAll;
{There is no MMOMlocal alias in the BDE configuration,
     set the C: as the default}
If vstlAlias.IndexOf('mmom_Local') = -1 then
    begin
    vstrLocalApplicationDirectory := 'C:\MMOM_Temp\';
    Session.ConfigMode := cmSession;
    Session.AddStandardAlias('mmom_local',
                              vstrLocalApplicationDirectory,
                              'PARADOX');
    Session.ConfigMode := cmAll;
    end
else
{There is an MMOM_local entry - use the directory as the LocalAppDir}
    begin
    Session.GetAliasParams('mmom_Local', vstlParams);
    vstrLocalApplicationDirectory := vstlParams.Values['PATH'];
    {If the manual overide alias does not end in a slash, add it}
    If copy(vstrLocalApplicationDirectory,
                           length(vstrLocalApplicationDirectory), 1) <> '\' then
        vstrLocalApplicationDirectory := vstrLocalApplicationDirectory + '\';
    end;
{Make sure the local directory exists}
ForceDirectories(vstrLocalApplicationDirectory);
{Allow the session to view all items since our Alias work is complete}
{Set the network locking file to the AppDir}
Session.NetFileDir := vstrApplicationDirectory;
Session.PrivateDir := vstrLocalApplicationDirectory;
{Free the stringlists that were used in Alias routines}
finally
  vstlAlias.free;
  vstlParams.free;
  end;
end;

{On system start-up, initialize certain work areas to utilize features
system-wide}
Procedure InitializeApplicationEvent;
  var vintLoop: integer;
begin
{---------------------------------------------------}
{System start-up - Initialize the forms array to nil and entity to 0}
For vintLoop := 1 to cintMaxForms do
  begin
  varrCreatedForms[vintLoop] := nil;
  varrCreatedFormsEntity[vintLoop] := 0;
  end;
{First time through, create the tQuery}
If vqryMainSearch = nil then
   begin
   vqryMainSearch := tQuery.Create(nil);
   vqryMainSearch.databasename := 'mmom_MainDatabase';
   vqryMainSearch.UniDirectional := true;
   vqryMainSearch.RequestLive := false;
   end;
{First time through, create the tdatasource}
If vdtsMainSearch = nil then
   begin
   vdtsMainSearch := tDatasource.Create(nil);
   vdtsMainSearch.Name := 'dtsMainSearch';
   vdtsMainSearch.AutoEdit := false;
   vdtsMainSearch.DataSet := vqryMainSearch;
   end;
{One instance of Entity is used for a variety of needs, such as filling
pick lists, etc}
If vqryEntity = nil then
   begin
   vqryEntity := tQuery.Create(nil);
   vqryEntity.databasename := 'mmom_MainDatabase';
   vqryEntity.UniDirectional := true;
   vqryEntity.RequestLive := false;
   end;
{Switch used to communicate with the menu form}
vbolRefreshOnly := false;
vbolSchedulerDisplay:= false;
{security default}
vbolFinanceView:= false;
{Force the system to display 4 digit years}
ShortDateFormat := 'MM/DD/YYYY';
end;

{Upon the creation of the local datamodule, adjust certain settings to keep
 unique context names}
Procedure DatamoduleCreateEvent(var dtmMainLocal: tdtmMain);
//var vstrHoldDirectory: string;
begin
{If we ever use 1 dir per local query and multiple session files}
//  vstrHoldDirectory := vstrLocalApplicationDirectory + 'dtm' +
//                                                inttostr(vintDatamoduleCount);
//  ForceDirectories(vstrHoldDirectory);
  {Assign a unique database name and session name...}
  dtmMainLocal.dbsmain.databasename:= 'dbsMain' + inttostr(vintDatamoduleCount);
  {Connect the database}
  dtmMainLocal.dbsmain.connected := true;
  InitializeTablesAndDataSources(dtmMainLocal);
  {Increase the count for the next datamodule to be created}
  inc(vintDatamoduleCount);
end;

{Based on the needed queries and datasources of the parent form, create the
 list of queries and datasources}
Procedure InitializeTablesAndDataSources(var dtmMainLocal: TdtmMain);
begin
 { If  vintDatamoduleInstance = cintScheduler then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLAppointment,
                     cstrSQLScheduleEntity,
                     cstrSQLUnScheduled]);
      end
  else   }
  If  vintDatamoduleInstance = cintSurvey then
    {Create the datamodule to match the format of the Survey system}
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLSurvey,
                     cstrSQLSurveyAnswer,
                     cstrSQLSurveyRule,
                     cstrSQLSurveyQuestion]);
      end
  else
  If  vintDatamoduleInstance = cintReminder then
    {Create the datamodule to match the format of the Reminder system}
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLReminder]);
      end
  else
    {Create the datamodule to match the format of the Household Form}
  If  vintDatamoduleInstance = cintEntityHouseHold then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntityHousehold,
                     cstrSQLHousehold,
                     cstrSQLEntity,
                     cstrSQLPatient,
                     cstrSQLAddress,
                     cstrSQLPhoneNumber,
                     cstrSQLPicture]);
      end
  else
    {Create the datamodule to match the format of the Patient Form}
  If  vintDatamoduleInstance = cintEntityPatient then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLPatient,
                     cstrSQLPicture,
                     cstrSQLProgram,
//                     cstrSQLAppointment,
                     cstrSQLReferral,
                     cstrSQLSurvey]);
      end
  else
    {Create the datamodule to match the format of the Patient Form}
  If  vintDatamoduleInstance = cintEntityPatHistory then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLPatient,
                     cstrSQLPatientChronic,
                     cstrSQLImmunization,
                     cstrSQLMedication,
                     cstrSQLPicture,
                     cstrSQLProgram,
                     cstrSQLAppointment,
                     cstrSQLLabWork,
                     cstrSQLReminder,
                     cstrSQLReferral,
                     cstrSQLSurvey]);
      end
  else
    {Create the datamodule to match the format of the Staff Form}
  If  vintDatamoduleInstance = cintEntityStaff then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLStaff,
                     cstrSQLAddress,
                     cstrSQLPhoneNumber,
                     cstrSQLPicture]);
      end
  else
    {Create the datamodule to match the format of the OutsideResource Form}
  If  vintDatamoduleInstance = cintEntityOutside then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLOutsideResource,
                     cstrSQLAddress,
                     cstrSQLPhoneNumber,
                     cstrSQLPicture]);
      end
  else
    {Create the datamodule to match the format of the Facility Form}
  If  vintDatamoduleInstance = cintEntityRoom then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLRoom,
                     cstrSQLPicture]);
      end
  else
    {Create the datamodule to match the format of the Equipment Form}
  If  vintDatamoduleInstance = cintEntityEquipment then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLEquipment,
                     cstrSQLPicture]);
      end
  else
    {Create the datamodule to match the format of the Appointment Form}
  If  vintDatamoduleInstance = cintAppointment then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLAppointment,
                     cstrSQLEntity,
                     cstrSQLPatient,
                     cstrSQLImmunization,
                     cstrSQLReferral,
                     cstrSQLPatientChronic,
                     cstrSQLMedication,
                     cstrSQLLabWork,
                     cstrSQL1500Form,
                     cstrSQLAppt1500Detail,
                     cstrSQLApptBilling,
                     cstrSQLApptAccount]);
      end
  else
    {Create the datamodule to match the format of the Finance Summary}
  If  vintDatamoduleInstance = cintFinance then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLPatient,
                     cstrSQLAppointment,
                     cstrSQL1500Form,
                     cstrSQLAppt1500Detail,
                     cstrSQLApptBilling]);
      end
  else
    {Create the datamodule to match the format of the Insurance Company Form}
  If  vintDatamoduleInstance = cintEntityInsCompany then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLInsurance,
                     cstrSQLAddress,
                     cstrSQLPhoneNumber]);
      end
  else
    {Create the datamodule to match the format of the Insurance Company Form}
  If  vintDatamoduleInstance = cintCompanyBilling then
      begin
      CreateSQLList(dtmMainLocal,
                    [cstrSQLEntity,
                     cstrSQLInsurance,
                     cstrSQLAddress]);
      end;
end;

{Process the array to create all queries  Set all SQL code for each of the
queries and include the datalink cascades.}
Procedure CreateSQLList(var dtmMainLocal: tdtmMain;
                        const carrSQLComponents: array of string);
var vintLoop: integer;
  begin
  {The tags assigned to the datasources matches the taog of the components on
  each form so the AssignDataSources function can have an easy way to match
  up the dynamically create dts with the component}
  For vintLoop := 0 to high(carrSQLComponents) do
     begin
     {Handle the Entity query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLEntity then
        begin
        dtmMainLocal.qryEntity := tquery.Create(dtmMainLocal);
        {Allow updates to this table from only certain screens}
        If (vintDatamoduleInstance = cintEntityHouseHold)
           or (vintDatamoduleInstance = cintEntityPatient)
           or (vintDatamoduleInstance = cintEntityStaff)
           or (vintDatamoduleInstance = cintEntityOutside)
           or (vintDatamoduleInstance = cintEntityRoom)
           or (vintDatamoduleInstance = cintEntityEquipment)
           or (vintDatamoduleInstance = cintFinance)
           or (vintDatamoduleInstance = cintEntityInsCompany) then
              begin
              dtmMainLocal.qryEntity.RequestLive:= true;
              dtmMainLocal.qryEntity.CachedUpdates:= true;
              end;
        dtmMainLocal.qryEntity.SQL.Add('Select * from Entity');
        {Household requires a Patient view that includes all entities in
        the household - multiple entites in the view}
        If (vintDatamoduleInstance = cintEntityInsCompany) or
           (vintDatamoduleInstance = cintCompanyBilling) then
           dtmMainLocal.qryEntity.SQL.Add
                                      ('Where Entity > 9999 and Entity < 39999')
        else
        If vintDatamoduleInstance = cintEntityHouseHold then
           dtmMainLocal.qryEntity.SQL.Add('Where EntityHousehold = ' +
                                        inttostr(vintCurrentEntity))
        else
        If vintDatamoduleInstance = cintScheduler then
           begin
           dtmMainLocal.qryEntity.SQL.Add('Where EntityLastName like "~%"');
           dtmMainLocal.qryEntity.SQL.Add('Order By EntityDescription');
           end
        else
        {Link directly to 1 entity number only}
           dtmMainLocal.qryEntity.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsEntity := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryEntity.tag := 11;
        dtmMainLocal.dtsEntity.tag := 11;
        dtmMainLocal.dtsEntity.Autoedit := false;
        dtmMainLocal.dtsEntity.DataSet := dtmMainLocal.qryEntity;
        end
     else
     If carrSQLComponents[vintLoop] = cstrSQLEntityHousehold then
        begin
        dtmMainLocal.qryEntityHousehold := tquery.Create(dtmMainLocal);
        dtmMainLocal.qryEntityHousehold.RequestLive:= true;
        dtmMainLocal.qryEntityHousehold.CachedUpdates:= true;
        dtmMainLocal.qryEntityHousehold.SQL.Add('Select * from Entity');
        dtmMainLocal.qryEntityHousehold.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsEntityHousehold := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryEntityHousehold.tag := 28;
        dtmMainLocal.dtsEntityHousehold.tag := 28;
        dtmMainLocal.dtsEntityHousehold.Autoedit := false;
        dtmMainLocal.dtsEntityHousehold.DataSet :=
                                                dtmMainLocal.qryEntityHousehold;
        end
     else
     {Handle the Patient query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLHousehold then
        begin
        dtmMainLocal.qryHousehold := tquery.Create(dtmMainLocal);
        {Allow updates to this table from only certain screens}
        If (vintDatamoduleInstance = cintEntityHouseHold) then
            begin
            dtmMainLocal.qryHousehold.RequestLive:= true;
            dtmMainLocal.qryHousehold.CachedUpdates:= true;
            end;
        dtmMainLocal.qryHousehold.SQL.Add('Select * from Household');
        dtmMainLocal.qryHousehold.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsHousehold := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.dtsHousehold.tag := 29;
        dtmMainLocal.qryHousehold.tag := 29;
        dtmMainLocal.dtsHousehold.Autoedit := false;
        dtmMainLocal.dtsHousehold.DataSet := dtmMainLocal.qryHousehold;
        end
     else
     {Handle the Patient query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLPatient then
        begin
        dtmMainLocal.qryPatient := tquery.Create(dtmMainLocal);
        {Allow updates to this table from only certain screens}
        If (vintDatamoduleInstance = cintEntityPatient) or
            (vintDatamoduleInstance = cintFinance) or
            (vintDatamoduleInstance = cintAppointment) then
            begin
            dtmMainLocal.qryPatient.RequestLive:= true;
            dtmMainLocal.qryPatient.CachedUpdates:= true;
            end;
        dtmMainLocal.qryPatient.SQL.Add('Select * from Patient');
        dtmMainLocal.qryPatient.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsPatient := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.dtsPatient.tag := 12;
        dtmMainLocal.qryPatient.tag := 12;
        dtmMainLocal.dtsPatient.Autoedit := false;
        dtmMainLocal.dtsPatient.DataSet := dtmMainLocal.qryPatient;
        end
     else
     {Handle the Staff query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLStaff then
        begin
        dtmMainLocal.qryStaff := tquery.Create(dtmMainLocal);
        {Allow updates to this table from only certain screens}
        If (vintDatamoduleInstance = cintEntityStaff) then
            begin
            dtmMainLocal.qryStaff.RequestLive:= true;
            dtmMainLocal.qryStaff.CachedUpdates:= true;
            end;
        dtmMainLocal.qryStaff.SQL.Add('Select * from Staff');
        dtmMainLocal.qryStaff.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsStaff := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryStaff.tag := 13;
        dtmMainLocal.dtsStaff.tag := 13;
        dtmMainLocal.dtsStaff.Autoedit := false;
        dtmMainLocal.dtsStaff.DataSet := dtmMainLocal.qryStaff;
        end
     else
     {Handle the Equipment query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLEquipment then
        begin
        dtmMainLocal.qryEquipment := tquery.Create(dtmMainLocal);
        {Allow updates to this table from only certain screens}
        If (vintDatamoduleInstance = cintEntityEquipment) then
            begin
            dtmMainLocal.qryEquipment.RequestLive:= true;
            dtmMainLocal.qryEquipment.CachedUpdates:= true;
            end;
        dtmMainLocal.qryEquipment.SQL.Add('Select * from Equipment');
        dtmMainLocal.qryEquipment.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsEquipment := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryEquipment.tag := 14;
        dtmMainLocal.dtsEquipment.tag := 14;
        dtmMainLocal.dtsEquipment.Autoedit := false;
        dtmMainLocal.dtsEquipment.DataSet := dtmMainLocal.qryEquipment;
        end
     else
     {Handle the FacilityRoom query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLRoom then
        begin
        dtmMainLocal.qryFacilityRoom := tquery.Create(dtmMainLocal);
        {Allow updates to this table from only certain screens}
        If (vintDatamoduleInstance = cintEntityRoom) then
            begin
            dtmMainLocal.qryFacilityRoom.RequestLive:= true;
            dtmMainLocal.qryFacilityRoom.CachedUpdates:= true;
            end;
        dtmMainLocal.qryFacilityRoom.SQL.Add('Select * from FacilityRoom');
        dtmMainLocal.qryFacilityRoom.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsFacilityRoom := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryFacilityRoom.tag := 15;
        dtmMainLocal.dtsFacilityRoom.tag := 15;
        dtmMainLocal.dtsFacilityRoom.Autoedit := false;
        dtmMainLocal.dtsFacilityRoom.DataSet := dtmMainLocal.qryFacilityRoom;
        end
     else
     {Handle the OutsideResource query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLOutsideResource then
        begin
        dtmMainLocal.qryOutsideResource := tquery.Create(dtmMainLocal);
        {Allow updates to this table from only certain screens}
        If (vintDatamoduleInstance = cintEntityOutside) then
            begin
            dtmMainLocal.qryOutsideResource.RequestLive:= true;
            dtmMainLocal.qryOutsideResource.CachedUpdates:= true;
            end;
        dtmMainLocal.qryOutsideResource.SQL.Add
                                              ('Select * from OutsideResource');
        dtmMainLocal.qryOutsideResource.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        dtmMainLocal.dtsOutsideResource := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryOutsideResource.tag := 16;
        dtmMainLocal.dtsOutsideResource.tag := 16;
        dtmMainLocal.dtsOutsideResource.Autoedit := false;
        dtmMainLocal.dtsOutsideResource.DataSet :=
                                                dtmMainLocal.qryOutsideResource;
        end
     else
     {Handle the insurance query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLInsurance then
        begin
        dtmMainLocal.qryInsurance := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintEntityInsCompany) then
              begin
              dtmMainLocal.qryInsurance.RequestLive:= true;
              dtmMainLocal.qryInsurance.CachedUpdates:= true;
              end;
        dtmMainLocal.qryInsurance.SQL.Add('Select * from Insurance');
        dtmMainLocal.qryInsurance.SQL.Add('Where Entity < 39999');
        dtmMainLocal.dtsInsurance := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryInsurance.tag := 37;
        dtmMainLocal.dtsInsurance.tag := 37;
        dtmMainLocal.dtsInsurance.Autoedit := false;
        dtmMainLocal.dtsInsurance.DataSet := dtmMainLocal.qryInsurance;
        end
     else
     {Handle the Address query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLAddress then
        begin
        dtmMainLocal.qryAddress := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintEntityHouseHold)
           or (vintDatamoduleInstance = cintEntityPatient)
           or (vintDatamoduleInstance = cintEntityStaff)
           or (vintDatamoduleInstance = cintEntityOutside)
           or (vintDatamoduleInstance = cintEntityInsCompany) then
              begin
              dtmMainLocal.qryAddress.RequestLive:= true;
              dtmMainLocal.qryAddress.CachedUpdates:= true;
              end;
        dtmMainLocal.qryAddress.SQL.Add('Select * from Address');
        If (vintDatamoduleInstance = cintEntityInsCompany) or
           (vintDatamoduleInstance = cintCompanyBilling) then
          dtmMainLocal.qryAddress.SQL.Add('Where Entity < 39999')
        else
          dtmMainLocal.qryAddress.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsAddress := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryAddress.tag := 17;
        dtmMainLocal.dtsAddress.tag := 17;
        dtmMainLocal.dtsAddress.Autoedit := false;
        dtmMainLocal.dtsAddress.DataSet := dtmMainLocal.qryAddress;
        end
     else
     {Handle the PhoneNumber query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLPhoneNumber then
        begin
        dtmMainLocal.qryPhoneNumber := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintEntityHouseHold)
           or (vintDatamoduleInstance = cintEntityPatient)
           or (vintDatamoduleInstance = cintEntityStaff)
           or (vintDatamoduleInstance = cintEntityOutside)
           or (vintDatamoduleInstance = cintEntityInsCompany) then
              begin
              dtmMainLocal.qryPhoneNumber.RequestLive:= true;
              dtmMainLocal.qryPhoneNumber.CachedUpdates:= true;
              end;
        dtmMainLocal.qryPhoneNumber.SQL.Add('Select * from PhoneNumber');
        If vintDatamoduleInstance = cintEntityInsCompany then
          dtmMainLocal.qryPhoneNumber.SQL.Add('Where Entity < 39999')
        else
          dtmMainLocal.qryPhoneNumber.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsPhoneNumber := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryPhoneNumber.tag := 18;
        dtmMainLocal.dtsPhoneNumber.tag := 18;
        dtmMainLocal.dtsPhoneNumber.Autoedit := false;
        dtmMainLocal.dtsPhoneNumber.DataSet := dtmMainLocal.qryPhoneNumber;
        end
     else
     {Handle the Referral query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLReferral then
        begin
        dtmMainLocal.qryReferral := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintAppointment) then
              begin
              dtmMainLocal.qryReferral.RequestLive:= true;
              dtmMainLocal.qryReferral.CachedUpdates:= true;
              end;
        dtmMainLocal.qryReferral.SQL.Add('Select * from Referral');
        dtmMainLocal.qryReferral.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        {Add an additional filter if this is an appointment for the Appt ticket}
        If vintDatamoduleInstance = cintAppointment then
             dtmMainLocal.qryReferral.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
        dtmMainLocal.dtsReferral := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryReferral.tag := 34;
        dtmMainLocal.dtsReferral.tag := 34;
        dtmMainLocal.dtsReferral.Autoedit := false;
        dtmMainLocal.dtsReferral.DataSet := dtmMainLocal.qryReferral;
        end
     else
     {Handle the Referral query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLProgram then
        begin
        dtmMainLocal.qryProgram := tquery.Create(dtmMainLocal);
        dtmMainLocal.qryProgram.RequestLive:= true;
        dtmMainLocal.qryProgram.CachedUpdates:= true;
        dtmMainLocal.qryProgram.SQL.Add('Select * from Program');
        dtmMainLocal.qryProgram.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        dtmMainLocal.dtsProgram := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryProgram.tag := 35;
        dtmMainLocal.dtsProgram.tag := 35;
        dtmMainLocal.dtsProgram.Autoedit := false;
        dtmMainLocal.dtsProgram.DataSet := dtmMainLocal.qryProgram;
        end
     else
     {Handle the Chronic illnesses query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLPatientChronic then
        begin
        dtmMainLocal.qryPatientChronic := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintAppointment) then
              begin
              dtmMainLocal.qryPatientChronic.RequestLive:= true;
              dtmMainLocal.qryPatientChronic.CachedUpdates:= true;
              end;
        dtmMainLocal.qryPatientChronic.SQL.Add('Select * from PatientChronic');
        dtmMainLocal.qryPatientChronic.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        {Add an additional filter if this is an appointment for the Appt ticket}
        If vintDatamoduleInstance = cintAppointment then
             dtmMainLocal.qryPatientChronic.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
        dtmMainLocal.dtsPatientChronic := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryPatientChronic.tag := 19;
        dtmMainLocal.dtsPatientChronic.tag := 19;
        dtmMainLocal.dtsPatientChronic.Autoedit := false;
        dtmMainLocal.dtsPatientChronic.DataSet :=
                                                 dtmMainLocal.qryPatientChronic;
        end
     else
     {Handle the Immunization query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLImmunization then
        begin
        dtmMainLocal.qryImmunization := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintAppointment) then
            begin
            dtmMainLocal.qryImmunization.RequestLive:= true;
            dtmMainLocal.qryImmunization.CachedUpdates:= true;
            end;
        dtmMainLocal.qryImmunization.SQL.Add('Select * from Immunization');
        dtmMainLocal.qryImmunization.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        {Add an additional filter if this is an appointment for the Appt ticket}
        If vintDatamoduleInstance = cintAppointment then
             dtmMainLocal.qryImmunization.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
        dtmMainLocal.dtsImmunization := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryImmunization.tag := 20;
        dtmMainLocal.dtsImmunization.tag := 20;
        dtmMainLocal.dtsImmunization.Autoedit := false;
        dtmMainLocal.dtsImmunization.DataSet := dtmMainLocal.qryImmunization;
        end
     else
     {Handle the Medication query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLMedication then
        begin
        dtmMainLocal.qryMedication := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintAppointment) then
            begin
            dtmMainLocal.qryMedication.RequestLive:= true;
            dtmMainLocal.qryMedication.CachedUpdates:= true;
            end;
        dtmMainLocal.qryMedication.SQL.Add('Select * from Medication');
        dtmMainLocal.qryMedication.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        {Add an additional filter if this is an appointment for the Appt ticket}
        If vintDatamoduleInstance = cintAppointment then
             dtmMainLocal.qryMedication.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
        dtmMainLocal.dtsMedication := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryMedication.tag := 21;
        dtmMainLocal.dtsMedication.tag := 21;
        dtmMainLocal.dtsMedication.Autoedit := false;
        dtmMainLocal.dtsMedication.DataSet := dtmMainLocal.qryMedication;
        end
     else
     {Handle the Labwork query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLLabwork then
        begin
        dtmMainLocal.qryLabwork := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintAppointment) then
            begin
            dtmMainLocal.qryLabwork.RequestLive:= true;
            dtmMainLocal.qryLabwork.CachedUpdates:= true;
            end;
        dtmMainLocal.qryLabwork.SQL.Add('Select * from Labwork');
        dtmMainLocal.qryLabwork.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        {Add an additional filter if this is an appointment for the Appt ticket}
        If vintDatamoduleInstance = cintAppointment then
             dtmMainLocal.qryLabwork.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
        dtmMainLocal.dtsLabwork := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryLabwork.tag := 30;
        dtmMainLocal.dtsLabwork.tag := 30;
        dtmMainLocal.dtsLabwork.Autoedit := false;
        dtmMainLocal.dtsLabwork.DataSet := dtmMainLocal.qryLabwork;
        end
     else
     {Handle the Picture query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLPicture then
        begin
        dtmMainLocal.qryPicture := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintEntityHouseHold)
           or (vintDatamoduleInstance = cintEntityPatient)
           or (vintDatamoduleInstance = cintEntityStaff)
           or (vintDatamoduleInstance = cintEntityOutside)
           or (vintDatamoduleInstance = cintEntityRoom)
           or (vintDatamoduleInstance = cintEntityEquipment) then
              begin
              dtmMainLocal.qryPicture.RequestLive:= true;
              dtmMainLocal.qryPicture.CachedUpdates:= true;
              end;
        dtmMainLocal.qryPicture.SQL.Add('Select * from Picture');
        dtmMainLocal.qryPicture.SQL.Add('Where Entity = ' +
                                        inttostr(vintCurrentEntity));
        dtmMainLocal.dtsPicture := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryPicture.tag := 22;
        dtmMainLocal.dtsPicture.tag := 22;
        dtmMainLocal.dtsPicture.Autoedit := false;
        dtmMainLocal.dtsPicture.DataSet := dtmMainLocal.qryPicture;
        end
     else
     {Handle the Appointment query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLAppointment then
        begin
        dtmMainLocal.qryAppointment := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintAppointment) or
//           (vintDatamoduleInstance = cintFinance) or
           (vintDatamoduleInstance = cintScheduler) then
            begin
            dtmMainLocal.qryAppointment.RequestLive:= true;
            dtmMainLocal.qryAppointment.CachedUpdates:= true;
            end;
        {Add an additional filter if this is an appointment for the Appt ticket}
        If vintDatamoduleInstance = cintAppointment then
            begin
            dtmMainLocal.qryAppointment.SQL.Add('Select * from Appointment');
            dtmMainLocal.qryAppointment.SQL.Add('Where ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
            end
        else
        {Scheduler looks at today's appointments as a default}
{        If vintDatamoduleInstance = cintScheduler then
            begin
            dtmMainLocal.qryAppointment.SQL.Add
            ('Select *');
            dtmMainLocal.qryAppointment.SQL.Add
            ('from Appointment');
            dtmMainLocal.qryAppointment.SQL.Add
              ('Where CAST(ApptDateTime AS DATE) = "' + datetostr(date) + '"');
            vdatScheduleDate:= date;
            vdatLastDate:= vdatScheduleDate;
            dtmMainLocal.qryAppointment.SQL.Add
                            ('and ApptScheduled = true');
            end
        else     }
            begin
            {This code pulls up all appointments for an entity}
            dtmMainLocal.qryAppointment.SQL.Add('Select * from Appointment '
                             + 'Where Entity = ' + inttostr(vintCurrentEntity));
            end;
        dtmMainLocal.dtsAppointment := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryAppointment.tag := 25;
        dtmMainLocal.dtsAppointment.tag := 25;
        dtmMainLocal.dtsAppointment.Autoedit := false;
        dtmMainLocal.dtsAppointment.DataSet := dtmMainLocal.qryAppointment;
        end
     else
     {Handle the view of the UnScheduled Appt query and datasource}
{     If carrSQLComponents[vintLoop] = cstrSQLUnScheduled then
        begin
        dtmMainLocal.qryUnScheduled := tquery.Create(dtmMainLocal);
        dtmMainLocal.qryUnScheduled.RequestLive:= true;
        dtmMainLocal.qryUnScheduled.CachedUpdates:= true;
        dtmMainLocal.qryUnScheduled.SQL.Add
            ('Select ApptTicket, ApptScheduled, ApptSchedulePend, Entity, '
              + 'ApptComplaint, ApptComplaintText, ApptDateTime, ApptDuration');
        dtmMainLocal.qryUnScheduled.SQL.Add
            ('from Appointment');
        dtmMainLocal.qryUnScheduled.SQL.Add
            ('Where ApptSchedulePend = true');
        dtmMainLocal.dtsUnScheduled := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryUnScheduled.tag := 33;
        dtmMainLocal.dtsUnScheduled.tag := 33;
        dtmMainLocal.dtsUnScheduled.Autoedit := false;
        dtmMainLocal.dtsUnScheduled.DataSet := dtmMainLocal.qryUnScheduled;
        end
     else     }
     {Handle the Reminder query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLReminder then
        begin
        dtmMainLocal.qryReminder := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintReminder) then
            begin
            dtmMainLocal.qryReminder.RequestLive:= true;
            dtmMainLocal.qryReminder.CachedUpdates:= true;
            end;
        dtmMainLocal.qryReminder.SQL.Add('Select * from Reminder');
        {Reminder screen}
        If vintDatamoduleInstance = cintReminder then
           dtmMainLocal.qryReminder.SQL.Add('Where ReminderTicket = ' +
                                        inttostr(vintCurrentReminder))
        {Patient screen}
        else
           begin
           dtmMainLocal.qryReminder.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
           dtmMainLocal.qryReminder.SQL.Add('Order By ReminderActive desc, ' +
                                            'ReminderDate desc, ' +
                                            'ReminderCategory asc');
           end;
        dtmMainLocal.dtsReminder := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryReminder.tag := 31;
        dtmMainLocal.dtsReminder.tag := 31;
        dtmMainLocal.dtsReminder.Autoedit := false;
        dtmMainLocal.dtsReminder.DataSet := dtmMainLocal.qryReminder;
        end
     else
     {Handle the Survey query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLSurvey then
        begin
        dtmMainLocal.qrySurvey := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintSurvey) then
            begin
            dtmMainLocal.qrySurvey.RequestLive:= true;
            dtmMainLocal.qrySurvey.CachedUpdates:= true;
            end;
        dtmMainLocal.qrySurvey.SQL.Add('Select * from Survey');
        {Query for the survey screen}
        If (vintDatamoduleInstance = cintSurvey) then
           dtmMainLocal.qrySurvey.SQL.Add('Where SurveyNumber = ' +
                                                   inttostr(vintCurrentSurvey))
        {Query for the Patient Screen}
        else
           dtmMainLocal.qrySurvey.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        dtmMainLocal.dtsSurvey := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qrySurvey.tag := 23;
        dtmMainLocal.dtsSurvey.tag := 23;
        dtmMainLocal.dtsSurvey.Autoedit := false;
        dtmMainLocal.dtsSurvey.DataSet := dtmMainLocal.qrySurvey;
        end
     else
     {Handle the SurveyAnswer query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLSurveyAnswer then
        begin
        dtmMainLocal.qrySurveyAnswer := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintSurvey) then
            begin
            dtmMainLocal.qrySurveyAnswer.RequestLive:= true;
            dtmMainLocal.qrySurveyAnswer.CachedUpdates:= true;
            end;
        dtmMainLocal.qrySurveyAnswer.SQL.Add('Select * from SurveyAnswer');
        dtmMainLocal.qrySurveyAnswer.SQL.Add('Where SurveyNumber = ' +
                                        inttostr(vintCurrentSurvey));
        dtmMainLocal.dtsSurveyAnswer := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qrySurveyAnswer.tag := 24;
        dtmMainLocal.dtsSurveyAnswer.tag := 24;
        dtmMainLocal.dtsSurveyAnswer.Autoedit := false;
        dtmMainLocal.dtsSurveyAnswer.DataSet := dtmMainLocal.qrySurveyAnswer;
        end
     else
     {Handle the SurveyRule query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLSurveyRule then
        begin
        dtmMainLocal.qrySurveyRule := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintSurvey) then
            begin
            dtmMainLocal.qrySurveyRule.RequestLive:= true;
            dtmMainLocal.qrySurveyRule.CachedUpdates:= true;
            end;
        dtmMainLocal.qrySurveyRule.SQL.Add('Select * from SurveyRule');
        dtmMainLocal.qrySurveyRule.SQL.Add('Where SurveyID = "' +
                                                     vstrCurrentSurveyID + '"');
        dtmMainLocal.qrySurveyRule.SQL.Add('and SurveyEdition = "' +
                                     datetostr(vdatCurrentSurveyEdition) + '"');
        dtmMainLocal.dtsSurveyRule := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qrySurveyRule.tag := 26;
        dtmMainLocal.dtsSurveyRule.tag := 26;
        dtmMainLocal.dtsSurveyRule.Autoedit := false;
        dtmMainLocal.dtsSurveyRule.DataSet := dtmMainLocal.qrySurveyRule;
        end
     else
     {Handle the Survey query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLSurveyQuestion then
        begin
        dtmMainLocal.qrySurveyQuestion := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        If (vintDatamoduleInstance = cintSurvey) then
            begin
            dtmMainLocal.qrySurveyQuestion.RequestLive:= true;
            dtmMainLocal.qrySurveyQuestion.CachedUpdates:= true;
            end;
        dtmMainLocal.qrySurveyQuestion.SQL.Add('Select * from SurveyQuestion');
        dtmMainLocal.qrySurveyQuestion.SQL.Add('Where SurveyID = "' +
                                                     vstrCurrentSurveyID + '"');
        dtmMainLocal.qrySurveyQuestion.SQL.Add('and SurveyEdition = "' +
                                     datetostr(vdatCurrentSurveyEdition) + '"');
        dtmMainLocal.dtsSurveyQuestion := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qrySurveyQuestion.tag := 27;
        dtmMainLocal.dtsSurveyQuestion.tag := 27;
        dtmMainLocal.dtsSurveyQuestion.Autoedit := false;
        dtmMainLocal.dtsSurveyQuestion.DataSet :=
                                                 dtmMainLocal.qrySurveyQuestion;
        end
     else
     {Handle the Schedule query and datasource}
    { If carrSQLComponents[vintLoop] = cstrSQLScheduleEntity then
        begin
        dtmMainLocal.qryScheduleEntity := tquery.Create(dtmMainLocal);
        dtmMainLocal.qryScheduleEntity.RequestLive:= true;
        dtmMainLocal.qryScheduleEntity.CachedUpdates:= true;
        dtmMainLocal.qryScheduleEntity.ParamCheck:= true;
        dtmMainLocal.qryScheduleEntity.Datasource:= dtmMainLocal.dtsAppointment;
        dtmMainLocal.qryScheduleEntity.SQL.Add('Select * from ScheduleEntity');
        dtmMainLocal.qryScheduleEntity.SQL.Add
                                             ('Where ApptTicket = :ApptTicket');
        dtmMainLocal.qryScheduleEntity.tag := 32;
        end
     else  }
     {Handle the 1500 query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQL1500Form then
        begin
        dtmMainLocal.qry1500Form := tquery.Create(dtmMainLocal);
        {Allow updates from only certain screens}
        dtmMainLocal.qry1500Form.RequestLive:= true;
        dtmMainLocal.qry1500Form.CachedUpdates:= true;
        dtmMainLocal.qry1500Form.SQL.Add('Select * from "1500Form"');
        dtmMainLocal.qry1500Form.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        If vintDatamoduleInstance <> cintFinance then
            dtmMainLocal.qry1500Form.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
//        dtmMainLocal.qry1500Form.SQL.Add('Order By Appt1500DateTime desc');
        dtmMainLocal.dts1500Form := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qry1500Form.tag := 36;
        dtmMainLocal.dts1500Form.tag := 36;
        dtmMainLocal.dts1500Form.Autoedit := false;
        dtmMainLocal.dts1500Form.DataSet := dtmMainLocal.qry1500Form;
        end
     else
     {Handle the Appt1500Detail query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLAppt1500Detail then
        begin
        dtmMainLocal.qryAppt1500Detail := tquery.Create(dtmMainLocal);
        dtmMainLocal.qryAppt1500Detail.RequestLive:= true;
        dtmMainLocal.qryAppt1500Detail.CachedUpdates:= true;
        dtmMainLocal.qryAppt1500Detail.SQL.Add('Select * from Appt1500Detail');
        dtmMainLocal.qryAppt1500Detail.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        If vintDatamoduleInstance <> cintFinance then
            dtmMainLocal.qryAppt1500Detail.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
        dtmMainLocal.dtsAppt1500Detail := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryAppt1500Detail.tag := 38;
        dtmMainLocal.dtsAppt1500Detail.tag := 38;
        dtmMainLocal.dtsAppt1500Detail.Autoedit := false;
        dtmMainLocal.dtsAppt1500Detail.DataSet :=
                                                 dtmMainLocal.qryAppt1500Detail;
        end
     else
     {Handle the ApptBilling query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLApptBilling then
        begin
        dtmMainLocal.qryApptBilling := tquery.Create(dtmMainLocal);
        dtmMainLocal.qryApptBilling.RequestLive:= true;
        dtmMainLocal.qryApptBilling.CachedUpdates:= true;
        dtmMainLocal.qryApptBilling.SQL.Add('Select * from ApptBilling');
        dtmMainLocal.qryApptBilling.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        If vintDatamoduleInstance <> cintFinance then
           dtmMainLocal.qryApptBilling.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
//        dtmMainLocal.qryApptBilling.SQL.Add('Order By ApptBillDate desc');
        dtmMainLocal.dtsApptBilling := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryApptBilling.tag := 39;
        dtmMainLocal.dtsApptBilling.tag := 39;
        dtmMainLocal.dtsApptBilling.Autoedit := false;
        dtmMainLocal.dtsApptBilling.DataSet := dtmMainLocal.qryApptBilling;
        end
     else
     {Handle the ApptBilling query and datasource}
     If carrSQLComponents[vintLoop] = cstrSQLApptAccount then
        begin
        dtmMainLocal.qryApptAccount := tquery.Create(dtmMainLocal);
        dtmMainLocal.qryApptAccount.RequestLive:= true;
        dtmMainLocal.qryApptAccount.CachedUpdates:= true;
        dtmMainLocal.qryApptAccount.SQL.Add('Select * from ApptAccount');
        dtmMainLocal.qryApptAccount.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        If vintDatamoduleInstance <> cintFinance then
           dtmMainLocal.qryApptAccount.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
//        dtmMainLocal.qryApptBilling.SQL.Add('Order By ApptBillDate desc');
        dtmMainLocal.dtsApptAccount := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryApptAccount.tag := 40;
        dtmMainLocal.dtsApptAccount.tag := 40;
        dtmMainLocal.dtsApptAccount.Autoedit := false;
        dtmMainLocal.dtsApptAccount.DataSet := dtmMainLocal.qryApptAccount;
        end
{     else
      If carrSQLComponents[vintLoop] = cstrSQLInterpret then
        begin
        dtmMainLocal.qryInterpret := tquery.Create(dtmMainLocal);
        dtmMainLocal.qryInterpret.RequestLive:= true;
        dtmMainLocal.qryInterpret.CachedUpdates:= true;
        dtmMainLocal.qryInterpret.SQL.Add('Select * from Interpret');
        dtmMainLocal.qryInterpret.SQL.Add('Where Entity = ' +
                                                   inttostr(vintCurrentEntity));
        dtmMainLocal.qryInterpret.SQL.Add('and ApptTicket = ' +
                                               inttostr(vintCurrentApptTicket));
        dtmMainLocal.dtsInterpret := tdatasource.Create(dtmMainLocal);
        dtmMainLocal.qryInterpret.tag := 40;
        dtmMainLocal.dtsInterpret.tag := 40;
        dtmMainLocal.dtsInterpret.Autoedit := false;
        dtmMainLocal.dtsInterpret.DataSet := dtmMainLocal.qryInterpret;
        end;        }
     end;

  {Loop through the component array to adjust any global settings in the array}
  For vintLoop := 0 to dtmMainLocal.ComponentCount - 1 do
     begin
     {All queries are linked through the single databasename component on the
      datamodule form}
     If dtmMainLocal.components[vintLoop] is tquery then
        begin
        If tquery(dtmMainLocal.components[vintLoop]).active = false then
          begin
         {Set the databasename to match the db component}
          tquery(dtmMainLocal.components[vintLoop]).databasename :=
                                              dtmMainLocal.dbsmain.databasename;
          {The SQL is ready, aimed at the database and ready to open}
          tquery(dtmMainLocal.components[vintLoop]).Open;
          end;
        end;
     end;
  {----------------EDIT MASKS ASSIGNED HERE----------------}
  {Add in any edit masks that may be required for display purporposes}
  If dtmMainLocal.qryPhoneNumber <> nil then
     dtmMainLocal.qryPhoneNumber.fieldbyname('PhoneNumber').EditMask:=
                                                         '!\(999\)000-0000;1; ';
  If dtmMainLocal.qryPatient <> nil then
     dtmMainLocal.qryPatient.fieldbyname('PatientSSN').EditMask:=
                                                         '000\-00\-0000;1; ';
  {----------------End Edit mask assignments---------------}
end;

{In order to assign a datasource to each DB-type component, figure out the
 identity of the item from the control array.  Too bad this couldn't be grouped
 by something like tdbControl}
Procedure AssignDataSources(var vcmpCurrent: Tcomponent;
                            const dtmMainLocal: tdtmMain);
  function GetDTS: tdatasource;
     var vintLoop : integer;
     begin
     GetDTS := nil;
     {The datamodule componet array has tags identical to the form tag for each
     visual component}
     For vintLoop := 0 to dtmMainLocal.ComponentCount - 1 do
         begin
         If dtmMainLocal.Components[vintLoop] is tdatasource then
             If vcmpCurrent.Tag = dtmMainLocal.Components[vintLoop].tag then
                 begin
                 {Tags match on created dts - return the array's value}
                 GetDTS := tdatasource(dtmMainLocal.Components[vintLoop]);
                 break;
                 end;
         end;
     end;
  {Assign datasets to quickreport components}
  function GetDataset: tquery;
     var vintLoop : integer;
     begin
     GetDataset := nil;
     {The datamodule componet array has tags identical to the form tag for each
     visual component}
     For vintLoop := 0 to dtmMainLocal.ComponentCount - 1 do
         begin
         If dtmMainLocal.Components[vintLoop] is tquery then
             If vcmpCurrent.Tag = dtmMainLocal.Components[vintLoop].tag then
                 begin
                 {Tags match on created dts - return the array's value}
                 GetDataset := tquery(dtmMainLocal.Components[vintLoop]);
                 break;
                 end;
         end;
     end;
begin
  {Based on the TAG, find the correct datasource to assign to the component
  obtained from the form component array.}
  {tdbedit assign}
  If vcmpCurrent is tdbEdit then
     tdbEdit(vcmpCurrent).datasource := GetDTS
  else
    {tdbgrid assign}
  If vcmpCurrent is tdbgrid then
     tdbgrid(vcmpCurrent).datasource := GetDTS
  else
    {tdbcheckbox assign}
  If vcmpCurrent is tdbcheckbox then
     tdbcheckbox(vcmpCurrent).datasource := GetDTS
  else
    {tdbradiogroup assign}
  If vcmpCurrent is tdbradiogroup then
     tdbradiogroup(vcmpCurrent).datasource := GetDTS
  else
    {tdbnavigator assign}
  If vcmpCurrent is tdbnavigator then
     tdbnavigator(vcmpCurrent).datasource := GetDTS
  else
    {tdbcombobox assign}
  If vcmpCurrent is tdbcombobox then
     tdbcombobox(vcmpCurrent).datasource := GetDTS
  else
    {tdblookupcombobox assign}
  If vcmpCurrent is tdblookupcombobox then
     tdblookupcombobox(vcmpCurrent).datasource := GetDTS
  else
    {tdblookuplistbox assign}
  If vcmpCurrent is tdblookuplistbox then
     tdblookuplistbox(vcmpCurrent).datasource := GetDTS
  else
    {tdblistbox assign}
  If vcmpCurrent is tdblistbox then
     tdblistbox(vcmpCurrent).datasource := GetDTS
  else
    {tdbrichedit assign}
  If vcmpCurrent is tdbrichedit then
     tdbrichedit(vcmpCurrent).datasource := GetDTS
  else
    {tdbmemo assign}
  If vcmpCurrent is tdbmemo then
     tdbmemo(vcmpCurrent).datasource := GetDTS
  else
    {tQuickreport assign}
  If vcmpCurrent is tQuickrep then
     tQuickrep(vcmpCurrent).dataset := GetDataset
  else
    {tQrSubDetail assign}
  If vcmpCurrent is tQrSubDetail then
     tQrSubDetail(vcmpCurrent).dataset := GetDataset
  else
    {tQrdbRichText assign}
  If vcmpCurrent is tQrdbRichText then
     tQrdbRichText(vcmpCurrent).dataset := GetDataset
  else
    {tdbmemo assign}
  If vcmpCurrent is tqrdbtext then
     tqrdbtext(vcmpCurrent).dataset := GetDataset;
end;

{---------CONTROLLING THE FORM ARRAY-------------}
{Find a spot in the form array or determine if the array is full}
Function FindFormLocation: integer;
  var vintLoop: integer;
begin
{There are a maximum number of forms visible}
For vintLoop := 1 to cintMaxForms do
    begin
    {Find a nil spot in the array}
    If varrCreatedForms[vintLoop] = nil then
       begin
       {The location to put the form in the array}
       result := vintLoop;
       exit;
       end;
    end;
{No more spots available}
ShowMessage('You have reached the maximum number of forms. ' + #13#10 +
            'Close other windows to continue');
result := -1;
end;

{If a form exists in the form array, show it}
Function FocusForm(cintNumber: LongInt):boolean;
var vintLoop: integer;
begin
For vintLoop := 1 to cintMaxForms do
  If varrCreatedFormsEntity[vintLoop] = cintNumber then
      begin
      tform(varrCreatedForms[vintLoop]).Windowstate := wsNormal;
      tform(varrCreatedForms[vintLoop]).BringToFront;
      Result:= true;
      exit;
      end;
{There was no form found open - return a false}
Result := false;
end;

{Eliminate the entity number for a form that is in the process of closing down}
Procedure CloseThisEntity(const cintEntity: LongInt);
var vintLoop: integer;
    vbolDummy: boolean;
begin
For vintLoop := 1 to cintMaxForms do
   If cintEntity = varrCreatedFormsEntity[vintLoop] then
      begin
      varrCreatedFormsEntity[vintLoop] := 0;
      {Refresh only tells the toolbar of the MainMenu to check all open
      windows remaining, because this one is shutting down.}
      try
      If varrCreatedForms[vintLoop] <> nil then
         varrCreatedForms[vintLoop].Release;
         except
         {If there is a problem freeing the form, the form will disappear when
         the application quits, but show a warning anyway)}
         ShowMessage('Unable to free a form - OK to Continue');
         end;
      {Place a nil in the arry to free up this position for future use}
      varrCreatedForms[vintLoop]:= nil;
      {The call to the main menu onclose checks the toolbar status and
       trigger some click events.}
      vbolRefreshOnly := true;
      vbolDummy := false;
      vfrmMainMenu.onclosequery(nil, vbolDummy);
      break;
      end;
end;

{The form array that allows the main menu to control all open forms.  These
must be freed in order to reclaim memory}
Procedure CloseAllForms;
  var vintLoop: integer;
begin
{Maxforms are controlled by a constant to make it easy to change our minds}
For vintLoop := 1 to cintMaxForms do
  {Some forms within the array may never have been used or already closed
   at the individual form level - field is Nil}
  If varrCreatedForms[vintLoop] <> Nil then
     begin
     {Make the form invisible to disable any visual events}
     varrCreatedForms[vintLoop].visible := false;
     {Close to form to allow it to free all dynamically created components,
     especially the local copy of the dynamic datamodule}
     varrCreatedForms[vintLoop].close;
     end;
end;

{-------------- CONTROL DATASET UPDATES THROUGH ACTIVE QUERIES ----------------}
{Allow the user to edit tables by selecting certain datasources.  The
updates will be cached under the database component}
Function EditDataSets(var dtmMainLocal: tdtmMain): boolean;
var vintLoop: integer;
    vcmpCurrent: Tcomponent;
begin
  {Track all updates through the database}
try
  dtmMainLocal.dbsMain.StartTransaction;
  for vintLoop := 1 to  dtmMainLocal.ComponentCount - 1 do
     begin
     vcmpCurrent := dtmMainLocal.Components[vintLoop];
     If (vcmpCurrent is tDatasource) then
       {Only tquery with request live should qualify for the ApplyUpdates}
       If tquery(tdatasource(vcmpCurrent).Dataset).RequestLive then
          tdatasource(vcmpCurrent).AutoEdit := true;
     {Make sure the latest information is in the edit buffer}
     If (vcmpCurrent is tquery) then
        tquery(vcmpCurrent).Refresh;
     end;
  except
    {The database was not able to attain edit on all datasources}
    Result := false;
    exit;
    end;
  dtmMainLocal.vbolTransactionActive:= true;
  Result := true;
end;

{Allow the user to edit tables by selecting certain datasources.  The
updates will be cached under the database component}
Function ApplyDataSets(var dtmMainLocal: tdtmMain): boolean;
var vintLoop: integer;
    vcmpCurrent: Tcomponent;
begin
  {If there is no active transaction, do not go through the posting process.}
  If not dtmMainLocal.vbolTransactionActive then
    begin
    Result := False;
    exit;
    end;
 vcmpCurrent:= nil;
 try
  {Loop through all Live queries and do Applyupdates to check the ability
   to post all records}
  for vintLoop := 1 to dtmMainLocal.ComponentCount - 1 do
    begin
     vcmpCurrent := dtmMainLocal.Components[vintLoop];
     If (vcmpCurrent is tQuery) then
       {Only tquery with request live should qualify for the ApplyUpdates}
       If tQuery(vcmpCurrent).RequestLive then
         tQuery(vcmpCurrent).ApplyUpdates;
    end;
    {Attempt to commit all }
    dtmMainLocal.dbsMain.Commit; {on success, commit the changes};
    except
      {If there is a failure in the ability to post, stop the process because
       data will be lost after this point.}
      dtmMainLocal.dbsMain.Rollback;
      ShowMessage('Database update Failed for table: '
                  + tquery(vcmpCurrent).SQL[0]);
      Result := false;
      exit;
    end;

  {Send all records to disk by looping through all CommitUpdates Routines}
  for vintLoop := 1 to  dtmMainLocal.ComponentCount - 1 do
    begin
     vcmpCurrent := dtmMainLocal.Components[vintLoop];
     {Applies to Tquery only}
     If (vcmpCurrent is tQuery) then
       {Only tquery with request live should qualify for the Commit}
       If tQuery(vcmpCurrent).RequestLive then
         tQuery(vcmpCurrent).CommitUpdates;
    end;

  {Set all datasources and querys on the form back to read-only status}
  for vintLoop := 1 to  dtmMainLocal.ComponentCount - 1 do
    begin
     vcmpCurrent := dtmMainLocal.Components[vintLoop];
     {Applies to tdatasource only}
     If (vcmpCurrent is tDataSource) then
         {Reset the datasource and the underlying query at the same point.}
         tdatasource(vcmpCurrent).AutoEdit := false;
    end;
  {Made it through all database levels - success!}
  dtmMainLocal.vbolTransactionActive := False;
  Result := true;
  end;

{Back out all database changes made this session}
Function RollBackDataSets(var dtmMainLocal: tdtmMain): boolean;
var vintLoop: integer;
    vcmpCurrent: Tcomponent;
begin
  {If there is no active transaction, do not go through the posting process.}
  If not dtmMainLocal.vbolTransactionActive then
    begin
    Result := False;
    exit;
    end;
 try
  {Loop through all Live queries and do Applyupdates to check the ability
   to post all records}
  for vintLoop := 1 to dtmMainLocal.ComponentCount - 1 do
    begin
     vcmpCurrent := dtmMainLocal.Components[vintLoop];
     If (vcmpCurrent is tQuery) then
       {Only tquery with request live should qualify for the ApplyUpdates}
       If tQuery(vcmpCurrent).RequestLive then
         tQuery(vcmpCurrent).CancelUpdates;
    end;
    {Attempt to cancell all database markers }
    dtmMainLocal.dbsMain.RollBack;
    except
      {If there is a failure in the ability to roll-back, stop.}
      dtmMainLocal.dbsMain.Rollback;
      ShowMessage('Database rollback failed');
      Result := false;
      exit;
    end;
  {Set all datasources and querys on the form back to read-only status}
  for vintLoop := 1 to  dtmMainLocal.ComponentCount - 1 do
    begin
     vcmpCurrent := dtmMainLocal.Components[vintLoop];
     {Applies to tdatasource only}
     If (vcmpCurrent is tDataSource) then
         {Reset the datasource and the underlying query at the same point.}
         tdatasource(vcmpCurrent).AutoEdit := false;
    end;
  {Done - no errors detected}
  Result := true;
  dtmMainLocal.vbolTransactionActive := False;
  end;

{----------------Field calculation routines------------------}
{Combine the entity names into EntityDescription}
Function CombineEntityName
                        (const cstrFirst, cstrMiddle, cstrLast: string): string;
  var vstrCombName: string;
begin
vstrCombName := trim(cstrFirst);
If Length(trim(cstrMiddle)) > 0 then
    vstrCombName:= vstrCombName + ' ' + trim(cstrMiddle);
If Length(trim(cstrLast)) > 0 then
    vstrCombName:= vstrCombName + ' ' + trim(cstrLast);
Result := vstrCombName;
end;

Function TestInteger(const cstrString: string): integer;
begin
  try
  Result := strtoint(cstrString);
  except
    Result := 0;
    end
end;

{Find the age in years based on the Birthday}
Function FindAge(const cdatBirthDay: tdatetime): integer;
var vintHoldAge: integer;
    vintYear, vintMonth, vintDay,
    vintBYear, vintBMonth, vintBDay: Word;
begin
  If cdatBirthday = 0 then
     begin
     Result := 0;
     exit;
     end;
  DecodeDate(date, vintYear, vintMonth, vintDay);
  DecodeDate(cdatBirthDay, vintBYear, vintBMonth, vintBDay);
  vintHoldAge := vintYear - vintBYear;
  If vintBMonth = vintMonth then
     If vintBDay > vintDay then
        Dec(vintHoldAge)
     else
  else
  If vintBMonth > vintMonth then
     Dec(vintHoldAge);
  Result:= vintHoldAge;
end;

{Find an age between dates that is not fixed on the current date.}
Function FindAgeDates(const cdatBirthDay: tdatetime;
                      const cdatCurrentDay: tdatetime): integer;
var vintHoldAge: integer;
    vintYear, vintMonth, vintDay,
    vintBYear, vintBMonth, vintBDay: Word;
begin
  If (cdatBirthday = 0) or (cdatCurrentDay = 0) then
     begin
     Result := 0;
     exit;
     end;
  DecodeDate(cdatCurrentDay, vintYear, vintMonth, vintDay);
  DecodeDate(cdatBirthDay, vintBYear, vintBMonth, vintBDay);
  vintHoldAge := vintYear - vintBYear;
  If vintBMonth = vintMonth then
     If vintBDay > vintDay then
        Dec(vintHoldAge)
     else
  else
  If vintBMonth > vintMonth then
     Dec(vintHoldAge);
  Result:= vintHoldAge;
end;

{----------------Other record maintenance routines------------------}
{Attempt to post - if it fails, cancel the update and return a false to the
calling routine}
Function PostEvent(var vqryQuery: tquery): boolean;
begin
try
Result := true;
If vqryQuery.State = dsBrowse then
   exit;
vqryQuery.Post;
    {Post is not OK - cancel}
    except
    Result := false;
    vqryQuery.Cancel;
    end;    
end;

{Copy a group of records to a new set of unique keys.}
procedure CloneRecords(var vqryQueryOld, vqryQueryNew: tquery;
                     const carrKeys: array of variant);
var vintLoop: integer;
begin
{Loop for all of the records present in the Old table}
vqryQueryOld.First;
While not vqryQueryOld.eof do
  begin
  vqryQueryNew.Append;
  {Loop for all fields in the currently focused table}
  For vintLoop := 0 to vqryQueryOld.Fieldcount - 1 do
    begin
    If vintLoop <= High(carrKeys) then
       vqryQueryNew.fields[vintLoop].value := variant(carrKeys[vintLoop])
    else
       vqryQueryNew.fields[vintLoop].value :=
                                            vqryQueryOld.fields[vintLoop].value;
    end;
  PostEvent(vqryQueryNew);
  vqryQueryOld.next;
  end;
end;

{This routine will use an Update SQL to delete all entries in the database
for a particular entity.  This includes all cascades.}
procedure DeleteAllEntity(const cintEntity: longint);
var vsqlDelete: tQuery;
  procedure SQLDelete(const cstrTable: string);
    begin
    vsqlDelete.SQL[0] := 'Delete From ' + cstrTable;
    vsqlDelete.ExecSQL;
    end;
begin
Screen.Cursor := crSQLWait;
vsqlDelete := tQuery.Create(nil);
try
vsqlDelete.SQL.add('Delete');
vsqlDelete.SQL.add('Where Entity = ' + inttostr(cintEntity));
vsqlDelete.databasename := 'mmom_MainDatabase';
SQLDelete('Entity');
SQLDelete('Household');
SQLDelete('Patient');
SQLDelete('Appointment');
SQLDelete('ApptAccount');
SQLDelete('ApptBilling');
SQLDelete('Address');
SQLDelete('Equipment');
SQLDelete('FacilityRoom');
SQLDelete('Immunization');
SQLDelete('Labwork');
SQLDelete('Medication');
SQLDelete('PatientChronic');
SQLDelete('PhoneNumber');
SQLDelete('Picture');
SQLDelete('Program');
SQLDelete('Referral');
SQLDelete('Reminder');
SQLDelete('Staff');
SQLDelete('Survey');
SQLDelete('Insurance');
finally
  vsqlDelete.free;
  screen.Cursor := crDefault;
  end;
end;

{This routine will use an Update SQL to delete all entries in the database
for a particular entity.  This includes all cascades.}
procedure DeleteAllAppointment(const cintApptTicket: longint);
var vsqlDelete: tQuery;
  procedure SQLDelete(const cstrTable: string);
    begin
    vsqlDelete.SQL[0] := 'Delete From ' + cstrTable;
    vsqlDelete.ExecSQL;
    end;
begin
Screen.Cursor := crSQLWait;
vsqlDelete := tQuery.Create(nil);
try
vsqlDelete.SQL.add('Delete');
vsqlDelete.SQL.add('Where ApptTicket = ' + inttostr(cintApptTicket));
vsqlDelete.databasename := 'mmom_MainDatabase';
SQLDelete('Appointment');
SQLDelete('ApptBilling');
SQLDelete('ApptAccount');
SQLDelete('Immunization');
SQLDelete('Labwork');
SQLDelete('Medication');
SQLDelete('PatientChronic');
SQLDelete('Referral');
//SQLDelete('Interpret');
finally
  vsqlDelete.free;
  screen.Cursor := crDefault;
  end;
end;

{This routine will use an Update SQL to delete all entries in the database
for a particular entity.  This includes all cascades.}
procedure DeleteAllSurvey(const cintSurvey: longint);
var vsqlDelete: tQuery;
  procedure SQLDelete(const cstrTable: string);
    begin
    vsqlDelete.SQL[0] := 'Delete From ' + cstrTable;
    vsqlDelete.ExecSQL;
    end;
begin
Screen.Cursor := crSQLWait;
vsqlDelete := tQuery.Create(nil);
try
vsqlDelete.SQL.add('Delete');
vsqlDelete.SQL.add('Where SurveyNumber = ' + inttostr(cintSurvey));
vsqlDelete.databasename := 'mmom_MainDatabase';
SQLDelete('SurveyAnswer');
SQLDelete('Survey');
finally
  vsqlDelete.free;
  screen.Cursor := crDefault;
  end;
end;

{---------Search routines for the mainmenu form---------}
{Search the main database using the received SQL command}
Procedure PerformSQLStatemtent(const vstlSQl: TstringList);
begin
Screen.Cursor := crSQLWait;
try
vqryMainSearch.Close;
vqryMainSearch.SQL := vstlSQL;
vqryMainSearch.Open;
{Just in case there is a proble, reset the cursor}
finally
  screen.Cursor := crDefault;
  end;
end;

{---------Insert a record into the database, post it and place it in edit mode}
Function NewRecord(const cintEntityType: LongInt;
                   const cintAdditionalEntity: LongInt;
                   const cstrSurveyID: string;
                   const cdatSurveyEdition: tdate): Longint;
var vqryNewRec, vqryNew: tquery;
    vbolEntity, vbolSurvey, vbolAppointment, vbolReminder, vbolInvoice: boolean;
    vintHighRange, vintHoldNew: longint;
begin
Result := 0;
{Initialize local variables}
vbolEntity := false;
vbolSurvey := false;
vbolReminder := false;
vbolAppointment := false;
vbolInvoice := false;
{The query used to insert a new record}
vqryNew := tQuery.Create(nil);
vqryNew.databasename := 'mmom_MainDatabase';
vqryNew.UniDirectional := false;
vqryNew.RequestLive := true;
{Decide the database area to add by setting a boolean}
If cintEntityType = cintReminder then
   vbolReminder := true
else
If cintEntityType = cintSurvey then
   vbolSurvey := true
else
If cintEntityType = cintAppointment then
   vbolAppointment := true
else
If cintEntityType = cintCompanyBilling then
   vbolInvoice := true
else
   vbolEntity := true;
{Create the tquery that will do the inserting...}
vqryNewRec := tquery.Create(nil);
try
vqryNewRec.DatabaseName := 'Mmom_MainDatabase';
{For Entity, find the next number in the sequential series based on the
integer constant + 99999.  Each series has a range of 100000}
If vbolEntity then
   begin
   {Open the table and restrict the range of the view before attampting to
   find the next policy...}
   If (cintEntityType = cintEntityInsCompany) or
      (cintEntityType = cintEntityMedCompany) or
      (cintEntityType = cintEntityOtherPhys) then
       vintHighRange := cintEntityType + 9999
   else
       vintHighRange := cintEntityType + 99999;
   vqryNewRec.SQL.text :=
                  'SELECT MAX(Entity) as Entity From Entity Where (Entity > '  +
                           inttostr(cintEntityType) + ') and (Entity < ' +
                           inttostr(vintHighRange) + ')';
   vqryNewRec.Open;
   {If there are no records start at the beginning of the series}
   If vqryNewRec.FieldByName('Entity').asinteger = 0 then
     vintHoldNew := cintEntityType
   else
     vintHoldNew := vqryNewRec.FieldByName('Entity').asinteger;
   {Add the record}
   vqryNew.SQL.text := 'Select * from Entity';
   vqryNew.Open;
   vqryNew.Append;
   vqryNew.Fieldbyname('Entity').asinteger := vintHoldNew + 1;
   vqryNew.Fieldbyname('EntitySchedule').asboolean := false;
   {Set the EntityCategory field in the database table}
   If cintEntityType = cintEntityPatient then
       begin
       vqryNew.Fieldbyname('EntityCategory').asstring := cstrSQLPatient;
       {The household field must be set for Patient}
       vqryNew.Fieldbyname('EntityHousehold').asinteger :=
                                                           cintAdditionalEntity;
       end
   else
   If cintEntityType = cintEntityHousehold then
       vqryNew.Fieldbyname('EntityCategory').asstring := cstrSQLHousehold
   else
   If cintEntityType = cintEntityRoom then
       vqryNew.Fieldbyname('EntityCategory').asstring := cstrSQLRoom
   else
   If cintEntityType = cintEntityStaff then
       vqryNew.Fieldbyname('EntityCategory').asstring := cstrSQLStaff
   else
   If cintEntityType = cintEntityEquipment then
       vqryNew.Fieldbyname('EntityCategory').asstring := cstrSQLEquipment
   else
   If cintEntityType = cintEntityInsCompany then
       vqryNew.Fieldbyname('EntityCategory').asstring := cstrSQLInsurance
   else
   If cintEntityType = cintEntityMedCompany then
       vqryNew.Fieldbyname('EntityCategory').asstring := cstrSQLMedCompany
   else
   If cintEntityType = cintEntityOtherPhys then
       vqryNew.Fieldbyname('EntityCategory').asstring := cstrSQLOtherPhys;
   {Set a default}
   vqryNew.Fieldbyname('EntityActive').asboolean := true;
   {If there is an error in attempting to add this record, cancel the insert
   and return the dataset to previous state;}
   Result := vqryNew.Fieldbyname('Entity').asinteger;
   end
else
If vbolReminder then
   begin
   {Open the table and restrict the range of the view before attampting to
   find the next policy...}
   vintHighRange := cintEntityType + 999999;
   vqryNewRec.SQL.text :=
           'SELECT MAX(ReminderTicket) as ReminderTicket From Reminder Where ' +
                        '(ReminderTicket > '  +
                         inttostr(cintEntityType) + ') and (ReminderTicket < ' +
                         inttostr(vintHighRange) + ')';
   vqryNewRec.Open;
   {If there are no records start at the beginning of the series}
   If vqryNewRec.FieldByName('ReminderTicket').asinteger = 0 then
     vintHoldNew := cintEntityType
   else
     vintHoldNew := vqryNewRec.FieldByName('ReminderTicket').asinteger;
   {Add the record}
   vqryNew.SQL.text := 'Select * from Reminder';
   vqryNew.Open;
   vqryNew.Append;
   vqryNew.Fieldbyname('ReminderTicket').asinteger := vintHoldNew + 1;
   vqryNew.Fieldbyname('Entity').asinteger := cintAdditionalEntity;
   vqryNew.Fieldbyname('ReminderActive').asboolean := true;
   vqryNew.Fieldbyname('ReminderDate').asdatetime := date;
   Result := vqryNew.Fieldbyname('ReminderTicket').asinteger;
   end
else
If vbolSurvey then
   begin
   {Open the table and restrict the range of the view before attampting to
   find the next policy...}
   vintHighRange := cintEntityType + 999999;
   vqryNewRec.SQL.text :=
                 'SELECT MAX(SurveyNumber) as SurveyNumber From Survey Where ' +
                          '(SurveyNumber > '  +
                           inttostr(cintEntityType) + ') and (SurveyNumber < ' +
                           inttostr(vintHighRange) + ')';
   vqryNewRec.Open;
   {If there are no records start at the beginning of the series}
   If vqryNewRec.FieldByName('SurveyNumber').asinteger = 0 then
     vintHoldNew := cintEntityType
   else
     vintHoldNew := vqryNewRec.FieldByName('SurveyNumber').asinteger;
   {Add the record}
   vqryNew.SQL.text := 'Select * from Survey';
   vqryNew.Open;
   vqryNew.Append;
   vqryNew.Fieldbyname('SurveyNumber').asinteger := vintHoldNew + 1;
   vqryNew.Fieldbyname('SurveyID').asstring := cstrSurveyID;
   vqryNew.Fieldbyname('SurveyEdition').asdatetime := cdatSurveyEdition;
   vqryNew.Fieldbyname('Entity').asinteger := cintAdditionalEntity;
   vqryNew.Fieldbyname('SurveyDate').asdatetime := date;
   Result := vqryNew.Fieldbyname('SurveyNumber').asinteger;
   end
else
If vbolAppointment then
   begin
   {Open the table and restrict the range of the view before attampting to
   find the next policy...}
   vintHighRange := cintEntityType + 999999;
   vqryNewRec.SQL.text :=
               'SELECT MAX(ApptTicket) as ApptTicket From Appointment Where ' +
                          '(ApptTicket > '  +
                           inttostr(cintEntityType) + ') and (ApptTicket < ' +
                           inttostr(vintHighRange) + ')';
   vqryNewRec.Open;
   {If there are no records start at the beginning of the series}
   If vqryNewRec.FieldByName('ApptTicket').asinteger = 0 then
     vintHoldNew := cintEntityType
   else
     vintHoldNew := vqryNewRec.FieldByName('ApptTicket').asinteger;
   {Add the record}
   vqryNew.SQL.text := 'Select * from Appointment';
   vqryNew.Open;
   vqryNew.Append;
   vqryNew.Fieldbyname('ApptTicket').asinteger := vintHoldNew + 1;
   vqryNew.Fieldbyname('ApptDuration').asinteger := 15;
   vqryNew.Fieldbyname('ApptDateTime').asdatetime := date;
   vqryNew.Fieldbyname('ApptScheduled').asboolean := false;
   If cstrSurveyID = 'Schedule' then
      vqryNew.Fieldbyname('ApptSchedulePend').asboolean := true
   else
      vqryNew.Fieldbyname('ApptSchedulePend').asboolean := false;
   vqryNew.Fieldbyname('ApptFee').asfloat := 0;
   vqryNew.Fieldbyname('ApptBilled').asboolean := false;
   vqryNew.Fieldbyname('Entity').asinteger := cintAdditionalEntity;
   vqryNew.Fieldbyname('ApptProgram').asstring :=
                                  '3. Low Cost Community Clinic';
   vqryNew.Fieldbyname('ApptVisitCategory').asstring :=
                                  'Clinic Visit - Sick/Physicals';
   Result := vqryNew.Fieldbyname('ApptTicket').asinteger;
   end
else
If vbolInvoice then
   begin
   {Open the table and restrict the range of the view before attampting to
   find the next policy...}
   vintHighRange := cintEntityType + 999999;
   vqryNewRec.SQL.text :=
               'SELECT MAX(InvoiceNumber) as InvoiceNumber ' +
                         'From CompanyBill Where ' +
                         '(InvoiceNumber > '  +
                          inttostr(cintEntityType) + ') and (InvoiceNumber < ' +
                          inttostr(vintHighRange) + ')';
   vqryNewRec.Open;
   {If there are no records start at the beginning of the series}
   If vqryNewRec.FieldByName('InvoiceNumber').asinteger = 0 then
     vintHoldNew := cintEntityType
   else
     vintHoldNew := vqryNewRec.FieldByName('InvoiceNumber').asinteger;
   {Add the record}
   vqryNew.SQL.text := 'Select * from CompanyBill';
   vqryNew.Open;
   vqryNew.Append;
   vqryNew.Fieldbyname('InvoiceNumber').asinteger := vintHoldNew + 1;
   vqryNew.Fieldbyname('Entity').asinteger := 0;
   vqryNew.Fieldbyname('BillDate').asdatetime := date;
   vqryNew.Fieldbyname('BillSent').asboolean := false;
   vqryNew.Fieldbyname('BillPaid').asboolean := false;
   Result := vqryNew.Fieldbyname('InvoiceNumber').asinteger;
   end;

{If the post fails, the Result of 0 will be returned to the main menu and the
new screen will not be displayed.}
try
 vqryNew.Post;
    {Post is not OK - cancel}
    except
    Result := 0;
    vqryNew.Cancel;
    end;

finally
  vqryNew.close;
  vqryNewRec.close;
  vqryNew.free;
  vqryNewRec.Free;
  end;
end;

{------------------------------MultiMedia----------------------------}
{Create a multimedia clip and play it based on the calling program's media
file name}
Procedure PlayMovie(const cstrClipName: string);
begin
If vfrmMediaHolder = Nil then
  begin
  Application.CreateForm(tform, vfrmMediaHolder);
  vmedMovie := TMediaPlayer.Create(vfrmMediaHolder);
  end;
{The parent is require for display}
 vmedMovie.Close;
 vmedMovie.Parent := vfrmMediaHolder;
 vmedMovie.Name := 'medMovie';
 vmedMovie.Visible := false;
 {The media clip name comes from the calling form}
 vmedMovie.FileName := vstrApplicationDirectory + '\Multimedia\' + cstrClipName;
 {Open it to load the multimedia}
 vmedMovie.Open;
 {Show the movie}
 vmedMovie.Play;
end;


{----------------------------PICK LISTS------------------------------}
function FillPickList(const cstrFieldName: string;
                      vstlPickList: tstrings):LongInt;
   Function ManualPickListRoutine: boolean;
      begin
      Result := false;
      If cstrFieldName = 'Physician' then
         begin
         Result := true;
         vqryEntity.Close;
         vqryEntity.SQL.clear;
         vqryEntity.SQL.add('Select Staff.Entity, Entity.EntityDescription');
         vqryEntity.SQL.add('From Staff, Entity');
         vqryEntity.SQL.add('Where Staff.StaffPosition = "Physician"');
         vqryEntity.SQL.add('and Staff.Entity = Entity.Entity');
         vqryEntity.Open;
         while not vqryEntity.eof do
            begin
            vstlPickList.add(vqryEntity.fieldbyname
                                                ('EntityDescription').asstring +
                 ' - #' + format('%6d',
                         [vqryEntity.fieldbyname('Entity').asinteger]));
            vqryEntity.Next;
            end;
         end
     else
       If cstrFieldName = 'Insurance' then
         begin
         Result := true;
         vqryEntity.Close;
         vqryEntity.SQL.clear;
         vqryEntity.SQL.add('Select EntityDescription');
         vqryEntity.SQL.add('From Entity');
         vqryEntity.SQL.add('Where Entity.Entity > ' +
                                         inttostr(cintEntityInsCompany));
         vqryEntity.SQL.add(' and Entity.Entity < ' +
                                         inttostr(cintEntityInsCompany + 9999));
         vqryEntity.Open;
         while not vqryEntity.eof do
            begin
            vstlPickList.add(vqryEntity.fieldbyname
                                                ('EntityDescription').asstring);
            vqryEntity.Next;
            end;
         end;  
      end;
begin
  FillPickList := 0;
  vstlPickList.Clear;
  {If this list is generated from another table than PickList, use the
  manual routine to fill in the strings.}
  If ManualPickListRoutine then
    exit
  else
  {The picklist table has never been created}
  If vqryPickList = nil then
     begin
     vqryPickList := tquery.Create(nil);
     vqryPickList.RequestLive:= false;
     vqryPickList.CachedUpdates:= false;
     vqryPickList.Unidirectional:= true;
     vqryPickList.databasename:= 'mmom_maindatabase';
     end;
  {To prevent a crash on prior errors, close the dataset as a precaution}
  vqryPickList.Close;
  vqryPickList.SQL.Clear;
  {Define the values to be sought in the pick list}
  vqryPickList.SQL.Add('Select * from Picklist');
  vqryPickList.SQL.Add('Where ListField = "' + cstrFieldName + '"');
  vqryPickList.Open;
  {Loop through all available pick list records}
  while not vqryPickList.EOF do
    begin
    {If a record is obsolete, it will have a date in the pick list}
    If (date < vqryPickList.fieldbyname('ListExpiration').asdatetime) or
       (vqryPickList.fieldbyname('ListExpiration').isnull) then
           vstlPickList.add(vqryPickList.fieldbyname('ListValue').asstring);
    vqryPickList.Next;
    end;
  vqryPickList.Close;
end;

{Certain fields will have default entry values.  These values come from the
picklist database and are in the format of DEFAULT_[fieldname].  Return the
default string for a fieldname specified.}
function FillDefault(const cstrFieldName: string):string;
begin
  Result := '';
  If vqryPickList = nil then
     begin
     vqryPickList := tquery.Create(nil);
     vqryPickList.RequestLive:= false;
     vqryPickList.CachedUpdates:= false;
     vqryPickList.Unidirectional:= true;
     vqryPickList.databasename:= 'mmom_maindatabase';
     end;
  {To prevent a crash on prior errors, close the dataset as a precaution}
  vqryPickList.Close;
  vqryPickList.SQL.Clear;
  {Define the values to be sought in the pick list}
  vqryPickList.SQL.Add('Select * from Picklist');
  vqryPickList.SQL.Add('Where ListField = "DEFAULT_' + cstrFieldName + '"');
  vqryPickList.Open;
  {Get the last available record}
  If vqryPickList.recordcount > 0 then
    begin
    vqryPickList.last;
    Result := vqryPickList.fieldbyname('ListValue').asstring;
    end;
  vqryPickList.Close;
end;

{In the cases where we have an entity number but no name on a table, we can use
this query to find the name and return the text to the calling routine.}
function FindEntityName(const cintEntity: integer):String;
begin
  vqryEntity.Close;
  vqryEntity.SQL.clear;
  vqryEntity.SQL.add('Select Entity, EntityDescription from Entity');
  vqryEntity.SQL.add('Where Entity = ' + inttostr(cintEntity));
  vqryEntity.Open;
  If vqryEntity.RecordCount = 1 then
     Result := vqryEntity.Fieldbyname('EntityDescription').asstring
  else
     Result := '';
end;

{-------------------------EXTRACT IMAGE------------------------------------}
function ExtractImagePath(dtmMainLocal: tdtmMain): string;
begin
  {Get the actual picture and load it into the image box}
  Result := vstrApplicationDirectory + 'Pictures\' +
       copy(dtmMainLocal.qryPicture.fieldbyname('PictureVolume').asstring,1,4)
       + '\' +
       copy(dtmMainLocal.qryPicture.fieldbyname('PictureVolume').asstring,5,2)
       + '\' +
       dtmMainLocal.qryPicture.fieldbyname('PictureID').asstring + '.JPG';
end;

{-------------------------FREE RESOURCES-----------------------------------}
{In order to close the open files and return some of the resources to the
BDE, this routine closes and frees all created datamodule components in the
local copy of the datamodule}
Procedure CloseAndFreeFiles(var dtmMainLocal: tdtmMain);
  var vintLoop: integer;
      vcmpCurrent: Tcomponent;
begin
  for vintLoop := 1 to  dtmMainLocal.ComponentCount - 1 do
     begin
     vcmpCurrent := dtmMainLocal.Components[vintLoop];
     {By looking at the datamodule component array, determine the components
     that were dynamically created and terefore must be freed}
     If (vcmpCurrent is tQuery) or (vcmpCurrent is tDatasource) then
       begin
       {To save on file handles, make sure the close on dynamic tables occurs
          before the free}
       If vcmpCurrent is tQuery then
         If tQuery(vcmpCurrent).Active then
             begin
             tQuery(vcmpCurrent).flushbuffers;
             tQuery(vcmpCurrent).close;
             end;
       end;
     end;

  for vintLoop := 1 to  dtmMainLocal.ComponentCount - 1 do
       begin
       {Always assign the value as 1, because the array is adjusted to each
       free automatically.}
       vcmpCurrent := dtmMainLocal.Components[1];
       {free the component}
       vcmpCurrent.free;
       end;

  dtmMainLocal.dbsMain.Connected := false;
  dtmMainLocal.free;
  dtmMainLocal := nil;
  {Try to delete any left-over files in the directory}
  DeleteFiles(vstrLocalApplicationDirectory, '*.db');
  DeleteFiles(vstrLocalApplicationDirectory, '*.mb');
end;

 {Some dynamic resourses are not related to a parent form and datamodule and
 therefore must be freed before the system execution completes}
Procedure SystemShutDown;
  begin
  {Close all forms than may be left open on the desktop}
  CloseAllForms;
  {If picklists were used, free the query}
  If vqryPickList <> nil then
    vqryPickList.Free;
  vqryPickList := nil;
  {If movies were played, free the parent form}
  If vfrmMediaHolder <> nil then
    vfrmMediaHolder.Free;
  vfrmMediaHolder := nil;
  {If any searches were done, free the components}
  If vdtsMainSearch <> nil then
    vdtsMainSearch.Free;
  vdtsMainSearch := nil;
  If vqryMainSearch <> nil then
    vqryMainSearch.Free;
  vqryMainSearch := nil;
  {Special Entity processing}
  If vqryEntity <> nil then
    vqryEntity.Free;
  vqryEntity := nil;
  {Selectively eliminate the query files.}
  DeleteFiles(vstrLocalApplicationDirectory, '*.db');
  DeleteFiles(vstrLocalApplicationDirectory, '*.mb');
  end;

function DeleteFiles(vstrFilePath, vstrMask : String): Boolean;
var
  vschDeleteFilesSearchRec: TSearchRec;
  vstrSearchResult : integer;
begin
  Result := True;
 
  if NOT DirectoryExists(vstrFilePath) then Exit;
 
  vstrSearchResult := FindFirst(vstrFilePath + '\' + vstrMask, faAnyFile,
                            vschDeleteFilesSearchRec);
  try
      // Loop through all the file and directory names
      while (vstrSearchResult = 0) do
      begin
        // Only Delete files .. this avoids directories
        if ( (vschDeleteFilesSearchRec.Attr AND faDirectory) = 0 ) then
          begin
          if NOT (DeleteFile(PChar(vstrFilePath + '\' +
                                           vschDeleteFilesSearchRec.Name))) then
              Result := FALSE;
          end;
 
        vstrSearchResult := FindNext(vschDeleteFilesSearchRec);
      end;
  finally
      FindClose(vschDeleteFilesSearchRec);
  end;
end;
 
end.
