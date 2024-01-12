unit formCreateMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    pnlKeyMain: TPanel;
    pnlKeyBack: TPanel;
    trvKeywords: TTreeView;
    pnlKeyControl: TPanel;
    lbl10: TLabel;
    chkDelKeywords: TCheckBox;
    lstUnfiled: TFileListBox;
    pnlMain: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
