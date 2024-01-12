unit pmutilities;

interface
uses sysutils;

 procedure Logit(const cstrLog: string);

 var
 vstrAppBaseFolder: string;
 vstrSessionType: string;

implementation

{Logging}
procedure Logit(const cstrLog: string);
var vstrWork: string;
    vfilLog: textfile;
begin
vstrWork:= datetimetostr(now) + ' ' + cstrLog;
assignfile(vfilLog, vstrAppBaseFolder + 'ScriptWave' + vstrSessionType + '.log');
If not fileexists(vstrAppBaseFolder + 'ScriptWave' + vstrSessionType + '.log') then
   rewrite(vfilLog)
else
   Append(vfilLog);
writeln(vfilLog, vstrWork);
closefile(vfilLog);
end;

end.
