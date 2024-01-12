unit formAddCD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, filectrl, ExtCtrls, fmxutils, FolderBrowser;

type
  TformAddNewCD = class(TForm)
    pnlNewCD: TPanel;
    lbl1: TLabel;
    edtNewName: TEdit;
    pnlImport: TPanel;
    radFormat: TRadioGroup;
    edtImportDir: TEdit;
    lbl2: TLabel;
    cmdAdd: TBitBtn;
    cmdOpenDir: TBitBtn;
    dlgOpen: TFolderBrowser;
    cmdImport: TBitBtn;
    procedure edtNewNameChange(Sender: TObject);
    procedure cmdAddClick(Sender: TObject);
    procedure cmdOpenDirClick(Sender: TObject);
    procedure cmdImportClick(Sender: TObject);
    procedure edtNewNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    vstrBase: string;
  public
    { Public declarations }
    vstrImpDir: string;
    vbolJPG: boolean;
    Procedure ShowAndProcess(const vstrBaseDir: string);
  end;

var
  formAddNewCD: TformAddNewCD;

implementation

{$R *.DFM}

procedure TformAddNewCD.ShowAndProcess(const vstrBaseDir: string);
begin
vstrImpDir:= '';
vstrBase := vstrBaseDir;
Showmodal;
close;
end;

procedure TformAddNewCD.edtNewNameChange(Sender: TObject);
begin
If (edtNewName.text < ' A') or
    (DirectoryExists(vstrBase + edtNewName.text)) then
    cmdAdd.enabled := false
else
    cmdAdd.enabled := true;
end;

procedure TformAddNewCD.cmdAddClick(Sender: TObject);
var vstlIni: TstringList;
begin
  ForceDirectories(vstrBase + edtNewName.text);
  vstlIni:= tstringlist.create;
  try
    try
    vstlini.add('1');
    vstlini.savetofile(vstrBase + edtNewName.text + '\ImageTotal.lst');
    vstlini.clear;
    vstlini.savetofile(vstrBase + edtNewName.text + '\ImageList.lst');
    vstlini.savetofile(vstrBase + edtNewName.text + '\Keywords.lst');
    fmxutils.copyfile(vstrBase + 'autorun.inf',
                      vstrBase + edtNewName.text);
    fmxutils.copyfile(vstrBase + 'MudsoxViewer.exe',
                      vstrBase + edtNewName.text);
    fmxutils.copyfile(vstrBase + 'MudsoxImageViewer.hlp',
                      vstrBase + edtNewName.text);
    except
      end;
  finally
    vstlini.free;
    If (DirectoryExists(vstrBase + edtNewName.text)) and
       (FileExists(vstrBase + edtNewName.text + '\MudsoxViewer.exe')) and
       (FileExists(vstrBase + edtNewName.text + '\MudsoxImageViewer.hlp')) and
       (FileExists(vstrBase + edtNewName.text + '\ImageTotal.lst')) and
       (FileExists(vstrBase + edtNewName.text + '\Keywords.lst')) and
       (FileExists(vstrBase + edtNewName.text + '\ImageList.lst')) then
         close
       else
         begin
         MessageDlg('Directory or control file not created. Try Again...',
                                                            mtError, [mbOk], 0);
         edtNewName.text := '';
         end;
    end;
end;

procedure TformAddNewCD.cmdOpenDirClick(Sender: TObject);
begin
dlgOpen.Folder:= vstrBase;
dlgOpen.Execute;
If length(dlgOpen.Folder) > 0 then
   edtImportDir.text := dlgOpen.Folder
else
   edtImportDir.text := '';
end;

procedure TformAddNewCD.cmdImportClick(Sender: TObject);
begin
vstrImpDir:= edtImportDir.text;
If radFormat.ItemIndex = 0 then
   vbolJPG:= true
else
   vbolJPG:= false;
close;
end;

procedure TformAddNewCD.edtNewNameKeyPress(Sender: TObject; var Key: Char);
begin
If key = #13 then
  If cmdAdd.enabled = true then
     cmdAddClick(self);
end;

end.
