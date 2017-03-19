unit RESTtest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Generics.Collections, DateUtils,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin,
  JournalEntryClass, WebApiRepository, Vcl.ComCtrls,QuestionClass, JournalDateSummaryClass;

type
  TfrmRestTest = class(TForm)
    Panel2: TPanel;
    memRestResponse: TMemo;
    GridPanel1: TGridPanel;
    btnQuestionGetAll: TButton;
    Label1: TLabel;
    Label2: TLabel;
    btnQuestionGet: TButton;
    btnQuestionDelete: TButton;
    btnQuestionPost: TButton;
    btnQuestionPut: TButton;
    btnJournalEntryGetForDate: TButton;
    btnJournalEntryGetAll: TButton;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    spnJournalEntryId: TSpinEdit;
    dtJournalEntryDate: TDateTimePicker;
    spnJournalEntryQuestionId: TSpinEdit;
    edtJournalEntryAnswer: TEdit;
    btnJournalEntryGet: TButton;
    btnJournalEntryDelete: TButton;
    btnJournalEntryPost: TButton;
    btnJournalEntryPut: TButton;
    Panel3: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    spnQuestionId: TSpinEdit;
    edtQuestion: TEdit;
    Panel4: TPanel;
    Label14: TLabel;
    Label11: TLabel;
    dtJournalEntrySummaryDateFrom: TDateTimePicker;
    dtJournalEntrySummaryDateTo: TDateTimePicker;
    btnJournalEntrySummary: TButton;
    Panel5: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    spnQuestionCount: TSpinEdit;
    dtQuestionEntryDate: TDateTimePicker;
    btnQuestionGetRandom: TButton;
    procedure btnJournalEntryGetAllClick(Sender: TObject);
    procedure btnJournalEntryGetClick(Sender: TObject);
    procedure btnJournalEntryDeleteClick(Sender: TObject);
    procedure btnJournalEntryPostClick(Sender: TObject);
    procedure btnJournalEntryPutClick(Sender: TObject);
    procedure btnQuestionGetClick(Sender: TObject);
    procedure btnQuestionDeleteClick(Sender: TObject);
    procedure btnQuestionPostClick(Sender: TObject);
    procedure btnQuestionPutClick(Sender: TObject);
    procedure btnQuestionGetAllClick(Sender: TObject);
    procedure btnQuestionGetRandomClick(Sender: TObject);
    procedure btnJournalEntryGetForDateClick(Sender: TObject);
    procedure btnJournalEntrySummaryClick(Sender: TObject);
  private
    FWebApiRepository: TWebApiRepository;
    procedure WriteJournalEntryOutput(journalEntry: TJournalEntry);
    procedure WriteQuestionOutput(AQuestion: TQuestion);
    procedure WriteJournalEntryListOutput(journalEntryList: TObjectList<TJournalEntry>);
    procedure FreeJournalEntryList(journalEntryList: TObjectList<TJournalEntry>);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; AWebApiUrl: string); reintroduce;
     destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TfrmRestTest }

procedure TfrmRestTest.btnJournalEntryGetClick(Sender: TObject);
var
  journalEntry: TJournalEntry;
begin
  journalEntry := FWebApiRepository.GetJournalEntry(spnJournalEntryId.Value);
  if Assigned(journalEntry) then
  begin
    try
      spnJournalEntryId.Value := journalEntry.Id;
      dtJournalEntryDate.Date := journalEntry.EntryDate;
      spnJournalEntryQuestionId.Value := journalEntry.QuestionId;
      edtJournalEntryAnswer.Text := journalEntry.Answer;
      memRestResponse.Clear;
      WriteJournalEntryOutput(journalEntry);
    finally
      if Assigned(journalEntry) then
      begin
        journalEntry.Question.Free;
        FreeAndNil(journalEntry);
      end;
    end;
  end;
end;

procedure TfrmRestTest.btnJournalEntryPostClick(Sender: TObject);
var
  journalEntry: TJournalEntry;
