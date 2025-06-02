unit UManajemenGudang;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdtIdGudang: TEdit;
    EdtNamaGudang: TEdit;
    EdtAlamat: TEdit;
    EdtKapasitas: TEdit;
    CbStatus: TComboBox;
    BtnSimpan: TBitBtn;
    BtnUbah: TBitBtn;
    BtnHapus: TBitBtn;
    BtnBatal: TBitBtn;
    BtnKeluar: TBitBtn;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    ZConnection1: TZConnection;
    ZQueryGudang: TZQuery;
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
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  // Inisialisasi ComboBox
  CbStatus.Items.Add('Aktif');
  CbStatus.Items.Add('Tidak Aktif');
  CbStatus.Items.Add('Maintenance');
  CbStatus.Items.Add('Penuh');
  
  // Atur koneksi database
  ZConnection1.Connected := True;
  ZQueryGudang.Active := True;
  
  // Setup dataset untuk paket
  ZQueryPaket.Connection := ZConnection1;
  ZQueryPaket.SQL.Text := 'SELECT * FROM paket WHERE id_gudang = :id_gudang';
  DataSource2.DataSet := ZQueryPaket;
  DBGrid2.DataSource := DataSource2;
  
  // Set form awal
  KosongkanForm;
  SetEditReadOnly(False);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm2.KosongkanForm;
begin
  EdtIdGudang.Clear;
  EdtNamaGudang.Clear;
  EdtAlamat.Clear;
  EdtKapasitas.Clear;
  CbStatus.ItemIndex := -1;
  
  EdtIdGudang.SetFocus;
end;

procedure TForm2.SetEditReadOnly(status: Boolean);
begin
  EdtIdGudang.ReadOnly := status;
  EdtNamaGudang.ReadOnly := status;
  EdtAlamat.ReadOnly := status;
  EdtKapasitas.ReadOnly := status;
  CbStatus.Enabled := not status;
end;

