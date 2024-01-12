unit formICD9Search;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, procICD9search;

type
  TfrmICD9Search = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    memTimes: TMemo;
    Edit1: TEdit;
    Button2: TButton;
    Memo1: TMemo;
    Button3: TButton;
    Button4: TButton;
    Section: TButton;
    Button5: TButton;
    Button6: TButton;
    Timer1: TTimer;
    Button7: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SectionClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    vreaStart: real;
    { Private declarations }
    Procedure StartTime;
    Procedure EndTime;
  public
    { Public declarations }
  end;

var
  frmICD9Search: TfrmICD9Search;

implementation

{$R *.DFM}

procedure TfrmICD9Search.Button1Click(Sender: TObject);
begin
StartTime;
ICD9LoadAndPrepare('.\');
EndTime;
timer1.enabled:=true;
end;

procedure TfrmICD9Search.StartTime;
begin
vreaStart:= now;
end;

procedure TfrmICD9Search.EndTime;
begin
memtimes.lines.add(floattostr((now-vreastart)*3600*24));
end;

procedure TfrmICD9Search.Button2Click(Sender: TObject);
  var vstlX: tstringlist;
begin
LogIT('Get code');
  vstlX:= tstringlist.create;
  StartTime;
  memo1.text:= ICD9GetCode(edit1.text, false, vstlX);
  memo1.text:= memo1.text + #13#10 + vstlX.text;
  EndTime;
  vstlX.free;
end;

procedure TfrmICD9Search.Button3Click(Sender: TObject);
var vstlOz, vstlLinks: tstringlist;
begin
  StartTime;
  vstlOz:= tstringlist.create;
  vstlLinks:= tstringlist.create;
  ICD9Search(edit1.text, vstlOZ, vstlLinks);
  memo1.lines.assign(vstlOZ);
  vstlOz.free;
  vstlLinks.free;
  EndTime;
end;

procedure TfrmICD9Search.Button4Click(Sender: TObject);
var vstlOz: tstringlist;
begin
  StartTime;
  vstlOz:= tstringlist.create;
  ICD9Chapter(vstlOZ);
  memo1.lines.assign(vstlOZ);
  vstlOz.free;
  EndTime;
end;


procedure TfrmICD9Search.SectionClick(Sender: TObject);
var vstlOz: tstringlist;
begin
  StartTime;
  vstlOz:= tstringlist.create;
  ICD9Section(edit1.text,vstlOZ);
  memo1.lines.assign(vstlOZ);
  vstlOz.free;
  EndTime;
end;

procedure TfrmICD9Search.Button5Click(Sender: TObject);
  var vstlX, vstlCodes: tstringlist;
      vintLoop: integer;
begin
vstlCodes:= tstringlist.create;
vstlX:= tstringlist.create;
try
vstlCodes.loadfromfile('icd9prefix.txt');
vintLoop:= 0;
while vintLoop < vstlCodes.count do
   begin
   If copy(vstlCodes[vintLoop],1,1) = '^' then
      vstlCodes[vintLoop]:= ''
   else
      vstlCodes[vintLoop]:=
                    copy(vstlCodes[vintLoop],1,pos('^', vstlCodes[vintLoop])-1);
   If length(vstlCodes[vintLoop]) = 0 then
      vstlCodes.delete(vintLoop)
   else
      inc(vintLoop);
   end;
vintLoop:= 0;
StartTime;
while vintLoop < vstlCodes.count do
  begin
  ICD9GetCode(vstlCodes[vintLoop], false, vstlX);
  memo1.text:= vstlX.text;
  vstlX.clear;
  inc(vintLoop);
  application.processmessages;
  end;
EndTime;
finally
  vstlX.free;
  vstlCodes.free;
  end
end;

procedure TfrmICD9Search.Button6Click(Sender: TObject);
var vintLoop: integer;
begin
for vintLoop:= 1 to 700 do
   memo1.lines.add(inttostr(vintLoop) + ' ' + inttostr(varrIndex[vintLoop]));
end;

procedure TfrmICD9Search.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
ICD9free;
end;

procedure TfrmICD9Search.Timer1Timer(Sender: TObject);
begin
LogCheck;
end;

procedure TfrmICD9Search.Button7Click(Sender: TObject);
begin
memo1.lines.add(vstlICD9Index[strtoint(edit1.text)]);
end;

end.
