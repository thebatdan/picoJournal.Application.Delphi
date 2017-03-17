unit PicoJournalMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, System.Generics.Collections,
  JournalEntryClass, ApplicationOptionsFactory, JournalServiceFactory, JournalServiceClass, JournalDateSummaryClass,
  ApplicationOptions, QuestionClass, JournalServiceInterface, Vcl.ExtCtrls, Vcl.ComCtrls, DateUtils,
  JournalEntryFrame;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Tools1: TMenuItem;
    Options1: TMenuItem;
    mclJournalDate: TMonthCalendar;
    Panel2: TPanel;
    btnPreviousDay: TButton;
    btnNextDay: TButton;
    Panel3: TPanel;
    pnlJournalEditorList: TPanel;
    Panel1: TPanel;
    btnSaveJournalEntries: TButton;
    procedure Exit1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mclJournalDateGetMonthBoldInfo(Sender: TObject; Month, Year: Cardinal; var MonthBoldInfo: Cardinal);
    procedure mclJournalDateClick(Sender: TObject);
    procedure btnPreviousDayClick(Sender: TObject);
    procedure btnNextDayClick(Sender: TObject);
    procedure btnSaveJournalEntriesClick(Sender: TObject);
  private
    FApplicationOptions: TApplicationOptions;
    FJournalEditorList: TList<TfmeJournalEntry>;
    function CheckPersistenceValue(settingValue: integer; formValue: integer): integer;
    procedure ClearJournalEditorList;
    procedure ChangeCalendarDate(newDate: TDate; Sender: TObject);
    procedure SetControlState;
    procedure GetJournalEditors;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Options;

procedure TfrmMain.btnNextDayClick(Sender: TObject);
begin
  ChangeCalendarDate(mclJournalDate.Date + 1, Sender);
end;

procedure TfrmMain.btnPreviousDayClick(Sender: TObject);
begin
  ChangeCalendarDate(mclJournalDate.Date - 1, Sender);
end;

procedure TfrmMain.btnSaveJournalEntriesClick(Sender: TObject);
var
  aJournalEditor: TfmeJournalEntry;
  aJournalEntry: TJournalEntry;
  aJournalService: IJournalService;
begin
  aJournalService := TJournalServiceFactory.GetJournalService(FApplicationOptions);
  for aJournalEditor in FJournalEditorList do
  begin
    aJournalEntry := aJournalEditor.JournalEntry;
    if aJournalEntry.Id <= 0 then
      aJournalService.AddJournalEntry(aJournalEntry)
    else
      aJournalService.UpdateJournalEntry(aJournalEntry);
  end;
end;

procedure TfrmMain.ChangeCalendarDate(newDate: TDate; Sender: TObject);
begin
  mclJournalDate.Date := newDate;
  GetJournalEditors;
end;

function TfrmMain.CheckPersistenceValue(settingValue, formValue: integer): integer;
var
  value: integer;
begin
  if settingValue <> -1 then
    value := settingValue
  else
    value := formValue;

  result := value
end;

procedure TfrmMain.ClearJournalEditorList;
var
  aJournalEditor: TfmeJournalEntry;
  aJournalEntry: TJournalEntry;
begin
  for aJournalEditor in FJournalEditorList do
  begin
    aJournalEntry := aJournalEditor.JournalEntry;
    aJournalEntry.Question.Free;
    aJournalEntry.Free;
    aJournalEditor.Free;
  end;

  FJournalEditorList.Clear;
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

  ClearJournalEditorList;
  FreeAndNil(FJournalEditorList);

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

  FJournalEditorList := TList<TfmeJournalEntry>.Create;

  mclJournalDate.MaxDate := Date;
  ChangeCalendarDate(Date, Sender);
end;

procedure TfrmMain.mclJournalDateClick(Sender: TObject);
begin
  GetJournalEditors;
end;

procedure TfrmMain.mclJournalDateGetMonthBoldInfo(Sender: TObject; Month, Year: Cardinal; var MonthBoldInfo: Cardinal);
var
  JournalEntrySummaryList: TList<TJournalDateSummary>;
  aJournalService: IJournalService;
  dateFrom: TDate;
  dateTo: TDate;
  journalDateSummary: TJournalDateSummary;
  days: array of Cardinal;
  i: integer;
begin
  aJournalService := TJournalServiceFactory.GetJournalService(FApplicationOptions);
  JournalEntrySummaryList := TList<TJournalDateSummary>.Create;
  try
    dateFrom := EncodeDate(Year, Month, 1);
    dateTo := IncMonth(dateFrom) - 1;

    aJournalService.GetJournalDateSummary(dateFrom, dateTo, JournalEntrySummaryList);
    if JournalEntrySummaryList.Count > 0 then
    begin
      SetLength(days, JournalEntrySummaryList.Count);
      for i := 0 to Pred(JournalEntrySummaryList.Count) do
      begin
        days[i] := DayOfTheMonth(JournalEntrySummaryList[i].JournalDate);
      end;

      mclJournalDate.BoldDays(days, MonthBoldInfo);
    end;
  finally
    for journalDateSummary in JournalEntrySummaryList do
    begin
      journalDateSummary.Free;
    end;
    FreeAndNil(JournalEntrySummaryList);
  end;
end;

procedure TfrmMain.Options1Click(Sender: TObject);
var
  frmOptions: TFrmOptions;
begin
  frmOptions := TFrmOptions.Create(Self, FApplicationOptions);
  try
    frmOptions.ShowModal;
  finally
    FreeAndNil(frmOptions);
  end;
end;

procedure TfrmMain.SetControlState;
begin
  btnSaveJournalEntries.Enabled := IsSameDay(mclJournalDate.Date, Date);
  btnNextDay.Enabled := not IsSameDay(mclJournalDate.Date, Date);
end;

procedure TfrmMain.GetJournalEditors;
var
  aJournalService: IJournalService;
  aJournalEntryList: System.Generics.Collections.TList<TJournalEntry>;
  aJournalEntry: TJournalEntry;
  aJournalEditor: TfmeJournalEntry;
  i: integer;
begin
  SetControlState;
  aJournalService := TJournalServiceFactory.GetJournalService(FApplicationOptions);
  aJournalEntryList := tList<TJournalEntry>.Create;
  try
    aJournalService.GetJournalEntriesForDay(mclJournalDate.Date, aJournalEntryList);
    
    SendMessage(pnlJournalEditorList.Handle, WM_SETREDRAW, 0, 0);
    ClearJournalEditorList;
    try
      for i := Pred(aJournalEntryList.Count) downto 0 do
      begin
        aJournalEntry := aJournalEntryList[i];
        aJournalEditor := TfmeJournalEntry.Create(Self, aJournalEntry);
        
        FJournalEditorList.Add(aJournalEditor);
        aJournalEditor.Name := aJournalEditor.Name + IntToStr(FJournalEditorList.Count);
        aJournalEditor.Parent := pnlJournalEditorList;
        //ScrollBox1.InsertControl(aJournalEditor);
      end;

      for i := Pred(pnlJournalEditorList.ControlCount) downto 0 do
      begin
        TWinControl(pnlJournalEditorList.Controls[i]).TabOrder := pnlJournalEditorList.ControlCount - i;
      end;                          
        
        

    finally
      SendMessage(pnlJournalEditorList.Handle, WM_SETREDRAW, 1, 0);
      RedrawWindow(pnlJournalEditorList.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
    end;
  finally
    FreeAndNil(aJournalEntryList);
  end;
end;

end.