procedure TForm2.BtnSimpanClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdGudang.Text = '' then
  begin
    ShowMessage('ID Gudang tidak boleh kosong!');
    EdtIdGudang.SetFocus;
    Exit;
  end;
  
  if EdtNamaGudang.Text = '' then
  begin
    ShowMessage('Nama Gudang tidak boleh kosong!');
    EdtNamaGudang.SetFocus;
    Exit;
  end;
  
  if EdtKapasitas.Text = '' then
  begin
    ShowMessage('Kapasitas tidak boleh kosong!');
    EdtKapasitas.SetFocus;
    Exit;
  end;
  
  if CbStatus.ItemIndex = -1 then
  begin
    ShowMessage('Status gudang harus dipilih!');
    CbStatus.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID sudah ada
  ZQueryGudang.SQL.Clear;
  ZQueryGudang.SQL.Add('SELECT * FROM gudang WHERE id_gudang = "' + EdtIdGudang.Text + '"');
  ZQueryGudang.Open;
  
  if ZQueryGudang.RecordCount > 0 then
  begin
    ShowMessage('ID Gudang sudah ada!');
    EdtIdGudang.Clear;
    EdtIdGudang.SetFocus;
    Exit;
  end;
  
  // Simpan data baru
  try
    ZQueryGudang.SQL.Clear;
    ZQueryGudang.SQL.Add('INSERT INTO gudang (id_gudang, nama_gudang, alamat, kapasitas, status) ' +
                         'VALUES (:id, :nama, :alamat, :kapasitas, :status)');
    ZQueryGudang.ParamByName('id').AsString := EdtIdGudang.Text;
    ZQueryGudang.ParamByName('nama').AsString := EdtNamaGudang.Text;
    ZQueryGudang.ParamByName('alamat').AsString := EdtAlamat.Text;
    ZQueryGudang.ParamByName('kapasitas').AsString := EdtKapasitas.Text;
    ZQueryGudang.ParamByName('status').AsString := CbStatus.Text;
    ZQueryGudang.ExecSQL;
    
    ShowMessage('Data berhasil disimpan!');
    
    // Refresh data
    ZQueryGudang.SQL.Clear;
    ZQueryGudang.SQL.Add('SELECT * FROM gudang ORDER BY id_gudang');
    ZQueryGudang.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm2.BtnUbahClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdGudang.Text = '' then
  begin
    ShowMessage('ID Gudang tidak boleh kosong!');
    EdtIdGudang.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID ada
  ZQueryGudang.SQL.Clear;
  ZQueryGudang.SQL.Add('SELECT * FROM gudang WHERE id_gudang = "' + EdtIdGudang.Text + '"');
  ZQueryGudang.Open;
  
  if ZQueryGudang.RecordCount = 0 then
  begin
    ShowMessage('ID Gudang tidak ditemukan!');
    KosongkanForm;
    Exit;
  end;
  
  // Update data
  try
    ZQueryGudang.SQL.Clear;
    ZQueryGudang.SQL.Add('UPDATE gudang SET nama_gudang = :nama, alamat = :alamat, ' +
                         'kapasitas = :kapasitas, status = :status ' +
                         'WHERE id_gudang = :id');
    ZQueryGudang.ParamByName('id').AsString := EdtIdGudang.Text;
    ZQueryGudang.ParamByName('nama').AsString := EdtNamaGudang.Text;
    ZQueryGudang.ParamByName('alamat').AsString := EdtAlamat.Text;
    ZQueryGudang.ParamByName('kapasitas').AsString := EdtKapasitas.Text;
    ZQueryGudang.ParamByName('status').AsString := CbStatus.Text;
    ZQueryGudang.ExecSQL;
    
    ShowMessage('Data berhasil diubah!');
    
    // Refresh data
    ZQueryGudang.SQL.Clear;
    ZQueryGudang.SQL.Add('SELECT * FROM gudang ORDER BY id_gudang');
    ZQueryGudang.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm2.BtnHapusClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdGudang.Text = '' then
  begin
    ShowMessage('ID Gudang tidak boleh kosong!');
    EdtIdGudang.SetFocus;
    Exit;
  end;
  
  // Konfirmasi penghapusan
  if MessageDlg('Apakah Anda yakin ingin menghapus data gudang ini?', 
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // Hapus data
    try
      ZQueryGudang.SQL.Clear;
      ZQueryGudang.SQL.Add('DELETE FROM gudang WHERE id_gudang = :id');
      ZQueryGudang.ParamByName('id').AsString := EdtIdGudang.Text;
      ZQueryGudang.ExecSQL;
      
      ShowMessage('Data berhasil dihapus!');
      
      // Refresh data
      ZQueryGudang.SQL.Clear;
      ZQueryGudang.SQL.Add('SELECT * FROM gudang ORDER BY id_gudang');
      ZQueryGudang.Open;
      
      KosongkanForm;
    except
      on E: Exception do
        ShowMessage('Terjadi kesalahan: ' + E.Message);
    end;
  end;
end;

procedure TForm2.BtnBatalClick(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm2.BtnKeluarClick(Sender: TObject);
begin
  Close;
end;

procedure TForm2.DBGrid1CellClick(Column: TColumn);
begin
  // Tampilkan data yang dipilih di form
  EdtIdGudang.Text := ZQueryGudang.FieldByName('id_gudang').AsString;
  EdtNamaGudang.Text := ZQueryGudang.FieldByName('nama_gudang').AsString;
  EdtAlamat.Text := ZQueryGudang.FieldByName('alamat').AsString;
  EdtKapasitas.Text := ZQueryGudang.FieldByName('kapasitas').AsString;
  
  // Set status di combobox
  if ZQueryGudang.FieldByName('status').AsString = 'Aktif' then
    CbStatus.ItemIndex := 0
  else if ZQueryGudang.FieldByName('status').AsString = 'Tidak Aktif' then
    CbStatus.ItemIndex := 1
  else if ZQueryGudang.FieldByName('status').AsString = 'Maintenance' then
    CbStatus.ItemIndex := 2
  else if ZQueryGudang.FieldByName('status').AsString = 'Penuh' then
    CbStatus.ItemIndex := 3
  else
    CbStatus.ItemIndex := -1;
  
  // Tampilkan paket terkait
  if not ZQueryGudang.IsEmpty then
  begin
    ZQueryPaket.Close;
    ZQueryPaket.ParamByName('id_gudang').AsString := ZQueryGudang.FieldByName('id_gudang').AsString;
    ZQueryPaket.Open;
  end;
end;

end.
