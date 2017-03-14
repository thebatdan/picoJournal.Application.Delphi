object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  Caption = 'frmOptions'
  ClientHeight = 256
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 436
    Height = 215
    Align = alClient
    TabOrder = 0
    ExplicitTop = -6
    ExplicitWidth = 448
    ExplicitHeight = 205
  end
  object Panel2: TPanel
    Left = 0
    Top = 215
    Width = 436
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 205
    ExplicitWidth = 448
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
      ExplicitLeft = 279
    end
    object btnCancel: TButton
      Left = 348
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 360
    end
  end
end
