object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Manajemen Data Kurir'
  ClientHeight = 550
  ClientWidth = 800
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
    Width = 800
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 798
    object Label1: TLabel
      Left = 280
      Top = 8
      Width = 212
      Height = 25
      Caption = 'MANAJEMEN KURIR'
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
    Width = 800
    Height = 250
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 798
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 777
      Height = 233
      Caption = 'Data Kurir'
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 24
        Width = 36
        Height = 13
        Caption = 'ID Kurir'
      end
      object Label3: TLabel
        Left = 16
        Top = 56
        Width = 27
        Height = 13
        Caption = 'Nama'
      end
      object Label4: TLabel
        Left = 16
        Top = 88
        Width = 33
        Height = 13
        Caption = 'Alamat'
      end
      object Label5: TLabel
        Left = 16
        Top = 120
        Width = 36
        Height = 13
        Caption = 'No Telp'
      end
      object Label6: TLabel
        Left = 16
        Top = 152
        Width = 63
        Height = 13
        Caption = 'Jenis Kelamin'
      end
      object Label7: TLabel
        Left = 16
        Top = 184
        Width = 31
        Height = 13
        Caption = 'Status'
      end
      object EdtIdKurir: TEdit
        Left = 112
        Top = 24
        Width = 217
        Height = 21
        TabOrder = 0
      end
      object EdtNama: TEdit
        Left = 112
        Top = 56
        Width = 217
        Height = 21
        TabOrder = 1
      end
      object EdtAlamat: TEdit
        Left = 112
        Top = 88
        Width = 313
        Height = 21
        TabOrder = 2
      end
      object EdtNoTelp: TEdit
        Left = 112
        Top = 120
        Width = 217
        Height = 21
        TabOrder = 3
      end
      object CbJenisKelamin: TComboBox
        Left = 112
        Top = 152
        Width = 217
        Height = 21
        TabOrder = 4
      end
      object CbStatus: TComboBox
        Left = 112
        Top = 184
        Width = 217
        Height = 21
        TabOrder = 5
      end
      object BtnSimpan: TBitBtn
        Left = 464
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Simpan'
        TabOrder = 6
        OnClick = BtnSimpanClick
      end
      object BtnUbah: TBitBtn
        Left = 464
        Top = 72
        Width = 75
        Height = 25
        Caption = 'Ubah'
        TabOrder = 7
        OnClick = BtnUbahClick
      end
      object BtnHapus: TBitBtn
        Left = 464
        Top = 112
        Width = 75
        Height = 25
        Caption = 'Hapus'
        TabOrder = 8
        OnClick = BtnHapusClick
      end
      object BtnBatal: TBitBtn
        Left = 464
        Top = 152
        Width = 75
        Height = 25
        Caption = 'Batal'
        TabOrder = 9
        OnClick = BtnBatalClick
      end
      object BtnKeluar: TBitBtn
        Left = 560
        Top = 152
        Width = 75
        Height = 25
        Caption = 'Keluar'
        TabOrder = 10
        OnClick = BtnKeluarClick
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 291
    Width = 800
    Height = 259
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 798
    ExplicitHeight = 251
    object Label8: TLabel
      Left = 16
      Top = 16
      Width = 136
      Height = 21
      Caption = 'Daftar Paket Kurir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 798
      Height = 257
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
          FieldName = 'id_kurir'
          Title.Caption = 'ID Kurir'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nama'
          Title.Caption = 'Nama'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'alamat'
          Title.Caption = 'Alamat'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'no_telp'
          Title.Caption = 'No Telepon'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'jenis_kelamin'
          Title.Caption = 'Jenis Kelamin'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'status'
          Title.Caption = 'Status'
          Width = 80
          Visible = True
        end>
    end
    object DBGrid2: TDBGrid
      Left = 16
      Top = 300
      Width = 865
      Height = 220
      DataSource = DataSource2
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
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
  object ZQueryKurir: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'SELECT * FROM kurir ORDER BY id_kurir')
    Params = <>
    Left = 728
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = ZQueryKurir
    Left = 728
    Top = 104
  end
  object ZQueryPaket: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      'SELECT * FROM paket WHERE id_kurir = :id_kurir')
    Params = <
      item
        Name = 'id_kurir'
      end>
    Left = 720
    Top = 432
    ParamData = <
      item
        Name = 'id_kurir'
      end>
  end
  object DataSource2: TDataSource
    DataSet = ZQueryPaket
    Left = 720
    Top = 480
  end
end
