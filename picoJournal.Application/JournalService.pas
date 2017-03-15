unit JournalService;

interface

uses
  SysUtils, System.Generics.Collections,
  JournalRepository, JournalEntry, Question;

type
  TJournalService = class
  private
    FRepository: IJournalRepository;
  protected

  public
    constructor Create(ARepository: IJournalRepository);
    destructor Destroy; override;
    function GetJournalEntry(id: integer): TJournalEntry;
    procedure AddJournalEntry(var AJournalEntry: TJournalEntry);
    procedure AddQuestion(var AQuestion: TQuestion);
    procedure RemoveJournalEntry(id: Integer);
    procedure RemoveQuestion(id: Integer);
    procedure GetAllJournalEntries(var AJournalEntries: TList<TJournalEntry>);
    procedure GetAllQuestions(var AQuestions: TList<TQuestion>);
    procedure GetJournalEntriesForDay(AEntryDate: TDate; var AJournalEntries: TList<TJournalEntry>);
    procedure GetRandomQuestions(AQuestionCount: integer; var AQuestions: TList<TQuestion>);
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
  end;

implementation

{ TJournalService }

procedure TJournalService.AddQuestion(var AQuestion: TQuestion);
begin
  AQuestion := FRepository.CreateQuestion(AQuestion);
end;

constructor TJournalService.Create(ARepository: IJournalRepository);
begin
  FRepository := ARepository;
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

procedure TJournalService.GetJournalEntriesForDay(AEntryDate: TDate;
  var AJournalEntries: TList<TJournalEntry>);
begin
  FRepository.GetJournalEntriesForDay(AEntryDate, AJournalEntries);
end;

function TJournalService.GetJournalEntry(id: integer): TJournalEntry;
begin
  result := FRepository.GetJournalEntry(id);
end;

procedure TJournalService.GetRandomQuestions(AQuestionCount: integer;
  var AQuestions: TList<TQuestion>);
begin
//This needs to be removed, just here for testing. To be replaced by method that
//prepares the daily question list
  FRepository.GetRandomQuestions(AQuestionCount, AQuestions);
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
