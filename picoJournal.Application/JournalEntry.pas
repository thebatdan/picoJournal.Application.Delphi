unit JournalEntry;

interface

uses
  Question;

type

  TJournalEntry = Class
    private
    FDate: TDateTime;
    FQuestion: TQuestion;
    FQuestionId: Integer;
    FEntryText: string;
    FId: Integer;
    procedure SetQuestion(const Value: TQuestion);
    function GetEntryText: string;
    procedure SetId(const Value: Integer);

    protected

    public
      property Id: Integer read FId write SetId;
      property Date: TDateTime read FDate write FDate;
      property QuestionId: Integer read FQuestionId write FQuestionId;
      property Question: TQuestion read FQuestion write SetQuestion;
      property EntryText: string read GetEntryText write FEntryText;
  end;

implementation

function TJournalEntry.GetEntryText: string;
begin
  Result := FEntryText;
end;

procedure TJournalEntry.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TJournalEntry.SetQuestion(const Value: TQuestion);
begin
  FQuestion := Value;
  if Assigned(FQuestion) then
    FQuestionId := FQuestion.Id;

end;

end.
