unit WebApiRepository;

interface

uses
  System.Generics.Collections, REST.Client, SysUtils, REST.Json, REST.Types,
  System.JSON, IPPeerClient,
  JournalRepository, QuestionClass, JournalEntryClass, JournalDateSummaryClass, System.Classes;

type
  TWebApiRepository = class(TInterfacedObject, IJournalRepository)
  private
    FWebApiUrl: string;
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    FRestResponse: TRESTResponse;
    function IncludeTrailingForwardSlash(const Value: string): string;
    procedure InitialiseWebApiConnection(AMethod: TRESTRequestMethod; ABaseUrl: string);
    procedure FinaliseWebApiConnection;
    function FormatJsonDate(ADate: TDate): string;
  protected

  public
    function GetQuestion(id: integer): TQuestion;
    procedure GetAllQuestions(var AQuestions: TObjectList<TQuestion>);
    procedure GetRandomQuestions(AQuestionCount: integer; AEntryDate: TDate; var AQuestions: TObjectList<TQuestion>);

    function CreateQuestion(AQuestion: TQuestion): TQuestion;
    procedure UpdateQuestion(AQuestion: TQuestion);
    procedure DeleteQuestion(AQuestion: TQuestion); overload;
    procedure DeleteQuestion(id: integer); overload;

    function GetJournalEntry(id: integer): TJournalEntry;
    procedure GetAllJournalEntries(var AJournalEntries: TObjectList<TJournalEntry>);
    procedure GetJournalEntriesForDay(entryDate: TDate; var AJournalEntries: TObjectList<TJournalEntry>);

    function CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
    procedure UpdateJournalEntry(AJournalEntry: TJournalEntry);
    procedure DeleteJournalEntry(AJournalEntry: TJournalEntry); overload;
    procedure DeleteJournalEntry(id: integer); overload;

    procedure GetJournalDateSummary(ADateFrom: TDate; ADateTo: TDate;
      var AJournalDateSummary: TObjectList<TJournalDateSummary>);

    constructor Create(webApiUrl: string);
    destructor Destroy; override;
  end;

implementation

Const
  API_JOURNAL_ENTRY = 'journalentry';
  API_JOURNAL_ENTRY_FOR_DATE = 'journalentry/fordate';
  API_JOURNAL_ENTRY_DATE_SUMMARY = 'journalentry/journaldatesummary';
  API_QUESTION = 'question';
  API_QUESTION_RANDOM = 'question/random';

  JSON_DATE_FORMAT = 'yyyy-mm-dd';

{ TWebApiRepository }

constructor TWebApiRepository.Create(webApiUrl: string);
begin
  FWebApiUrl := IncludeTrailingForwardSlash(webApiUrl);
end;

function TWebApiRepository.CreateJournalEntry(AJournalEntry: TJournalEntry): TJournalEntry;
var
  journalEntryForJson: TJournalEntry;
begin
  InitialiseWebApiConnection(rmPOST, FWebApiUrl + API_JOURNAL_ENTRY);
  try
    journalEntryForJson := TJournalEntry.Create;
    try
      journalEntryForJson.EntryDate := AJournalEntry.EntryDate;
      journalEntryForJson.QuestionId := AJournalEntry.QuestionId;
      journalEntryForJson.Answer := AJournalEntry.Answer;
      FRestRequest.AddBody(TJson.ObjectToJsonString(journalEntryForJson), ctAPPLICATION_JSON);
      FRestRequest.Execute;
    finally
      FreeAndNil(journalEntryForJson);
    end;

    journalEntryForJson := TJson.JsonToObject<TJournalEntry>(FRestResponse.Content);
    try
      AJournalEntry.Id := journalEntryForJson.Id;
      AJournalEntry.EntryDate := journalEntryForJson.EntryDate;
      AJournalEntry.QuestionId := journalEntryForJson.QuestionId;
      AJournalEntry.Answer := journalEntryForJson.Answer;
    finally
      journalEntryForJson.Question.Free;
      FreeAndNil(journalEntryForJson);
    end;
  finally
    FinaliseWebApiConnection;
  end;

  result := AJournalEntry;
end;

function TWebApiRepository.CreateQuestion(AQuestion: TQuestion): TQuestion;
var
  questionResult: TQuestion;
