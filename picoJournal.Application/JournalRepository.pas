unit JournalRepository;

interface

uses
  Question, JournalEntry, System.Generics.Collections;

type
  IJournalRepository = Interface(IInterface)
    function GetQuestion(id:integer): TQuestion;
    function GetAllQuestions: TList<TQuestion>;
    function GetRandomQuestion(date: TDateTime): TQuestion;

    function CreateQuestion(question: TQuestion): TQuestion;
    procedure UpdateQuestion(question: TQuestion);
    procedure DeleteQuestion(question: TQuestion);

    function GetJournalEntry(id: integer): TJournalEntry;
    function GetAllJournalEntries:TList<TJournalEntry>;
    function GetJournalEntriesForDay(date: TDateTime): TList<TJournalEntry>;

    function CreateJournalEntry(journalEntry: TJournalEntry): TJournalEntry;
    procedure UpdateJournalEntry(journalEntry: TJournalEntry);
    procedure DeleteJournalEntry(journalEntry: TJournalEntry);

    procedure Save;
  End;

implementation

end.
