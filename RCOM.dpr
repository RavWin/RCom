program RCOM;

uses
  Forms,
  Main in 'Main.pas' {fTTY},
  RVer in 'RVer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfTTY, fTTY);
  Application.Run;
end.
