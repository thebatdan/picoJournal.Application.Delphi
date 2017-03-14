unit Question;

interface

type
  TQuestion = class
  private
    FId: Integer;
    FText: string;
    procedure SetId(const Value: Integer);
    procedure SetText(const Value: string);

  protected

  public
    property Id: Integer read FId write SetId;
    property Text: string read FText write SetText;
  end;

implementation

{ TQuestion }

procedure TQuestion.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TQuestion.SetText(const Value: string);
begin
  FText := Value;
end;

end.
