unit JournalEntry;

interface

uses
  Question;

type

  TJournalEntry = Class
    private
    FEntryDate: TDateTime;
    FQuestion: TQuestion;
    FQuestionId: Integer;
    FAnswer: string;
    FId: Integer;
    procedure SetQuestion(const Value: TQuestion);
    function GetAnswer: string;
    procedure SetId(const Value: Integer);

    protected

    public
      property Id: Integer read FId write SetId;
      property EntryDate: TDateTime read FEntryDate write FEntryDate;
      property QuestionId: Integer read FQuestionId write FQuestionId;
      property Question: TQuestion read FQuestion write SetQuestion;
      property Answer: string read GetAnswer write FAnswer;
  end;

implementation

function TJournalEntry.GetAnswer: string;
begin
  Result := FAnswer;
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
