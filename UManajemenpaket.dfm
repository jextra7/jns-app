object Form14: TForm14
  Left = 0
  Top = 0
  Caption = 'Manajemen Paket Ekspedisi'
  ClientHeight = 550
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 849
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 280
      Top = 8
      Width = 210
      Height = 25
      Caption = 'MANAJEMEN PAKET'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 849
    Height = 304
    Align = alTop
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 777
      Height = 281
      Caption = 'Data Paket'
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 24
        Width = 47
        Height = 13
        Caption = 'No. Paket'
      end
      object Label3: TLabel
        Left = 16
        Top = 56
        Width = 70
        Height = 13
        Caption = 'Nama Pengirim'
      end
      object Label4: TLabel
        Left = 16
        Top = 88
        Width = 76
        Height = 13
        Caption = 'Alamat Pengirim'
      end
      object Label5: TLabel
        Left = 16
        Top = 120
        Width = 74
        Height = 13
        Caption = 'Nama Penerima'
      end
      object Label6: TLabel
        Left = 16
        Top = 152
        Width = 80
        Height = 13
        Caption = 'Alamat Penerima'
      end
      object Label7: TLabel
        Left = 16
        Top = 184
        Width = 54
        Height = 13
        Caption = 'Jenis Paket'
      end
      object Label8: TLabel
        Left = 16
        Top = 216
        Width = 26
        Height = 13
        Caption = 'Berat'
      end
      object Label9: TLabel
        Left = 400
        Top = 24
        Width = 39
        Height = 13
        Caption = 'Tgl Kirim'
      end
      object Label10: TLabel
        Left = 400
        Top = 56
        Width = 26
        Height = 13
        Caption = 'Biaya'
      end
      object Label11: TLabel
        Left = 386
        Top = 168
        Width = 56
        Height = 15
        Caption = 'Pelanggan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 386
        Top = 194
        Width = 25
        Height = 15
        Caption = 'Kurir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 386
        Top = 136
        Width = 42
        Height = 15
        Caption = 'Gudang'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object EdtNoPaket: TEdit
        Left = 112
        Top = 24
        Width = 217
        Height = 21
        TabOrder = 0
      end
      object EdtNamaPengirim: TEdit
        Left = 112
        Top = 56
        Width = 217
        Height = 21
        TabOrder = 1
      end
      object EdtAlamatPengirim: TEdit
        Left = 112
        Top = 88
        Width = 217
        Height = 21
        TabOrder = 2
      end
      object EdtNamaPenerima: TEdit
        Left = 112
        Top = 120
        Width = 217
        Height = 21
        TabOrder = 3
      end
      object EdtAlamatPenerima: TEdit
        Left = 112
        Top = 152
        Width = 217
        Height = 21
        TabOrder = 4
      end
      object CbJenisPaket: TComboBox
        Left = 112
        Top = 184
        Width = 217
        Height = 21
        TabOrder = 5
      end
      object EdtBerat: TEdit
        Left = 112
        Top = 216
        Width = 121
        Height = 21
        TabOrder = 6
      end
      object DateTimePicker1: TDateTimePicker
        Left = 464
        Top = 24
        Width = 186
        Height = 21
        Date = 45105.000000000000000000
        Time = 0.683460486114199700
        TabOrder = 7
      end
      object EdtBiaya: TEdit
        Left = 464
        Top = 56
        Width = 185
        Height = 21
        TabOrder = 8
      end
      object CbIdPelanggan: TComboBox
        Left = 464
        Top = 162
        Width = 281
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
      end
      object CbIdKurir: TComboBox
        Left = 464
        Top = 191
        Width = 281
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
      end
      object CbIdGudang: TComboBox
        Left = 464
        Top = 133
        Width = 281
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
      end
      object BtnSimpan: TBitBtn
        Left = 144
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Simpan'
        TabOrder = 9
        OnClick = BtnSimpanClick
      end
      object BtnUbah: TBitBtn
        Left = 265
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Ubah'
        TabOrder = 10
        OnClick = BtnUbahClick
      end
      object BtnHapus: TBitBtn
        Left = 386
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Hapus'
        TabOrder = 11
        OnClick = BtnHapusClick
      end
      object BtnBatal: TBitBtn
        Left = 507
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Batal'
        TabOrder = 12
        OnClick = BtnBatalClick
      end
      object BtnKeluar: TBitBtn
        Left = 628
        Top = 256
        Width = 75
        Height = 25
        Caption = 'Keluar'
        TabOrder = 13
        OnClick = BtnKeluarClick
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 345
    Width = 849
    Height = 205
    Align = alClient
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 847
      Height = 203
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'no_paket'
          Title.Caption = 'No Paket'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nama_pengirim'
          Title.Caption = 'Nama Pengirim'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'alamat_pengirim'
          Title.Caption = 'Alamat Pengirim'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nama_penerima'
          Title.Caption = 'Nama Penerima'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'alamat_penerima'
          Title.Caption = 'Alamat Penerima'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jenis_paket'
          Title.Caption = 'Jenis Paket'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'berat'
          Title.Caption = 'Berat'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tanggal_kirim'
          Title.Caption = 'Tanggal Kirim'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'biaya'
          Title.Caption = 'Biaya'
          Width = 80
          Visible = True
        end>
    end
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'controls_cp=CP_UTF16'
      'RawStringEncoding=DB_CP')
    Connected = True
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
  object ZQueryPaket: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'SELECT * FROM paket ORDER BY no_paket DESC')
    Params = <>
    Left = 728
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = ZQueryPaket
    Left = 728
    Top = 104
  end
end
