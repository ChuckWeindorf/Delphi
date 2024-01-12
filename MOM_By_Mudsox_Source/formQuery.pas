unit formQuery;
{Author: Chuck Weindorf
 Description: All the user to create database searches with easy pick lists.
 Convert the selections into SQ Land connect related tables by using the entity
 field.

 Date: 02/29/2000 - CEW - New
  }


interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  dataMainDatamodule, StdCtrls, DBCtrls, Grids, DBGrids, ExtCtrls, Buttons,
  ToolWin, ComCtrls, Db, DBTables, Mask;

type
  TfrmQuery = class(TForm)
    tbrTools: TToolBar;
    cmdNew: TSpeedButton;
    spl2: TSplitter;
    cmdexit: TSpeedButton;
    cmdVideo: TSpeedButton;
    cmdHelp: TSpeedButton;
    cmdSave: TSpeedButton;
    cmdEdit: TSpeedButton;
    cmdCancel: TSpeedButton;
    cmdDelete: TSpeedButton;
    spl1: TSplitter;
    pnlAnswers: TPanel;
    pnlAdmin: TPanel;
    pnlQueryList: TPanel;
    grdAnswers: TDBGrid;
    grdQueryList: TDBGrid;
    pnlAdmin2: TPanel;
    pnlCurrent: TPanel;
    cboLogical: TComboBox;
    edtCompare: TEdit;
    cboPickList: TComboBox;
    qrySearches: TQuery;
    qryPickList: TQuery;
    dtsSearches: TDataSource;
    qryFields: TQuery;
    cboFields2: TComboBox;
    pnlSelectAdd: TPanel;
    cboFields1: TComboBox;
    cmdNewField1: TSpeedButton;
    cmdNewField2: TSpeedButton;
    cmdSearch: TSpeedButton;
    qryQuery: TQuery;
    dtsQuery: TDataSource;
    pnlSelect: TPanel;
    lstSelect: TListBox;
    pnlWhere: TPanel;
    lstWhere: TListBox;
    cmdDelSelect: TSpeedButton;
    cmdDelWhere: TSpeedButton;
    lbl9001: TLabel;
    lbl9002: TLabel;
    lbl9003: TLabel;
    lbl9004: TLabel;
    cmdMoveUp: TSpeedButton;
    cmdMoveDown: TSpeedButton;
    chkCount: TCheckBox;
    lbl9009: TLabel;
    edtQueryName: TDBEdit;
    cmdPrev: TSpeedButton;
    cmdGraph: TSpeedButton;
    chkGraph: TCheckBox;
    lbl_10001: TLabel;
    edtLines: TEdit;
    Label1: TLabel;
    edtCount: TEdit;
    chkDistinct: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cboLogicalChange(Sender: TObject);
    procedure cboFields2Change(Sender: TObject);
    procedure cmdNewField2Click(Sender: TObject);
    procedure cmdNewField1Click(Sender: TObject);
    procedure cboFields1Change(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
    procedure cmdSearchClick(Sender: TObject);
    procedure cmdDelSelectClick(Sender: TObject);
    procedure cmdDelWhereClick(Sender: TObject);
    procedure cmdMoveUpClick(Sender: TObject);
    procedure cmdMoveDownClick(Sender: TObject);
    procedure lstSelectClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure dtsSearchesDataChange(Sender: TObject; Field: TField);
    procedure lstWhereClick(Sender: TObject);
    procedure grdAnswersDblClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdPrevClick(Sender: TObject);
    procedure cmdGraphClick(Sender: TObject);
    procedure chkCountClick(Sender: TObject);
  private
    { Private declarations }
    vbolBypassEvents: boolean;
    vbolBypassUpdate: boolean;
    procedure LoadPickList;
    procedure EditState(const vbolEdit: boolean);
    procedure BreakFileField(const cstrFileField: string;
                               var vstrFile, vstrField: string);
    procedure BuildWhereStatement;
    function  FindSurveyQuestion(const vstrID: string;
                                 const vstrEdition: string;
                                 const vintQuestion: integer): string;
  public
    { Public declarations }
  end;

var
  frmQuery: TfrmQuery;

implementation

{$R *.DFM}

uses procSharedDatamoduleCalls, formQueryQR, formDataGraph;


procedure TfrmQuery.FormClose(Sender: TObject; var Action: TCloseAction);
begin
If qrySearches.state <> dsBrowse then
   cmdSaveClick(Self);
CloseThisEntity(cintQuery);
action := cafree;
end;

procedure TfrmQuery.FormCreate(Sender: TObject);
var vstrWork: string;
begin
  qrySearches.databasename := 'mmom_maindatabase';
  qryPickList.databasename := 'mmom_maindatabase';
  qryQuery.databasename := 'mmom_maindatabase';
  qryFields.databasename := 'mmom_reference';
  qryFields.open;
  cboFields1.Items.Clear;
  While not qryFields.eof do
    begin
    vstrWork := qryFields.fieldbyname('FileName').asstring + '.' +
                qryFields.fieldbyname('FieldName').asstring;
    If (qryFields.fieldbyname('FieldType').asstring = 'Integer') or
       (qryFields.fieldbyname('FieldType').asstring = 'Money') or
       (Pos('Numeric', qryFields.fieldbyname('FieldType').asstring)>0) then
         vstrWork := vstrWork + '#';
    cboFields1.items.add(vstrWork);
    qryFields.Next;
    end;
  cboFields2.items.assign(cboFields1.items);
  qrySearches.open;
  editstate(false);
  end;

procedure TfrmQuery.cboLogicalChange(Sender: TObject);
begin
If cboLogical.Text = '=' then
  begin
  {Find the pick list here depending on the availability of the picklist file}
  edtCompare.visible := false;
  If (cboFields2.text > '     A') and
     (cboFields2.text <> '-New Field-') then
     LoadPickList;
  cboPickList.visible := true;
  end
else
  begin
  edtCompare.text := '';
  edtCompare.visible := true;
  cboPickList.visible := false;
  end;
If not vbolBypassEvents then
  BuildWhereStatement;
end;

{This routine will attempt to find a valid pick list in the list system.  If
not, it will dynamically create a list based on all values in the live table.}
procedure TfrmQuery.LoadPickList;
var vstrFile, vstrField: string;
begin
BreakFileField(cboFields2.text, vstrFile, vstrField);
delete(vstrField, pos('#', vstrField), 1);
cboPickList.Items.Clear;
qryPickList.close;
qryPickList.SQL.clear;
qryPickList.SQL.Add('Select distinct ' + vstrField + ' from ' + vstrFile);
qryPickList.open;
While not qryPickList.eof do
  begin
  cboPickList.items.add(qryPicklist.fields[0].asstring);
  qryPickList.next;
  end;
qryPickList.close;
end;

{This routine will attempt to find a valid pick list in the list system.  If
not, it will dynamically create a list based on all values in the live table.}
function TfrmQuery.FindSurveyQuestion(const vstrID: string;
                                      const vstrEdition: string;
                                      const vintQuestion: integer): string;
begin
Result := '';
qryPickList.close;
qryPickList.SQL.clear;
qryPickList.SQL.Add('Select SurveyQuestionText from SurveyQuestion');
qryPickList.SQL.Add('Where SurveyID = "' + vstrID + '"');
qryPickList.SQL.Add('and SurveyEdition = "' + vstrEdition + '"');
qryPickList.SQL.Add('and SurveyQuestion = ' + inttostr(vintQuestion));
qryPickList.open;
If qryPickList.recordcount = 1 then
  Result:= qryPickList.fieldbyname('SurveyQuestionText').asstring;
qryPickList.close;
end;

{Since the file and field are combined to one string for dicplay to the user,
this procudure breaks them apart again}
procedure TfrmQuery.BreakFileField(const cstrFileField: string;
                         var vstrFile, vstrField: string);
begin
vstrFile := copy(cstrFileField,1,pos('.', cstrFileField) - 1);
vstrField := copy(cstrFileField,pos('.', cstrFileField) + 1, 999);
end;

procedure TfrmQuery.cboFields2Change(Sender: TObject);
begin
If not vbolBypassEvents then
  BuildWhereStatement;
end;

procedure TfrmQuery.BuildWhereStatement;
var vstrQuote: string;
    vstrCompare: string;
begin
If lstWhere.Items.count = 0 then
  lstWhere.Items.add(' ');
If lstWhere.ItemIndex = -1 then
  lstWhere.ItemIndex := 0;
vstrCompare := edtCompare.text;
If pos('#', cboFields2.text) = 0 then
  vstrQuote := '"'
else
  begin
  {The field is numeric, so test the value to be compared for a numeric value}
  vstrQuote := '';
  try
  strtofloat(vstrCompare);
    except
    vstrCompare:='0';
    end;
  end;
If cboLogical.ItemIndex > -1 then
  If cboLogical.Text = '=' then
    lstWhere.Items[lstWhere.ItemIndex] := cboFields2.text + ' '
                                    + cboLogical.text + ' ' + vstrQuote
                                    + cboPickList.text + vstrQuote
  else
  If cboLogical.Text = 'Like' then
    lstWhere.Items[lstWhere.ItemIndex] := cboFields2.text + ' '
                                    + cboLogical.text + ' ' + vstrQuote + '%'
                                    + vstrCompare + '%' + vstrQuote
  else
    lstWhere.Items[lstWhere.ItemIndex] := cboFields2.text + ' '
                                    + cboLogical.text + ' ' + vstrQuote
                                    + vstrCompare + vstrQuote;
end;

procedure TfrmQuery.cmdNewField2Click(Sender: TObject);
begin
If lstSelect.Items.IndexOf('-New Item-') = -1 then
  begin
  lstWhere.Items.add('-New Item-');
  lstWhere.ItemIndex := 0;
  cboFields2.itemindex := -1;
  cboLogical.itemindex := -1;
  cboPicklist.itemindex := -1;
  edtCompare.text := '';
  end;
end;

procedure TfrmQuery.cmdNewField1Click(Sender: TObject);
begin
If lstSelect.Items.IndexOf('-New Field-') = -1 then
  begin
  lstSelect.Items.add('-New Field-');
  lstSelect.ItemIndex := lstSelect.Items.count - 1;
  end;
end;

procedure TfrmQuery.cboFields1Change(Sender: TObject);
begin
If lstSelect.Items.count = 0 then
  lstSelect.Items.add('.');
If lstSelect.ItemIndex = -1 then
  lstSelect.ItemIndex := 0;
If lstSelect.items.IndexOf(cboFields1.text) = -1 then
  lstSelect.Items[lstSelect.ItemIndex] := cboFields1.text;
end;

procedure TfrmQuery.cmdexitClick(Sender: TObject);
begin
close;
end;

procedure TfrmQuery.cmdSearchClick(Sender: TObject);
var vintLoop, vintCounter: integer;
    vstrWork, vstrFile, vstrWhere, vstrGroup, vstrThisCompare,
              vstrThisField, vstrNextField: string;
    vbolOR: boolean;
    varrParenAndOr: array [1..3, 0..99] of string;
    {Each table listed in the FROM line must belinked back to the Entity
    table by the Entity number field.  }
    procedure BuildFrom(const cstrFile:string; var vstrFrom: string);
       begin
       {If the file already exists in the from statement then bypass}
       If (cstrFile <> 'Entity') and (length(cstrFile) > 2) then
          begin
          {In the case of Survey, Add both Survey and SurveyAnswer}
          If (cstrFile = 'Survey') or (cstrFile = 'SurveyAnswer') then
            begin
             vstrFrom := vstrFrom +
                    ' Survey, SurveyAnswer,';
            end
          else
          {Add the file on the From statement generically}
             vstrFrom := vstrFrom + cstrFile + ',';
          end;
       end;
    {Each table listed in the FROM line must belinked back to the Entity
    table by the Entity number field.  }
    procedure BuildWhereLinks(const cstrFile:string; var vstrWhere: string);
       begin
       If (cstrFile <> 'Entity') and (length(cstrFile) > 2) then
          begin
          {Special hard-code.  Addresses for households also apply to the
          individual patients in the household.  The EntityHousehold field
          in the Entity table is used to link to Address and Household }
          If (cstrFile = 'Address') then
            begin
             vstrWhere := vstrWhere +
                    ' (Entity.EntityHousehold = Address.Entity) and ';
            end
          else
          If (cstrFile = 'HouseHold') then
            begin
             vstrWhere := vstrWhere +
                    ' (Entity.EntityHousehold = HouseHold.Entity) and ';
            end
          else
          {SurveyAnswer does not have an Entity code, so the SurveyNumber
          must be linked through the Survey table Entity}
          If (cstrFile = 'Survey') or (cstrFile = 'SurveyAnswer') then
            begin
             vstrWhere := vstrWhere +
                    ' (Entity.Entity = Survey.Entity) and';
             vstrWhere := vstrWhere +
                    ' (Survey.SurveyNumber = SurveyAnswer.SurveyNumber) and ';
            end
          else
          {If not linked by the entity household, use the standard entity
          number}
             vstrWhere := vstrWhere +
                              ' (Entity.Entity = ' + cstrFile + '.Entity) and ';
          end;
       end;
begin
{If there is a new field or new item marker in either the Select or Where
statement areas, eliminate it before moving on to build the SQL logic}
If lstSelect.items.indexof('-New Field-') > -1 then
   lstSelect.items.delete(lstSelect.items.indexof('-New Field-'));
If lstWhere.items.indexof('-New Item-') > -1 then
   lstWhere.items.delete(lstWhere.items.indexof('-New Item-'));
{The edits.  There must be a Select field or the SQL statement will not work.
Return to screen after a warning dialog.}
If lstSelect.items.count = 0 then
   begin
   ShowMessage('Please select a field to show in the query results');
   exit;
   end;
{Be neat and initialize}
vstrWork := '';
vstrWhere := '';
vstrGroup := '';
{Sorting the Where fields will place them in an order to support the OR and AND
logic.  If the same field name appears twice in a query's Where logic, it must
be specified with an OR between the fields and also parenthesis around the
2 OR statements.}
lstWhere.Sorted := false;
lstWhere.Sorted := true;
qryQuery.close;
qryQuery.sql.clear;
{Build the select line out of the list of fields in the list box}
qryQuery.sql.add('Select distinct ');
for vintLoop := 0 to lstSelect.items.count - 1 do
  vstrWork:=vstrWork + lstSelect.items[vintLoop]  + ', ';
vstrGroup := vstrWork;
{If there is to be a total count for each distinct item, add logic to the SQL
statement to count all entity numbers represented in the results.}
If chkDistinct.checked then
   vstrWork := vstrWork + 'Count(Distinct Entity) as Counter, '
else
If chkCount.Checked then
   vstrWork := vstrWork + 'Count(Entity) as Counter, ';
{Remove the last , on the select line}
vstrWork := copy(vstrWork,1,length(vstrWork)-2);
{Remove the numeric marker from any fields in the Select statement}
while pos('#', vstrWork) > 0 do
   delete(vstrWork, pos('#', vstrWork), 1);
{Remove the last comma in the select line}
vstrGroup := copy(vstrGroup,1,length(vstrGroup)-2);
{Add the select line to the query}
qryQuery.SQL.add(vstrWork);
{Entity is included in all queries because all tables in the database search
share a common link to entity number}
vstrWork := 'From Entity,';
{Build initial FROM line based on the tables in the Select fields}
for vintLoop := 0 to lstSelect.items.count - 1 do
  begin
  {Split out the file name form the compound File.Field string}
  vstrFile := copy(lstSelect.items[vintLoop], 1,
                                       pos('.', lstSelect.items[vintLoop]) - 1);
  {If the file has already been added to the FROM statement, do not add it
  a second time}
  If (pos(vstrFile, vstrWork) = 0) and (length(vstrFile) > 2) then
     begin
     {Hard coded exceptions for the From statement are contained here}
     BuildFrom(vstrFile, vstrWork);
     {Use this routine to run any hard-coded logic that is required to put
     together odd relationships between tables for the Where statement.  If
     tables are not linked solely by the Entity.Entity# field, the relationship
     is added here}
     BuildWhereLinks(vstrFile, vstrWhere);
     end;
  end;
{Add any tables from the Where logic to the From line.  It is possible to
limit a query in the Where statement with a table that is not included in a
Select statement}
for vintLoop := 0 to lstWhere.items.count - 1 do
  begin
  vstrFile := copy(lstWhere.items[vintLoop], 1,
                                       pos('.', lstWhere.items[vintLoop]) - 1);
  {If a table name already exists in the list of From tables, do not add it
  again...}
  If (pos(vstrFile, vstrWork) = 0) and (length(vstrFile) > 2) then
     begin
     BuildFrom(vstrFile, vstrWork);
     BuildWhereLinks(vstrFile, vstrWhere);
     end;
  end;
{Remove the last comma on the From statement before continuing with the
Where statement}
If copy(vstrWork, length(vstrWork), 1) =',' then
   vstrWork:= copy(vstrWork, 1, length(vstrWork) - 1);
qryQuery.SQL.add(vstrWork);
{Eliminate any blank lines from the possible list of Where statements}
vintLoop:=0;
while vintLoop <= lstWhere.items.count -1 do
  If length(lstWhere.items[vintLoop]) < 3 then
     lstWhere.Items.Delete(vintLoop)
  else
     inc(vintLoop);
{Figure out the AND and OR situations based on the name of the field in the
search.  Build all remaining where statements}
vbolOR:= false;
For vintLoop := 0 to lstWhere.items.count -1 do
  begin
  {Set up the current field name and next field name}
  vstrThisCompare:= copy(lstWhere.items[vintLoop],
                        pos(' ', lstWhere.items[vintLoop]) + 1, 2);
  vstrThisField:= copy(lstWhere.items[vintLoop],
                                     pos('.', lstWhere.items[vintLoop]) + 1,
                                     99);
  vstrThisField:= copy(lstWhere.items[vintLoop], 1,
                                     pos(' ', lstWhere.items[vintLoop]) - 1);
  If vintLoop <> lstWhere.items.count -1 then
     begin
     vstrNextField:= copy(lstWhere.items[vintLoop+1],
                                   pos('.', lstWhere.items[vintLoop+1]) + 1,
                                   99);
     vstrNextField:= copy(lstWhere.items[vintLoop+1], 1,
                                   pos(' ', lstWhere.items[vintLoop+1]) - 1);
     end
  else
     vstrNextField := '';
     
  If (pos('Date', vstrThisField) > 0) or (vstrThisCompare <> '= ') then
    else
  {Set the parenthesis based on the need for an OR operand or an AND operand
  for this line}
  If vbolOR then
    {The last line had matched field and so will the next, so there should
    be no parenthesis on this line}
    If vstrThisField = vstrNextField then
    else
       begin
       vbolOR := false;
       varrParenAndOr[2, vintLoop] := ')';
       end
  else
    {Currently, there is no OR in progress.  Set the switch on and set the open
    paren for this line if the next field matches this one}
    If (vstrThisField = vstrNextField) then
       begin
       vbolOR := true;
       varrParenAndOr[1, vintLoop] := '(';
       end;
  {The last line will contain no more AND/OR logic}
  If vintLoop = lstWhere.items.count -1 then
  else
  If vbolOR then
    varrParenAndOr[3, vintLoop] := ' OR '
  else
    varrParenAndOr[3, vintLoop] := ' AND ';
  end;
{Place all Where logic into the SQL statement with the AND/OR and parenthesis}
For vintLoop := 0 to lstWhere.items.count -1 do
       vstrWhere := vstrWhere +
                    varrParenAndOr[1, vintLoop] + '(' +
                    lstWhere.items[vintLoop] +  ')' +
                    varrParenAndOr[2, vintLoop] +
                    varrParenAndOr[3, vintLoop];
{Remove the numeric field marker from the Where statement so the name of the
field will match the one in the table}
If (length(vstrWhere) > 0) then
    begin
    if lstWhere.items.count = 0 then
        vstrWhere := copy(vstrWhere,1,length(vstrWhere)-4);
    while pos('#', vstrWhere) > 0 do
       delete(vstrWhere, pos('#', vstrWhere), 1);
    end;
{Add the Where to the complete SQL statement}
If length(vstrWhere) > 0 then
   qryQuery.SQL.add('Where ' + vstrWhere);
{The Groupby statement is required for any Count routines that may have been
added at the Select level}
If length(vstrGroup) > 0 then
   begin
   {Remove any numeric markers from the field names}
    while pos('#', vstrGroup) > 0 do
       delete(vstrGroup, pos('#', vstrGroup), 1);
   {append the Group By line to the end of the SQL statement}
   qryQuery.SQL.add('Group By ' + vstrGroup);
    end;
grdAnswers.datasource := nil;
try
  {To allow us to debug failed queries, send this query to the current directory
  in ASCII}
  qryQuery.sql.SaveToFile('LastSQLrun.txt');
  {If this Open fails to execute the SQL statement, bring up a  generic error
  dialog.  If this begins to happen often, it should be exapnded to show the
  reason for the failure in the SQL statement}
  qryQuery.open;
  except
  ShowMessage('Error in query.  Make sure all conditions have values.');
  end;
  If qryQuery.recordCount > 0 then
    begin
    cmdPrev.Enabled := true;
    If chkCount.checked then
       cmdGraph.Enabled := true;
    end
  else
    cmdPrev.Enabled := false;
  vintCounter:= 0;
  If chkCount.checked then
    begin
    while not qryQuery.Eof do
          begin
          vintCounter:= vintCounter + qryQuery['Counter'];
          qryQuery.next;
          end;
    qryQuery.first;
    end;
  edtLines.text:= inttostr(qryQuery.recordCount);
  edtCount.text:= inttostr(vintCounter);
  grdAnswers.datasource := dtsQuery;
end;

procedure TfrmQuery.cmdDelSelectClick(Sender: TObject);
begin
lstSelect.items.delete(lstSelect.itemindex);
end;

procedure TfrmQuery.cmdDelWhereClick(Sender: TObject);
begin
lstWhere.items.delete(lstWhere.itemindex);
end;

procedure TfrmQuery.cmdMoveUpClick(Sender: TObject);
var vstrWork: string;
begin
{Allow the user to order the fields in the Select statement. This routine shifts
the field in the list box up one position.  The queries are sorted first field
to last, so this gives the user control of the order the results are sorted
by}
If lstSelect.itemindex > 0 then
  begin
  vstrWork:= lstSelect.items[lstSelect.itemindex-1];
  lstSelect.items[lstSelect.itemindex-1]:= lstSelect.items[lstSelect.itemindex];
  lstSelect.items[lstSelect.itemindex]:=vstrWork;
  lstSelect.itemindex:= lstSelect.itemindex - 1;
  end;
end;

procedure TfrmQuery.cmdMoveDownClick(Sender: TObject);
var vstrWork: string;
begin
{Same as the MoveUp routine, but to shift the current field down one place in
the heirarchy.}
If (lstSelect.items.count > 1)
    and (lstSelect.ItemIndex <> lstSelect.items.count -1) then
  begin
  vstrWork:= lstSelect.items[lstSelect.itemindex+1];
  lstSelect.items[lstSelect.itemindex+1]:= lstSelect.items[lstSelect.itemindex];
  lstSelect.items[lstSelect.itemindex]:=vstrWork;
  lstSelect.itemindex:= lstSelect.itemindex + 1;
  end;
end;

procedure TfrmQuery.lstSelectClick(Sender: TObject);
begin
{Whemever the Select list box is accessed, make sure the pick lists above are
repositioned to support data entry.  The pick lists should show the currently
selected item to correspond with the list box}
cboFields1.itemindex:=
                 cboFields1.items.Indexof(lstSelect.items[lstSelect.ItemIndex]);
end;

{Find a new sequence number for the query about to be created and add this value
the the database of queries.}
procedure TfrmQuery.cmdNewClick(Sender: TObject);
var vintNew: integer;
begin
{First query is number 1 by default}
If qrySearches.recordCount = 0 then
    vintNew := 1
else
{Go to the end of the table and get the next available number based on the last
number used}
    begin
    qrySearches.last;
    vintNew := qrySearches.fieldbyname('QueryID').asinteger + 1;
    end;
{Add a record with certain default values that the user will override}
qrySearches.Append;
qrySearches.fieldbyname('QueryID').asinteger := vintNew;
qrySearches.fieldbyname('QueryName').asstring := '-New Search-';
qrySearches.post;
qrySearches.edit;
{Automatically go to edit state to allow the user to work on the new query}
editstate(true);
end;

procedure TfrmQuery.cmdDeleteClick(Sender: TObject);
begin
{Delete the selected query if the user affirms the commanc in the dialog}
If qrySearches.recordcount > 0 then
  if MessageDlg('Delete this query?',
       mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     qrySearches.delete;
end;

procedure TfrmQuery.dtsSearchesDataChange(Sender: TObject; Field: TField);
begin
{If there are internal loops occurring, the vbolBypassUpdate switch will prevent
recursive loops from occurring.  Since the first datachange event in a loop
would trigger this logic again, the system would bog down or fail}
If vbolBypassUpdate then
else
  begin
  {Fill in the list box base on the selection of the query}
  lstSelect.items.text:= qrySearches['QuerySelect'];
  lstWhere.items.text:= qrySearches['QueryWhere'];
  chkCount.checked:= qrySearches.fieldbyname('QueryCount').asboolean;
  chkDistinct.checked:= qrySearches.fieldbyname('QueryDistinct').asboolean;
  If (chkCount.checked) and (chkCount.enabled) then
    begin
    chkGraph.Enabled := true;
    chkDistinct.Enabled := true;
    end
  else
    begin
    chkGraph.Enabled := false;
    chkDistinct.Enabled := false;
    end;
  chkGraph.checked:= qrySearches.fieldbyname('QueryGraph').asboolean;
  {If there have been fields chosen in the Select list box, fill in the
  corresponding combo box by calling the Select list click event}
  If lstSelect.items.Count > 0 then
    begin
    lstSelect.Itemindex := 0;
    lstSelectClick(Self);
    end
  else
    cboFields1.ItemIndex := -1;
  {If there are fields in the Where logic, fill in the combo boxes by calling
  the click event}
  If lstWhere.items.Count > 0 then
    begin
    lstWhere.Itemindex := 0;
    lstWhereClick(Self);
    end
  else
      begin
      cboFields2.ItemIndex := -1;
      cboLogical.itemindex := -1;
      cboPicklist.itemindex := -1;
      edtCompare.text := '';
      end;
  end;
end;

procedure TfrmQuery.lstWhereClick(Sender: TObject);
var vstrWork: string;
begin
{Shut off the datachange event while this logic is performed}
vbolBypassEvents := true;
vstrWork:= lstWhere.items[lstWhere.itemindex];
{Clear the fields to be filled-in}
cboFields2.itemindex:= -1;
cboLogical.itemindex := -1;
cboPicklist.itemindex := -1;
edtCompare.text := '';
{The user has not entered a value to comapre to the field yet.  Reactivate the
visual events in datachange and exit the routine}
If length(vstrWork) < 12 then
  begin
  vbolBypassEvents:= false;
  exit;
  end;
{begin to fill in the available picklist items based on the selection in
lstWhere.}
cboFields2.itemindex:=
            cboFields2.items.Indexof(copy(vstrWork, 1, pos(' ', vstrWork) - 1));
vstrWork:= trim(copy(vstrWork, pos(' ', vstrWork) +1, 999));
{If the only thing selected so far is the field name, go around the last part}
If (copy(vstrWork,1,1)='"') or (length(vstrWork) < 3) then
  begin
  vbolBypassEvents:= false;
  exit;
  end;
{Fill in the logical operator and trigger any other logic associated with
the logical operand}
cboLogical.itemindex:=
            cboLogical.items.Indexof(copy(vstrWork, 1, pos(' ', vstrWork) - 1));
vstrWork:= trim(copy(vstrWork, pos(' ', vstrWork) +1, 999));
cboLogicalChange(Self);
{Complete by filling in the item to be compared}
{Eliminate any of the characters that are not part of the true field name}
While pos('"', vstrWork) > 0 do
   delete(vstrWork, pos('"', vstrWork),1);
While pos('%', vstrWork) > 0 do
   delete(vstrWork, pos('%', vstrWork),1);
{This value is filled in so that the user can enter free-format items without
the help of the picklist}
edtCompare.text := trim(vstrWork);
{If the item is in the picklist, more the picklist to the correct location and
display the value}
cboPicklist.itemindex:= cboPicklist.items.Indexof(trim(vstrWork));
{Turn on the datachange events again}
vbolBypassEvents := false;
end;

procedure TfrmQuery.grdAnswersDblClick(Sender: TObject);
var vbolDummy: boolean;
begin
{Exit the routine if the Entity field is not one of the results from the
 latest query}
 try
  vintCurrentEntity := qryQuery.fieldbyname('Entity').asinteger;
 except
  exit;
  end;
  {This is the sneaky way to call a routine in a form that created you!}
  vbolDummy := false;
  vfrmMainMenu.onclosequery(Sender, vbolDummy);

end;

procedure TfrmQuery.cmdEditClick(Sender: TObject);
begin
{Place the current query in the edit mode to allow the user to modify the
query}
If qrySearches.recordCount = 0 then
   cmdNewClick(Self)
else
   begin
   editstate(true);
   qrySearches.Edit;
   end;
end;

procedure TfrmQuery.cmdSaveClick(Sender: TObject);
begin
{Save the values of the query that has just been edited or added}
vbolBypassUpdate := true;
qrySearches['QuerySelect']:= lstSelect.items.text;
qrySearches['QueryWhere']:= lstWhere.items.text;
qrySearches.fieldbyname('QueryCount').asboolean:= chkCount.checked;
qrySearches.fieldbyname('QueryDistinct').asboolean:= chkDistinct.checked;
qrySearches.fieldbyname('QueryGraph').asboolean:= chkGraph.checked;
qrySearches.Post;
editstate(false);
vbolBypassUpdate := false;
end;

procedure TfrmQuery.cmdCancelClick(Sender: TObject);
begin
{Do not save screen changes made this session by cancelling the query buffer
before a post.}
If qrySearches.State <> dsBrowse then
   qrySearches.Cancel;
editstate(false);
end;

Procedure TfrmQuery.EditState(const vbolEdit: boolean);
begin
{If a query is about to be edited, activate and protect certain visual
components}
If vbolEdit then
   begin
   cboFields1.enabled := true;
   cboFields2.Enabled := true;
   cboLogical.enabled := true;
   cboPickList.Enabled := true;
   edtCompare.Enabled := true;
   cmdEdit.Enabled := false;
   cmdCancel.Enabled := true;
   cmdSave.Enabled := true;
   cmdDelSelect.Enabled := true;
   cmdDelWhere.Enabled := true;
   cmdNewField1.Enabled := true;
   cmdNewField2.Enabled := true;
   cmdMoveUp.Enabled := true;
   cmdMoveDown.Enabled := true;
   cmdSearch.Enabled := false;
   cmdNew.Enabled := false;
   cmdDelete.Enabled := false;
   chkCount.Enabled := true;
   If chkCount.checked then
      begin
      chkGraph.Enabled := true;
      chkDistinct.Enabled := true;
      end;
   grdQueryList.visible := false;
   end
else
{If a query is read-only, activate and protect certain visual components}
   begin
   cboFields1.enabled := false;
   cboFields2.Enabled := false;
   cboLogical.enabled := false;
   cboPickList.Enabled := false;
   edtCompare.Enabled := false;
   cmdEdit.Enabled := true;
   cmdCancel.Enabled := false;
   cmdSave.Enabled := false;
   cmdDelSelect.Enabled := false;
   cmdDelWhere.Enabled := false;
   cmdNewField1.Enabled := false;
   cmdNewField2.Enabled := false;
   cmdMoveUp.Enabled := false;
   cmdMoveDown.Enabled := false;
   cmdSearch.Enabled := true;
   cmdNew.Enabled := true;
   cmdDelete.Enabled := true;
   chkCount.Enabled := false;
   chkGraph.Enabled := false;
   chkDistinct.Enabled := false;
   grdQueryList.visible := true;
   end;
end;

{Using the current query, generate the quick report.}
procedure TfrmQuery.cmdPrevClick(Sender: TObject);
var vstrID, vstrEdition, vstrQuestion: string;
    vintID, vintEdition, vintQuestion: integer;
begin
  vqryQuickReport := qryQuery;
  frmQueryQR := tfrmQueryQR.Create(nil);
  frmQueryQR.txtReportName.Caption:=
                                  qrySearches.fieldbyname('QueryName').asstring;
  frmQueryQR.txtLines.caption := 'Report Lines: '
                                               + inttostr(qryQuery.recordCount);
  frmQueryQR.txtCounter.caption := 'Total Count: ' + edtCount.text;
  {I love hard-coded stuff, so here is a routine to pick off the survey question
  and place it on the generic report.}
  vintID:= pos('SurveyID', lstWhere.Items.text);
  vintEdition:= pos('SurveyEdition', lstWhere.Items.text);
  vintQuestion:= pos('SurveyQuestion', lstWhere.Items.text);
  If (vintID > 0)
     and (vintEdition > 0)
     and (vintQuestion > 0) then
     begin
     {Isolate the particular field name and filter}
     vstrID := copy(lstWhere.Items.text, vintID, 999);
     {Get down to the first part of the field value after the first "}
     vstrID := copy(vstrID, pos('"', vstrID)+1, 999);
     {Eliminate the second "}
     vstrID := copy(vstrID, 1, pos('"', vstrID)-1);
     {Isolate the particular field name and filter}
     vstrEdition := copy(lstWhere.Items.text, vintEdition, 999);
     {Get down to the first part of the field value after the first "}
     vstrEdition := copy(vstrEdition, pos('"', vstrEdition)+1, 999);
     {Eliminate the second "}
     vstrEdition := copy(vstrEdition, 1, pos('"', vstrEdition)-1);
     {Isolate the particular field name and filter}
     vstrQuestion := copy(lstWhere.Items.text, vintQuestion, 999);
     vstrQuestion := copy(vstrQuestion, pos('#', vstrQuestion)+4, 999);
     If pos(#13, vstrQuestion) > 0 then
        vstrQuestion:=copy(vstrQuestion, 1, pos(#13, vstrQuestion)-1);
     If vstrQuestion < '0' then
        vstrQuestion := '0';
     frmQueryQR.memSurveyQuestion.enabled:= true;
     frmQueryQR.memSurveyQuestion.lines.text :=
                FindSurveyQuestion(vstrID, vstrEdition, strtoint(vstrQuestion));
            end;
  {---------End of hard-coded survey logic-------------}
  {Allow the graph only if the query generated a total column}
  If chkCount.checked and
     chkGraph.Checked then
       frmQueryQR.bndGraph.Enabled := true;
  {Run the report in a preview window.}
  try
    frmQueryQR.rptQuery.Preview;
  {Clean up all references to the form}
  finally
    frmQueryQR.release;
    frmQueryQR := nil;
    vqryQuickReport := nil;
  end;
end;

procedure TfrmQuery.cmdGraphClick(Sender: TObject);
begin
  vqryQuickReport := qryQuery;
  frmDatabaseGraph := tfrmDatabaseGraph.Create(nil);
  frmDatabaseGraph.crtPie.Title.text.add(
                                qrySearches.fieldbyname('QueryName').asstring);
  try
    frmDatabaseGraph.showmodal;
  finally
    frmDatabaseGraph.release;
    frmDatabaseGraph := nil;
    vqryQuickReport := nil;
  end;

end;

procedure TfrmQuery.chkCountClick(Sender: TObject);
begin
If chkcount.checked = true then
   begin
   chkGraph.enabled := true;
   chkDistinct.enabled := true;
   end
else
   begin
   chkGraph.Enabled := false;
   chkDistinct.Enabled := false;
   end;
end;

end.
