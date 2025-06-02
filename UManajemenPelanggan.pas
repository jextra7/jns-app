unit UManajemenPelanggan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdtIdPelanggan: TEdit;
    EdtNama: TEdit;
    EdtAlamat: TEdit;
    EdtNoTelp: TEdit;
    CbJenisKelamin: TComboBox;
    BtnSimpan: TBitBtn;
    BtnUbah: TBitBtn;
    BtnHapus: TBitBtn;
    BtnBatal: TBitBtn;
    BtnKeluar: TBitBtn;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    ZConnection1: TZConnection;
    ZQueryPelanggan: TZQuery;
    DataSource1: TDataSource;
    Label7: TLabel;
    DBGrid2: TDBGrid;
    ZQueryPaket: TZQuery;
    DataSource2: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSimpanClick(Sender: TObject);
    procedure BtnUbahClick(Sender: TObject);
    procedure BtnHapusClick(Sender: TObject);
    procedure BtnBatalClick(Sender: TObject);
    procedure BtnKeluarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
    procedure KosongkanForm;
    procedure SetEditReadOnly(status: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Inisialisasi ComboBox
  CbJenisKelamin.Items.Clear;
  CbJenisKelamin.Items.Add('Laki-laki');
  CbJenisKelamin.Items.Add('Perempuan');
  
  // Atur koneksi database
  try
    ZConnection1.Connected := True;
    ZQueryPelanggan.Connection := ZConnection1;
    ZQueryPelanggan.SQL.Clear;
    ZQueryPelanggan.SQL.Add('SELECT * FROM pelanggan ORDER BY id_pelanggan');
    ZQueryPelanggan.Active := True;
    
    // Setup dataset untuk paket
    ZQueryPaket.Connection := ZConnection1;
    ZQueryPaket.SQL.Clear;
    ZQueryPaket.SQL.Add('SELECT * FROM paket WHERE id_pelanggan = :id_pelanggan');
    ZQueryPaket.Params.ParamByName('id_pelanggan').AsString := '';
    ZQueryPaket.Active := False;
  except
    on E: Exception do
    begin
      ShowMessage('Koneksi database gagal: ' + E.Message);
    end;
  end;
  
  // Set form awal
  KosongkanForm;
  SetEditReadOnly(False);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm1.KosongkanForm;
begin
  EdtIdPelanggan.Clear;
  EdtNama.Clear;
  EdtAlamat.Clear;
  EdtNoTelp.Clear;
  CbJenisKelamin.ItemIndex := -1;
  
  // Bersihkan tabel paket terkait
  ZQueryPaket.Close;
  
  EdtIdPelanggan.SetFocus;
end;

procedure TForm1.SetEditReadOnly(status: Boolean);
begin
  EdtIdPelanggan.ReadOnly := status;
  EdtNama.ReadOnly := status;
  EdtAlamat.ReadOnly := status;
  EdtNoTelp.ReadOnly := status;
  CbJenisKelamin.Enabled := not status;
end;

procedure TForm1.BtnSimpanClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdPelanggan.Text = '' then
  begin
    ShowMessage('ID Pelanggan tidak boleh kosong!');
    EdtIdPelanggan.SetFocus;
    Exit;
  end;
  
  if EdtNama.Text = '' then
  begin
    ShowMessage('Nama Pelanggan tidak boleh kosong!');
    EdtNama.SetFocus;
    Exit;
  end;
  
  if CbJenisKelamin.ItemIndex = -1 then
  begin
    ShowMessage('Jenis Kelamin harus dipilih!');
    CbJenisKelamin.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID sudah ada - menggunakan parameter
  ZQueryPelanggan.Close;
  ZQueryPelanggan.SQL.Clear;
  ZQueryPelanggan.SQL.Add('SELECT * FROM pelanggan WHERE id_pelanggan = :id');
  ZQueryPelanggan.ParamByName('id').AsString := EdtIdPelanggan.Text;
  ZQueryPelanggan.Open;
  
  if ZQueryPelanggan.RecordCount > 0 then
  begin
    ShowMessage('ID Pelanggan sudah ada!');
    EdtIdPelanggan.Clear;
    EdtIdPelanggan.SetFocus;
    Exit;
  end;
  
  // Simpan data baru
  try
    ZQueryPelanggan.Close;
    ZQueryPelanggan.SQL.Clear;
    ZQueryPelanggan.SQL.Add('INSERT INTO pelanggan (id_pelanggan, nama, alamat, no_telp, jenis_kelamin) ' +
                           'VALUES (:id, :nama, :alamat, :telp, :jk)');
    ZQueryPelanggan.ParamByName('id').AsString := EdtIdPelanggan.Text;
    ZQueryPelanggan.ParamByName('nama').AsString := EdtNama.Text;
    ZQueryPelanggan.ParamByName('alamat').AsString := EdtAlamat.Text;
    ZQueryPelanggan.ParamByName('telp').AsString := EdtNoTelp.Text;
    ZQueryPelanggan.ParamByName('jk').AsString := CbJenisKelamin.Text;
    ZQueryPelanggan.ExecSQL;
    
    ShowMessage('Data berhasil disimpan!');
    
    // Refresh data
    ZQueryPelanggan.SQL.Clear;
    ZQueryPelanggan.SQL.Add('SELECT * FROM pelanggan ORDER BY id_pelanggan');
    ZQueryPelanggan.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm1.BtnUbahClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdPelanggan.Text = '' then
  begin
    ShowMessage('ID Pelanggan tidak boleh kosong!');
    EdtIdPelanggan.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID ada - menggunakan parameter
  ZQueryPelanggan.Close;
  ZQueryPelanggan.SQL.Clear;
  ZQueryPelanggan.SQL.Add('SELECT * FROM pelanggan WHERE id_pelanggan = :id');
  ZQueryPelanggan.ParamByName('id').AsString := EdtIdPelanggan.Text;
  ZQueryPelanggan.Open;
  
  if ZQueryPelanggan.RecordCount = 0 then
  begin
    ShowMessage('ID Pelanggan tidak ditemukan!');
    KosongkanForm;
    Exit;
  end;
  
  // Update data
  try
    ZQueryPelanggan.Close;
    ZQueryPelanggan.SQL.Clear;
    ZQueryPelanggan.SQL.Add('UPDATE pelanggan SET nama = :nama, alamat = :alamat, ' +
                           'no_telp = :telp, jenis_kelamin = :jk ' +
                           'WHERE id_pelanggan = :id');
    ZQueryPelanggan.ParamByName('id').AsString := EdtIdPelanggan.Text;
    ZQueryPelanggan.ParamByName('nama').AsString := EdtNama.Text;
    ZQueryPelanggan.ParamByName('alamat').AsString := EdtAlamat.Text;
    ZQueryPelanggan.ParamByName('telp').AsString := EdtNoTelp.Text;
    ZQueryPelanggan.ParamByName('jk').AsString := CbJenisKelamin.Text;
    ZQueryPelanggan.ExecSQL;
    
    ShowMessage('Data berhasil diubah!');
    
    // Refresh data
    ZQueryPelanggan.SQL.Clear;
    ZQueryPelanggan.SQL.Add('SELECT * FROM pelanggan ORDER BY id_pelanggan');
    ZQueryPelanggan.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm1.BtnHapusClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdPelanggan.Text = '' then
  begin
    ShowMessage('ID Pelanggan tidak boleh kosong!');
    EdtIdPelanggan.SetFocus;
    Exit;
  end;
  
  // Konfirmasi penghapusan
  if MessageDlg('Apakah Anda yakin ingin menghapus data pelanggan ini?', 
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // Hapus data
    try
      ZQueryPelanggan.Close;
      ZQueryPelanggan.SQL.Clear;
      ZQueryPelanggan.SQL.Add('DELETE FROM pelanggan WHERE id_pelanggan = :id');
      ZQueryPelanggan.ParamByName('id').AsString := EdtIdPelanggan.Text;
      ZQueryPelanggan.ExecSQL;
      
      ShowMessage('Data berhasil dihapus!');
      
      // Refresh data
      ZQueryPelanggan.SQL.Clear;
      ZQueryPelanggan.SQL.Add('SELECT * FROM pelanggan ORDER BY id_pelanggan');
      ZQueryPelanggan.Open;
      
      KosongkanForm;
    except
      on E: Exception do
        ShowMessage('Terjadi kesalahan: ' + E.Message);
    end;
  end;
end;

procedure TForm1.BtnBatalClick(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm1.BtnKeluarClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
  if not ZQueryPelanggan.IsEmpty then
  begin
    // Tampilkan data yang dipilih di form
    EdtIdPelanggan.Text := ZQueryPelanggan.FieldByName('id_pelanggan').AsString;
    EdtNama.Text := ZQueryPelanggan.FieldByName('nama').AsString;
    EdtAlamat.Text := ZQueryPelanggan.FieldByName('alamat').AsString;
    EdtNoTelp.Text := ZQueryPelanggan.FieldByName('no_telp').AsString;
    
    if ZQueryPelanggan.FieldByName('jenis_kelamin').AsString = 'Laki-laki' then
      CbJenisKelamin.ItemIndex := 0
    else if ZQueryPelanggan.FieldByName('jenis_kelamin').AsString = 'Perempuan' then
      CbJenisKelamin.ItemIndex := 1
    else
      CbJenisKelamin.ItemIndex := -1;
    
    // Tampilkan paket terkait
    ZQueryPaket.Close;
    ZQueryPaket.ParamByName('id_pelanggan').AsString := ZQueryPelanggan.FieldByName('id_pelanggan').AsString;
    ZQueryPaket.Open;
  end;
end;

end.
