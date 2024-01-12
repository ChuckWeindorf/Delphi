program ScriptWaveProself;

uses
  Forms,
  fmProself in 'fmProself.pas' {frmProself};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ScriptWave Proself';
  Application.CreateForm(TfrmProself, frmProself);
  Application.Run;
end.
