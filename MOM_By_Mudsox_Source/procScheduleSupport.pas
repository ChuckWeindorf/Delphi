unit procScheduleSupport;
{Author: Chuck Weindorf
 Description: Contain all array and array manipulation routines for a scheduler
 form

 Date: 10/02/1999 - CEW - New
  }


interface
uses procSharedDatamoduleCalls, dataMainDatamodule, dbtables, sysutils;

var
  varrDaySchedule: array[1..50, 1..96, 1..3] of LongInt;
  varrDayDuration: array[1..50, 1..96] of Integer;
  varrEntity: array[1..50] of LongInt;
  varrName: array[1..50] of string[30];
  vtimMin, vtimMax: tdatetime;
  vintStartPoint: integer;

{Manage the scheduling arrays}
Procedure InitializeEntityScheduler;
Procedure LoadEntityScheduler;
Procedure InitializeDayScheduler;
Procedure LoadDayScheduler(var vdtmMainLocal: tdtmMain);

{Convert database time fields to the integer for the schedule array}
Function TimeToArray(const cdatSchedule: tdatetime): integer;
Function ArrayToTime(const cintArray: integer;
                     const cdatDateTime: tdatetime): tdatetime;
Function UnScheduleAppointment(vdtmMainLocal: tdtmMain): boolean;
Function ScheduleAppointment(const cintArray: integer;
                             const cdatDate: tdatetime;
                             const cintDuration: integer;
                                   vdtmMainLocal: tdtmMain;
                             const cstrComplaint: string;
                             const cstrDescription: string;
                             const carrEntity: array of LongInt): boolean;
implementation

{Clear all references to entities}
Procedure InitializeEntityScheduler;
  var vintLoop: integer;
begin
For vintLoop:= 1 to 50 do
   begin
   varrEntity[vintLoop] := 0;
   varrName[vintLoop] := '';
   end;
end;

{Clear all references to entities}
Procedure LoadEntityScheduler;
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
Procedure InitializeDayScheduler;
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
Procedure LoadDayScheduler(var vdtmMainLocal: tdtmmain);
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
                                        vdtmMainLocal.qryAppointment.Fieldbyname
                                                       ('ApptTicket').asinteger;
              break;
              end;
       end;
begin
{If the requested date on the scheduler has changed, rerun ther query for
scheduled appointments...}
If vdatScheduleDate <> vdatLastDate then
  begin
  vdtmMainLocal.qryAppointment.close;
  vdtmMainLocal.qryAppointment.SQL[2]:=
     'Where CAST(ApptDateTime AS DATE) = "' + datetostr(vdatScheduleDate) + '"';
  vdatLastDate:= vdatScheduleDate;
  vdtmMainLocal.qryAppointment.open;
  end;
{Exit without data on the schedule}
If vdtmMainLocal.qryAppointment.recordcount = 0 then
   exit;
vdtmMainLocal.qryAppointment.First;
{Loop through all scheduled appointments...}
while not vdtmMainLocal.qryAppointment.eof do
   begin
   {There are invited entities to this appointment, add to display...}
   If vdtmMainLocal.qryScheduleEntity.RecordCount > 0 then
     begin
     vintTimeSlot := TimeToArray(vdtmMainLocal.qryAppointment.Fieldbyname
                                                   ('ApptDateTime').asdatetime);
     {0 would be a failed calculation or exactly midnight - do not put in the
      array}
     If vintTimeSlot > 0 then
        while not vdtmMainLocal.qryScheduleEntity.eof do
           begin
           {Find the entity position in the schedule array}
           For vintLoop:= 1 to 50 do
             If varrEntity[vintLoop] = vdtmMainLocal.qryScheduleEntity.
                                            fieldbyname('Entity').asinteger then
               break;
           {We found the valid entity in the array}
           If (vintLoop > 0) and (vintLoop < 50) then
             begin
             {Store the duration for quick box drawing}
             varrDayDuration[vintLoop, vintTimeSlot] :=
                   vdtmMainLocal.qryAppointment.Fieldbyname
                                                     ('ApptDuration').asinteger;
             vintArrayDuration := strtoint(floattostr(Int(
                                 varrDayDuration[vintLoop, vintTimeSlot]/ 15)));
             {Place the ApptTicket number in each spot based on the duration}
             For vintLoop2 := 0 to vintArrayDuration - 1 do
                 PlaceInScheduleArrayLoop;
             end;
           {Get the next person in the entities being scheduled}
           vdtmMainLocal.qryScheduleEntity.next;
           end;
     end;
   vdtmMainLocal.qryAppointment.Next;
   vdtmMainLocal.qryScheduleEntity.First;
   end;
end;

