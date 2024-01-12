unit dataScheduler;
{Author: Chuck Weindorf
 Description: Contain all array and array manipulation routines for a scheduler
 form

 Date: 03/10/2002 - CEW - New
  }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TdtmScheduler = class(TDataModule)
    tblEntity: TTable;
    tblPatient: TTable;
    tblHousehold: TTable;
    tblAppointmentTicket: TTable;
    dtsEntity: TDataSource;
    dtsPatient: TDataSource;
    tblScheduleEntity: TTable;
    dtsAppointment: TDataSource;
    qryUnscheduled: TQuery;
    qryEntity: TQuery;
    dbsScheduler: TDatabase;
    dtsSearchEntity: TDataSource;
    tblAppointment: TTable;
    tblApptYear: TTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    varrDaySchedule: array[1..50, 1..96, 1..3] of LongInt;
    varrDayDuration: array[1..50, 1..96] of Integer;
    varrEntity: array[1..50] of LongInt;
    varrName: array[1..50] of string[30];
    vtimMin, vtimMax: tdatetime;
    vintStartPoint: integer;
    vdatScheduleDate, vdatLastDate: tdatetime;
    {Manage the scheduling arrays}
    Procedure InitializeEntityScheduler;
    Procedure LoadEntityScheduler;
    Procedure InitializeDayScheduler;
    Procedure LoadDayScheduler;
    procedure NewAppointment;
    procedure ShutDownScheduler;

    {Convert database time fields to the integer for the schedule array}
    Function TimeToArray(const cdatSchedule: tdatetime): integer;
    Function ArrayToTime(const cintArray: integer;
                         const cdatDateTime: tdatetime): tdatetime;
    Function UnScheduleAppointment(const cintTicket: integer): boolean;
    Function ScheduleAppointment(const cintArray: integer;
                                 const cdatDate: tdatetime;
                                 const cintDuration: integer;
                                 const cstrComplaint: string;
                                 const cstrDescription: string;
                                 const carrEntity: array of LongInt): boolean;
  end;

var
  dtmScheduler: TdtmScheduler;

const
  {Constant for time conversion at 15 minute intervals}
  crea_15_Minutes: real = 0.01041666667;
  cintAppointment:        LongInt = 1000000;

implementation

{$R *.DFM}

{Clear all references to entities}
Procedure TdtmScheduler.InitializeEntityScheduler;
  var vintLoop: integer;
begin
For vintLoop:= 1 to 50 do
   begin
   varrEntity[vintLoop] := 0;
   varrName[vintLoop] := '';
   end;
end;

{Clear all references to entities}
Procedure TdtmScheduler.LoadEntityScheduler;
  var vqryEntity: tQuery;
      vintLoop: integer;
begin
vqryEntity:= tquery.create(nil);
try
vqryEntity.RequestLive := false;
vqryEntity.Unidirectional := true;
vqryEntity.Databasename := 'mmom_maindatabase';
vqryEntity.SQL.add('Select Entity, EntityCategory, EntityDescription,');
vqryEntity.SQL.add('       EntityLastName');
vqryEntity.SQL.add('From Entity');
vqryEntity.SQL.add('Where Entity > 300000 and Entity < 1000000');
vqryEntity.SQL.add('      and EntitySchedule = true');
vqryEntity.SQL.add
                 ('Order by EntityCategory, EntityLastName, EntityDescription');
vqryEntity.Open;
vintLoop := 1;
while not vqryEntity.eof do
   begin
   varrEntity[vintLoop] := vqryEntity.fieldbyname('Entity').asinteger;
   varrName[vintLoop] := vqryEntity.fieldbyname('EntityDescription').asstring;
   inc(vintLoop);
   vqryEntity.next;
   end;
finally
   vqryEntity.free;
   end;
end;

