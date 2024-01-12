unit formNewSurveyRule;
{Author: Chuck Weindorf
 Description: Determine if the user wants to Create, Clone or Edit a set of
 Survey rules.  This is done just prior

 Date: 08/20/1999 - CEW - New
  }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, ExtCtrls, Buttons, dbtables, db;

type
  TfrmNewSurveyRule = class(TForm)
    pnlTitle: TPanel;
    pnlExisting: TPanel;
    cmdOK: TBitBtn;
    radNewUsed: TRadioGroup;
    grdExistingSurveyRule: TDBGrid;
    edtSurveyTitle: TEdit;
    lbl_00001: TLabel;
    edtEdition: TEdit;
    lbl_00002: TLabel;
    procedure radNewUsedClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtSurveyTitleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdExistingSurveyRuleDblClick(Sender: TObject);
    procedure grdExistingSurveyRuleCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewSurveyRule: TfrmNewSurveyRule;
  vqrySurveyList: tquery;
  vdtsSurveyList: tdatasource;
  vqrySurveyRecordsOld: tquery;
  vqrySurveyRecordsNew: tquery;

implementation

uses procSharedDatamoduleCalls;
{$R *.DFM}

{The type of Survey activity is defined here.  Modify some of the field values
based on the type of change being made.}
procedure TfrmNewSurveyRule.radNewUsedClick(Sender: TObject);
begin
{If the current database is empty, do not allow edits or clones}
If vqrySurveyList.recordCount = 0 then
   radNewUsed.ItemIndex := 0;

{0 = Set up a completely new survey and edition date}
{1 = Clone all entries of the selected Survey to build a new Survey}
If (radNewUsed.ItemIndex = 0) or (radNewUsed.ItemIndex = 1)then
   begin
   edtSurveyTitle.text := '';
   edtSurveyTitle.readonly := false;
   edtEdition.text := datetostr(date);
   cmdOK.enabled := false;
   edtSurveyTitle.setfocus;
   end
else
{Allow edit if there are existing SurveyRule records}
If (radNewUsed.ItemIndex = 2) then
  begin
  edtSurveyTitle.text := vqrySurveyList.fieldbyname('SurveyID').asstring;
  edtEdition.text := vqrySurveyList.fieldbyname('SurveyEdition').asstring;
  cmdOK.enabled := true;
  edtSurveyTitle.readonly := true;
  end;
end;

{Create or edit the correct Survey Rule combination based on the user's
 selection}
procedure TfrmNewSurveyRule.cmdOKClick(Sender: TObject);
begin
{Save the values of the Survey to be displayed or created}
vdatCurrentSurveyEdition := strtodate(edtEdition.text);
vstrCurrentSurveyID := edtSurveyTitle.text;

