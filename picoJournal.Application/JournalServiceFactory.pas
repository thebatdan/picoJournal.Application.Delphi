unit JournalServiceFactory;

interface

uses
  SysUtils,
  ApplicationOptions, JournalService, JournalRepository, ApplicationDbRepository,
  WebApiRepository;

type
  TJournalServiceFactory = class
  private

  public
    class function GetJournalService(applicationOptions: TApplicationOptions): TJournalService;
  end;

implementation

{ TJournalServiceFactory }

class function TJournalServiceFactory.GetJournalService(applicationOptions: TApplicationOptions): TJournalService;
var
  repository: IJournalRepository;
begin
  repository := nil;
  case applicationOptions.JournalDataSource of
    jdcAppDb : repository := TApplicationDbRepository.Create;
    jdcWebApi: repository := TWebApiRepository.Create;
    else
      raise Exception.Create('No valid Journal Access options defined');
  end;

  result := TJournalService.Create(repository);
end;

end.
