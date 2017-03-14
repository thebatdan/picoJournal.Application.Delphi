unit JournalService;

interface

uses
  SysUtils,
  JournalRepository, JournalEntry, Question;

type
  TJournalService = class
  private
    FRepository: IJournalRepository;
  protected

  public
    constructor Create(repository: IJournalRepository);
    destructor Destroy; override;
    function GetJournalEntry(id: integer): TJournalEntry;
  end;

implementation

{ TJournalService }

constructor TJournalService.Create(repository: IJournalRepository);
begin
  FRepository := repository;
end;

destructor TJournalService.Destroy;
begin
  FRepository := nil;
  inherited Destroy;
end;



function TJournalService.GetJournalEntry(id: integer): TJournalEntry;
begin
  result := FRepository.GetJournalEntry(id);
end;

end.
