object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  Caption = 'frmOptions'
  ClientHeight = 204
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 436
    Height = 163
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 215
    object Label1: TLabel
      Left = 7
      Top = 128
      Width = 68
      Height = 13
      Caption = 'Web API URL:'
    end
    object rdgAccessJournalEntries: TRadioGroup
      Left = 7
      Top = 8
      Width = 416
      Height = 105
      Caption = 'Access Journal Entries using '
      Items.Strings = (
        'Local Application Database'
        'Web API')
      TabOrder = 0
      OnClick = rdgAccessJournalEntriesClick
    end
    object edtWebApiUrl: TEdit
      Left = 96
      Top = 125
      Width = 327
      Height = 21
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 163
    Width = 436
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 215
    DesignSize = (
      436
      41)
    object btnOk: TButton
      Left = 267
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 348
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
