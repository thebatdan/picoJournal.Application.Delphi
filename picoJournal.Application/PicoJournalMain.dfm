object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'picoJournal'
  ClientHeight = 246
  ClientWidth = 448
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 336
    Top = 213
    Width = 104
    Height = 25
    Caption = 'Get Entry Text'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 432
    Height = 199
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 8
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
    object Tools1: TMenuItem
      Caption = '&Tools'
      object Options1: TMenuItem
        Caption = '&Options'
        OnClick = Options1Click
      end
    end
  end
end
