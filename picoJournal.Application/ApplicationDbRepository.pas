unit ApplicationDbRepository;

interface

uses
  System.Generics.Collections, SysUtils,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Stan.Def, FireDAC.Stan.Param,
  FireDAC.Stan.ASync, FireDAC.Phys.MSSQL, FireDAC.Dapt,
  JournalRepository, QuestionClass, JournalEntryClass, JournalDateSummaryClass;

type
  TApplicationDbRepository = class(TInterfacedObject, IJournalRepository)
  private
    FConnection: TFDConnection;
    function GetBaseQuery: TFDQuery;
    function GetJournalEntryBaseQuery: TFDQuery;
    function GetQuestionBaseQuery: TFDQuery;
    procedure JournalEntryQueryToList(query: TFDQuery;
      var AJournalEntries: System.Generics.Collections.TList<TJournalEntry>);
    function MapQueryToJournalEntry(query: TFDQuery): TJournalEntry;
    function MapQueryToQuestion(query: TFDQuery): TQuestion;
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
    procedure GetJournalEntriesForDay(AEntryDate: TDate; var AJournalEntries: TList<TJournalEntry>);

    function CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure DeleteJournalEntry(AJournalEntry: TJournalEntry); overload;
    procedure DeleteJournalEntry(id: integer); overload;

    procedure GetJournalDateSummary(ADateFrom: TDate; ADateTo: TDate;
      var AJournalDateSummary: TList<TJournalDateSummary>);

    constructor Create(connectionString: string);
    destructor Destroy; override;
  end;

implementation

{ TApplicationDbRepository }

constructor TApplicationDbRepository.Create(connectionString: string);
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  FConnection.connectionString := connectionString;
  FConnection.Connected := true;
end;

function TApplicationDbRepository.CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
var
  sql: string;
begin
  sql := 'insert into dbo.JournalEntry(EntryDate, QuestionId, Answer) values (:entryDate, :questionId, :answer); ';
  sql := sql + 'SELECT SCOPE_IDENTITY()';
  AJournalEntry.id := FConnection.ExecSQLScalar(sql, [AJournalEntry.entryDate, AJournalEntry.QuestionId,
    AJournalEntry.Answer]);
  Result := AJournalEntry;
end;

function TApplicationDbRepository.CreateQuestion(AQuestion: TQuestion): TQuestion;
var
  sql: string;
begin
  sql := 'insert into dbo.Question(Question) values (:question); ';
  sql := sql + 'SELECT SCOPE_IDENTITY()';
  AQuestion.id := FConnection.ExecSQLScalar(sql, [AQuestion.Question]);
  Result := AQuestion;
end;

procedure TApplicationDbRepository.DeleteJournalEntry(AJournalEntry: TJournalEntry);
begin
  DeleteJournalEntry(AJournalEntry.id);
end;

procedure TApplicationDbRepository.DeleteJournalEntry(id: integer);
begin
  FConnection.ExecSQL('delete from dbo.JournalEntry where Id = :id', [id]);
end;

procedure TApplicationDbRepository.DeleteQuestion(id: integer);
begin
  FConnection.ExecSQL('delete from dbo.Question where Id = :id', [id]);
end;

procedure TApplicationDbRepository.DeleteQuestion(AQuestion: TQuestion);
begin
  DeleteQuestion(AQuestion.id);
end;

destructor TApplicationDbRepository.Destroy;
begin
  if Assigned(FConnection) then
    FConnection.Connected := false;

  FreeAndNil(FConnection);
  inherited;
end;

function TApplicationDbRepository.MapQueryToJournalEntry(query: TFDQuery): TJournalEntry;
var
  AJournalEntry: TJournalEntry;
