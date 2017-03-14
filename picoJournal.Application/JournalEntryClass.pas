unit JournalEntryClass;

interface

type

  JournalEntry = Class
    private

    protected

    public
      function GetJournalEntry(): string;
  end;

implementation

function JournalEntry.GetJournalEntry;
begin
    Result := 'Here''s a journal entry!';
end;

end.
