unit ApplicationOptions;

interface

uses
  IniFiles, SysUtils, System.UITypes;

type
  TJournalDataSource = (jdcNone=-1, jdcAppDb, jdcWebApi);

  TApplicationOptions = class
  private
    FWebApiUrl: string;
    FFileName: string;
    FQuestionsPerDay: integer;
    FJournalDataSource: TJournalDataSource;
    FAppPersistenceTop: integer;
    FAppPersistenceHeight: integer;
    FAppPersistenceLeft: integer;
    FAppPersistenceWidth: integer;
    FAppPersistenceState: TWindowState;
    procedure SetWebApiUrl(const Value: string);
    procedure InitialiseSettings;
    procedure SetJournalDataSource(const Value: TJournalDataSource);
    procedure SetQuestionsPerDay(const Value: integer);
    procedure SetAppPersistenceHeight(const Value: integer);
    procedure SetAppPersistenceLeft(const Value: integer);
    procedure SetAppPersistenceState(const Value: TWindowState);
    procedure SetAppPersistenceTop(const Value: integer);
    procedure SetAppPersistenceWidth(const Value: integer);
  protected

  public
    property WebApiUrl: string read FWebApiUrl write SetWebApiUrl;
    property JournalDataSource: TJournalDataSource read FJournalDataSource write SetJournalDataSource;
    property QuestionsPerDay: integer read FQuestionsPerDay write SetQuestionsPerDay;
    property AppPersistenceTop: integer read FAppPersistenceTop write SetAppPersistenceTop;
    property AppPersistenceLeft: integer read FAppPersistenceLeft write SetAppPersistenceLeft;
    property AppPersistenceWidth: integer read FAppPersistenceWidth write SetAppPersistenceWidth;
    property AppPersistenceHeight: integer read FAppPersistenceHeight write SetAppPersistenceHeight;
    property AppPersistenceState: TWindowState read FAppPersistenceState write SetAppPersistenceState;

    procedure SaveSettings;

    constructor Create(fileName: string);
  end;

implementation

{ TApplicationOptions }

constructor TApplicationOptions.Create(fileName: string);
begin
  FFileName := fileName;
  InitialiseSettings;
end;

procedure TApplicationOptions.InitialiseSettings;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(FFileName);
  try
    SetJournalDataSource(TJournalDataSource(iniFile.ReadInteger('General','JournalDataSource', 0)));
    SetWebApiUrl(iniFile.ReadString('General','WebApiUrl', ''));
    SetQuestionsPerDay(iniFile.ReadInteger('General','QuestionsPerDay', 3));

    SetAppPersistenceTop(iniFile.ReadInteger('AppPersistence','Top', -1));
    SetAppPersistenceLeft(iniFile.ReadInteger('AppPersistence','Left', -1));
    SetAppPersistenceWidth(iniFile.ReadInteger('AppPersistence','Width', -1));
    SetAppPersistenceHeight(iniFile.ReadInteger('AppPersistence','Height', -1));
    SetAppPersistenceState(TWindowState(iniFile.ReadInteger('AppPersistence','State', integer(TWindowState.wsNormal))));
  finally
    FreeAndNil(IniFile);
  end;
end;

procedure TApplicationOptions.SaveSettings;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(FFileName);
  try
    iniFile.WriteInteger('General','JournalDataSource', integer(FJournalDataSource));
    iniFile.WriteString('General','WebApiUrl', FWebApiUrl);
    iniFile.WriteInteger('General','QuestionsPerDay', FQuestionsPerDay);

    iniFile.WriteInteger('AppPersistence','Top', FAppPersistenceTop);
    iniFile.WriteInteger('AppPersistence','Left', FAppPersistenceLeft);
    iniFile.WriteInteger('AppPersistence','Width', FAppPersistenceWidth);
    iniFile.WriteInteger('AppPersistence','Height', FAppPersistenceHeight);
    iniFile.WriteInteger('AppPersistence','State', integer(FAppPersistenceState));
  finally
    FreeAndNil(IniFile);
  end;
end;

procedure TApplicationOptions.SetAppPersistenceHeight(const Value: integer);
begin
  FAppPersistenceHeight := Value;
end;

procedure TApplicationOptions.SetAppPersistenceLeft(const Value: integer);
begin
  FAppPersistenceLeft := Value;
end;

procedure TApplicationOptions.SetAppPersistenceState(const Value: TWindowState);
begin
  FAppPersistenceState := Value;
end;

procedure TApplicationOptions.SetAppPersistenceTop(const Value: integer);
begin
  FAppPersistenceTop := Value;
end;

procedure TApplicationOptions.SetAppPersistenceWidth(const Value: integer);
begin
  FAppPersistenceWidth := Value;
end;

procedure TApplicationOptions.SetJournalDataSource(
  const Value: TJournalDataSource);
begin
  FJournalDataSource := Value;
end;

procedure TApplicationOptions.SetQuestionsPerDay(const Value: integer);
begin
  FQuestionsPerDay := Value;
end;

procedure TApplicationOptions.SetWebApiUrl(const Value: string);
begin
  FWebApiUrl := Value;
end;

end.
