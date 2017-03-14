unit PicoJournalMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, JournalEntryClass, Vcl.StdCtrls;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Tools1: TMenuItem;
    Options1: TMenuItem;
    Button1: TButton;
    procedure Exit1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
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
  jeMessage: string;
  je: JournalEntry;
begin
  try
    je := JournalEntry.Create;
    jeMessage := je.GetJournalEntry;
    ShowMessage(jeMessage);
  finally
    FreeAndNil(je);
  end;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.Options1Click(Sender: TObject);
begin
  frmOptions.ShowModal;
end;

end.
