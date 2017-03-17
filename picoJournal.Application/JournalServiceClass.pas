unit JournalServiceClass;

interface

uses
  SysUtils, System.Generics.Collections, DateUtils,
  JournalRepository, JournalEntryClass, QuestionClass, JournalDateSummaryClass, JournalServiceInterface;

type
  TJournalService = class(TInterfacedObject, IJournalService)
  private
    FRepository: IJournalRepository;
    FQuestionsPerDay: Integer;
    procedure GetNewQuestionSet(AQuestionsToAdd: Integer; AEntryDate: TDate; var AJournalEntries: TList<TJournalEntry>);
  protected

  public
    constructor Create(ARepository: IJournalRepository; QuestionsPerDay: Integer);
    destructor Destroy; override;
    function GetJournalEntry(id: integer): TJournalEntry;
    procedure AddJournalEntry(var AJournalEntry: TJournalEntry);
    procedure AddQuestion(var AQuestion: TQuestion);
    procedure RemoveJournalEntry(id: Integer);
    procedure RemoveQuestion(id: Integer);
    procedure GetAllJournalEntries(var AJournalEntries: TList<TJournalEntry>);
    procedure GetAllQuestions(var AQuestions: TList<TQuestion>);
    procedure GetJournalEntriesForDay(AEntryDate: TDate; var AJournalEntries: TList<TJournalEntry>);
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure GetJournalDateSummary(ADateFrom: TDate; ADateTo: TDate; var AJournalDateSummary: TList<TJournalDateSummary>);
  end;

implementation

{ TJournalService }

procedure TJournalService.AddQuestion(var AQuestion: TQuestion);
begin
  AQuestion := FRepository.CreateQuestion(AQuestion);
end;

constructor TJournalService.Create(ARepository: IJournalRepository; QuestionsPerDay: Integer);
begin
  FRepository := ARepository;
  FQuestionsPerDay := QuestionsPerDay;
end;

procedure TJournalService.AddJournalEntry(var AJournalEntry: TJournalEntry);
begin
  AJournalEntry := FRepository.CreateJournalEntry(AJournalEntry);
end;

destructor TJournalService.Destroy;
begin
  FRepository := nil;
  inherited Destroy;
end;

procedure TJournalService.GetAllJournalEntries(
  var AJournalEntries: TList<TJournalEntry>);
begin
  FRepository.GetAllJournalEntries(AJournalEntries);
end;

procedure TJournalService.GetAllQuestions(var AQuestions: TList<TQuestion>);
begin
  FRepository.GetAllQuestions(AQuestions);
end;

procedure TJournalService.GetJournalDateSummary(ADateFrom, ADateTo: TDate;
  var AJournalDateSummary: TList<TJournalDateSummary>);
begin
  FRepository.GetJournalDateSummary(ADateFrom, ADateTo, AJournalDateSummary);
end;

procedure TJournalService.GetJournalEntriesForDay(AEntryDate: TDate;
  var AJournalEntries: TList<TJournalEntry>);
var
  aDate: TDate;
begin
  FRepository.GetJournalEntriesForDay(AEntryDate, AJournalEntries);
  aDate := Date;
  if (AJournalEntries.Count < FQuestionsPerDay) and IsSameDay(AEntryDate, aDate) then
  begin
    GetNewQuestionSet(FQuestionsPerDay - AJournalEntries.Count, AEntryDate, AJournalEntries);
  end;
end;

function TJournalService.GetJournalEntry(id: integer): TJournalEntry;
begin
  result := FRepository.GetJournalEntry(id);
end;

procedure TJournalService.GetNewQuestionSet(AQuestionsToAdd: Integer; AEntryDate: TDate;
  var AJournalEntries: TList<TJournalEntry>);
var
  aQuestionList: TList<TQuestion>;
  aQuestion: TQuestion;
  aJournalEntry: TJournalEntry;
begin
  aQuestionList := TList<TQuestion>.Create;
  try
    FRepository.GetRandomQuestions(AQuestionsToAdd, AEntryDate, aQuestionList);
    for aQuestion in aQuestionList do
    begin
      aJournalEntry := TJournalEntry.Create;
      aJournalEntry.EntryDate := AEntryDate;
      aJournalEntry.Question := aQuestion;
      AJournalEntries.Add(aJournalEntry);
    end;
  finally
    FreeAndNil(aQuestionList) ;
  end;
end;

procedure TJournalService.RemoveJournalEntry(id: Integer);
begin
  FRepository.DeleteJournalEntry(id);
end;

procedure TJournalService.RemoveQuestion(id: Integer);
begin
  FRepository.DeleteQuestion(id);
end;

procedure TJournalService.UpdateJournalEntry(AJournalEntry: TJournalEntry);
begin
  FRepository.UpdateJournalEntry(AJournalEntry);
end;

end.
