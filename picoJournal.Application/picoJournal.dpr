program picoJournal;

uses
  Vcl.Forms,
  PicoJournalMain in 'PicoJournalMain.pas' {frmMain},
  Options in 'Options.pas' {frmOptions},
  JournalEntryClass in 'JournalEntryClass.pas',
  QuestionClass in 'QuestionClass.pas',
  ApplicationOptions in 'ApplicationOptions.pas',
  ApplicationOptionsFactory in 'ApplicationOptionsFactory.pas',
  JournalRepository in 'JournalRepository.pas',
  JournalServiceClass in 'JournalServiceClass.pas',
  JournalServiceFactory in 'JournalServiceFactory.pas',
  ApplicationDbRepository in 'ApplicationDbRepository.pas',
  WebApiRepository in 'WebApiRepository.pas',
  JournalDateSummaryClass in 'JournalDateSummaryClass.pas',
  JournalServiceInterface in 'JournalServiceInterface.pas',
  JournalEntryFrame in 'JournalEntryFrame.pas' {fmeJournalEntry: TFrame};

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
