unit JournalEntryFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  DateUtils,
  JournalEntryClass;

type
  TfmeJournalEntry = class(TFrame)
    lblQuestion: TLabel;
    memJournalEntry: TMemo;
    Panel1: TPanel;
    procedure memJournalEntryChange(Sender: TObject);
  private
    FJournalEntry: TJournalEntry;
  public
    constructor Create(AOwner: TComponent; AJournalEntry: TJournalEntry);  reintroduce;
    property JournalEntry: TJournalEntry read FJournalEntry;
  end;

implementation

{$R *.dfm}

{ TfmeJournalEntry }

constructor TfmeJournalEntry.Create(AOwner: TComponent;
  AJournalEntry: TJournalEntry);
begin
  inherited Create(AOwner);
  FJournalEntry := AJournalEntry;
  lblQuestion.Caption := FJournalEntry.Question.QuestionText;
  memJournalEntry.Text := FJournalEntry.Answer;

  // For now, allow any day to be edited.
  // Eventually. older days will be locked down and only the current day can be edited.
  //memJournalEntry.Enabled := IsSameDay(FJournalEntry.EntryDate, Date);
end;

procedure TfmeJournalEntry.memJournalEntryChange(Sender: TObject);
begin
  FJournalEntry.Answer := memJournalEntry.Text;
end;

end.