{Zero the array to prepare for loading the day's appointment list.}
Procedure TdtmScheduler.InitializeDayScheduler;
  var vintLoop, vintLoop2, vintLoop3: integer;
begin
For vintLoop:= 1 to 50 do
  For vintLoop2:= 1 to 96 do
      begin
      For vintLoop3:= 1 to 3 do
          varrDaySchedule[vintLoop, vintLoop2, vintLoop3] := 0;
      varrDayDuration[vintLoop, vintLoop2] := 0;
      end;
end;

{Complete the array}
Procedure TdtmScheduler.LoadDayScheduler;
var vintLoop, vintLoop2, vintArrayDuration, vintTimeSlot: integer;
    Procedure PlaceInScheduleArrayLoop;
       var vintLoop3: integer;
       begin
       For vintLoop3:= 1 to 3 do
          If varrDaySchedule[vintLoop,
                             vintTimeSlot + vintLoop2,
                             vintLoop3] = 0 then
              begin
              varrDaySchedule[vintLoop,
                              vintTimeSlot + vintLoop2,
                              vintLoop3] :=
                                        tblAppointment.Fieldbyname
                                                       ('ApptTicket').asinteger;
              break;
              end;
       end;
begin
{If the requested date on the scheduler has changed, rerun ther query for
scheduled appointments...}
tblAppointment.Refresh;
tblAppointmentTicket.Refresh;
{Attempt to lock down a constant problem in the corruption of the ScheduleEntity}
tblScheduleEntity.flushbuffers;
tblScheduleEntity.Close;
tblScheduleEntity.open;
//tblScheduleEntity.Refresh;

If vdatScheduleDate <> vdatLastDate then
  begin
  tblAppointment.setrange([vdatScheduleDate], [vdatScheduleDate+1]);
  vdatLastDate:= vdatScheduleDate;
  end;
{Exit without data on the schedule}
If tblAppointment.recordcount = 0 then
   exit;
tblAppointment.First;
{Loop through all scheduled appointments...}
while not tblAppointment.eof do
   begin
   If tblAppointment.fieldbyname('ApptScheduled').asboolean = true then
   {There are invited entities to this appointment, add to display...}
    If tblScheduleEntity.RecordCount > 0 then
     begin
     vintTimeSlot := TimeToArray(tblAppointment.Fieldbyname
                                                   ('ApptDateTime').asdatetime);
     {0 would be a failed calculation or exactly midnight - do not put in the
      array}
     If vintTimeSlot > 0 then
        while not tblScheduleEntity.eof do
           begin
           {Find the entity position in the schedule array}
           For vintLoop:= 1 to 50 do
             If varrEntity[vintLoop] = tblScheduleEntity.
                                            fieldbyname('Entity').asinteger then
               break;
           {We found the valid entity in the array}
           If (vintLoop > 0) and (vintLoop < 50) then
             begin
             {Store the duration for quick box drawing}
             varrDayDuration[vintLoop, vintTimeSlot] :=
                   tblAppointment.Fieldbyname('ApptDuration').asinteger;
             vintArrayDuration := strtoint(floattostr(Int(
                                 varrDayDuration[vintLoop, vintTimeSlot]/ 15)));
             {Place the ApptTicket number in each spot based on the duration}
             For vintLoop2 := 0 to vintArrayDuration - 1 do
                 PlaceInScheduleArrayLoop;
             end;
           {Get the next person in the entities being scheduled}
           tblScheduleEntity.next;
           end;
     end;
   tblAppointment.Next;
   tblScheduleEntity.First;
   end;
end;

{The Appointment table stores the date/time of an appointment in the database
format while the screen program will use an array for rapid display.}
Function TdtmScheduler.TimeToArray(const cdatSchedule: tdatetime): integer;
  var vreaTimeWork: double;
  begin
  vreaTimeWork:= cdatSchedule - Int(cdatSchedule);
  If vreaTimeWork <> 0 then
     vreaTimeWork:= vreaTimeWork / crea_15_Minutes;
  Result:= round(vreaTimeWork);
  end;

{Take the current array position and convert that to a datatime that will be
placed into the current appointment.}
Function TdtmScheduler.ArrayToTime(const cintArray: integer;
                     const cdatDateTime: tdatetime): tdatetime;
  begin
  {Change the 15 minute increments of the array back to the decimal portion of
  a full day}
  Result:= int(cdatDateTime)
           + (cintArray * crea_15_Minutes);
  end;

{Take the current unscheduled appointment and schedule it based on the
Array position selected.  Also create all entity records.  Refresh the
array based on the changes to the schedule database}
Function TdtmScheduler.UnScheduleAppointment
                                           (const cintTicket: integer): boolean;
begin
  Result := false;
  If not tblAppointmentTicket.findkey([cintTicket]) then
    exit;
  tblAppointmentTicket.edit;
  tblAppointmentTicket.fieldbyname('ApptScheduled').asboolean := false;
  tblAppointmentTicket.fieldbyname('ApptSchedulePend').asboolean := true;
  tblAppointmentTicket.fieldbyname('ApptDateTime').asdatetime := 0;
  tblAppointmentTicket.fieldbyname('ApptDuration').asinteger := 0;
  tblAppointmentTicket.post;
  tblScheduleEntity.MasterSource:= nil;
  tblScheduleEntity.MasterFields:= '';
  tblScheduleEntity.setrange([cintTicket],[cintTicket]);
  while tblScheduleEntity.recordcount > 0 do
        tblScheduleEntity.delete;
  tblScheduleEntity.MasterSource:= dtsAppointment;
  tblScheduleEntity.MasterFields:= 'ApptTicket';
  InitializeDayScheduler;
  LoadDayScheduler;
  Result := true;
end;

{Take the current unscheduled appointment and schedule it based on the
Array position selected.  Also create all entity records.  Refresh the
array based on the changes to the schedule database}
Function TdtmScheduler.ScheduleAppointment(const cintArray: integer;
                                           const cdatDate: tdatetime;
                                           const cintDuration: integer;
                                           const cstrComplaint: string;
                                           const cstrDescription: string;
                                   const carrEntity: array of LongInt): boolean;
  var vintSaveAppt: longint;
      vintLoop: integer;
  begin
  Result:= false;
  If qryUnScheduled.RecordCount = 0 then
     exit;
  {Before repositioning the datasets, save the appointment ticket}
  vintSaveAppt:= qryUnScheduled.fieldbyname('ApptTicket').asinteger;
  qryUnScheduled.edit;
  qryUnScheduled.fieldbyname('ApptScheduled').asboolean := true;
  qryUnScheduled.fieldbyname('ApptSchedulePend').asboolean := false;
  qryUnScheduled.fieldbyname('ApptDateTime').asdatetime :=
                                               ArrayToTime(cintArray, cdatDate);
  qryUnScheduled.fieldbyname('ApptDuration').asinteger := cintDuration;
  qryUnScheduled.fieldbyname('ApptComplaint').asstring := cstrComplaint;
  qryUnScheduled.fieldbyname('ApptComplaintText').asstring := cstrDescription;
  try
  qryUnScheduled.post;
    except
     qryUnScheduled.cancel;
     end;
  {Refresh the queries to show the appointment in the Appointment dataset}
  If not tblAppointmentTicket.findkey([vintSaveAppt]) then
      exit;
  {Add all entities that will be scheduled into this appointment}
  tblScheduleEntity.MasterSource:= nil;
  tblScheduleEntity.MasterFields:= '';
  For vintLoop := 0 to High(carrEntity) do
     begin
     if carrEntity[vintLoop] = 0 then
         break;
     tblScheduleEntity.append;
     tblScheduleEntity.fieldbyname('ApptTicket').asinteger :=
                                                           vintSaveAppt;
     tblScheduleEntity.fieldbyname('Entity').asinteger :=
                                                           carrEntity[vintLoop];
     try
     tblScheduleEntity.post;
     except
       tblScheduleEntity.cancel;
       end;
     end;
  {------------}
  qryUnscheduled.FlushBuffers;
  tblScheduleEntity.FlushBuffers;
  tblAppointmentTicket.FlushBuffers;
  {------------}
  tblScheduleEntity.MasterSource:= dtsAppointment;
  tblScheduleEntity.MasterFields:= 'ApptTicket';
  InitializeDayScheduler;
  LoadDayScheduler;
  Result:=true;
  end;

procedure tdtmScheduler.NewAppointment;
var vintNext: integer;
begin
   tblAppointmentTicket.FlushBuffers;
   tblAppointmentTicket.Refresh;
   If tblAppointmentTicket.recordcount > 0 then
     begin
     tblAppointmentTicket.last;
     vintNext:= tblAppointmentTicket.FieldByName('ApptTicket').asinteger + 1;
     end
   else
     vintNext:= cintAppointment + 1;

   tblAppointmentTicket.Append;
   tblAppointmentTicket.Fieldbyname('ApptTicket').asinteger := vintNext;
   tblAppointmentTicket.Fieldbyname('ApptDuration').asinteger := 15;
   tblAppointmentTicket.Fieldbyname('ApptDateTime').asdatetime := date;
   tblAppointmentTicket.Fieldbyname('ApptScheduled').asboolean := false;
   tblAppointmentTicket.Fieldbyname('ApptSchedulePend').asboolean := true;
   tblAppointmentTicket.Fieldbyname('ApptFee').asfloat := 0;
   tblAppointmentTicket.Fieldbyname('ApptBilled').asboolean := false;
   tblAppointmentTicket.Fieldbyname('Entity').asinteger :=
                                      qryEntity.fieldbyname('Entity').asinteger;
   try
   tblAppointmentTicket.post;
   except
     tblAppointment.Cancel;
     end;
end;

procedure TdtmScheduler.DataModuleCreate(Sender: TObject);
begin
{Open databases and arrange cascades}
qryUnscheduled.open;
tblAppointment.indexname:= 'ApptDateTime';
tblAppointment.open;
tblAppointmentTicket.open;
tblScheduleEntity.open;
tblScheduleEntity.MasterSource:= dtsAppointment;
tblScheduleEntity.MasterFields:= 'ApptTicket';
tblEntity.open;
tblPatient.open;
tblPatient.MasterSource:= dtsEntity;
tblPatient.MasterFields:= 'Entity';
tblHouseHold.open;
tblHouseHold.MasterSource:= dtsEntity;
tblHouseHold.MasterFields:= 'EntityHouseHold';
tblApptYear.Open;

end;

procedure TdtmScheduler.ShutDownScheduler;
begin
  tblAppointment.flushbuffers;
  tblAppointmentTicket.flushbuffers;
  tblScheduleEntity.flushbuffers;
  tblEntity.flushbuffers;
  tblPatient.flushbuffers;
  tblHouseHold.flushbuffers;
  tblAppointment.close;
  tblApptYear.close;
  tblAppointmentTicket.close;
  tblScheduleEntity.close;
  tblEntity.close;
  tblPatient.close;
  tblHouseHold.close;
end;
end.
