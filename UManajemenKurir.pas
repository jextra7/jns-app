unit UManajemenKurir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EdtIdKurir: TEdit;
    EdtNama: TEdit;
    EdtAlamat: TEdit;
    EdtNoTelp: TEdit;
    CbJenisKelamin: TComboBox;
    CbStatus: TComboBox;
    BtnSimpan: TBitBtn;
    BtnUbah: TBitBtn;
    BtnHapus: TBitBtn;
    BtnBatal: TBitBtn;
    BtnKeluar: TBitBtn;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    ZConnection1: TZConnection;
    ZQueryKurir: TZQuery;
    ZQueryPaket: TZQuery;
    DataSource1: TDataSource;
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
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.FormCreate(Sender: TObject);
begin
  // Inisialisasi ComboBox Jenis Kelamin
  CbJenisKelamin.Items.Add('Laki-laki');
  CbJenisKelamin.Items.Add('Perempuan');
  
  // Inisialisasi ComboBox Status
  CbStatus.Items.Add('Aktif');
  CbStatus.Items.Add('Cuti');
  CbStatus.Items.Add('Sakit');
  CbStatus.Items.Add('Nonaktif');
  
  // Atur koneksi database
  ZConnection1.Connected := True;
  ZQueryKurir.Active := True;
  
  // Setup dataset untuk paket
  ZQueryPaket.Connection := ZConnection1;
  ZQueryPaket.SQL.Text := 'SELECT * FROM paket WHERE id_kurir = :id_kurir';
  DataSource2.DataSet := ZQueryPaket;
  DBGrid2.DataSource := DataSource2;
  
  // Set form awal
  KosongkanForm;
  SetEditReadOnly(False);
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm4.KosongkanForm;
begin
  EdtIdKurir.Clear;
  EdtNama.Clear;
  EdtAlamat.Clear;
  EdtNoTelp.Clear;
  CbJenisKelamin.ItemIndex := -1;
  CbStatus.ItemIndex := -1;
  
  EdtIdKurir.SetFocus;
end;

procedure TForm4.SetEditReadOnly(status: Boolean);
begin
  EdtIdKurir.ReadOnly := status;
  EdtNama.ReadOnly := status;
  EdtAlamat.ReadOnly := status;
  EdtNoTelp.ReadOnly := status;
  CbJenisKelamin.Enabled := not status;
  CbStatus.Enabled := not status;
end;

