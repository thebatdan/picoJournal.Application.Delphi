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
    procedure GetNewQuestionSet(AQuestionsToAdd: Integer; AEntryDate: TDate; var AJournalEntries: TObjectList<TJournalEntry>);
  protected

  public
    constructor Create(ARepository: IJournalRepository; QuestionsPerDay: Integer);
    destructor Destroy; override;
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
  var AJournalEntries: TObjectList<TJournalEntry>);
begin
  FRepository.GetAllJournalEntries(AJournalEntries);
end;

procedure TJournalService.GetAllQuestions(var AQuestions: TObjectList<TQuestion>);
begin
  FRepository.GetAllQuestions(AQuestions);
end;

procedure TJournalService.GetJournalDateSummary(ADateFrom, ADateTo: TDate;
  var AJournalDateSummary: TObjectList<TJournalDateSummary>);
begin
  FRepository.GetJournalDateSummary(ADateFrom, ADateTo, AJournalDateSummary);
end;

procedure TJournalService.GetJournalEntriesForDay(AEntryDate: TDate;
  var AJournalEntries: TObjectList<TJournalEntry>);
begin
  FRepository.GetJournalEntriesForDay(AEntryDate, AJournalEntries);

  // For now, fill any day's journal list with the required number of questions. Later,
  // only the current day will be editable.
  if (AJournalEntries.Count < FQuestionsPerDay) then
  // If it is the current day, and there are less journal entries logged than required,
  // fill up the list with a random set of queries.
  //if (AJournalEntries.Count < FQuestionsPerDay) and IsSameDay(AEntryDate, Date) then
  begin
    GetNewQuestionSet(FQuestionsPerDay - AJournalEntries.Count, AEntryDate, AJournalEntries);
  end;
end;

function TJournalService.GetJournalEntry(id: integer): TJournalEntry;
begin
  result := FRepository.GetJournalEntry(id);
end;

procedure TJournalService.GetNewQuestionSet(AQuestionsToAdd: Integer; AEntryDate: TDate;
  var AJournalEntries: TObjectList<TJournalEntry>);
var
  aQuestionList: TObjectList<TQuestion>;
  aQuestion: TQuestion;
  aJournalEntry: TJournalEntry;
begin
  aQuestionList := TObjectList<TQuestion>.Create;
  aQuestionList.OwnsObjects := False;
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
    FreeAndNil(aQuestionList);
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
