object Form5: TForm5
  Left = 0
  Top = 0
  Caption = 'Manajemen Pembayaran'
  ClientHeight = 630
  ClientWidth = 900
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
    Width = 900
    Height = 49
    Align = alTop
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 336
      Top = 8
      Width = 229
      Height = 25
      Caption = 'MANAJEMEN PEMBAYARAN'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 900
    Height = 312
    Align = alTop
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 16
      Top = 16
      Width = 865
      Height = 281
      Caption = 'Input Data Pembayaran'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label2: TLabel
        Left = 24
        Top = 32
        Width = 81
        Height = 15
        Caption = 'ID Pembayaran'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 24
        Top = 64
        Width = 52
        Height = 15
        Caption = 'No. Paket'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 24
        Top = 96
        Width = 111
        Height = 15
        Caption = 'Metode Pembayaran'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 24
        Top = 128
        Width = 118
        Height = 15
        Caption = 'Tanggal Pembayaran'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 24
        Top = 160
        Width = 71
        Height = 15
        Caption = 'Jumlah Bayar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 24
        Top = 192
        Width = 110
        Height = 15
        Caption = 'Status Pembayaran'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 24
        Top = 224
        Width = 66
        Height = 15
        Caption = 'Keterangan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object LblPelanggan: TLabel
        Left = 464
        Top = 192
        Width = 65
        Height = 15
        Caption = 'Pelanggan: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object LblKurir: TLabel
        Left = 464
        Top = 216
        Width = 32
        Height = 15
        Caption = 'Kurir: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object LblGudang: TLabel
        Left = 464
        Top = 240
        Width = 50
        Height = 15
        Caption = 'Gudang: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object EdtIdPembayaran: TEdit
        Left = 152
        Top = 32
        Width = 281
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object EdtNoPaket: TEdit
        Left = 152
        Top = 64
        Width = 217
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object CbMetodeBayar: TComboBox
        Left = 152
        Top = 96
        Width = 281
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object DateTimePicker1: TDateTimePicker
        Left = 152
        Top = 128
        Width = 281
        Height = 23
        Date = 45106.000000000000000000
        Time = 0.729166666665949700
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object EdtJumlahBayar: TEdit
        Left = 152
        Top = 160
        Width = 281
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object CbStatusBayar: TComboBox
        Left = 152
        Top = 192
        Width = 281
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object BtnSimpan: TBitBtn
        Left = 152
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Simpan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = BtnSimpanClick
      end
      object BtnUbah: TBitBtn
        Left = 232
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Ubah'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = BtnUbahClick
      end
      object BtnHapus: TBitBtn
        Left = 312
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Hapus'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        OnClick = BtnHapusClick
      end
      object BtnBatal: TBitBtn
        Left = 392
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Batal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = BtnBatalClick
      end
      object BtnKeluar: TBitBtn
        Left = 472
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Keluar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = BtnKeluarClick
      end
      object BtnCariPaket: TBitBtn
        Left = 376
        Top = 64
        Width = 57
        Height = 23
        Caption = 'Cari'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = BtnCariPaketClick
      end
      object EdtKeterangan: TEdit
        Left = 152
        Top = 224
        Width = 281
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 361
    Width = 900
    Height = 269
    Align = alClient
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 16
      Top = 16
      Width = 865
      Height = 241
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
    end
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16'
      'RawStringEncoding=DB_CP')
    DisableSavepoints = False
    HostName = 'localhost'
    Port = 3306
    Database = 'db_ekspedisi'
    User = 'root'
    Password = ''
    Protocol = 'mysql'
    Left = 728
    Top = 8
  end
  object ZQueryPembayaran: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'SELECT * FROM pembayaran ORDER BY id_pembayaran')
    Params = <>
    Left = 728
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = ZQueryPembayaran
    Left = 728
    Top = 104
  end
  object ZQueryPaket: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'SELECT * FROM paket')
    Params = <>
    Left = 728
    Top = 152
  end
end
