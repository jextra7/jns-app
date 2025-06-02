object FormMainMenu: TFormMainMenu
  Left = 0
  Top = 0
  Caption = 'Aplikasi Manajemen Paket Ekspedisi Lokal Banjarmasin'
  ClientHeight = 500
  ClientWidth = 800
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
    Width = 800
    Height = 57
    Align = alTop
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 798
    object Label1: TLabel
      Left = 176
      Top = 16
      Width = 432
      Height = 25
      Caption = 'APLIKASI MANAJEMEN PAKET EKSPEDISI LOKAL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblUserInfo: TLabel
      Left = 630
      Top = 32
      Width = 66
      Height = 15
      Alignment = taRightJustify
      Caption = 'Belum login'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 800
    Height = 443
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 798
    ExplicitHeight = 435
    object Label2: TLabel
      Left = 352
      Top = 16
      Width = 114
      Height = 25
      Caption = 'MAIN MENU'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 312
      Top = 400
      Width = 191
      Height = 15
      Caption = 'Aplikasi Ekspedisi Lokal Banjarmasin'
    end
    object Image1: TImage
      Left = 312
      Top = 56
      Width = 177
      Height = 145
      Center = True
      Proportional = True
    end
    object Label4: TLabel
      Left = 336
      Top = 216
      Width = 143
      Height = 17
      Caption = 'SILAHKAN PILIH MENU'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BtnPaket: TBitBtn
      Left = 96
      Top = 248
      Width = 145
      Height = 49
      Caption = 'Manajemen Paket'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BtnPaketClick
    end
    object BtnPelanggan: TBitBtn
      Left = 328
      Top = 248
      Width = 145
      Height = 49
      Caption = 'Manajemen Pelanggan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BtnPelangganClick
    end
    object BtnGudang: TBitBtn
      Left = 560
      Top = 248
      Width = 145
      Height = 49
      Caption = 'Manajemen Gudang'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = BtnGudangClick
    end
    object BtnKurir: TBitBtn
      Left = 96
      Top = 320
      Width = 145
      Height = 49
      Caption = 'Manajemen Kurir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = BtnKurirClick
    end
    object BtnPembayaran: TBitBtn
      Left = 328
      Top = 320
      Width = 145
      Height = 49
      Caption = 'Manajemen Pembayaran'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = BtnPembayaranClick
    end
    object BtnAdmin: TBitBtn
      Left = 560
      Top = 320
      Width = 145
      Height = 49
      Caption = 'Manajemen Admin'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = BtnAdminClick
    end
    object BtnLogout: TBitBtn
      Left = 696
      Top = 16
      Width = 89
      Height = 33
      Caption = 'Logout'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = BtnLogoutClick
    end
  end
  object ZConnection1: TZConnection
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
    Left = 24
    Top = 16
  end
end
