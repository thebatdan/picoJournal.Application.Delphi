unit Options;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ApplicationOptions,
  Vcl.Samples.Spin;

type
  TfrmOptions = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    rdgAccessJournalEntries: TRadioGroup;
    Label1: TLabel;
    edtWebApiUrl: TEdit;
    Label2: TLabel;
    spnQuestionsPerDay: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure rdgAccessJournalEntriesClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FApplicationOptions: TApplicationOptions;

    procedure SetControlState;
  public
    constructor Create(AOwner: TComponent; applicationOptions: TApplicationOptions); reintroduce;
  end;

implementation

{$R *.dfm}

procedure TfrmOptions.btnOkClick(Sender: TObject);
begin
  FApplicationOptions.JournalDataSource := TJournalDataSource(rdgAccessJournalEntries.ItemIndex);
  FApplicationOptions.WebApiUrl := edtWebApiUrl.Text;
  FApplicationOptions.QuestionsPerDay := spnQuestionsPerDay.Value;
  FApplicationOptions.SaveSettings;
end;

constructor TfrmOptions.Create(AOwner: TComponent;
  applicationOptions: TApplicationOptions);
begin
  FApplicationOptions := applicationOptions;
  inherited Create(AOwner);
end;

procedure TfrmOptions.SetControlState;
begin
  edtWebApiUrl.Enabled := rdgAccessJournalEntries.ItemIndex = 1;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  rdgAccessJournalEntries.ItemIndex := integer(FApplicationOptions.JournalDataSource);
  edtWebApiUrl.Text := FApplicationOptions.WebApiUrl;
  spnQuestionsPerDay.Value := FApplicationOptions.QuestionsPerDay;
  SetControlState;
end;

procedure TfrmOptions.rdgAccessJournalEntriesClick(Sender: TObject);
begin
  SetControlState;
end;

end.
