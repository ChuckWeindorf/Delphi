unit Count1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    Memo2: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
memo1.lines.LoadFromFile('..\ICD9prefix.txt');
end;

procedure TForm1.Button2Click(Sender: TObject);
var vintLoop, vintLow: integer;
begin
vintLoop:= 0;
while copy(memo1.lines[vintLoop],1,3) <> '001' do
   inc(vintLoop);
vintLow:= vintLoop;
inc(vintLoop);
memo2.lines.text:= '001';
while vintLoop < memo1.lines.count do
   begin
   If pos('.', copy(memo1.lines[vintLoop],1,5)) = 0 then
      begin
      memo2.lines[memo2.lines.count - 1] :=
          memo2.lines[memo2.lines.count - 1] + ',' +
                                 inttostr(vintLoop - vintLow);
      memo2.lines.add(copy(memo1.lines[vintLoop],
                                 1,
                                 pos('^', memo1.lines[vintLoop]) - 1));
      vintLow:= vintLoop;
      end;
   inc(vintLoop);
   end;
memo2.lines[memo2.lines.count - 1] :=
            memo2.lines[memo2.lines.count - 1] + ',' +
            inttostr(vintLoop - vintLow);
memo2.lines.savetofile('codesummary.txt');
end;

end.
