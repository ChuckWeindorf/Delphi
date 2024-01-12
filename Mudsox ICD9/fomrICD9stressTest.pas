unit fomrICD9stressTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure WebBrowser1NavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    vstlCodes: tstringList;
    vintTextPos: integer;
    vreaStart: real;
    vbolStop: boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var vintLoop: integer;
begin
vstlCodes:= tstringlist.create;
vstlCodes.loadfromfile('icd9prefix.txt');
vintLoop:= 0;
vintTextPos:= 0;
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
vbolStop:= false;
webbrowser1.Navigate('http://24.52.53.167:81/default.htm');
vreaStart:= now;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
If vstlCodes = nil then
else
   vstlCodes.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
vbolStop:= true;
end;

procedure TForm1.WebBrowser1NavigateComplete2(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
//timer1.enabled:= false;
application.processmessages;
If vintTextPos = vstlCodes.count then
  vintTextPos:= 0;
If vbolStop then exit
else
 webbrowser1.Navigate('http://24.52.53.167:81/cgi-bin/MudsoxICD9.DLL/Code?Code='
    + vstlCodes[vintTextPos]);
edit1.text:= vstlCodes[vintTextPos];
edit2.text:= inttostr(vintTextPos);
If vintTextPos > 0 then
   edit4.text:= floattostr(((now - vreaStart)/vintTextPos)*(3600*24));
inc(vintTextPos);
Sleep(strtoint(RadioGroup1.Items[RadioGroup1.ItemIndex]));
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
//webbrowser1.Navigate('http://192.168.0.1/default.htm');
end;

end.
