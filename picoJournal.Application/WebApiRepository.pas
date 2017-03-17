unit WebApiRepository;

interface

uses
  System.Generics.Collections,
  JournalRepository, QuestionClass, JournalEntryClass, JournalDateSummaryClass;

type
  TWebApiRepository = class(TInterfacedObject, IJournalRepository)
  private

  protected

  public
    function GetQuestion(id: integer): TQuestion;
    procedure GetAllQuestions(var AQuestions: TList<TQuestion>);
    procedure GetRandomQuestions(AQuestionCount: integer; AEntryDate: TDate; var AQuestions: TList<TQuestion>);

    function CreateQuestion(AQuestion: TQuestion): TQuestion;
    procedure UpdateQuestion(AQuestion: TQuestion);
    procedure DeleteQuestion(AQuestion: TQuestion); overload;
    procedure DeleteQuestion(id: integer); overload;

    function GetJournalEntry(id: integer): TJournalEntry;
    procedure GetAllJournalEntries(var AJournalEntries: TList<TJournalEntry>);
    procedure GetJournalEntriesForDay(entryDate: TDate; var AJournalEntries: TList<TJournalEntry>);

    function CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure DeleteJournalEntry(AJournalEntry: TJournalEntry); overload;
    procedure DeleteJournalEntry(id: integer); overload;

    procedure GetJournalDateSummary(ADateFrom: TDate; ADateTo: TDate;
      var AJournalDateSummary: TList<TJournalDateSummary>);
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

procedure TWebApiRepository.DeleteJournalEntry(id: integer);
begin

end;

procedure TWebApiRepository.DeleteQuestion(id: integer);
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

procedure TWebApiRepository.GetJournalDateSummary(ADateFrom, ADateTo: TDate;
  var AJournalDateSummary: TList<TJournalDateSummary>);
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

procedure TWebApiRepository.GetRandomQuestions(AQuestionCount: integer; AEntryDate: TDate;
  var AQuestions: TList<TQuestion>);
begin

end;

procedure TWebApiRepository.UpdateJournalEntry(AJournalEntry: TJournalEntry);
begin

end;

procedure TWebApiRepository.UpdateQuestion(AQuestion: TQuestion);
begin

end;

end.
