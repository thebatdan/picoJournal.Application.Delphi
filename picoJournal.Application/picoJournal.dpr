program picoJournal;

uses
  Vcl.Forms,
  PicoJournalMain in 'PicoJournalMain.pas' {frmMain},
  Options in 'Options.pas' {frmOptions},
  JournalEntryClass in 'JournalEntryClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.
