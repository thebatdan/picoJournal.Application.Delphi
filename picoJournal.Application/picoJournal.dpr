program picoJournal;

uses
  Vcl.Forms,
  PicoJournalMain in 'PicoJournalMain.pas' {frmMain},
  Options in 'Options.pas' {frmOptions},
  JournalEntry in 'JournalEntry.pas',
  Question in 'Question.pas',
  ApplicationOptions in 'ApplicationOptions.pas',
  ApplicationOptionsFactory in 'ApplicationOptionsFactory.pas',
  JournalRepository in 'JournalRepository.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
