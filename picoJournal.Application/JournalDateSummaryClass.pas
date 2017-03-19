unit JournalDateSummaryClass;

interface

type
  TJournalDateSummary = class
  private
    FEntryCount: Integer;
    FJournalDate: TDateTime;
    procedure SetEntryCount(const Value: Integer);
    procedure SetJournalDate(const Value: TDateTime);
  public
    property JournalDate: TDateTime read FJournalDate write SetJournalDate;
    property EntryCount: Integer read FEntryCount write SetEntryCount;
  end;

implementation

{ TJournalDateSummary }

procedure TJournalDateSummary.SetEntryCount(const Value: Integer);
begin
  FEntryCount := Value;
end;

procedure TJournalDateSummary.SetJournalDate(const Value: TDateTime);
begin
  FJournalDate := Value;
end;

end.
