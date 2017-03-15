unit WebApiRepository;

interface

uses
  JournalRepository, System.Generics.Collections, Question, JournalEntry;

type
  TWebApiRepository = class(TInterfacedObject, IJournalRepository)
  private

  protected

  public
    function GetQuestion(id: integer): TQuestion;
    procedure GetAllQuestions(var AQuestions: TList<TQuestion>);
    procedure GetRandomQuestions(AQuestionCount: integer; var AQuestions: TList<TQuestion>);

    function CreateQuestion(AQuestion: TQuestion): TQuestion;
    procedure UpdateQuestion(AQuestion: TQuestion);
    procedure DeleteQuestion(AQuestion: TQuestion); overload;
    procedure DeleteQuestion(id: Integer); overload;

    function GetJournalEntry(id: integer): TJournalEntry;
    procedure GetAllJournalEntries(var AJournalEntries: TList<TJournalEntry>);
    procedure GetJournalEntriesForDay(entryDate: TDate; var AJournalEntries: TList<TJournalEntry>);

    function CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure DeleteJournalEntry(AJournalEntry: TJournalEntry); overload;
    procedure DeleteJournalEntry(id: Integer); overload;
  end;

implementation

{ TWebApiRepository }

function TWebApiRepository.CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
begin

end;

function TWebApiRepository.CreateQuestion(AQuestion: TQuestion): TQuestion;
begin

end;

procedure TWebApiRepository.DeleteJournalEntry(AJournalEntry: TJournalEntry);
begin

end;

procedure TWebApiRepository.DeleteJournalEntry(id: Integer);
begin

end;

procedure TWebApiRepository.DeleteQuestion(id: Integer);
begin

end;

procedure TWebApiRepository.DeleteQuestion(AQuestion: TQuestion);
begin

end;

procedure TWebApiRepository.GetAllJournalEntries(var AJournalEntries: TList<TJournalEntry>);
begin

end;

procedure TWebApiRepository.GetAllQuestions(var AQuestions: TList<TQuestion>);
begin

end;

procedure TWebApiRepository.GetJournalEntriesForDay(entryDate: TDate; var AJournalEntries: TList<TJournalEntry>);
begin

end;

function TWebApiRepository.GetJournalEntry(id: integer): TJournalEntry;
var
  je: TJournalEntry;
begin
  je := TJournalEntry.Create;
  je.Answer := 'Journal Entry from Web API Repository';
  Result := je;
end;

function TWebApiRepository.GetQuestion(id: integer): TQuestion;
begin

end;

procedure TWebApiRepository.GetRandomQuestions(AQuestionCount: integer; var AQuestions: TList<TQuestion>);
begin

end;

procedure TWebApiRepository.UpdateJournalEntry(AJournalEntry: TJournalEntry);
begin

end;

procedure TWebApiRepository.UpdateQuestion(AQuestion: TQuestion);
begin

end;

end.
