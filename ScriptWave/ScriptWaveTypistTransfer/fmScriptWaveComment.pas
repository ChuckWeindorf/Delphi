unit fmScriptWaveComment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls;

type
  TfrmAddComment = class(TForm)
    memFileComments: TMemo;
    cmdAddtoComment: TSpeedButton;
    cmdCancelComment: TSpeedButton;
    procedure cmdCancelCommentClick(Sender: TObject);
    procedure cmdAddtoCommentClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddComment: TfrmAddComment;

implementation

{$R *.DFM}

procedure TfrmAddComment.cmdCancelCommentClick(Sender: TObject);
begin
memFileComments.Lines.text:= '';
close;
end;

procedure TfrmAddComment.cmdAddtoCommentClick(Sender: TObject);
begin
close;
end;

end.
