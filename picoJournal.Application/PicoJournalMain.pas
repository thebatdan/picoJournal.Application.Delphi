unit PicoJournalMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, System.Generics.Collections,
  JournalEntry, ApplicationOptionsFactory, JournalServiceFactory, JournalService,
  ApplicationOptions, Question;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Tools1: TMenuItem;
    Options1: TMenuItem;
    Button1: TButton;
    Memo1: TMemo;
    procedure Exit1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FApplicationOptions: TApplicationOptions;
    procedure WriteMessage(msgText: string);
    function CheckPersistenceValue(settingValue: integer; formValue: integer): integer;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Options;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  je: TJournalEntry;
  journalService: TJournalService;
begin
  journalService := TJournalServiceFactory.GetJournalService(FApplicationOptions);
  try
    je := journalService.GetJournalEntry(7);
    try
      WriteMessage(je.Answer);
    finally
      FreeAndNil(je);
    end;

  finally
    FreeAndNil(journalService);
  end;
end;

function TfrmMain.CheckPersistenceValue(settingValue,
  formValue: integer): integer;
var
  value: integer;
begin
  if settingValue <> -1 then
    value := settingValue
  else
    value := formValue;

  result := value
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FApplicationOptions.AppPersistenceState := frmMain.WindowState;
  if frmMain.WindowState <> wsMaximized then
    begin
      FApplicationOptions.AppPersistenceTop := frmMain.Top;
      FApplicationOptions.AppPersistenceLeft := frmMain.Left;
      FApplicationOptions.AppPersistenceWidth := frmMain.Width;
      FApplicationOptions.AppPersistenceHeight := frmMain.Height;
    end;

  FApplicationOptions.SaveSettings;
  FreeAndNil(FApplicationOptions);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FApplicationOptions := TApplicationOptionsFactory.GetApplicationOptions;
  frmMain.Top := CheckPersistenceValue(FApplicationOptions.AppPersistenceTop, frmMain.Top);
  frmMain.Left := CheckPersistenceValue(FApplicationOptions.AppPersistenceLeft, frmMain.Left);
  frmMain.Width := CheckPersistenceValue(FApplicationOptions.AppPersistenceWidth, frmMain.Width);
  frmMain.Height := CheckPersistenceValue(FApplicationOptions.AppPersistenceHeight, frmMain.Height);

  frmMain.WindowState := FApplicationOptions.AppPersistenceState;
end;

procedure TfrmMain.Options1Click(Sender: TObject);
var
  frmOptions: TFrmOptions;
begin
  frmOptions := TfrmOptions.Create(Self, FApplicationOptions);
  try
    frmOptions.ShowModal;
  finally
    FreeAndNil(frmOptions);
  end;
end;

procedure TfrmMain.WriteMessage(msgText: string);
begin
  Memo1.Lines.Add(msgText);
end;

end.