procedure TForm4.BtnSimpanClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdKurir.Text = '' then
  begin
    ShowMessage('ID Kurir tidak boleh kosong!');
    EdtIdKurir.SetFocus;
    Exit;
  end;
  
  if EdtNama.Text = '' then
  begin
    ShowMessage('Nama Kurir tidak boleh kosong!');
    EdtNama.SetFocus;
    Exit;
  end;
  
  if EdtNoTelp.Text = '' then
  begin
    ShowMessage('Nomor Telepon tidak boleh kosong!');
    EdtNoTelp.SetFocus;
    Exit;
  end;
  
  if CbJenisKelamin.ItemIndex = -1 then
  begin
    ShowMessage('Jenis Kelamin harus dipilih!');
    CbJenisKelamin.SetFocus;
    Exit;
  end;
  
  if CbStatus.ItemIndex = -1 then
  begin
    ShowMessage('Status Kurir harus dipilih!');
    CbStatus.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID sudah ada
  ZQueryKurir.SQL.Clear;
  ZQueryKurir.SQL.Add('SELECT * FROM kurir WHERE id_kurir = "' + EdtIdKurir.Text + '"');
  ZQueryKurir.Open;
  
  if ZQueryKurir.RecordCount > 0 then
  begin
    ShowMessage('ID Kurir sudah ada!');
    EdtIdKurir.Clear;
    EdtIdKurir.SetFocus;
    Exit;
  end;
  
  // Simpan data baru
  try
    ZQueryKurir.SQL.Clear;
    ZQueryKurir.SQL.Add('INSERT INTO kurir (id_kurir, nama, alamat, no_telp, jenis_kelamin, status) ' +
                        'VALUES (:id, :nama, :alamat, :telp, :jk, :status)');
    ZQueryKurir.ParamByName('id').AsString := EdtIdKurir.Text;
    ZQueryKurir.ParamByName('nama').AsString := EdtNama.Text;
    ZQueryKurir.ParamByName('alamat').AsString := EdtAlamat.Text;
    ZQueryKurir.ParamByName('telp').AsString := EdtNoTelp.Text;
    ZQueryKurir.ParamByName('jk').AsString := CbJenisKelamin.Text;
    ZQueryKurir.ParamByName('status').AsString := CbStatus.Text;
    ZQueryKurir.ExecSQL;
    
    ShowMessage('Data kurir berhasil disimpan!');
    
    // Refresh data
    ZQueryKurir.SQL.Clear;
    ZQueryKurir.SQL.Add('SELECT * FROM kurir ORDER BY id_kurir');
    ZQueryKurir.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm4.BtnUbahClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdKurir.Text = '' then
  begin
    ShowMessage('ID Kurir tidak boleh kosong!');
    EdtIdKurir.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID ada
  ZQueryKurir.SQL.Clear;
  ZQueryKurir.SQL.Add('SELECT * FROM kurir WHERE id_kurir = "' + EdtIdKurir.Text + '"');
  ZQueryKurir.Open;
  
  if ZQueryKurir.RecordCount = 0 then
  begin
    ShowMessage('ID Kurir tidak ditemukan!');
    KosongkanForm;
    Exit;
  end;
  
  // Update data
  try
    ZQueryKurir.SQL.Clear;
    ZQueryKurir.SQL.Add('UPDATE kurir SET nama = :nama, alamat = :alamat, ' +
                        'no_telp = :telp, jenis_kelamin = :jk, status = :status ' +
                        'WHERE id_kurir = :id');
    ZQueryKurir.ParamByName('id').AsString := EdtIdKurir.Text;
    ZQueryKurir.ParamByName('nama').AsString := EdtNama.Text;
    ZQueryKurir.ParamByName('alamat').AsString := EdtAlamat.Text;
    ZQueryKurir.ParamByName('telp').AsString := EdtNoTelp.Text;
    ZQueryKurir.ParamByName('jk').AsString := CbJenisKelamin.Text;
    ZQueryKurir.ParamByName('status').AsString := CbStatus.Text;
    ZQueryKurir.ExecSQL;
    
    ShowMessage('Data kurir berhasil diubah!');
    
    // Refresh data
    ZQueryKurir.SQL.Clear;
    ZQueryKurir.SQL.Add('SELECT * FROM kurir ORDER BY id_kurir');
    ZQueryKurir.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm4.BtnHapusClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdKurir.Text = '' then
  begin
    ShowMessage('ID Kurir tidak boleh kosong!');
    EdtIdKurir.SetFocus;
    Exit;
  end;
  
  // Konfirmasi penghapusan
  if MessageDlg('Apakah Anda yakin ingin menghapus data kurir ini?', 
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // Hapus data
    try
      ZQueryKurir.SQL.Clear;
      ZQueryKurir.SQL.Add('DELETE FROM kurir WHERE id_kurir = :id');
      ZQueryKurir.ParamByName('id').AsString := EdtIdKurir.Text;
      ZQueryKurir.ExecSQL;
      
      ShowMessage('Data kurir berhasil dihapus!');
      
      // Refresh data
      ZQueryKurir.SQL.Clear;
      ZQueryKurir.SQL.Add('SELECT * FROM kurir ORDER BY id_kurir');
      ZQueryKurir.Open;
      
      KosongkanForm;
    except
      on E: Exception do
        ShowMessage('Terjadi kesalahan: ' + E.Message);
    end;
  end;
end;

procedure TForm4.BtnBatalClick(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm4.BtnKeluarClick(Sender: TObject);
begin
  Close;
end;

procedure TForm4.DBGrid1CellClick(Column: TColumn);
begin
  // Tampilkan data yang dipilih di form
  EdtIdKurir.Text := ZQueryKurir.FieldByName('id_kurir').AsString;
  EdtNama.Text := ZQueryKurir.FieldByName('nama').AsString;
  EdtAlamat.Text := ZQueryKurir.FieldByName('alamat').AsString;
  EdtNoTelp.Text := ZQueryKurir.FieldByName('no_telp').AsString;
  
  // Set jenis kelamin di combobox
  if ZQueryKurir.FieldByName('jenis_kelamin').AsString = 'Laki-laki' then
    CbJenisKelamin.ItemIndex := 0
  else if ZQueryKurir.FieldByName('jenis_kelamin').AsString = 'Perempuan' then
    CbJenisKelamin.ItemIndex := 1
  else
    CbJenisKelamin.ItemIndex := -1;
    
  // Set status di combobox
  if ZQueryKurir.FieldByName('status').AsString = 'Aktif' then
    CbStatus.ItemIndex := 0
  else if ZQueryKurir.FieldByName('status').AsString = 'Cuti' then
    CbStatus.ItemIndex := 1
  else if ZQueryKurir.FieldByName('status').AsString = 'Sakit' then
    CbStatus.ItemIndex := 2
  else if ZQueryKurir.FieldByName('status').AsString = 'Nonaktif' then
    CbStatus.ItemIndex := 3
  else
    CbStatus.ItemIndex := -1;
  
  // Tampilkan paket terkait
  if not ZQueryKurir.IsEmpty then
  begin
    ZQueryPaket.Close;
    ZQueryPaket.ParamByName('id_kurir').AsString := ZQueryKurir.FieldByName('id_kurir').AsString;
    ZQueryPaket.Open;
  end;
end;

end.
