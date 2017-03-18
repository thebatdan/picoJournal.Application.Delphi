unit QuestionClass;

interface

type
  TQuestion = class
  private
    FId: Integer;
    FQuestionText: string;
    procedure SetId(const Value: Integer);
    procedure SetQuestionText(const Value: string);

  protected

  public
    property Id: Integer read FId write SetId;
    property QuestionText: string read FQuestionText write SetQuestionText;
  end;

implementation

{ TQuestion }

procedure TQuestion.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TQuestion.SetQuestionText(const Value: string);
begin
  FQuestionText := Value;
end;

end.
