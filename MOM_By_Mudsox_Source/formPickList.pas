unit formPickList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, Menus, ExtCtrls, Grids, DBGrids, Db, DBTables,
  Buttons, StdCtrls, DBCtrls,
  formNewPickList, procSharedDatamoduleCalls;

type
  TfrmPickLists = class(TForm)
    pnlListDetails: TPanel;
    mnuMain: TMainMenu;
    mnuFile: TMenuItem;
    mnuExit: TMenuItem;
    ToolBar1: TToolBar;
    pnlList: TPanel;
    cmdEdit: TSpeedButton;
    cmdSave: TSpeedButton;
    spl1: TSplitter;
    cmdDelete: TSpeedButton;
    spl2: TSplitter;
    cmdHelp: TSpeedButton;
    qryList: TQuery;
    dtsList: TDataSource;
    qryChoices: TQuery;
    grdPickList: TDBGrid;
    mnuEdit: TMenuItem;
    mnuHelp: TMenuItem;
    mnuChange: TMenuItem;
    mnuSave: TMenuItem;
    mnuDiscard: TMenuItem;
    mnuNew: TMenuItem;
    cboListField: TComboBox;
    cmdNew: TSpeedButton;
    lbl_00001: TLabel;
    Splitter3: TSplitter;
    cmdNewRecord: TSpeedButton;
    cmdPrint: TSpeedButton;
    cmdexit: TSpeedButton;
    procedure cboListFieldEnter(Sender: TObject);
    procedure cboListFieldClick(Sender: TObject);
    procedure cmdEditClick(Sender: TObject);
    procedure cmdSaveClick(Sender: TObject);
    procedure cmdNewRecordClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdDeleteClick(Sender: TObject);
    procedure cmdHelpClick(Sender: TObject);
    procedure qryListNewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdexitClick(Sender: TObject);
  private
    { Private declarations }
    procedure ApplyUpdates;
  public
    { Public declarations }
  end;

var
  frmPickLists: TfrmPickLists;

implementation
  uses FormPickListQR;
{$R *.DFM}

procedure TfrmPickLists.cboListFieldEnter(Sender: TObject);
begin
qryChoices.Close;
qryChoices.Open;
cboListField.Items.Clear;
qryChoices.First;
While not qryChoices.EOF Do
  begin
  cboListField.Items.Add(qryChoices.fieldbyname('ListField').asstring);
  qryChoices.Next;
  end;
end;

procedure TfrmPickLists.cboListFieldClick(Sender: TObject);
begin
qryList.Close;
qryList.SQL[1] := 'Where ListField = "' + cboListField.text + '"';
qryList.Open;
cmdEdit.enabled := true;
cmdPrint.enabled := true;
end;

procedure TfrmPickLists.cmdEditClick(Sender: TObject);
begin
  dtsList.autoedit := true;
  {Allow grid editing events}
  grdPickList.Options := [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs];
  cmdEdit.enabled := false;
  cmdNew.enabled := false;
  cmdPrint.enabled := false;
  cmdDelete.enabled := true;
  cmdSave.enabled := true;
  cmdNewRecord.enabled := true;
end;

procedure TfrmPickLists.cmdSaveClick(Sender: TObject);
begin
  ApplyUpdates;
  dtsList.autoedit := false;
  {Shut off grid editing events}
  grdPickList.Options := [dgTitles, dgColLines, dgRowLines, dgTabs];
  cmdEdit.enabled := true;
  cmdNew.enabled := true;
  cmdPrint.enabled := true;
  cmdDelete.enabled := false;
  cmdSave.enabled := false;
  cmdNewRecord.enabled := false;
end;

procedure TfrmPickLists.cmdNewRecordClick(Sender: TObject);
begin
  ApplyUpdates;
  qryList.Append;
end;

Procedure tfrmPickLists.ApplyUpdates;
begin
If qryList.State <> dsBrowse then
   begin
   try
     qryList.post;
     except
        qryList.cancel;
        end;
   end;
end;

procedure TfrmPickLists.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ApplyUpdates;
end;

procedure TfrmPickLists.cmdNewClick(Sender: TObject);
begin
{Make sure the pick list is ready}
Application.CreateForm(TfrmNewPickList, frmNewPickList);
try
frmNewPickList.Showmodal;
If qryList.Active = false then
   qryList.open;
If length(frmNewPickList.edtNewPickList.text) > 0 then
  begin
  qryList.Append;
  qryList.FieldByName('ListField').asstring :=
                                             frmNewPickList.edtNewPickList.text;
  ApplyUpdates;
  cboListFieldEnter(Self);
  cboListField.ItemIndex := cboListField.Items.IndexOf
                                           (frmNewPickList.edtNewPickList.text);
  cboListFieldClick(Self);
  cmdEditClick(Self);
  grdPickList.SetFocus;
  end;
finally
  frmNewPickList.Release;
  frmNewPickList:= nil;
  end;
end;

procedure TfrmPickLists.cmdDeleteClick(Sender: TObject);
begin
ApplyUpdates;
If qryList.RecordCount > 0 then
   qryList.delete;
end;

procedure TfrmPickLists.cmdHelpClick(Sender: TObject);
begin
  PlayMovie('tuffy.mpg');
end;

procedure TfrmPickLists.qryListNewRecord(DataSet: TDataSet);
begin
  qryList.Fieldbyname('ListField').asstring := cboListField.text;
end;

procedure TfrmPickLists.FormCreate(Sender: TObject);
begin
  qryChoices.databasename := 'mmom_maindatabase';
  qryList.databasename := 'mmom_maindatabase';
end;

procedure TfrmPickLists.cmdPrintClick(Sender: TObject);
begin
  vqryQuickReport:= qryList;
  frmPicklistQR := tfrmPicklistQR.Create(nil);
  try
    frmPicklistQR.rptPickList.Preview;
  finally
    frmPicklistQR.release;
    frmPicklistQR := nil;
  end;
  end;
procedure TfrmPickLists.cmdexitClick(Sender: TObject);
begin
  Close;
end;

end.
