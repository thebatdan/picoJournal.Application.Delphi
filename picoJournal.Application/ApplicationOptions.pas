unit ApplicationOptions;

interface

uses
  IniFiles, SysUtils;

type
  TApplicationOptions = class
  private
    FWebApiUrl: string;
    FUseWebApi: boolean;
    FUseAppDb: boolean;
    FFileName: string;
    procedure SetWebApiUrl(const Value: string);
    procedure SetUseWebApi(const Value: boolean);
    procedure SetUseAppDb(const Value: boolean);
    procedure InitialiseSettings;
  protected

  public
    property UseWebApi: boolean read FUseWebApi write SetUseWebApi;
    property WebApiUrl: string read FWebApiUrl write SetWebApiUrl;
    property UseAppDb: boolean read FUseAppDb write SetUseAppDb;

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
    FUseWebApi := iniFile.ReadBool('General','UseWebApi', false);
    FUseAppDb := iniFile.ReadBool('General','UseAppDb', true);
    FWebApiUrl := iniFile.ReadString('General','WebApiUrl', '');
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
    iniFile.WriteBool('General','UseWebApi', FUseWebApi);
    iniFile.WriteBool('General','UseAppDb', FUseAppDb);
    iniFile.WriteString('General','WebApiUrl', FWebApiUrl);
  finally
    FreeAndNil(IniFile);
  end;
end;

procedure TApplicationOptions.SetUseAppDb(const Value: boolean);
begin
  FUseAppDb := Value;
end;

procedure TApplicationOptions.SetUseWebApi(const Value: boolean);
begin
  FUseWebApi := Value;
end;

procedure TApplicationOptions.SetWebApiUrl(const Value: string);
begin
  FWebApiUrl := Value;
end;


end.
