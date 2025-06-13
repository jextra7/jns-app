object FormResetPassword: TFormResetPassword
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Reset Password'
  ClientHeight = 320
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
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
      Left = 16
      Top = 12
      Width = 265
      Height = 25
      Caption = 'FORM RESET PASSWORD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 400
    Height = 271
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 24
      Top = 24
      Width = 62
      Height = 15
      Caption = 'Username :'
    end
    object Label3: TLabel
      Left = 24
      Top = 72
      Width = 35
      Height = 15
      Caption = 'Email :'
    end
    object Label4: TLabel
      Left = 24
      Top = 120
      Width = 125
      Height = 15
      Caption = 'Pertanyaan Keamanan :'
    end
    object Label5: TLabel
      Left = 24
      Top = 168
      Width = 114
      Height = 15
      Caption = 'Jawaban Keamanan :'
    end
    object EdtUsername: TEdit
      Left = 24
      Top = 40
      Width = 345
      Height = 23
      TabOrder = 0
    end
    object EdtEmail: TEdit
      Left = 24
      Top = 88
      Width = 345
      Height = 23
      TabOrder = 1
    end
    object EdtPertanyaanKeamanan: TEdit
      Left = 24
      Top = 136
      Width = 345
      Height = 23
      TabOrder = 2
    end
    object EdtJawabanKeamanan: TEdit
      Left = 24
      Top = 184
      Width = 345
      Height = 23
      TabOrder = 3
    end
    object BtnResetPassword: TBitBtn
      Left = 64
      Top = 224
      Width = 129
      Height = 33
      Caption = 'Reset Password'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BtnResetPasswordClick
    end
    object BtnBatal: TBitBtn
      Left = 208
      Top = 224
      Width = 129
      Height = 33
      Caption = 'Batal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = BtnBatalClick
    end
  end
end
