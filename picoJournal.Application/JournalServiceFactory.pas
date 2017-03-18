unit JournalServiceFactory;

interface

uses
  SysUtils,
  ApplicationOptions, JournalServiceClass, JournalRepository, ApplicationDbRepository,
  WebApiRepository, JournalServiceInterface;

type
  TJournalServiceFactory = class
  private

  public
    class function GetJournalService(applicationOptions: TApplicationOptions): IJournalService;
  end;

implementation

{ TJournalServiceFactory }

class function TJournalServiceFactory.GetJournalService(applicationOptions: TApplicationOptions): IJournalService;
var
  repository: IJournalRepository;
begin
  repository := nil;
  case applicationOptions.JournalDataSource of
    jdcAppDb : repository := TApplicationDbRepository.Create(applicationOptions.DbConnectionString);
    jdcWebApi: repository := TWebApiRepository.Create(applicationOptions.WebApiUrl);
    else
      raise Exception.Create('No valid Journal Access options defined');
  end;

  result := TJournalService.Create(repository, applicationOptions.QuestionsPerDay);
end;

end.