begin
  InitialiseWebApiConnection(rmPOST, FWebApiUrl + API_QUESTION);
  try
    FRestRequest.AddBody(TJson.ObjectToJsonString(AQuestion), ctAPPLICATION_JSON);
    FRestRequest.Execute;

    questionResult := TJson.JsonToObject<TQuestion>(FRestResponse.Content);
    try
      AQuestion.Id := questionResult.Id;
      AQuestion.QuestionText := questionResult.QuestionText;
    finally
      FreeAndNil(questionResult);
    end;

    result := AQuestion;
  finally
    FinaliseWebApiConnection;
  end;
end;

procedure TWebApiRepository.DeleteJournalEntry(AJournalEntry: TJournalEntry);
begin
  DeleteJournalEntry(AJournalEntry.Id);
end;

procedure TWebApiRepository.DeleteJournalEntry(id: integer);
begin
  InitialiseWebApiConnection(rmDELETE, IncludeTrailingForwardSlash(FWebApiUrl + API_JOURNAL_ENTRY)+IntToStr(id));
  try
    FRestRequest.Execute;
  finally
    FinaliseWebApiConnection;
  end;
end;

procedure TWebApiRepository.DeleteQuestion(id: integer);
begin
  InitialiseWebApiConnection(rmDELETE, IncludeTrailingForwardSlash(FWebApiUrl + API_QUESTION)+IntToStr(id));
  try
    FRestRequest.Execute;
  finally
    FinaliseWebApiConnection;
  end;
end;

destructor TWebApiRepository.Destroy;
begin

  inherited;
end;

procedure TWebApiRepository.FinaliseWebApiConnection;
begin
  FRestRequest.Params.Clear;
  FRestRequest.ClearBody;
  FreeAndNil(FRestClient);
end;

function TWebApiRepository.FormatJsonDate(ADate: TDate): string;
begin
  result := FormatDateTime(JSON_DATE_FORMAT, ADate);
end;

procedure TWebApiRepository.DeleteQuestion(AQuestion: TQuestion);
begin
  DeleteQuestion(AQuestion.Id);
end;

procedure TWebApiRepository.GetAllJournalEntries(var AJournalEntries: TObjectList<TJournalEntry>);
var
  jsonArr: TJSONArray;
  jsonValue : TJSONValue;
begin
  InitialiseWebApiConnection(rmGET, FWebApiUrl + API_JOURNAL_ENTRY);
  try
    FRestRequest.Execute;

    jsonArr := nil;
    try
      jsonArr := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FRestResponse.Content),0) as TJSONArray;
      for jsonValue in jsonArr do
      begin
        AJournalEntries.Add(TJson.JsonToObject<TJournalEntry>(jsonValue.ToString));
      end;
    finally
      FreeAndNil(jsonArr);
    end;
  finally
    FinaliseWebApiConnection;
  end;
end;

procedure TWebApiRepository.GetAllQuestions(var AQuestions: TObjectList<TQuestion>);
var
  jsonArr: TJSONArray;
  jsonValue : TJSONValue;
begin
  InitialiseWebApiConnection(rmGET,FWebApiUrl + API_QUESTION);
  try
    FRestRequest.Execute;

    jsonArr := nil;
    try
      jsonArr := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FRestResponse.Content),0) as TJSONArray;
      for jsonValue in jsonArr do
      begin
        AQuestions.Add(TJson.JsonToObject<TQuestion>(jsonValue.ToString));
      end;
    finally
      FreeAndNil(jsonArr);
    end;
  finally
    FinaliseWebApiConnection;
  end;
end;

procedure TWebApiRepository.GetJournalDateSummary(ADateFrom, ADateTo: TDate;
  var AJournalDateSummary: TObjectList<TJournalDateSummary>);
var
  jsonArr: TJSONArray;
  jsonValue : TJSONValue;
begin
  InitialiseWebApiConnection(rmGET, FWebApiUrl + API_JOURNAL_ENTRY_DATE_SUMMARY);
  try
    FRestRequest.Params.AddItem('datefrom', FormatJsonDate(ADateFrom));
    FRestRequest.Params.AddItem('dateto', FormatJsonDate(ADateTo));

    FRestRequest.Execute;

    jsonArr := nil;
    try
      jsonArr := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FRestResponse.Content),0) as TJSONArray;
      for jsonValue in jsonArr do
      begin
        AJournalDateSummary.Add(TJson.JsonToObject<TJournalDateSummary>(jsonValue.ToString));
      end;
    finally
      FreeAndNil(jsonArr);
    end;
  finally
    FinaliseWebApiConnection;
  end;
end;

procedure TWebApiRepository.GetJournalEntriesForDay(entryDate: TDate; var AJournalEntries: TObjectList<TJournalEntry>);
var
  jsonArr: TJSONArray;
  jsonValue : TJSONValue;
