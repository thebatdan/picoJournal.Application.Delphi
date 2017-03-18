object fmeJournalEntry: TfmeJournalEntry
  Left = 0
  Top = 0
  Width = 451
  Height = 67
  Align = alTop
  TabOrder = 0
  ExplicitWidth = 337
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 67
    Align = alClient
    BorderWidth = 4
    TabOrder = 0
    object lblQuestion: TLabel
      Left = 5
      Top = 5
      Width = 50
      Height = 13
      Align = alTop
      Caption = 'Question'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object memJournalEntry: TMemo
      Left = 5
      Top = 18
      Width = 327
      Height = 44
      Align = alClient
      MaxLength = 140
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = memJournalEntryChange
    end
  end
end
