unit JournalRepository;

interface

uses
  Question, JournalEntry, System.Generics.Collections;

type
  IJournalRepository = Interface(IInterface)
    function GetQuestion(id:integer): TQuestion;
    procedure GetAllQuestions(var AQuestions: TList<TQuestion>);
    procedure GetRandomQuestions(AQuestionCount: integer; var questions: TList<TQuestion>);

    function CreateQuestion(AQuestion: TQuestion): TQuestion;
    procedure UpdateQuestion(AQuestion: TQuestion);
    procedure DeleteQuestion(AQuestion: TQuestion); overload;
    procedure DeleteQuestion(id: Integer); overload;

    function GetJournalEntry(id: integer): TJournalEntry;
    procedure GetAllJournalEntries(var AJournalEntries: TList<TJournalEntry>);
    procedure GetJournalEntriesForDay(AEntryDate: TDate; var AJournalEntries: TList<TJournalEntry>);

    function CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure DeleteJournalEntry(AJournalEntry: TJournalEntry); overload;
    procedure DeleteJournalEntry(id: Integer); overload;
  End;

implementation

end.
