unit fmLogForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TfrmLogFile = class(TForm)
    memLog: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogFile: TfrmLogFile;

implementation

{$R *.DFM}

end.