{Clone all entries of the selected Survey to build a new Survey as long as the
same ID and edition of the new survey don't exist}
If (radNewUsed.ItemIndex = 1) and
   (not vqrySurveyList.locate('SurveyID;SurveyEdition',VarArrayOf
                      ([vstrCurrentSurveyID,vdatCurrentSurveyEdition]),[])) then
  begin
  {Dynamic rule list for the selection grid}
  vqrySurveyRecordsOld := tquery.create(nil);
  vqrySurveyRecordsNew := tquery.create(nil);
  try
  {Open and focus the existing records for the rule table}
  vqrySurveyRecordsOld.DatabaseName := 'mmom_Maindatabase';
  vqrySurveyRecordsOld.RequestLive := false;
  vqrySurveyRecordsOld.Unidirectional := true;
  vqrySurveyRecordsOld.SQL.add('Select * from SurveyRule');
  vqrySurveyRecordsOld.SQL.add('Where SurveyID = "' +
                    vqrySurveyList.fieldbyname('SurveyID').asstring + '"');
  vqrySurveyRecordsOld.SQL.add('and SurveyEdition = "' +
                    vqrySurveyList.fieldbyname('SurveyEdition').asstring + '"');
  vqrySurveyRecordsOld.Open;
  {Open the new record table }
  vqrySurveyRecordsNew.DatabaseName := 'mmom_Maindatabase';
  vqrySurveyRecordsNew.RequestLive := true;
  vqrySurveyRecordsNew.SQL.add('Select * from SurveyRule');
  vqrySurveyRecordsNew.SQL.add('Where SurveyID = ""');
  vqrySurveyRecordsNew.Open;
  {Copy all records by changing the key to the new value}
  CloneRecords(vqrySurveyRecordsOld, vqrySurveyRecordsNew,
                     [vstrCurrentSurveyID, vdatCurrentSurveyEdition]);
  vqrySurveyRecordsOld.close;
  vqrySurveyRecordsNew.close;
  {Open and focus the existing records for the Questions table}
  vqrySurveyRecordsOld.DatabaseName := 'mmom_Maindatabase';
  vqrySurveyRecordsOld.RequestLive := false;
  vqrySurveyRecordsOld.Unidirectional := true;
  vqrySurveyRecordsOld.SQL.clear;
  vqrySurveyRecordsOld.SQL.add('Select * from SurveyQuestion');
  vqrySurveyRecordsOld.SQL.add('Where SurveyID = "' +
                    vqrySurveyList.fieldbyname('SurveyID').asstring + '"');
  vqrySurveyRecordsOld.SQL.add('and SurveyEdition = "' +
                    vqrySurveyList.fieldbyname('SurveyEdition').asstring + '"');
  vqrySurveyRecordsOld.Open;
  {Open the new record table }
  vqrySurveyRecordsNew.DatabaseName := 'mmom_Maindatabase';
  vqrySurveyRecordsNew.RequestLive := true;
  vqrySurveyRecordsNew.SQL.clear;
  vqrySurveyRecordsNew.SQL.add('Select * from SurveyQuestion');
  vqrySurveyRecordsNew.SQL.add('Where SurveyID = ""');
  vqrySurveyRecordsNew.Open;
  {Copy all records by changing the key to the new value}
  CloneRecords(vqrySurveyRecordsOld, vqrySurveyRecordsNew,
                     [vstrCurrentSurveyID, vdatCurrentSurveyEdition]);
  vqrySurveyRecordsOld.close;
  vqrySurveyRecordsNew.close;
  finally
    vqrySurveyRecordsOld.free;
    vqrySurveyRecordsOld := nil;
    vqrySurveyRecordsNew.free;
    vqrySurveyRecordsNew := nil;
    end;
  {Get the cloned rule record available to the SurveyList and continue}
  vqrySurveyList.close;
  vqrySurveyList.open;
  end;

{If this same survey key already exists, just show it - do not add the record
 to the database}
If not vqrySurveyList.locate('SurveyID;SurveyEdition',VarArrayOf
                 ([vstrCurrentSurveyID,vdatCurrentSurveyEdition]),[]) then
   begin
   vqrySurveyList.append;
   vqrySurveyList.fieldbyname('SurveyID').asstring := vstrCurrentSurveyID;
   vqrySurveyList.fieldbyname('SurveyEdition').asdatetime :=
                                                       vdatCurrentSurveyEdition;
   try
      vqrySurveyList.post;
      except
      {Possibly a corrupt file to make it this far.}
      vqrySurveyList.cancel;
      ShowMessage('SurveyRule may be corrupt - unable to add record');
      end;
   end;
close;
end;

{Clean up all dynamic items at the time the form is closed and freed...}
procedure TfrmNewSurveyRule.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
vqrySurveyList.Free;
vdtsSurveyList.Free;
Action := caFree;
end;

procedure TfrmNewSurveyRule.edtSurveyTitleChange(Sender: TObject);
begin
{There must be a valid entry in the name to continue...}
If length(edtSurveyTitle.text) > 0 then
   cmdOK.enabled := true
else
   cmdOK.enabled := false;
end;

{Initialize all dynamic items.}
procedure TfrmNewSurveyRule.FormCreate(Sender: TObject);
begin
{Dynamic rule list for the selection grid}
vqrySurveyList := tquery.create(frmNewSurveyRule);
vqrySurveyList.DatabaseName := 'mmom_Maindatabase';
vqrySurveyList.RequestLive := true;
vqrySurveyList.SQL.add('Select SurveyID, SurveyEdition from SurveyRule');
vqrySurveyList.Open;
{The datasource for the query above}
vdtsSurveyList := tdatasource.create(frmNewSurveyRule);
vdtsSurveyList.dataset := vqrySurveyList;
{Link the datasource to the grid}
grdExistingSurveyRule.datasource := vdtsSurveyList;
end;

procedure TfrmNewSurveyRule.grdExistingSurveyRuleDblClick(Sender: TObject);
begin
{On double-click set up the radio buttons if neded}
If radNewUsed.ItemIndex = -1 then
   radNewUsed.ItemIndex := 2;
radNewUsedClick(Sender);
end;

procedure TfrmNewSurveyRule.grdExistingSurveyRuleCellClick(
  Column: TColumn);
begin
 grdExistingSurveyRuleDblClick(Self);
end;

end.
