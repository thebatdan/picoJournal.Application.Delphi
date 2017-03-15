unit ApplicationDbRepository;

interface

uses
  System.Generics.Collections, SysUtils,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Stan.Def, FireDAC.Stan.Param,
  FireDAC.Stan.ASync, FireDAC.Phys.MSSQL, FireDac.Dapt,
  JournalRepository, Question, JournalEntry;

type
  TApplicationDbRepository = class(TInterfacedObject, IJournalRepository)
  private
    FConnection: TFDConnection;
    function GetBaseQuery: TFDQuery;
    function GetJournalEntryBaseQuery: TFDQuery;
    function GetQuestionBaseQuery: TFDQuery;
    procedure JournalEntryQueryToList(query: TFDQuery; var AJournalEntries: System.Generics.Collections.TList<TJournalEntry>);
    function MapQueryToJournalEntry(query: TFDQuery): TJournalEntry;
    function MapQueryToQuestion(query: TFDQuery): TQuestion;
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
    procedure GetJournalEntriesForDay(AEntryDate: TDate; var AJournalEntries: TList<TJournalEntry>);

    function CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure DeleteJournalEntry(AJournalEntry: TJournalEntry); overload;
    procedure DeleteJournalEntry(id: Integer); overload;

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
  DeleteJournalEntry(AJournalEntry.Id);
end;

procedure TApplicationDbRepository.DeleteJournalEntry(id: Integer);
begin
  FConnection.ExecSQL('delete from dbo.JournalEntry where Id = :id', [id]);
end;

procedure TApplicationDbRepository.DeleteQuestion(id: Integer);
begin
  FConnection.ExecSQL('delete from dbo.Question where Id = :id', [id]);
end;

procedure TApplicationDbRepository.DeleteQuestion(AQuestion: TQuestion);
begin
  DeleteQuestion(AQuestion.Id);
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
  aJournalEntry: TJournalEntry;
begin
  aJournalEntry := TJournalEntry.Create;
  aJournalEntry.Question := TQuestion.Create;
  aJournalEntry.Id := query.FieldByName('Id').AsInteger;
  aJournalEntry.EntryDate := query.FieldByName('EntryDate').AsDateTime;
  aJournalEntry.QuestionId := query.FieldByName('QuestionId').AsInteger;
  aJournalEntry.Answer := query.FieldByName('Answer').AsString;
  ajournalEntry.Question.Id := aJournalEntry.QuestionId;
  aJournalEntry.Question.Question := query.FieldByName('Question').AsString;
  result := aJournalEntry;
end;

function TApplicationDbRepository.MapQueryToQuestion(
  query: TFDQuery): TQuestion;
var
  aQuestion: TQuestion;
begin
  aQuestion := TQuestion.Create;
  aQuestion.Id := query.FieldByName('Id').AsInteger;
  aQuestion.Question := query.FieldByName('Question').AsString;
  result := aQuestion;
end;

procedure TApplicationDbRepository.JournalEntryQueryToList(query: TFDQuery; var AJournalEntries: System.Generics.Collections.TList<TJournalEntry>);
var
  aJournalEntry: TJournalEntry;
begin
  query.Open;
  query.First;
  while (not query.Eof) do
  begin
    aJournalEntry := MapQueryToJournalEntry(query);
    AJournalEntries.Add(aJournalEntry);
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
  result := query;
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
  aQuestion: TQuestion;
begin
  query := GetQuestionBaseQuery;
  try
    query.Open();
    query.First;
    while (not query.Eof) do
    begin
      aQuestion := MapQueryToQuestion(query);
      AQuestions.Add(aQuestion);
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
  query.SQL.Add('where je.EntryDate = :entryDate');
  try
    query.ParamByName('entryDate').AsDate := AEntryDate;
    JournalEntryQueryToList(query, AJournalEntries);
  finally
    FreeAndNil(query);
  end;
end;

function TApplicationDbRepository.GetJournalEntry(id: integer): TJournalEntry;
var
  aJournalEntry: TJournalEntry;
  query: TFDQuery;
begin
  aJournalEntry := nil;
  query := GetJournalEntryBaseQuery;
  query.SQL.Add('where je.Id = :id');
  try
    query.ParamByName('id').AsInteger := id;
    query.Open;
    query.First;
    if query.RecordCount = 1 then
      aJournalEntry := MapQueryToJournalEntry(query);

    query.Close;
  finally
    FreeAndNil(query);
  end;

  Result := aJournalEntry;
end;

function TApplicationDbRepository.GetJournalEntryBaseQuery: TFDQuery;
var
  query: TFDQuery;
begin
  query := GetBaseQuery;
  query.SQL.Add('select je.Id, je.EntryDate, je.QuestionId, je.Answer, q.Question');
  query.SQL.Add('from dbo.JournalEntry je join dbo.Question q on je.QuestionId = q.Id');
  result := query;
end;

function TApplicationDbRepository.GetQuestion(id: integer): TQuestion;
var
  aQuestion: TQuestion;
  query: TFDQuery;
begin
  aQuestion:= nil;
  query := GetQuestionBaseQuery;
  query.SQL.Add('where Id = :id');
  try
    query.ParamByName('id').AsInteger := id;
    query.Open;
    query.First;
    if query.RecordCount = 1 then
      aQuestion := MapQueryToQuestion(query);

    query.Close;
  finally
    FreeAndNil(query);
  end;

  Result := aQuestion;
end;

function TApplicationDbRepository.GetQuestionBaseQuery: TFDQuery;
var
  query: TFDQuery;
begin
  query := GetBaseQuery;
  query.SQL.Add('select Id, Question from dbo.Question');
  result := query;
end;

procedure TApplicationDbRepository.GetRandomQuestions(AQuestionCount: integer; var AQuestions: TList<TQuestion>);
var
  query: TFDQuery;
  aQuestion: TQuestion;
begin
  query := GetBaseQuery;
  try
    query.SQL.Add('select top (:QuestionCount) Id, Question from dbo.Question order by newid()');
    query.ParamByName('QuestionCount').AsInteger := AQuestionCount;
    query.Open();
    query.First;
    while (not query.Eof) do
    begin
      aQuestion := MapQueryToQuestion(query);
      AQuestions.Add(aQuestion);
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
  query.SQL.Add('update dbo.JournalEntry set');
  query.SQL.Add('  EntryDate = :entryDate,' );
  query.SQL.Add('  QuestionId = :questionId,');
  query.SQL.Add('  Answer = :answer');
  query.SQL.Add('where id = :id');
  try
    query.ParamByName('entryDate').AsDate := AJournalEntry.EntryDate;
    query.ParamByName('questionId').AsInteger := AJournalEntry.QuestionId;
    query.ParamByName('answer').AsString := AJournalEntry.Answer;
    query.ParamByName('id').AsInteger := AJournalEntry.Id;
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
  query.SQL.Add('update dbo.Question set');
  query.SQL.Add('  Question = :question');
  query.SQL.Add('where id = :id');
  try
    query.ParamByName('question').AsString := AQuestion.Question;
    query.ParamByName('id').AsInteger := AQuestion.Id;
    query.ExecSQL;
  finally
    FreeAndNil(query);
  end;
end;

end.
