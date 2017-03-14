unit Options;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ApplicationOptions;

type
  TfrmOptions = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    rdgAccessJournalEntries: TRadioGroup;
    Label1: TLabel;
    edtWebApiUrl: TEdit;
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
  FApplicationOptions.UseWebApi := rdgAccessJournalEntries.ItemIndex = 1;
  FApplicationOptions.UseAppDb := rdgAccessJournalEntries.ItemIndex = 0;
  FApplicationOptions.WebApiUrl := edtWebApiUrl.Text;
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
  if FApplicationOptions.UseAppDb then
    rdgAccessJournalEntries.ItemIndex := 0
  else if FApplicationOptions.UseWebApi then
    rdgAccessJournalEntries.ItemIndex := 1
  else
    rdgAccessJournalEntries.ItemIndex := -1;

  edtWebApiUrl.Text := FApplicationOptions.WebApiUrl;
  SetControlState;
end;

procedure TfrmOptions.rdgAccessJournalEntriesClick(Sender: TObject);
begin
  SetControlState;
end;

end.
