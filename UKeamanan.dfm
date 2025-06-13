object FormKeamanan: TFormKeamanan
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Pengaturan Keamanan Akun'
  ClientHeight = 400
  ClientWidth = 450
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
    Width = 450
    Height = 49
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 325
      Height = 25
      Caption = 'PENGATURAN KEAMANAN AKUN'
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
    Width = 450
    Height = 351
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 24
      Top = 16
      Width = 109
      Height = 17
      Caption = 'Ubah Password'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 48
      Width = 108
      Height = 15
      Caption = 'Password Sekarang :'
    end
    object Label4: TLabel
      Left = 24
      Top = 96
      Width = 87
      Height = 15
      Caption = 'Password Baru :'
    end
    object Label5: TLabel
      Left = 24
      Top = 144
      Width = 107
      Height = 15
      Caption = 'Konfirmasi Password:'
    end
    object Bevel1: TBevel
      Left = 24
      Top = 192
      Width = 401
      Height = 9
      Shape = bsTopLine
    end
    object Label6: TLabel
      Left = 24
      Top = 208
      Width = 171
      Height = 17
      Caption = 'Pengaturan Pertanyaan Keamanan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 24
      Top = 240
      Width = 68
      Height = 15
      Caption = 'Pertanyaan :'
    end
    object Label8: TLabel
      Left = 24
      Top = 288
      Width = 53
      Height = 15
      Caption = 'Jawaban :'
    end
    object EdtPasswordLama: TEdit
      Left = 24
      Top = 64
      Width = 401
      Height = 23
      PasswordChar = '*'
      TabOrder = 0
    end
    object EdtPasswordBaru: TEdit
      Left = 24
      Top = 112
      Width = 401
      Height = 23
      PasswordChar = '*'
      TabOrder = 1
    end
    object EdtKonfirmasiPassword: TEdit
      Left = 24
      Top = 160
      Width = 401
      Height = 23
      PasswordChar = '*'
      TabOrder = 2
    end
    object CbPertanyaanKeamanan: TComboBox
      Left = 24
      Top = 256
      Width = 401
      Height = 23
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'Siapa nama hewan peliharaan pertama Anda?'
        'Di kota mana Anda lahir?'
        'Apa makanan favorit Anda?'
        'Siapa nama guru favorit Anda?'
        'Apa nama jalan tempat Anda tinggal saat kecil?'
        'Apa nama tengah ibu Anda?')
    end
    object EdtJawabanKeamanan: TEdit
      Left = 24
      Top = 304
      Width = 401
      Height = 23
      TabOrder = 4
    end
    object BtnSimpan: TBitBtn
      Left = 144
      Top = 344
      Width = 97
      Height = 33
      Caption = 'Simpan'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = BtnSimpanClick
    end
    object BtnBatal: TBitBtn
      Left = 248
      Top = 344
      Width = 97
      Height = 33
      Caption = 'Batal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = BtnBatalClick
    end
  end
end
