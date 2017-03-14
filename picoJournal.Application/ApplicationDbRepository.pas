unit ApplicationDbRepository;

interface

uses
  JournalRepository, System.Generics.Collections, Question, JournalEntry;

type
  TApplicationDbRepository = class(TInterfacedObject, IJournalRepository)
  private

  protected

  public
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
  end;

implementation

{ TApplicationDbRepository }

function TApplicationDbRepository.CreateJournalEntry(
  journalEntry: TJournalEntry): TJournalEntry;
begin

end;

function TApplicationDbRepository.CreateQuestion(
  question: TQuestion): TQuestion;
begin

end;

procedure TApplicationDbRepository.DeleteJournalEntry(
  journalEntry: TJournalEntry);
begin

end;

procedure TApplicationDbRepository.DeleteQuestion(question: TQuestion);
begin

end;

function TApplicationDbRepository.GetAllJournalEntries: TList<TJournalEntry>;
begin

end;

function TApplicationDbRepository.GetAllQuestions: TList<TQuestion>;
begin

end;

function TApplicationDbRepository.GetJournalEntriesForDay(
  date: TDateTime): TList<TJournalEntry>;
begin

end;

function TApplicationDbRepository.GetJournalEntry(id: integer): TJournalEntry;
var
  je: TJournalEntry;
begin
  je := TJournalEntry.Create;
  je.EntryText := 'Journal Entry from App Db Repository';
  Result := je;
end;

function TApplicationDbRepository.GetQuestion(id: integer): TQuestion;
begin

end;

function TApplicationDbRepository.GetRandomQuestion(date: TDateTime): TQuestion;
begin

end;

procedure TApplicationDbRepository.Save;
begin

end;

procedure TApplicationDbRepository.UpdateJournalEntry(
  journalEntry: TJournalEntry);
begin

end;

procedure TApplicationDbRepository.UpdateQuestion(question: TQuestion);
begin

end;

end.
