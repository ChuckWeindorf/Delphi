unit formDataGraph;
{Author: Chuck Weindorf
 Description: Allow the user to graph database results

 Date: 04/19/2000 - CEW - New
  }


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeeProcs, TeEngine, Chart, ExtCtrls, ToolWin, ComCtrls, Series, DBChart,
  Buttons;

type
  TfrmDatabaseGraph = class(TForm)
    ToolBar1: TToolBar;
    pnlGraph: TPanel;
    crtPie: TDBChart;
    Series1: TPieSeries;
    cmdexit: TSpeedButton;
    cmdPrev: TSpeedButton;
    spl1: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdPrevClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDatabaseGraph: TfrmDatabaseGraph;

implementation
uses procSharedDatamoduleCalls;
{$R *.DFM}

procedure TfrmDatabaseGraph.FormCreate(Sender: TObject);
begin
crtPie.Series[0].DataSource:=vqryQuickReport;
crtPie.Series[0].yvalues.ValueSource:='counter';
crtPie.Series[0].xlabelssource:=vqryQuickReport.fields[0].displayname;
end;

procedure TfrmDatabaseGraph.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmDatabaseGraph.cmdPrevClick(Sender: TObject);
begin
crtPie.printlandscape;
end;

end.