begin
  journalEntry := TJournalEntry.Create;
  try
    journalEntry.QuestionId := spnJournalEntryQuestionId.Value;
    journalEntry.EntryDate := dtJournalEntryDate.Date;
    journalEntry.Answer := edtJournalEntryAnswer.Text;
    journalEntry := FWebApiRepository.CreateJournalEntry(journalEntry);
    memRestResponse.Clear;
    WriteJournalEntryOutput(journalEntry);
  finally
    FreeAndNil(journalEntry);
  end;
end;

procedure TfrmRestTest.btnJournalEntryPutClick(Sender: TObject);
var
  journalEntry: TJournalEntry;
begin
  journalEntry := TJournalEntry.Create;
  try
    journalEntry.Id := spnJournalEntryId.Value;
    journalEntry.QuestionId := spnJournalEntryQuestionId.Value;
    journalEntry.EntryDate := dtJournalEntryDate.Date;
    journalEntry.Answer := edtJournalEntryAnswer.Text;
    FWebApiRepository.UpdateJournalEntry(journalEntry);
    memRestResponse.Clear;
    memRestResponse.Text := 'Journal Entry Updated.';
  finally
    FreeAndNil(journalEntry);
  end;
end;

procedure TfrmRestTest.btnJournalEntrySummaryClick(Sender: TObject);
var
  journalDateSummaryList: TObjectList<TJournalDateSummary>;
  journalDateSummary: TJournalDateSummary;
begin
  journalDateSummaryList := TObjectList<TJournalDateSummary>.Create;
  try
    FWebApiRepository.GetJournalDateSummary(dtJournalEntrySummaryDateFrom.Date, dtJournalEntrySummaryDateTo.Date, journalDateSummaryList);
    memRestResponse.Clear;
    for journalDateSummary in journalDateSummaryList do
    begin
      memRestResponse.Lines.Add(Format('Date: %s; Journal Entry Count: %d',
        [DateToStr(journalDateSummary.JournalDate), journalDateSummary.EntryCount]));
    end;
  finally
    FreeAndNil(journalDateSummaryList);
  end;
end;

procedure TfrmRestTest.btnQuestionDeleteClick(Sender: TObject);
begin
  FWebApiRepository.DeleteQuestion(spnQuestionId.Value);
  memRestResponse.Clear;
  memRestResponse.Text := 'Deleted Question Id '+inttostr(spnQuestionId.Value);
end;

procedure TfrmRestTest.btnQuestionGetAllClick(Sender: TObject);
var
  QuestionList: TObjectList<TQuestion>;
  question: TQuestion;
begin
  QuestionList := TObjectList<TQuestion>.Create;
  try
    FWebApiRepository.GetAllQuestions(QuestionList);

    memRestResponse.Clear;
    for question in QuestionList do
    begin
      WriteQuestionOutput(question);
    end;
  finally
    FreeAndNil(QuestionList);
  end;
end;

procedure TfrmRestTest.btnQuestionGetClick(Sender: TObject);
var
  question: TQuestion;
begin
  question := FWebApiRepository.GetQuestion(spnQuestionId.Value);
  if Assigned(question) then
  begin
    try
      spnQuestionId.Value := question.Id;
      edtQuestion.Text := question.QuestionText;
      memRestResponse.Clear;
      WriteQuestionOutput(question);
    finally
      if Assigned(question) then
      begin
        FreeAndNil(question);
      end;
    end;
  end;
end;

procedure TfrmRestTest.btnQuestionGetRandomClick(Sender: TObject);
var
  QuestionList: TObjectList<TQuestion>;
  question: TQuestion;
begin
  QuestionList := TObjectList<TQuestion>.Create;
  try
    FWebApiRepository.GetRandomQuestions(spnQuestionCount.Value, dtQuestionEntryDate.Date, QuestionList);

    memRestResponse.Clear;
    for question in QuestionList do
    begin
      WriteQuestionOutput(question);
    end;
  finally
    FreeAndNil(QuestionList);
  end;
end;

procedure TfrmRestTest.btnQuestionPostClick(Sender: TObject);
var
  question: TQuestion;
begin
  question := TQuestion.Create;
  try
    question.QuestionText := edtQuestion.Text;
    question := FWebApiRepository.CreateQuestion(question);
    memRestResponse.Clear;
    WriteQuestionOutput(question);
  finally
    FreeAndNil(question);
  end;