begin
  AJournalEntry := TJournalEntry.Create;
  AJournalEntry.Question := TQuestion.Create;
  AJournalEntry.id := query.FieldByName('Id').AsInteger;
  AJournalEntry.entryDate := query.FieldByName('EntryDate').AsDateTime;
  AJournalEntry.QuestionId := query.FieldByName('QuestionId').AsInteger;
  AJournalEntry.Answer := query.FieldByName('Answer').AsString;
  AJournalEntry.Question.id := AJournalEntry.QuestionId;
  AJournalEntry.Question.Question := query.FieldByName('Question').AsString;
  Result := AJournalEntry;
end;

function TApplicationDbRepository.MapQueryToQuestion(query: TFDQuery): TQuestion;
var
  AQuestion: TQuestion;
begin
  AQuestion := TQuestion.Create;
  AQuestion.id := query.FieldByName('Id').AsInteger;
  AQuestion.Question := query.FieldByName('Question').AsString;
  Result := AQuestion;
end;

procedure TApplicationDbRepository.JournalEntryQueryToList(query: TFDQuery;
  var AJournalEntries: System.Generics.Collections.TList<TJournalEntry>);
var
  AJournalEntry: TJournalEntry;
begin
  query.Open;
  query.First;
  while (not query.Eof) do
  begin
    AJournalEntry := MapQueryToJournalEntry(query);
    AJournalEntries.Add(AJournalEntry);
    query.Next;
  end;
  query.Close;
end;

function TApplicationDbRepository.GetBaseQuery: TFDQuery;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := FConnection;
  Result := query;
end;

procedure TApplicationDbRepository.GetAllJournalEntries(var AJournalEntries: TList<TJournalEntry>);
var
  query: TFDQuery;
begin
  query := GetJournalEntryBaseQuery;
  try
    JournalEntryQueryToList(query, AJournalEntries);
  finally
    FreeAndNil(query);
  end;
end;

procedure TApplicationDbRepository.GetAllQuestions(var AQuestions: TList<TQuestion>);
var
  query: TFDQuery;
  AQuestion: TQuestion;
begin
  query := GetQuestionBaseQuery;
  try
    query.Open();
    query.First;
    while (not query.Eof) do
    begin
      AQuestion := MapQueryToQuestion(query);
      AQuestions.Add(AQuestion);
      query.Next;
    end;

    query.Close;
  finally
    FreeAndNil(query);
  end;
end;

procedure TApplicationDbRepository.GetJournalDateSummary(ADateFrom, ADateTo: TDate;
  var AJournalDateSummary: TList<TJournalDateSummary>);
var
  query: TFDQuery;
  journalDateSummary: TJournalDateSummary;
begin
  query := GetBaseQuery;
  query.sql.Add('select EntryDate, Count(*) as EntryCount from dbo.JournalEntry');
  query.sql.Add('where EntryDate >= :startDate and EntryDate <= :endDate');
  query.sql.Add('group by EntryDate');
  try
    query.ParamByName('startDate').AsDate := ADateFrom;
    query.ParamByName('endDate').AsDate := ADateTo;
    query.Open;
    query.First;
    while (not query.Eof) do
    begin
      journalDateSummary := TJournalDateSummary.Create;
      journalDateSummary.JournalDate := query.FieldByName('EntryDate').AsDateTime;
      journalDateSummary.EntryCount := query.FieldByName('EntryCount').AsInteger;
      AJournalDateSummary.Add(journalDateSummary);
      query.Next;
    end;
    query.Close;
  finally
    FreeAndNil(query);
  end;
end;

procedure TApplicationDbRepository.GetJournalEntriesForDay(AEntryDate: TDate;
  var AJournalEntries: TList<TJournalEntry>);
var
  query: TFDQuery;
begin
  query := GetJournalEntryBaseQuery;
  query.sql.Add('where je.EntryDate = :entryDate');
  try
    query.ParamByName('entryDate').AsDate := AEntryDate;
    JournalEntryQueryToList(query, AJournalEntries);
  finally
    FreeAndNil(query);
  end;
end;

function TApplicationDbRepository.GetJournalEntry(id: integer): TJournalEntry;
var
  AJournalEntry: TJournalEntry;
  query: TFDQuery;
