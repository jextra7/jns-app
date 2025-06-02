unit UManajemenpaket;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, Data.DB, ZAbstractRODataset, ZAbstractDataset, 
  ZDataset, ZAbstractConnection, ZConnection, Vcl.Buttons;

type
  TForm14 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    ZConnection1: TZConnection;
    ZQueryPaket: TZQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EdtNoPaket: TEdit;
    EdtNamaPengirim: TEdit;
    EdtAlamatPengirim: TEdit;
    EdtNamaPenerima: TEdit;
    EdtAlamatPenerima: TEdit;
    CbJenisPaket: TComboBox;
    EdtBerat: TEdit;
    Label9: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label10: TLabel;
    EdtBiaya: TEdit;
    BtnSimpan: TBitBtn;
    BtnUbah: TBitBtn;
    BtnHapus: TBitBtn;
    BtnBatal: TBitBtn;
    BtnKeluar: TBitBtn;
    Label11: TLabel;
    Label12: TLabel;
    CbIdPelanggan: TComboBox;
    CbIdKurir: TComboBox;
    CbIdGudang: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure BtnSimpanClick(Sender: TObject);
    procedure BtnUbahClick(Sender: TObject);
    procedure BtnHapusClick(Sender: TObject);
    procedure BtnBatalClick(Sender: TObject);
    procedure BtnKeluarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure KosongkanForm;
    procedure TampilkanData;
    function GenerateNoPaket: string;
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

{$R *.dfm}

procedure TForm14.FormCreate(Sender: TObject);
var
  Query: TZQuery;
