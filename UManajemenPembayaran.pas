unit UManajemenPembayaran;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TForm5 = class(TForm)
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
    EdtIdPembayaran: TEdit;
    EdtNoPaket: TEdit;
    CbMetodeBayar: TComboBox;
    DateTimePicker1: TDateTimePicker;
    EdtJumlahBayar: TEdit;
    CbStatusBayar: TComboBox;
    BtnSimpan: TBitBtn;
    BtnUbah: TBitBtn;
    BtnHapus: TBitBtn;
    BtnBatal: TBitBtn;
    BtnKeluar: TBitBtn;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    ZConnection1: TZConnection;
    ZQueryPembayaran: TZQuery;
    DataSource1: TDataSource;
    BtnCariPaket: TBitBtn;
    ZQueryPaket: TZQuery;
    Label8: TLabel;
    EdtKeterangan: TEdit;
    LblPelanggan: TLabel;
    LblKurir: TLabel;
    LblGudang: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSimpanClick(Sender: TObject);
    procedure BtnUbahClick(Sender: TObject);
    procedure BtnHapusClick(Sender: TObject);
    procedure BtnBatalClick(Sender: TObject);
    procedure BtnKeluarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnCariPaketClick(Sender: TObject);
  private
    { Private declarations }
    procedure KosongkanForm;
    procedure SetEditReadOnly(status: Boolean);
    procedure ValidasiPaket;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.FormCreate(Sender: TObject);
begin
  // Inisialisasi ComboBox Metode Pembayaran
  CbMetodeBayar.Items.Clear;
  CbMetodeBayar.Items.Add('Tunai');
  CbMetodeBayar.Items.Add('Transfer Bank');
  CbMetodeBayar.Items.Add('Kartu Kredit');
  CbMetodeBayar.Items.Add('QRIS');
  CbMetodeBayar.Items.Add('E-Wallet');
  
  // Inisialisasi ComboBox Status Pembayaran
  CbStatusBayar.Items.Clear;
  CbStatusBayar.Items.Add('Lunas');
  CbStatusBayar.Items.Add('Belum Lunas');
  CbStatusBayar.Items.Add('Pending');
  CbStatusBayar.Items.Add('Dibatalkan');
  
  // Atur koneksi database
  ZConnection1.Connected := True;
  ZQueryPembayaran.Active := True;
  ZQueryPaket.Active := True;
  
  // Set form awal
  KosongkanForm;
  SetEditReadOnly(False);
  
  // Set tanggal hari ini
  DateTimePicker1.Date := Now;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm5.KosongkanForm;
begin
  EdtIdPembayaran.Clear;
  EdtNoPaket.Clear;
  EdtJumlahBayar.Clear;
  EdtKeterangan.Clear;
  CbMetodeBayar.ItemIndex := -1;
  CbStatusBayar.ItemIndex := -1;
  DateTimePicker1.Date := Now;
  
  // Reset label informasi
  LblPelanggan.Caption := 'Pelanggan: ';
  LblKurir.Caption := 'Kurir: ';
  LblGudang.Caption := 'Gudang: ';
  
  EdtIdPembayaran.SetFocus;
end;

procedure TForm5.SetEditReadOnly(status: Boolean);
begin
  EdtIdPembayaran.ReadOnly := status;
  EdtNoPaket.ReadOnly := status;
  EdtJumlahBayar.ReadOnly := status;
  EdtKeterangan.ReadOnly := status;
  CbMetodeBayar.Enabled := not status;
  CbStatusBayar.Enabled := not status;
  DateTimePicker1.Enabled := not status;
end;

procedure TForm5.BtnCariPaketClick(Sender: TObject);
var
  noPaket: string;
begin
  // Gunakan input box untuk mencari paket
  if InputQuery('Cari Paket', 'Masukkan No Paket:', noPaket) then
  begin
    EdtNoPaket.Text := noPaket;
    
    // Dapatkan data paket
    ZQueryPaket.Close;
    ZQueryPaket.SQL.Clear;
    ZQueryPaket.SQL.Add('SELECT p.*, pl.nama as nama_pelanggan, k.nama as nama_kurir, g.nama_gudang ' +
                       'FROM paket p ' +
                       'LEFT JOIN pelanggan pl ON p.id_pelanggan = pl.id_pelanggan ' +
                       'LEFT JOIN kurir k ON p.id_kurir = k.id_kurir ' +
                       'LEFT JOIN gudang g ON p.id_gudang = g.id_gudang ' +
                       'WHERE p.no_paket = :no_paket');
    ZQueryPaket.ParamByName('no_paket').AsString := noPaket;
    ZQueryPaket.Open;
    
    if not ZQueryPaket.IsEmpty then
    begin
      // Tampilkan jumlah bayar
      EdtJumlahBayar.Text := ZQueryPaket.FieldByName('biaya').AsString;
      
      // Tampilkan informasi terkait
      LblPelanggan.Caption := 'Pelanggan: ' + ZQueryPaket.FieldByName('nama_pelanggan').AsString;
      LblKurir.Caption := 'Kurir: ' + ZQueryPaket.FieldByName('nama_kurir').AsString;
      LblGudang.Caption := 'Gudang: ' + ZQueryPaket.FieldByName('nama_gudang').AsString;
    end
    else
    begin
      ShowMessage('No Paket tidak ditemukan!');
      EdtNoPaket.Clear;
      LblPelanggan.Caption := 'Pelanggan: ';
      LblKurir.Caption := 'Kurir: ';
      LblGudang.Caption := 'Gudang: ';
    end;
  end;
