program picoJournal;

uses
  Vcl.Forms,
  PicoJournalMain in 'PicoJournalMain.pas' {frmMain},
  Options in 'Options.pas' {frmOptions},
  JournalEntry in 'JournalEntry.pas',
  Question in 'Question.pas',
  ApplicationOptions in 'ApplicationOptions.pas',
  ApplicationOptionsFactory in 'ApplicationOptionsFactory.pas',
  JournalRepository in 'JournalRepository.pas',
  JournalService in 'JournalService.pas',
  JournalServiceFactory in 'JournalServiceFactory.pas',
  ApplicationDbRepository in 'ApplicationDbRepository.pas',
  WebApiRepository in 'WebApiRepository.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
  {$ENDIF}
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
