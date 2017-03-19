unit JournalRepository;

interface

uses
  System.Generics.Collections,
  QuestionClass, JournalEntryClass, JournalDateSummaryClass;

type
  IJournalRepository = Interface(IInterface)
    function GetQuestion(id:integer): TQuestion;
    procedure GetAllQuestions(var AQuestions: TObjectList<TQuestion>);
    procedure GetRandomQuestions(AQuestionCount: integer; AEntryDate: TDate; var questions: TObjectList<TQuestion>);

    function CreateQuestion(AQuestion: TQuestion): TQuestion;
    procedure UpdateQuestion(AQuestion: TQuestion);
    procedure DeleteQuestion(AQuestion: TQuestion); overload;
    procedure DeleteQuestion(id: Integer); overload;

    function GetJournalEntry(id: integer): TJournalEntry;
    procedure GetAllJournalEntries(var AJournalEntries: TObjectList<TJournalEntry>);
    procedure GetJournalEntriesForDay(AEntryDate: TDate; var AJournalEntries: TObjectList<TJournalEntry>);

    function CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure DeleteJournalEntry(AJournalEntry: TJournalEntry); overload;
    procedure DeleteJournalEntry(id: Integer); overload;

    procedure GetJournalDateSummary(ADateFrom: TDate; ADateTo: TDate; var AJournalDateSummary: TObjectList<TJournalDateSummary>);
  End;

implementation

end.