end;

procedure TForm5.ValidasiPaket;
begin
  if EdtNoPaket.Text = '' then
  begin
    ShowMessage('No Paket tidak boleh kosong!');
    EdtNoPaket.SetFocus;
    Exit;
  end;

  ZQueryPaket.Close;
  ZQueryPaket.SQL.Clear;
  ZQueryPaket.SQL.Add('SELECT p.*, pl.nama as nama_pelanggan, k.nama as nama_kurir, g.nama_gudang ' +
                     'FROM paket p ' +
                     'LEFT JOIN pelanggan pl ON p.id_pelanggan = pl.id_pelanggan ' +
                     'LEFT JOIN kurir k ON p.id_kurir = k.id_kurir ' +
                     'LEFT JOIN gudang g ON p.id_gudang = g.id_gudang ' +
                     'WHERE p.no_paket = :no_paket');
  ZQueryPaket.ParamByName('no_paket').AsString := EdtNoPaket.Text;
  ZQueryPaket.Open;
  
  if ZQueryPaket.IsEmpty then
  begin
    ShowMessage('No Paket tidak ditemukan!');
    EdtNoPaket.Clear;
    EdtNoPaket.SetFocus;
    LblPelanggan.Caption := 'Pelanggan: ';
    LblKurir.Caption := 'Kurir: ';
    LblGudang.Caption := 'Gudang: ';
    Exit;
  end;
  
  // Tampilkan informasi detail paket
  EdtJumlahBayar.Text := ZQueryPaket.FieldByName('biaya').AsString;
  LblPelanggan.Caption := 'Pelanggan: ' + ZQueryPaket.FieldByName('nama_pelanggan').AsString;
  LblKurir.Caption := 'Kurir: ' + ZQueryPaket.FieldByName('nama_kurir').AsString;
  LblGudang.Caption := 'Gudang: ' + ZQueryPaket.FieldByName('nama_gudang').AsString;
end;