begin
  AJournalEntry := nil;
  query := GetJournalEntryBaseQuery;
  query.sql.Add('where je.Id = :id');
  try
    query.ParamByName('id').AsInteger := id;
    query.Open;
    query.First;
    if query.RecordCount = 1 then
      AJournalEntry := MapQueryToJournalEntry(query);

    query.Close;
  finally
    FreeAndNil(query);
  end;

  Result := AJournalEntry;
end;

function TApplicationDbRepository.GetJournalEntryBaseQuery: TFDQuery;
var
  query: TFDQuery;
begin
  query := GetBaseQuery;
  query.sql.Add('select je.Id, je.EntryDate, je.QuestionId, je.Answer, q.Question');
  query.sql.Add('from dbo.JournalEntry je join dbo.Question q on je.QuestionId = q.Id');
  Result := query;
end;

function TApplicationDbRepository.GetQuestion(id: integer): TQuestion;
var
  AQuestion: TQuestion;
  query: TFDQuery;
begin
  AQuestion := nil;
  query := GetQuestionBaseQuery;
  query.sql.Add('where Id = :id');
  try
    query.ParamByName('id').AsInteger := id;
    query.Open;
    query.First;
    if query.RecordCount = 1 then
      AQuestion := MapQueryToQuestion(query);

    query.Close;
  finally
    FreeAndNil(query);
  end;

  Result := AQuestion;
end;

function TApplicationDbRepository.GetQuestionBaseQuery: TFDQuery;
var
  query: TFDQuery;
begin
  query := GetBaseQuery;
  query.sql.Add('select Id, Question from dbo.Question');
  Result := query;
end;

procedure TApplicationDbRepository.GetRandomQuestions(AQuestionCount: integer; AEntryDate: TDate;
  var AQuestions: TList<TQuestion>);
var
  query: TFDQuery;
  AQuestion: TQuestion;
begin
  query := GetBaseQuery;
  try
    query.sql.Add('select top (:questionCount) Id, Question from dbo.Question q');
    query.sql.Add('where not exists (');
		query.sql.Add(' select null from dbo.JournalEntry je');
		query.sql.Add(' where je.QuestionId = q.Id');
		query.sql.Add(' and je.EntryDate = :entryDate)');
    query.sql.Add('order by newid()');
    query.ParamByName('questionCount').AsInteger := AQuestionCount;
    query.ParamByName('entryDate').AsDate := AEntryDate;
    query.Open();
    query.First;
    while (not query.Eof) do
    begin
      AQuestion := MapQueryToQuestion(query);
      AQuestions.Add(AQuestion);
      query.Next;
    end;

    query.Close;
  finally
    FreeAndNil(query);
  end;

end;

procedure TApplicationDbRepository.UpdateJournalEntry(AJournalEntry: TJournalEntry);
var
  query: TFDQuery;
begin
  query := GetBaseQuery;
  query.sql.Add('update dbo.JournalEntry set');
  query.sql.Add('  EntryDate = :entryDate,');
  query.sql.Add('  QuestionId = :questionId,');
  query.sql.Add('  Answer = :answer');
  query.sql.Add('where id = :id');
  try
    query.ParamByName('entryDate').AsDate := AJournalEntry.entryDate;
    query.ParamByName('questionId').AsInteger := AJournalEntry.QuestionId;
    query.ParamByName('answer').AsString := AJournalEntry.Answer;
    query.ParamByName('id').AsInteger := AJournalEntry.id;
    query.ExecSQL;
  finally
    FreeAndNil(query);
  end;
end;

procedure TApplicationDbRepository.UpdateQuestion(AQuestion: TQuestion);
var
  query: TFDQuery;
begin
  query := GetBaseQuery;
  query.sql.Add('update dbo.Question set');
  query.sql.Add('  Question = :question');
  query.sql.Add('where id = :id');
  try
    query.ParamByName('question').AsString := AQuestion.Question;
    query.ParamByName('id').AsInteger := AQuestion.id;
    query.ExecSQL;
  finally
    FreeAndNil(query);
  end;
end;

end.