begin
  // Koneksi database
  ZConnection1.HostName := 'localhost';
  ZConnection1.Port := 3306;
  ZConnection1.Database := 'db_ekspedisi';
  ZConnection1.User := 'root';
  ZConnection1.Password := '';
  ZConnection1.Protocol := 'mysql';
  
  try
    ZConnection1.Connected := True;
  except
    on E: Exception do
    begin
      ShowMessage('Koneksi database gagal: ' + E.Message);
    end;
  end;
  
  // Isi ComboBox jenis paket
  CbJenisPaket.Items.Clear;
  CbJenisPaket.Items.Add('Reguler');
  CbJenisPaket.Items.Add('Express');
  CbJenisPaket.Items.Add('Ekonomi');
  CbJenisPaket.Items.Add('Super Express');
  
  // Isi ComboBox ID Pelanggan
  Query := TZQuery.Create(nil);
  try
    Query.Connection := ZConnection1;
    Query.SQL.Text := 'SELECT id_pelanggan, nama FROM pelanggan ORDER BY id_pelanggan';
    Query.Open;
    
    CbIdPelanggan.Items.Clear;
    while not Query.Eof do
    begin
      CbIdPelanggan.Items.Add(Query.FieldByName('id_pelanggan').AsString + ' - ' + 
                             Query.FieldByName('nama').AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
  
  // Isi ComboBox ID Kurir
  Query := TZQuery.Create(nil);
  try
    Query.Connection := ZConnection1;
    Query.SQL.Text := 'SELECT id_kurir, nama FROM kurir WHERE status = ''Aktif'' ORDER BY id_kurir';
    Query.Open;
    
    CbIdKurir.Items.Clear;
    while not Query.Eof do
    begin
      CbIdKurir.Items.Add(Query.FieldByName('id_kurir').AsString + ' - ' + 
                         Query.FieldByName('nama').AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
  
  // Isi ComboBox ID Gudang
  Query := TZQuery.Create(nil);
  try
    Query.Connection := ZConnection1;
    Query.SQL.Text := 'SELECT id_gudang, nama_gudang FROM gudang WHERE status = ''Aktif'' ORDER BY id_gudang';
    Query.Open;
    
    CbIdGudang.Items.Clear;
    while not Query.Eof do
    begin
      CbIdGudang.Items.Add(Query.FieldByName('id_gudang').AsString + ' - ' + 
                          Query.FieldByName('nama_gudang').AsString);
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

procedure TForm14.FormShow(Sender: TObject);
begin
  KosongkanForm;
  TampilkanData;
  EdtNoPaket.Text := GenerateNoPaket;
  DateTimePicker1.Date := Now;
end;

procedure TForm14.KosongkanForm;
begin
  EdtNoPaket.Clear;
  EdtNamaPengirim.Clear;
  EdtAlamatPengirim.Clear;
  EdtNamaPenerima.Clear;
  EdtAlamatPenerima.Clear;
  CbJenisPaket.ItemIndex := -1;
  EdtBerat.Clear;
  EdtBiaya.Clear;
  DateTimePicker1.Date := Now;
  
  EdtNoPaket.SetFocus;
end;

procedure TForm14.TampilkanData;
begin
  ZQueryPaket.Close;
  ZQueryPaket.SQL.Clear;
  ZQueryPaket.SQL.Text := 'SELECT * FROM paket ORDER BY no_paket DESC';
  ZQueryPaket.Open;
end;

function TForm14.GenerateNoPaket: string;
var
  Tahun, Bulan, Hari: Word;
  Nomor: Integer;
  Query: TZQuery;
begin
  DecodeDate(Date, Tahun, Bulan, Hari);
  
  Query := TZQuery.Create(nil);
  try
    Query.Connection := ZConnection1;
    Query.SQL.Text := 'SELECT MAX(RIGHT(no_paket, 4)) AS nomor FROM paket ' +
                      'WHERE LEFT(no_paket, 8) = :tanggal';
    Query.ParamByName('tanggal').AsString := Format('%.4d%.2d%.2d', [Tahun, Bulan, Hari]);
    Query.Open;
    
    if Query.IsEmpty or Query.FieldByName('nomor').IsNull then
      Nomor := 1
    else
      Nomor := StrToIntDef(Query.FieldByName('nomor').AsString, 0) + 1;
      
    Result := Format('%.4d%.2d%.2d%.4d', [Tahun, Bulan, Hari, Nomor]);
  finally
    Query.Free;
  end;
end;

procedure TForm14.BtnSimpanClick(Sender: TObject);
var
  idPelanggan, idKurir, idGudang: string;
begin
  if EdtNoPaket.Text = '' then
  begin
    ShowMessage('No Paket harus diisi!');
    EdtNoPaket.SetFocus;
    Exit;
  end;
  
  if EdtNamaPengirim.Text = '' then
  begin
    ShowMessage('Nama Pengirim harus diisi!');
    EdtNamaPengirim.SetFocus;
    Exit;
  end;
  
  if EdtNamaPenerima.Text = '' then
  begin
    ShowMessage('Nama Penerima harus diisi!');
    EdtNamaPenerima.SetFocus;
    Exit;
  end;
  
  if CbJenisPaket.ItemIndex = -1 then
  begin
    ShowMessage('Jenis Paket harus dipilih!');
    CbJenisPaket.SetFocus;
    Exit;
  end;
  
  if EdtBerat.Text = '' then
  begin
    ShowMessage('Berat Paket harus diisi!');
    EdtBerat.SetFocus;
    Exit;
  end;
  
  if EdtBiaya.Text = '' then
  begin
    ShowMessage('Biaya Paket harus diisi!');
    EdtBiaya.SetFocus;
    Exit;
  end;
  
  // Ekstrak ID dari ComboBox
  if CbIdPelanggan.ItemIndex > -1 then
    idPelanggan := Copy(CbIdPelanggan.Text, 1, Pos(' - ', CbIdPelanggan.Text) - 1)
  else
    idPelanggan := '';
    
  if CbIdKurir.ItemIndex > -1 then
    idKurir := Copy(CbIdKurir.Text, 1, Pos(' - ', CbIdKurir.Text) - 1)
  else
    idKurir := '';
    
  if CbIdGudang.ItemIndex > -1 then
    idGudang := Copy(CbIdGudang.Text, 1, Pos(' - ', CbIdGudang.Text) - 1)
  else
    idGudang := '';
  
  try
    ZQueryPaket.Close;
    ZQueryPaket.SQL.Clear;
    ZQueryPaket.SQL.Text := 'INSERT INTO paket (no_paket, nama_pengirim, alamat_pengirim, ' +
                           'nama_penerima, alamat_penerima, jenis_paket, berat, tanggal_kirim, biaya, ' +
                           'id_pelanggan, id_kurir, id_gudang) ' +
                           'VALUES (:no_paket, :nama_pengirim, :alamat_pengirim, :nama_penerima, ' +
                           ':alamat_penerima, :jenis_paket, :berat, :tanggal_kirim, :biaya, ' +
                           ':id_pelanggan, :id_kurir, :id_gudang)';
                           
    ZQueryPaket.ParamByName('no_paket').AsString := EdtNoPaket.Text;
    ZQueryPaket.ParamByName('nama_pengirim').AsString := EdtNamaPengirim.Text;
    ZQueryPaket.ParamByName('alamat_pengirim').AsString := EdtAlamatPengirim.Text;
    ZQueryPaket.ParamByName('nama_penerima').AsString := EdtNamaPenerima.Text;
    ZQueryPaket.ParamByName('alamat_penerima').AsString := EdtAlamatPenerima.Text;
    ZQueryPaket.ParamByName('jenis_paket').AsString := CbJenisPaket.Text;
    ZQueryPaket.ParamByName('berat').AsFloat := StrToFloatDef(EdtBerat.Text, 0);
    ZQueryPaket.ParamByName('tanggal_kirim').AsDate := DateTimePicker1.Date;
    ZQueryPaket.ParamByName('biaya').AsFloat := StrToFloatDef(EdtBiaya.Text, 0);
    
    // Parameter foreign key baru
    ZQueryPaket.ParamByName('id_pelanggan').AsString := idPelanggan;
    ZQueryPaket.ParamByName('id_kurir').AsString := idKurir;
    ZQueryPaket.ParamByName('id_gudang').AsString := idGudang;
    
    ZQueryPaket.ExecSQL;
    
    ShowMessage('Data berhasil disimpan!');
    KosongkanForm;
    TampilkanData;
    EdtNoPaket.Text := GenerateNoPaket;
  except
    on E: Exception do
    begin
      ShowMessage('Error: ' + E.Message);
    end;
  end;
end;

procedure TForm14.BtnUbahClick(Sender: TObject);
var
  idPelanggan, idKurir, idGudang: string;
begin
  if EdtNoPaket.Text = '' then
  begin
    ShowMessage('Pilih data yang akan diubah!');
    Exit;
  end;
  
  // Ekstrak ID dari ComboBox
  if CbIdPelanggan.ItemIndex > -1 then
    idPelanggan := Copy(CbIdPelanggan.Text, 1, Pos(' - ', CbIdPelanggan.Text) - 1)
  else
    idPelanggan := '';
    
  if CbIdKurir.ItemIndex > -1 then
    idKurir := Copy(CbIdKurir.Text, 1, Pos(' - ', CbIdKurir.Text) - 1)
  else
    idKurir := '';
    
  if CbIdGudang.ItemIndex > -1 then
    idGudang := Copy(CbIdGudang.Text, 1, Pos(' - ', CbIdGudang.Text) - 1)
  else
    idGudang := '';
  
  try
    ZQueryPaket.Close;
    ZQueryPaket.SQL.Clear;
    ZQueryPaket.SQL.Text := 'UPDATE paket SET nama_pengirim = :nama_pengirim, ' +
                           'alamat_pengirim = :alamat_pengirim, nama_penerima = :nama_penerima, ' +
                           'alamat_penerima = :alamat_penerima, jenis_paket = :jenis_paket, ' +
                           'berat = :berat, tanggal_kirim = :tanggal_kirim, biaya = :biaya, ' +
                           'id_pelanggan = :id_pelanggan, id_kurir = :id_kurir, id_gudang = :id_gudang ' +
                           'WHERE no_paket = :no_paket';
    
    ZQueryPaket.ParamByName('no_paket').AsString := EdtNoPaket.Text;
    ZQueryPaket.ParamByName('nama_pengirim').AsString := EdtNamaPengirim.Text;
    ZQueryPaket.ParamByName('alamat_pengirim').AsString := EdtAlamatPengirim.Text;
    ZQueryPaket.ParamByName('nama_penerima').AsString := EdtNamaPenerima.Text;
    ZQueryPaket.ParamByName('alamat_penerima').AsString := EdtAlamatPenerima.Text;
    ZQueryPaket.ParamByName('jenis_paket').AsString := CbJenisPaket.Text;
    ZQueryPaket.ParamByName('berat').AsFloat := StrToFloatDef(EdtBerat.Text, 0);
    ZQueryPaket.ParamByName('tanggal_kirim').AsDate := DateTimePicker1.Date;
    ZQueryPaket.ParamByName('biaya').AsFloat := StrToFloatDef(EdtBiaya.Text, 0);
    
    // Parameter foreign key baru
    ZQueryPaket.ParamByName('id_pelanggan').AsString := idPelanggan;
    ZQueryPaket.ParamByName('id_kurir').AsString := idKurir;
    ZQueryPaket.ParamByName('id_gudang').AsString := idGudang;
    
    ZQueryPaket.ExecSQL;
    
    ShowMessage('Data berhasil diubah!');
    KosongkanForm;
    TampilkanData;
    EdtNoPaket.Text := GenerateNoPaket;
  except
    on E: Exception do
    begin
      ShowMessage('Error: ' + E.Message);
    end;
  end;
end;

procedure TForm14.BtnHapusClick(Sender: TObject);
begin
  if EdtNoPaket.Text = '' then
  begin
    ShowMessage('Pilih data yang akan dihapus!');
    Exit;
  end;
  
  if MessageDlg('Apakah Anda yakin ingin menghapus data ini?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      ZQueryPaket.Close;
      ZQueryPaket.SQL.Clear;
      ZQueryPaket.SQL.Text := 'DELETE FROM paket WHERE no_paket = :no_paket';
      ZQueryPaket.ParamByName('no_paket').AsString := EdtNoPaket.Text;
      ZQueryPaket.ExecSQL;
      
      ShowMessage('Data berhasil dihapus!');
      KosongkanForm;
      TampilkanData;
      EdtNoPaket.Text := GenerateNoPaket;
    except
      on E: Exception do
      begin
        ShowMessage('Error: ' + E.Message);
      end;
    end;
  end;
end;

procedure TForm14.BtnBatalClick(Sender: TObject);
begin
  KosongkanForm;
  EdtNoPaket.Text := GenerateNoPaket;
end;

procedure TForm14.BtnKeluarClick(Sender: TObject);
begin
  Close;
end;

procedure TForm14.DBGrid1CellClick(Column: TColumn);
var
  Query: TZQuery;
  idPelanggan, idKurir, idGudang: string;
begin
  if not ZQueryPaket.IsEmpty then
  begin
    EdtNoPaket.Text := ZQueryPaket.FieldByName('no_paket').AsString;
    EdtNamaPengirim.Text := ZQueryPaket.FieldByName('nama_pengirim').AsString;
    EdtAlamatPengirim.Text := ZQueryPaket.FieldByName('alamat_pengirim').AsString;
    EdtNamaPenerima.Text := ZQueryPaket.FieldByName('nama_penerima').AsString;
    EdtAlamatPenerima.Text := ZQueryPaket.FieldByName('alamat_penerima').AsString;
    CbJenisPaket.Text := ZQueryPaket.FieldByName('jenis_paket').AsString;
    EdtBerat.Text := ZQueryPaket.FieldByName('berat').AsString;
    DateTimePicker1.Date := ZQueryPaket.FieldByName('tanggal_kirim').AsDateTime;
    EdtBiaya.Text := ZQueryPaket.FieldByName('biaya').AsString;
    
    // Set ComboBox foreign key
    idPelanggan := ZQueryPaket.FieldByName('id_pelanggan').AsString;
    idKurir := ZQueryPaket.FieldByName('id_kurir').AsString;
    idGudang := ZQueryPaket.FieldByName('id_gudang').AsString;
    
    // Set ComboBox ID Pelanggan
    for var i := 0 to CbIdPelanggan.Items.Count - 1 do
    begin
      if Pos(idPelanggan + ' - ', CbIdPelanggan.Items[i]) = 1 then
      begin
        CbIdPelanggan.ItemIndex := i;
        Break;
      end;
    end;
    
    // Set ComboBox ID Kurir
    for var i := 0 to CbIdKurir.Items.Count - 1 do
    begin
      if Pos(idKurir + ' - ', CbIdKurir.Items[i]) = 1 then
      begin
        CbIdKurir.ItemIndex := i;
        Break;
      end;
    end;
    
    // Set ComboBox ID Gudang
    for var i := 0 to CbIdGudang.Items.Count - 1 do
    begin
      if Pos(idGudang + ' - ', CbIdGudang.Items[i]) = 1 then
      begin
        CbIdGudang.ItemIndex := i;
        Break;
      end;
    end;
  end;
end;

end.