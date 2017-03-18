object frmRestTest: TfrmRestTest
  Left = 0
  Top = 0
  Caption = 'frmRestTest'
  ClientHeight = 515
  ClientWidth = 773
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 337
    Top = 0
    Width = 436
    Height = 515
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 0
    ExplicitLeft = 265
    ExplicitWidth = 508
    ExplicitHeight = 411
    object memRestResponse: TMemo
      Left = 1
      Top = 1
      Width = 434
      Height = 513
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
      ExplicitWidth = 506
      ExplicitHeight = 409
    end
  end
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 515
    Align = alLeft
    ColumnCollection = <
      item
        Value = 50.003051571559350000
      end
      item
        Value = 49.996948428440650000
      end>
    ControlCollection = <
      item
        Column = 1
        Control = btnQuestionGetAll
        Row = 1
      end
      item
        Column = 0
        Control = Label1
        Row = 0
      end
      item
        Column = 1
        Control = Label2
        Row = 0
      end
      item
        Column = 1
        Control = btnQuestionGet
        Row = 3
      end
      item
        Column = 1
        Control = btnQuestionDelete
        Row = 4
      end
      item
        Column = 1
        Control = btnQuestionPost
        Row = 5
      end
      item
        Column = 1
        Control = btnQuestionPut
        Row = 6
      end
      item
        Column = 0
        Control = Button10
        Row = 7
      end
      item
        Column = 0
        Control = btnJournalEntryGetAll
        Row = 1
      end
      item
        Column = 0
        Control = Panel1
        Row = 2
      end
      item
        Column = 0
        Control = btnJournalEntryGet
        Row = 3
      end
      item
        Column = 0
        Control = btnJournalEntryDelete
        Row = 4
      end
      item
        Column = 0
        Control = btnJournalEntryPost
        Row = 5
      end
      item
        Column = 0
        Control = btnJournalEntryPut
        Row = 6
      end
      item
        Column = 1
        Control = Panel3
        Row = 2
      end
      item
        Column = 0
        Control = Panel4
        Row = 8
      end
      item
        Column = 1
        Control = Panel5
        Row = 8
      end>
    RowCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 30.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAbsolute
        Value = 200.000000000000000000
      end
      item
        SizeStyle = ssAuto
        Value = 80.000000000000000000
      end
      item
        SizeStyle = ssAuto
        Value = 80.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAbsolute
        Value = 130.000000000000000000
      end>
    TabOrder = 1
    ExplicitHeight = 411
    DesignSize = (
      337
      515)
    object btnQuestionGetAll: TButton
      Left = 192
      Top = 31
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Get All'
      TabOrder = 0
      OnClick = btnQuestionGetAllClick
    end
    object Label1: TLabel
      Left = 41
      Top = 8
      Width = 86
      Height = 16
      Anchors = []
      Caption = 'Journal Entry'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 29
      ExplicitTop = 1
    end
    object Label2: TLabel
      Left = 223
      Top = 8
      Width = 57
      Height = 16
      Anchors = []
      Caption = 'Question'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 173
      ExplicitTop = 1
    end
    object btnQuestionGet: TButton
      Left = 192
      Top = 256
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Get'
      TabOrder = 1
      OnClick = btnQuestionGetClick
    end
    object btnQuestionDelete: TButton
      Left = 192
      Top = 281
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Delete'
      TabOrder = 2
      OnClick = btnQuestionDeleteClick
    end
    object btnQuestionPost: TButton
      Left = 192
      Top = 306
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Post'
      TabOrder = 3
      OnClick = btnQuestionPostClick
    end
    object btnQuestionPut: TButton
      Left = 192
      Top = 331
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Put'
      TabOrder = 4
      OnClick = btnQuestionPutClick
    end
    object Button10: TButton
      Left = 24
      Top = 356
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Get For Date'
      TabOrder = 5
    end
    object btnJournalEntryGetAll: TButton
      Left = 24
      Top = 31
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Get All'
      TabOrder = 6
      OnClick = btnJournalEntryGetAllClick
    end
    object Panel1: TPanel
      Left = 1
      Top = 56
      Width = 167
      Height = 200
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 7
      ExplicitWidth = 131
      ExplicitHeight = 50
      object Label3: TLabel
        Left = 5
        Top = 3
        Width = 128
        Height = 13
        Caption = 'Entry Id (Get, Delete, Put)'
      end
      object Label4: TLabel
        Left = 5
        Top = 50
        Width = 149
        Height = 26
        Caption = 'Entry Date (Post, Put, Get For Date)'
        WordWrap = True
      end
      object Label5: TLabel
        Left = 5
        Top = 104
        Width = 111
        Height = 13
        Caption = 'Question Id (Post, Put)'
      end
      object Label6: TLabel
        Left = 5
        Top = 151
        Width = 91
        Height = 13
        Caption = 'Answer (Post, Put)'
      end
      object spnJournalEntryId: TSpinEdit
        Left = 23
        Top = 22
        Width = 120
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object dtJournalEntryDate: TDateTimePicker
        Left = 23
        Top = 77
        Width = 120
        Height = 21
        Date = 42812.986748425920000000
        Time = 42812.986748425920000000
        TabOrder = 1
      end
      object spnJournalEntryQuestionId: TSpinEdit
        Left = 23
        Top = 123
        Width = 120
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 1
      end
      object edtJournalEntryAnswer: TEdit
        Left = 23
        Top = 170
        Width = 120
        Height = 21
        TabOrder = 3
      end
    end
    object btnJournalEntryGet: TButton
      Left = 24
      Top = 256
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Get'
      TabOrder = 8
      OnClick = btnJournalEntryGetClick
    end
    object btnJournalEntryDelete: TButton
      Left = 24
      Top = 281
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Delete'
      TabOrder = 9
      OnClick = btnJournalEntryDeleteClick
    end
    object btnJournalEntryPost: TButton
      Left = 24
      Top = 306
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Post'
      TabOrder = 10
      OnClick = btnJournalEntryPostClick
    end
    object btnJournalEntryPut: TButton
      Left = 24
      Top = 331
      Width = 120
      Height = 25
      Anchors = []
      Caption = 'Put'
      TabOrder = 11
      OnClick = btnJournalEntryPutClick
    end
    object Panel3: TPanel
      Left = 168
      Top = 56
      Width = 168
      Height = 200
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 12
      ExplicitTop = 135
      ExplicitWidth = 131
      ExplicitHeight = 50
      object Label9: TLabel
        Left = 6
        Top = 3
        Width = 145
        Height = 13
        Caption = 'Question Id (Get, Delete, Put)'
      end
      object Label10: TLabel
        Left = 6
        Top = 50
        Width = 98
        Height = 13
        Caption = 'Question (Post, Put)'
      end
      object spnQuestionId: TSpinEdit
        Left = 24
        Top = 22
        Width = 120
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object edtQuestion: TEdit
        Left = 24
        Top = 77
        Width = 120
        Height = 21
        TabOrder = 1
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 381
      Width = 167
      Height = 130
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 13
      ExplicitTop = 135
      ExplicitWidth = 131
      ExplicitHeight = 50
      object Label14: TLabel
        Left = 5
        Top = 6
        Width = 50
        Height = 13
        Caption = 'Date From'
      end
      object Label11: TLabel
        Left = 5
        Top = 52
        Width = 38
        Height = 13
        Caption = 'Date To'
      end
      object dtJournalEntrySummaryDateFrom: TDateTimePicker
        Left = 23
        Top = 25
        Width = 120
        Height = 21
        Date = 42812.986748425920000000
        Time = 42812.986748425920000000
        TabOrder = 0
      end
      object dtJournalEntrySummaryDateTo: TDateTimePicker
        Left = 23
        Top = 71
        Width = 120
        Height = 21
        Date = 42812.986748425920000000
        Time = 42812.986748425920000000
        TabOrder = 1
      end
      object btnJournalEntrySummary: TButton
        Left = 23
        Top = 98
        Width = 120
        Height = 25
        Caption = 'Journal Entry Summary'
        TabOrder = 2
      end
    end
    object Panel5: TPanel
      Left = 168
      Top = 381
      Width = 168
      Height = 130
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 14
      ExplicitLeft = 174
      ExplicitTop = 387
      object Label15: TLabel
        Left = 6
        Top = 6
        Width = 75
        Height = 13
        Caption = 'Question Count'
      end
      object Label16: TLabel
        Left = 6
        Top = 53
        Width = 52
        Height = 13
        Caption = 'Entry Date'
      end
      object spnQuestionCount: TSpinEdit
        Left = 24
        Top = 25
        Width = 120
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 1
      end
      object dtQuestionEntryDate: TDateTimePicker
        Left = 24
        Top = 72
        Width = 120
        Height = 21
        Date = 42812.986748425920000000
        Time = 42812.986748425920000000
        TabOrder = 1
      end
      object btnQuestionGetRandom: TButton
        Left = 24
        Top = 99
        Width = 120
        Height = 25
        Caption = 'Get Random'
        TabOrder = 2
        OnClick = btnQuestionGetRandomClick
      end
    end
  end
end
