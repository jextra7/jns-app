object Login: TLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 231
  ClientWidth = 457
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
    Width = 457
    Height = 49
    Align = alTop
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 208
      Top = 14
      Width = 41
      Height = 20
      Caption = 'LOGIN'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 457
    Height = 182
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 48
      Top = 32
      Width = 58
      Height = 15
      Caption = 'Username:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 48
      Top = 72
      Width = 55
      Height = 15
      Caption = 'Password:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object EdtUsername: TEdit
      Left = 120
      Top = 32
      Width = 273
      Height = 23
      TabOrder = 0
    end
    object EdtPassword: TEdit
      Left = 120
      Top = 72
      Width = 273
      Height = 23
      PasswordChar = '*'
      TabOrder = 1
    end
    object BtnLogin: TBitBtn
      Left = 120
      Top = 120
      Width = 113
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
      Left = 280
      Top = 120
      Width = 113
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
  object ZQueryLogin: TZQuery
    Params = <>
    Left = 24
    Top = 16
  end
end
