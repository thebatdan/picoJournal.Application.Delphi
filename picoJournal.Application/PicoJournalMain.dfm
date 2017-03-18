object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderWidth = 8
  Caption = 'picoJournal'
  ClientHeight = 315
  ClientWidth = 581
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 235
    Height = 315
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object mclJournalDate: TMonthCalendar
      Left = 0
      Top = 0
      Width = 235
      Height = 160
      Align = alTop
      Date = 42795.461444444450000000
      TabOrder = 0
      TabStop = True
      OnClick = mclJournalDateClick
      OnGetMonthBoldInfo = mclJournalDateGetMonthBoldInfo
    end
    object btnPreviousDay: TButton
      Left = 0
      Top = 166
      Width = 89
      Height = 25
      Caption = '< Previous Day'
      TabOrder = 1
      OnClick = btnPreviousDayClick
    end
    object btnNextDay: TButton
      Left = 140
      Top = 166
      Width = 89
      Height = 25
      Caption = 'Next Day >'
      TabOrder = 2
      OnClick = btnNextDayClick
    end
    object btnRestTest: TButton
      Left = 0
      Top = 247
      Width = 89
      Height = 25
      Caption = 'REST Test'
      TabOrder = 3
      OnClick = btnRestTestClick
    end
  end
  object Panel3: TPanel
    Left = 235
    Top = 0
    Width = 346
    Height = 315
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnlJournalEditorList: TPanel
      Left = 0
      Top = 0
      Width = 346
      Height = 272
      Align = alClient
      BevelOuter = bvLowered
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 0
      Top = 272
      Width = 346
      Height = 43
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        346
        43)
      object btnSaveJournalEntries: TButton
        Left = 222
        Top = 14
        Width = 118
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Save Journal Entries'
        TabOrder = 0
        OnClick = btnSaveJournalEntriesClick
      end
    end
  end
  object MainMenu1: TMainMenu
    Top = 288
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
