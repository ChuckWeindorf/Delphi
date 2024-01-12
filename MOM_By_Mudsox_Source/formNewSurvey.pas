unit formNewSurvey;
{Author: Chuck Weindorf
 Description: Dialog to select the Survey rules that will apply to this
 instance of a survey.

 Date: 08/20/1999 - CEW - New
  }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ToolWin, ComCtrls, Grids, DBGrids, dbtables, db;

type
  TfrmNewSurvey = class(TForm)
    ToolBar1: TToolBar;
    cmdOK: TBitBtn;
    spl1: TSplitter;
    pnl1: TPanel;
    grdSurveyList: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure grdSurveyListDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewSurvey: TfrmNewSurvey;
  vqrySurveyList: tquery;
  vdtsSurveyList: tdatasource;

implementation
uses procSharedDatamoduleCalls;

{$R *.DFM}

procedure TfrmNewSurvey.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
vqrySurveyList.Free;
vdtsSurveyList.Free;
Action := caFree;
end;

procedure TfrmNewSurvey.FormCreate(Sender: TObject);
begin
vqrySurveyList := tquery.create(frmNewSurvey);
vqrySurveyList.DatabaseName := 'mmom_Maindatabase';
vqrySurveyList.RequestLive := false;
vqrySurveyList.Unidirectional := true;
vqrySurveyList.SQL.add
                    ('Select Distinct SurveyID, SurveyEdition from SurveyRule');
vqrySurveyList.Open;
vdtsSurveyList := tdatasource.create(frmNewSurvey);
vdtsSurveyList.dataset := vqrySurveyList;
grdSurveyList.datasource := vdtsSurveyList;
end;

procedure TfrmNewSurvey.cmdOKClick(Sender: TObject);
begin
grdSurveyListDblClick(Sender);
end;

procedure TfrmNewSurvey.FormActivate(Sender: TObject);
begin
grdSurveyList.SetFocus;
end;

procedure TfrmNewSurvey.grdSurveyListDblClick(Sender: TObject);
begin
vstrCurrentSurveyID := vqrySurveyList.FieldByName('SurveyID').asstring;
vdatCurrentSurveyEdition :=
                         vqrySurveyList.FieldByName('SurveyEdition').asdatetime;
Close;
end;

end.
