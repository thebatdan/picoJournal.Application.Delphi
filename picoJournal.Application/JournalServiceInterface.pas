unit JournalServiceInterface;

interface

uses
  System.Generics.Collections,
  JournalRepository, JournalEntryClass, QuestionClass, JournalDateSummaryClass;

type
  IJournalService = Interface(IInterface)
    function GetJournalEntry(id: integer): TJournalEntry;
    procedure AddJournalEntry(var AJournalEntry: TJournalEntry);
    procedure AddQuestion(var AQuestion: TQuestion);
    procedure RemoveJournalEntry(id: Integer);
    procedure RemoveQuestion(id: Integer);
    procedure GetAllJournalEntries(var AJournalEntries: TObjectList<TJournalEntry>);
    procedure GetAllQuestions(var AQuestions: TObjectList<TQuestion>);
    procedure GetJournalEntriesForDay(AEntryDate: TDate; var AJournalEntries: TObjectList<TJournalEntry>);
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure GetJournalDateSummary(ADateFrom: TDate; ADateTo: TDate; var AJournalDateSummary: TObjectList<TJournalDateSummary>);
  end;

implementation

end.