procedure TForm5.BtnSimpanClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdPembayaran.Text = '' then
  begin
    ShowMessage('ID Pembayaran tidak boleh kosong!');
    EdtIdPembayaran.SetFocus;
    Exit;
  end;
  
  if EdtNoPaket.Text = '' then
  begin
    ShowMessage('No Paket tidak boleh kosong!');
    EdtNoPaket.SetFocus;
    Exit;
  end;
  
  if EdtJumlahBayar.Text = '' then
  begin
    ShowMessage('Jumlah Bayar tidak boleh kosong!');
    EdtJumlahBayar.SetFocus;
    Exit;
  end;
  
  if CbMetodeBayar.ItemIndex = -1 then
  begin
    ShowMessage('Metode Pembayaran harus dipilih!');
    CbMetodeBayar.SetFocus;
    Exit;
  end;
  
  if CbStatusBayar.ItemIndex = -1 then
  begin
    ShowMessage('Status Pembayaran harus dipilih!');
    CbStatusBayar.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID sudah ada - menggunakan parameter
  ZQueryPembayaran.Close;
  ZQueryPembayaran.SQL.Clear;
  ZQueryPembayaran.SQL.Add('SELECT * FROM pembayaran WHERE id_pembayaran = :id');
  ZQueryPembayaran.ParamByName('id').AsString := EdtIdPembayaran.Text;
  ZQueryPembayaran.Open;
  
  if ZQueryPembayaran.RecordCount > 0 then
  begin
    ShowMessage('ID Pembayaran sudah ada!');
    EdtIdPembayaran.Clear;
    EdtIdPembayaran.SetFocus;
    Exit;
  end;
  
  // Validasi paket
  ValidasiPaket;
  if EdtNoPaket.Text = '' then Exit;  // Paket tidak valid
  
  // Simpan data baru
  try
    ZQueryPembayaran.Close;
    ZQueryPembayaran.SQL.Clear;
    ZQueryPembayaran.SQL.Add('INSERT INTO pembayaran (id_pembayaran, no_paket, metode_pembayaran, ' +
                            'tanggal_pembayaran, jumlah_bayar, status_pembayaran, keterangan) ' +
                            'VALUES (:id, :nopaket, :metode, :tanggal, :jumlah, :status, :keterangan)');
    ZQueryPembayaran.ParamByName('id').AsString := EdtIdPembayaran.Text;
    ZQueryPembayaran.ParamByName('nopaket').AsString := EdtNoPaket.Text;
    ZQueryPembayaran.ParamByName('metode').AsString := CbMetodeBayar.Text;
    ZQueryPembayaran.ParamByName('tanggal').AsDate := DateTimePicker1.Date;
    ZQueryPembayaran.ParamByName('jumlah').AsFloat := StrToFloatDef(EdtJumlahBayar.Text, 0);
    ZQueryPembayaran.ParamByName('status').AsString := CbStatusBayar.Text;
    ZQueryPembayaran.ParamByName('keterangan').AsString := EdtKeterangan.Text;
    ZQueryPembayaran.ExecSQL;
    
    ShowMessage('Data pembayaran berhasil disimpan!');
    
    // Refresh data
    ZQueryPembayaran.SQL.Clear;
    ZQueryPembayaran.SQL.Add('SELECT * FROM pembayaran ORDER BY id_pembayaran');
    ZQueryPembayaran.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm5.BtnUbahClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdPembayaran.Text = '' then
  begin
    ShowMessage('ID Pembayaran tidak boleh kosong!');
    EdtIdPembayaran.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID ada - menggunakan parameter
  ZQueryPembayaran.Close;
  ZQueryPembayaran.SQL.Clear;
  ZQueryPembayaran.SQL.Add('SELECT * FROM pembayaran WHERE id_pembayaran = :id');
  ZQueryPembayaran.ParamByName('id').AsString := EdtIdPembayaran.Text;
  ZQueryPembayaran.Open;
  
  if ZQueryPembayaran.RecordCount = 0 then
  begin
    ShowMessage('ID Pembayaran tidak ditemukan!');
    KosongkanForm;
    Exit;
  end;
  
  // Validasi paket
  ValidasiPaket;
  if EdtNoPaket.Text = '' then Exit;  // Paket tidak valid
  
  // Update data
  try
    ZQueryPembayaran.Close;
    ZQueryPembayaran.SQL.Clear;
    ZQueryPembayaran.SQL.Add('UPDATE pembayaran SET no_paket = :nopaket, metode_pembayaran = :metode, ' +
                            'tanggal_pembayaran = :tanggal, jumlah_bayar = :jumlah, ' +
                            'status_pembayaran = :status, keterangan = :keterangan ' +
                            'WHERE id_pembayaran = :id');
    ZQueryPembayaran.ParamByName('id').AsString := EdtIdPembayaran.Text;
    ZQueryPembayaran.ParamByName('nopaket').AsString := EdtNoPaket.Text;
    ZQueryPembayaran.ParamByName('metode').AsString := CbMetodeBayar.Text;
    ZQueryPembayaran.ParamByName('tanggal').AsDate := DateTimePicker1.Date;
    ZQueryPembayaran.ParamByName('jumlah').AsFloat := StrToFloatDef(EdtJumlahBayar.Text, 0);
    ZQueryPembayaran.ParamByName('status').AsString := CbStatusBayar.Text;
    ZQueryPembayaran.ParamByName('keterangan').AsString := EdtKeterangan.Text;
    ZQueryPembayaran.ExecSQL;
    
    ShowMessage('Data pembayaran berhasil diubah!');
    
    // Refresh data
    ZQueryPembayaran.SQL.Clear;
    ZQueryPembayaran.SQL.Add('SELECT * FROM pembayaran ORDER BY id_pembayaran');
    ZQueryPembayaran.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm5.BtnHapusClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdPembayaran.Text = '' then
  begin
    ShowMessage('ID Pembayaran tidak boleh kosong!');
    EdtIdPembayaran.SetFocus;
    Exit;
  end;
  
  // Konfirmasi penghapusan
  if MessageDlg('Apakah Anda yakin ingin menghapus data pembayaran ini?', 
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // Hapus data - menggunakan parameter
    try
      ZQueryPembayaran.Close;
      ZQueryPembayaran.SQL.Clear;
      ZQueryPembayaran.SQL.Add('DELETE FROM pembayaran WHERE id_pembayaran = :id');
      ZQueryPembayaran.ParamByName('id').AsString := EdtIdPembayaran.Text;
      ZQueryPembayaran.ExecSQL;
      
      ShowMessage('Data pembayaran berhasil dihapus!');
      
      // Refresh data
      ZQueryPembayaran.SQL.Clear;
      ZQueryPembayaran.SQL.Add('SELECT * FROM pembayaran ORDER BY id_pembayaran');
      ZQueryPembayaran.Open;
      
      KosongkanForm;
    except
      on E: Exception do
        ShowMessage('Terjadi kesalahan: ' + E.Message);
    end;
  end;
end;

procedure TForm5.BtnBatalClick(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm5.BtnKeluarClick(Sender: TObject);
begin
  Close;
end;

procedure TForm5.DBGrid1CellClick(Column: TColumn);
begin
  if not ZQueryPembayaran.IsEmpty then
  begin
    // Tampilkan data pembayaran
    EdtIdPembayaran.Text := ZQueryPembayaran.FieldByName('id_pembayaran').AsString;
    EdtNoPaket.Text := ZQueryPembayaran.FieldByName('no_paket').AsString;
    EdtJumlahBayar.Text := ZQueryPembayaran.FieldByName('jumlah_bayar').AsString;
    EdtKeterangan.Text := ZQueryPembayaran.FieldByName('keterangan').AsString;
    DateTimePicker1.Date := ZQueryPembayaran.FieldByName('tanggal_pembayaran').AsDateTime;
    
    // Set metode pembayaran di combobox
    if ZQueryPembayaran.FieldByName('metode_pembayaran').AsString = 'Tunai' then
      CbMetodeBayar.ItemIndex := 0
    else if ZQueryPembayaran.FieldByName('metode_pembayaran').AsString = 'Transfer Bank' then
      CbMetodeBayar.ItemIndex := 1
    else if ZQueryPembayaran.FieldByName('metode_pembayaran').AsString = 'Kartu Kredit' then
      CbMetodeBayar.ItemIndex := 2
    else if ZQueryPembayaran.FieldByName('metode_pembayaran').AsString = 'QRIS' then
      CbMetodeBayar.ItemIndex := 3
    else if ZQueryPembayaran.FieldByName('metode_pembayaran').AsString = 'E-Wallet' then
      CbMetodeBayar.ItemIndex := 4
    else
      CbMetodeBayar.ItemIndex := -1;
    
    // Set status pembayaran di combobox
    if ZQueryPembayaran.FieldByName('status_pembayaran').AsString = 'Lunas' then
      CbStatusBayar.ItemIndex := 0
    else if ZQueryPembayaran.FieldByName('status_pembayaran').AsString = 'Belum Lunas' then
      CbStatusBayar.ItemIndex := 1
    else if ZQueryPembayaran.FieldByName('status_pembayaran').AsString = 'Pending' then
      CbStatusBayar.ItemIndex := 2
    else if ZQueryPembayaran.FieldByName('status_pembayaran').AsString = 'Dibatalkan' then
      CbStatusBayar.ItemIndex := 3
    else
      CbStatusBayar.ItemIndex := -1;
      
    // Tampilkan informasi paket terkait
    ZQueryPaket.Close;
    ZQueryPaket.SQL.Clear;
    ZQueryPaket.SQL.Add('SELECT p.*, pl.nama as nama_pelanggan, k.nama as nama_kurir, g.nama_gudang ' +
                       'FROM paket p ' +
                       'LEFT JOIN pelanggan pl ON p.id_pelanggan = pl.id_pelanggan ' +
                       'LEFT JOIN kurir k ON p.id_kurir = k.id_kurir ' +
                       'LEFT JOIN gudang g ON p.id_gudang = g.id_gudang ' +
                       'WHERE p.no_paket = :no_paket');
    ZQueryPaket.ParamByName('no_paket').AsString := EdtNoPaket.Text;
    ZQueryPaket.Open;
    
    if not ZQueryPaket.IsEmpty then
    begin
      LblPelanggan.Caption := 'Pelanggan: ' + ZQueryPaket.FieldByName('nama_pelanggan').AsString;
      LblKurir.Caption := 'Kurir: ' + ZQueryPaket.FieldByName('nama_kurir').AsString;
      LblGudang.Caption := 'Gudang: ' + ZQueryPaket.FieldByName('nama_gudang').AsString;
    end
    else
    begin
      LblPelanggan.Caption := 'Pelanggan: ';
      LblKurir.Caption := 'Kurir: ';
      LblGudang.Caption := 'Gudang: ';
    end;
  end;
end;

end.
