object Login: TLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 250
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 49
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 152
      Top = 14
      Width = 98
      Height = 21
      Caption = 'FORM LOGIN'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 400
    Height = 201
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 48
      Top = 32
      Width = 59
      Height = 15
      Caption = 'Username :'
    end
    object Label3: TLabel
      Left = 48
      Top = 80
      Width = 56
      Height = 15
      Caption = 'Password :'
    end
    object LblLupaPassword: TLabel
      Left = 176
      Top = 160
      Width = 84
      Height = 15
      Cursor = crHandPoint
      Caption = 'Lupa Password?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = LblLupaPasswordClick
    end
    object EdtUsername: TEdit
      Left = 120
      Top = 32
      Width = 225
      Height = 23
      TabOrder = 0
    end
    object EdtPassword: TEdit
      Left = 120
      Top = 80
      Width = 225
      Height = 23
      PasswordChar = '*'
      TabOrder = 1
    end
    object BtnLogin: TBitBtn
      Left = 120
      Top = 120
      Width = 97
      Height = 33
      Caption = 'Login'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BtnLoginClick
    end
    object BtnBatal: TBitBtn
      Left = 248
      Top = 120
      Width = 97
      Height = 33
      Caption = 'Batal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BtnBatalClick
    end
  end
  object ZConnection: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16')
    DisableSavepoints = False
    HostName = 'localhost'
    Port = 3306
    Database = 'db_ekspedisi'
    User = 'root'
    Password = ''
    Protocol = 'mysql'
    Left = 328
    Top = 8
  end
  object ZQueryLogin: TZQuery
    Connection = ZConnection
    Params = <>
    Left = 368
    Top = 8
  end
end
