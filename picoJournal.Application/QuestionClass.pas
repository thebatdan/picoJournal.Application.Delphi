unit QuestionClass;

interface

type
  TQuestion = class
  private
    FId: Integer;
    FQuestion: string;
    procedure SetId(const Value: Integer);
    procedure SetQuestion(const Value: string);

  protected

  public
    property Id: Integer read FId write SetId;
    property Question: string read FQuestion write SetQuestion;
  end;

implementation

{ TQuestion }

procedure TQuestion.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TQuestion.SetQuestion(const Value: string);
begin
  FQuestion := Value;
end;

end.
