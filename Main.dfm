object fTTY: TfTTY
  Left = 206
  Top = 136
  Caption = 'COM Terminal'
  ClientHeight = 701
  ClientWidth = 638
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 0
    Top = 37
    Width = 638
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 41
    ExplicitWidth = 572
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 638
    Height = 37
    Align = alTop
    ParentBackground = False
    TabOrder = 0
    object clConnected: TComLed
      Left = 208
      Top = 4
      Width = 25
      Height = 25
      ComPort = com1
      LedSignal = lsConn
      Kind = lkRedLight
    end
    object clCTS: TComLed
      Left = 232
      Top = 4
      Width = 25
      Height = 25
      Hint = 'CTS'
      ComPort = com1
      LedSignal = lsCTS
      Kind = lkRedLight
    end
    object clDSR: TComLed
      Left = 252
      Top = 4
      Width = 25
      Height = 25
      Hint = 'DSR'
      ComPort = com1
      LedSignal = lsDSR
      Kind = lkRedLight
    end
    object clTx: TComLed
      Left = 276
      Top = 4
      Width = 25
      Height = 25
      Hint = 'TX'
      ComPort = com1
      LedSignal = lsTx
      Kind = lkRedLight
    end
    object clRx: TComLed
      Left = 296
      Top = 4
      Width = 25
      Height = 25
      Hint = 'RX'
      ComPort = com1
      LedSignal = lsRx
      Kind = lkRedLight
    end
    object clRI: TComLed
      Left = 316
      Top = 4
      Width = 25
      Height = 25
      Hint = 'RI'
      ComPort = com1
      LedSignal = lsRing
      Kind = lkGreenLight
    end
    object cbPort: TComComboBox
      Left = 4
      Top = 8
      Width = 69
      Height = 21
      ComPort = com1
      ComProperty = cpPort
      Text = ''
      Style = csDropDownList
      ImeName = 'Russian'
      ItemIndex = -1
      TabOrder = 0
      OnDropDown = cbPortDropDown
    end
    object bConnect: TButton
      Left = 140
      Top = 6
      Width = 61
      Height = 25
      Caption = 'Connect'
      TabOrder = 2
      OnClick = bConnectClick
    end
    object cbBaudRate: TComComboBox
      Left = 76
      Top = 8
      Width = 61
      Height = 21
      ComPort = com1
      ComProperty = cpBaudRate
      Text = '115200'
      Style = csDropDownList
      ImeName = 'Russian'
      ItemIndex = 13
      TabOrder = 1
    end
    object bSend: TButton
      Left = 492
      Top = 6
      Width = 65
      Height = 25
      Caption = 'Send'
      TabOrder = 3
      OnClick = bSendClick
    end
    object eTest: TEdit
      Left = 380
      Top = 8
      Width = 109
      Height = 21
      ImeName = 'Russian'
      TabOrder = 4
      Text = 'Echo test string'
      OnClick = eTestClick
      OnKeyPress = eTestKeyPress
    end
    object ebyte: TEdit
      Left = 559
      Top = 8
      Width = 33
      Height = 21
      Hint = 'Int Byte to send'
      TabOrder = 5
    end
    object cbCR: TCheckBox
      Left = 596
      Top = 2
      Width = 37
      Height = 17
      Caption = 'CR'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object cbNL: TCheckBox
      Left = 596
      Top = 17
      Width = 37
      Height = 17
      Caption = 'NL'
      TabOrder = 7
    end
    object lrDTR: TRLedRectangle
      Left = 341
      Top = 9
      Width = 33
      Height = 20
      CenterLabelText = 'DTR'
      Caption = 'DTR'
      Active = False
      OnClick = cbDTRClick
    end
  end
  object ctTerm: TComTerminal
    Left = 0
    Top = 40
    Width = 638
    Height = 661
    Align = alClient
    Color = clBlack
    ComPort = com1
    Emulation = teVT100orANSI
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Fixedsys'
    Font.Style = []
    ImeName = 'Russian'
    Rows = 40
    ScrollBars = ssBoth
    SmoothScroll = True
    TabOrder = 1
    WantTab = True
    OnDblClick = ctTermDblClick
  end
  object com1: TComPort
    BaudRate = br115200
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = False
    OnException = com1Exception
    Left = 320
    Top = 52
  end
end