end;

procedure TfrmRestTest.btnQuestionPutClick(Sender: TObject);
var
  question: TQuestion;
begin
  question := TQuestion.Create;
  try
    question.Id := spnQuestionId.Value;
    question.QuestionText := edtQuestion.Text;
    FWebApiRepository.UpdateQuestion(question);
    memRestResponse.Clear;
    memRestResponse.Text := 'Question Updated.';
  finally
    FreeAndNil(question);
  end;
end;

procedure TfrmRestTest.btnJournalEntryGetForDateClick(Sender: TObject);
var
  journalEntryList: TObjectList<TJournalEntry>;
begin
  journalEntryList := TObjectList<TJournalEntry>.Create;
  try
    FWebApiRepository.GetJournalEntriesForDay(dtJournalEntryDate.Date, journalEntryList);
    WriteJournalEntryListOutput(journalEntryList);
  finally
    FreeJournalEntryList(journalEntryList);
  end;
end;

procedure TfrmRestTest.btnJournalEntryDeleteClick(Sender: TObject);
begin
  FWebApiRepository.DeleteJournalEntry(spnJournalEntryId.Value);
  memRestResponse.Clear;
  memRestResponse.Text := 'Deleted Journal entry Id '+inttostr(spnJournalEntryId.Value);
end;

procedure TfrmRestTest.btnJournalEntryGetAllClick(Sender: TObject);
var
  journalEntryList: TObjectList<TJournalEntry>;
begin
  journalEntryList := TObjectList<TJournalEntry>.Create;
  try
    FWebApiRepository.GetAllJournalEntries(journalEntryList);
    WriteJournalEntryListOutput(journalEntryList);
  finally
    FreeJournalEntryList(journalEntryList);
  end;
end;

constructor TfrmRestTest.Create(AOwner: TComponent; AWebApiUrl: string);
begin
  FWebApiRepository := TWebApiRepository.Create(AWebApiUrl);
  inherited Create(AOwner);
end;

destructor TfrmRestTest.Destroy;
begin
  FreeAndNil(FWebApiRepository);
  inherited;
end;

procedure TfrmRestTest.FreeJournalEntryList(journalEntryList: TObjectList<TJournalEntry>);
var
  journalEntry: TJournalEntry;
begin
  for journalEntry in journalEntryList do
  begin
    journalEntry.Question.Free;
  end;
  FreeAndNil(journalEntryList);
end;

procedure TfrmRestTest.WriteJournalEntryListOutput(journalEntryList: TObjectList<TJournalEntry>);
var
  journalEntry: TJournalEntry;
begin
  memRestResponse.Clear;
  for journalEntry in journalEntryList do
  begin
    WriteJournalEntryOutput(journalEntry);
  end;
end;

procedure TfrmRestTest.WriteJournalEntryOutput(journalEntry: TJournalEntry);
begin
  if Assigned(journalEntry) then
  begin
    if Assigned(journalEntry.Question) then
      memRestResponse.Lines.Add(Format('Id: %d; Date: %s; Question: (%d) %s; Answer: %s',
        [journalEntry.Id, DateToStr(journalEntry.EntryDate), journalEntry.QuestionId, journalEntry.Question.QuestionText, journalEntry.Answer]))
    else
      memRestResponse.Lines.Add(Format('Id: %d; Date: %s; Question Id: %d; Answer: %s',
        [journalEntry.Id, DateToStr(journalEntry.EntryDate), journalEntry.QuestionId, journalEntry.Answer]));
  end
  else
  begin
    memRestResponse.Lines.Add('No Journal Entry found.');
  end;
end;

procedure TfrmRestTest.WriteQuestionOutput(AQuestion: TQuestion);
begin
  if Assigned(AQuestion) then
  begin
      memRestResponse.Lines.Add(Format('Id: %d; Question: %s',
        [AQuestion.Id, AQuestion.QuestionText]))
  end
  else
  begin
    memRestResponse.Lines.Add('No Question found.');
  end;
end;

end.
