unit PicoJournalMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, JournalEntry, Vcl.StdCtrls, ApplicationOptionsFactory;

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
  private
    procedure WriteMessage(msgText: string);
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
begin
  try
    je := TJournalEntry.Create;
    je.EntryText := 'Text or some such...';
    WriteMessage(je.EntryText);
  finally
    FreeAndNil(je);
  end;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.Options1Click(Sender: TObject);
var
  frmOptions: TFrmOptions;
begin
  frmOptions := TfrmOptions.Create(Self, TApplicationOptionsFactory.GetApplicationOptions);
  try

    if frmOptions.ShowModal = mrOk then
      WriteMessage('It''s Ok :)')
    else
      WriteMessage('Not Ok :(');
  finally
    FreeAndNil(frmOptions);
  end;
end;

procedure TfrmMain.WriteMessage(msgText: string);
begin
  Memo1.Lines.Add(msgText);
end;

end.
