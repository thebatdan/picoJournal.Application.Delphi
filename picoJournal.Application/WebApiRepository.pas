unit WebApiRepository;

interface

uses
  JournalRepository, System.Generics.Collections, Question, JournalEntry;

type
  TWebApiRepository = class(TInterfacedObject, IJournalRepository)
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

{ TWebApiRepository }

function TWebApiRepository.CreateJournalEntry(
  journalEntry: TJournalEntry): TJournalEntry;
begin

end;

function TWebApiRepository.CreateQuestion(question: TQuestion): TQuestion;
begin

end;

procedure TWebApiRepository.DeleteJournalEntry(journalEntry: TJournalEntry);
begin

end;

procedure TWebApiRepository.DeleteQuestion(question: TQuestion);
begin

end;

function TWebApiRepository.GetAllJournalEntries: TList<TJournalEntry>;
begin

end;

function TWebApiRepository.GetAllQuestions: TList<TQuestion>;
begin

end;

function TWebApiRepository.GetJournalEntriesForDay(
  date: TDateTime): TList<TJournalEntry>;
begin

end;

function TWebApiRepository.GetJournalEntry(id: integer): TJournalEntry;
var
  je: TJournalEntry;
begin
  je := TJournalEntry.Create;
  je.EntryText := 'Journal Entry from Web API Repository';
  Result := je;
end;

function TWebApiRepository.GetQuestion(id: integer): TQuestion;
begin

end;

function TWebApiRepository.GetRandomQuestion(date: TDateTime): TQuestion;
begin

end;

procedure TWebApiRepository.Save;
begin

end;

procedure TWebApiRepository.UpdateJournalEntry(journalEntry: TJournalEntry);
begin

end;

procedure TWebApiRepository.UpdateQuestion(question: TQuestion);
begin

end;

end.