{The Appointment table stores the date/time of an appointment in the database
format while the screen program will use an array for rapid display.}
Function TimeToArray(const cdatSchedule: tdatetime): integer;
  var vreaTimeWork: double;
  begin
  vreaTimeWork:= cdatSchedule - Int(cdatSchedule);
  If vreaTimeWork <> 0 then
     vreaTimeWork:= vreaTimeWork / crea_15_Minutes;
  Result:= round(vreaTimeWork);
  end;

{Take the current array position and convert that to a datatime that will be
placed into the current appointment.}
Function ArrayToTime(const cintArray: integer;
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
Function UnScheduleAppointment(vdtmMainLocal: tdtmMain): boolean;
begin
  Result := false;
  If not EditDataSets(vdtmMainLocal) then
     exit;
  vdtmMainLocal.qryAppointment.edit;
  vdtmMainLocal.qryAppointment.fieldbyname('ApptScheduled').asboolean := false;
  vdtmMainLocal.qryAppointment.fieldbyname
                                         ('ApptSchedulePend').asboolean := true;
  vdtmMainLocal.qryAppointment.fieldbyname('ApptDateTime').asdatetime := 0;
  vdtmMainLocal.qryAppointment.fieldbyname('ApptDuration').asinteger := 0;
  PostEvent(vdtmMainLocal.qryAppointment);
  while vdtmMainLocal.qryScheduleEntity.recordcount > 0 do
        vdtmMainLocal.qryScheduleEntity.delete;
  If not ApplyDataSets(vdtmMainLocal) then
     exit;
  vdtmMainLocal.qryUnScheduled.close;
  vdtmMainLocal.qryUnScheduled.open;
  InitializeDayScheduler;
  LoadDayScheduler(vdtmMainLocal);
  Result := true;
end;

{Take the current unscheduled appointment and schedule it based on the
Array position selected.  Also create all entity records.  Refresh the
array based on the changes to the schedule database}
Function ScheduleAppointment(const cintArray: integer;
                             const cdatDate: tdatetime;
                             const cintDuration: integer;
                                   vdtmMainLocal: tdtmMain;
                             const cstrComplaint: string;
                             const cstrDescription: string;
                             const carrEntity: array of LongInt): boolean;
  var vintSaveAppt: longint;
      vintLoop: integer;
  begin
  Result:= false;
  If vdtmMainLocal.qryUnScheduled.RecordCount = 0 then
     exit;
  If not EditDataSets(vdtmMainLocal) then
     exit;
  vdtmMainLocal.qryUnScheduled.edit;
  vdtmMainLocal.qryUnScheduled.fieldbyname('ApptScheduled').asboolean := true;
  vdtmMainLocal.qryUnScheduled.fieldbyname
                                        ('ApptSchedulePend').asboolean := false;
  vdtmMainLocal.qryUnScheduled.fieldbyname('ApptDateTime').asdatetime :=
                                               ArrayToTime(cintArray, cdatDate);
  vdtmMainLocal.qryUnScheduled.fieldbyname('ApptDuration').asinteger :=
                                                                   cintDuration;
  vdtmMainLocal.qryUnScheduled.fieldbyname('ApptComplaint').asstring :=
                                                                  cstrComplaint;
  vdtmMainLocal.qryUnScheduled.fieldbyname('ApptComplaintText').asstring :=
                                                                cstrDescription;
  PostEvent(vdtmMainLocal.qryUnScheduled);
  {Before repositioning the datasets, save the appointment ticket}
  vintSaveAppt:=
               vdtmMainLocal.qryUnScheduled.fieldbyname('ApptTicket').asinteger;
  {Refresh the queries to show the appointment in the Appointment dataset}
  If not ApplyDataSets(vdtmMainLocal) then
     exit;
  vdtmMainLocal.qryAppointment.close;
  vdtmMainLocal.qryAppointment.open;
  If not vdtmMainLocal.qryAppointment.Locate
                                           ('ApptTicket', vintSaveAppt, []) then
      exit;
  If not EditDataSets(vdtmMainLocal) then
     exit;
  {Add all entities that will be scheduled into this appointment}
  For vintLoop := 0 to High(carrEntity) do
     begin
     if carrEntity[vintLoop] = 0 then
         break;
     vdtmMainLocal.qryScheduleEntity.append;
     vdtmMainLocal.qryScheduleEntity.fieldbyname('ApptTicket').asinteger :=
                                                           vintSaveAppt;
     vdtmMainLocal.qryScheduleEntity.fieldbyname('Entity').asinteger :=
                                                           carrEntity[vintLoop];
     PostEvent(vdtmMainLocal.qryScheduleEntity);
     end;
  If not ApplyDataSets(vdtmMainLocal) then
     exit;
  InitializeDayScheduler;
  LoadDayScheduler(vdtmMainLocal);
  Result:=true;
  end;
end.
