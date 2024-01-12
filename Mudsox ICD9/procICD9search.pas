unit procICD9search;

{This is the main unit to load and organize the ICD9 tables for high-speed  
processing}
interface

{
^ and #170    Link
^ and #171    Include
^ and #172    Exclude
^ and #173    Notes
^ and #174    4 digit
^ and #175    5 digit
^ and #176    Chapter
^ and #177    Section
^ and #178    Verify- Lowest Level
^ and #179    Search match tag
}

uses Windows, SysUtils, Classes, forms;

{Initialize routine for the ISAPI DLL}
function ICD9LoadAndPrepare(const cstrICD9path: string): boolean;

var
   vstlICD9: tstringlist;
   vstlICD9Index: tstringlist;
   vstlICD9Pre: tstringlist;
   vstlLogA: tstringlist;
   vstlLogB: tstringlist;
   varrReg: array [1..1000] of integer;
   varrV: array [1..100] of integer;
   varrE: array [1..200] of integer;
   varrIndex: array [1..700] of integer;
   vintSectionStart, vintDetailStart: integer;
   vstrHoldAppPath: string;
   vstrPath: string;
   vstrWebAddress: string;
   vstrRootFolder: string;
//const
// cstrPalmLit: string = 'Palm';

implementation

function ICD9LoadAndPrepare(const cstrICD9path: string): boolean;
var vintLoop: integer;
    vbolStart: boolean;
    vstrTest: string;
begin

vstrRootFolder:= copy(ExtractFilePath(cstrICD9path), 1,
                  pos('cgi-bin', ExtractFilePath(cstrICD9path)) - 1);

If vstlICD9pre <> nil then
   begin
   Result:= true;
   exit;
   end;

for vintLoop:= 1 to 1000 do
  begin
  varrReg[vintLoop]:= 0;
  If vintLoop < 200 then
    varrE[vintLoop]:= 0;
  If vintLoop < 100 then
    varrV[vintLoop]:= 0;
  If vintLoop < 700 then
    varrIndex[vintLoop]:= 0;
  end;

vstlICD9pre:= tstringlist.create;
vstlICD9:= tstringlist.create;
vstlICD9Index:= tstringlist.create;

vstlLogA:= tstringlist.create;
vstlLogB:= tstringlist.create;

{Load the IP setting}
vstlICD9pre.loadfromfile(vstrRootFolder + '\data\IP.INI');
vstrWebAddress:= vstlICD9pre[0];
vstlICD9pre.clear;

vstlICD9pre.loadfromfile(vstrRootFolder + '\data\ICD9Prefix.txt');
vstlICD9.loadfromfile(vstrRootFolder + '\data\ICD9Data.txt');
vstlICD9Index.loadfromfile(vstrRootFolder + '\data\ICD9Index.txt');

{Calculate the position of "no decimal" locations in the string list for the
regular ICD9 data}
vbolStart:= false;
for vintLoop:= 1 to vstlICD9.Count - 1 do
  begin
  vstrTest:= vstlICD9[vintLoop];
  If copy(vstrTest,1,5) = '=DONE' then
  else
  If copy(vstrTest,1,8) = '=DETAILS' then
     begin
     vbolStart:= true;
     vintDetailStart:= vintLoop;
     end
  else
  If copy(vstrTest,1,8) = '=SECTION' then
     vintSectionStart:= vintLoop
  else
  If vbolStart then
    If (vstrTest[1] = 'E') and
       (varrE[strtoint(copy(vstrTest,2,3))-799] = 0) then
       varrE[strtoint(copy(vstrTest,2,3))-799]:= vintLoop
    else
    If (vstrTest[1] = 'V') and
       (varrV[strtoint(copy(vstrTest,2,2))] = 0) then
       varrV[strtoint(copy(vstrTest,2,2))]:= vintLoop
    else
    If (vstrTest[1] <> 'E') and
       (vstrTest[1] <> 'V') then
       If (varrReg[strtoint(copy(vstrTest,1,3))] = 0) then
          varrReg[strtoint(copy(vstrTest,1,3))]:= vintLoop;
  end;

{Initialize the logging system}
vstrHoldAppPath:= cstrICD9path;
//LogIT('Initialization complete');
Result:=true;
end;

end.