begin
  InitialiseWebApiConnection(rmGET, IncludeTrailingForwardSlash(FWebApiUrl + API_JOURNAL_ENTRY_FOR_DATE)+FormatJsonDate(entryDate));
  try
    FRestRequest.Execute;

    jsonArr := nil;
    try
      jsonArr := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FRestResponse.Content),0) as TJSONArray;
      for jsonValue in jsonArr do
      begin
        AJournalEntries.Add(TJson.JsonToObject<TJournalEntry>(jsonValue.ToString));
      end;
    finally
      FreeAndNil(jsonArr);
    end;
  finally
    FinaliseWebApiConnection;
  end;
end;

function TWebApiRepository.GetJournalEntry(id: integer): TJournalEntry;
var
  journalEntry: TJournalEntry;
begin
  journalEntry := nil;
  InitialiseWebApiConnection(rmGET, IncludeTrailingForwardSlash(FWebApiUrl + API_JOURNAL_ENTRY)+IntToStr(id));
  try
    FRestRequest.Execute;
    if Length(FRestResponse.Content) > 0 then
       journalEntry := TJson.JsonToObject<TJournalEntry>(FRestResponse.Content);
    result := journalEntry;
  finally
    FinaliseWebApiConnection;
  end;
end;

function TWebApiRepository.GetQuestion(id: integer): TQuestion;
var
  question: TQuestion;
begin
  question := nil;
  InitialiseWebApiConnection(rmGET, FWebApiUrl + API_QUESTION);
  try
    FRestRequest.Execute;
    if Length(FRestResponse.Content) > 0 then
       question := TJson.JsonToObject<TQuestion>(FRestResponse.Content);
    result := question;
  finally
    FinaliseWebApiConnection;
  end;
end;

procedure TWebApiRepository.GetRandomQuestions(AQuestionCount: integer; AEntryDate: TDate;
  var AQuestions: TObjectList<TQuestion>);
var
  jsonArr: TJSONArray;
  jsonValue : TJSONValue;
begin
  InitialiseWebApiConnection(rmGET, FWebApiUrl + API_QUESTION_RANDOM);
  try
    FRestRequest.Params.AddItem('questionCount', IntToStr(AQuestionCount));
    FRestRequest.Params.AddItem('forDate', FormatJsonDate(AEntryDate));
    FRestRequest.Execute;

    jsonArr := nil;
    try
      jsonArr := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FRestResponse.Content),0) as TJSONArray;
      for jsonValue in jsonArr do
      begin
        AQuestions.Add(TJson.JsonToObject<TQuestion>(jsonValue.ToString));
      end;
    finally
      FreeAndNil(jsonArr);
    end;
  finally
    FinaliseWebApiConnection;
  end;
end;

procedure TWebApiRepository.UpdateJournalEntry(AJournalEntry: TJournalEntry);
begin
  InitialiseWebApiConnection(rmPUT, IncludeTrailingForwardSlash(FWebApiUrl + API_JOURNAL_ENTRY)+IntToStr(AJournalEntry.Id));
  try
    FRestRequest.AddBody(TJson.ObjectToJsonString(AJournalEntry), ctAPPLICATION_JSON);
    FRestRequest.Execute;
  finally
    FinaliseWebApiConnection;
  end;
end;

procedure TWebApiRepository.UpdateQuestion(AQuestion: TQuestion);
begin
  InitialiseWebApiConnection(rmPUT, IncludeTrailingForwardSlash(FWebApiUrl + API_QUESTION)+IntToStr(AQuestion.Id));
  try
    FRestRequest.AddBody(TJson.ObjectToJsonString(AQuestion), ctAPPLICATION_JSON);
    FRestRequest.Execute;
  finally
    FinaliseWebApiConnection;
  end;
end;

function TWebApiRepository.IncludeTrailingForwardSlash(const Value: string): string;
var
  newValue: string;
begin
  newValue := Value;
  if newValue[length(newValue)] <> '/' then
    newValue := newValue + '/';
  result := newValue;
end;

procedure TWebApiRepository.InitialiseWebApiConnection(AMethod: TRESTRequestMethod;
  ABaseUrl: string);
begin
  FRestClient := TRESTClient.Create(ABaseUrl);
  FRestRequest := TRESTRequest.Create(FRestClient);
  FRestResponse := TRESTResponse.Create(FRestClient);

  FRestRequest.Method := AMethod;
  FRestRequest.Client := FRestClient;
  FRestRequest.Response := FRestResponse;
end;

end.
