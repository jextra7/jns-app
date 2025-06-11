unit UFormResi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, QuickRpt, QRCtrls, QRPDFFilt, ExtCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZConnection;

type
  TFormResi = class(TForm)
    QRResi: TQuickRep;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRLabel_NoPaket: TQRLabel;
    QRLabel_TglKirim: TQRLabel;
    QRLabel_Pengirim: TQRLabel;
    QRLabel_AlamatPengirim: TQRLabel;
    QRLabel_Penerima: TQRLabel;
    QRLabel_AlamatPenerima: TQRLabel;
    QRLabel_JenisPaket: TQRLabel;
    QRLabel_Berat: TQRLabel;
    QRLabel_Biaya: TQRLabel;
    QRLabel_Kurir: TQRLabel;
    QRLabel_Gudang: TQRLabel;
    QRLabelBarcode: TQRLabel;
    QRShape1: TQRShape;
    QRLabel2: TQRLabel;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CetakResi(Connection: TZConnection; NoPaket: string);
  end;

var
  FormResi: TFormResi;

implementation

{$R *.dfm}

procedure TFormResi.CetakResi(Connection: TZConnection; NoPaket: string);
var
  Query: TZQuery;
begin
  Screen.Cursor := crHourGlass;
  Query := nil;
  
  try
    // Pastikan semua komponen QR telah dibuat dengan benar
    if not Assigned(QRResi) or not Assigned(QRLabel_NoPaket) or
       not Assigned(QRLabel_TglKirim) or not Assigned(QRLabel_Pengirim) or
       not Assigned(QRLabel_AlamatPengirim) or not Assigned(QRLabel_Penerima) or
       not Assigned(QRLabel_AlamatPenerima) or not Assigned(QRLabel_JenisPaket) or
       not Assigned(QRLabel_Berat) or not Assigned(QRLabel_Biaya) or
       not Assigned(QRLabel_Kurir) or not Assigned(QRLabel_Gudang) or
       not Assigned(QRLabelBarcode) then
    begin
      ShowMessage('Komponen QuickReport tidak lengkap');
      Exit;
    end;
    
    // Pastikan koneksi database tersedia
    if not Assigned(Connection) then
    begin
      ShowMessage('Koneksi database tidak tersedia');
      Exit;
    end;
    
    // Buat query untuk mengambil data paket
    Query := TZQuery.Create(nil);
    Query.Connection := Connection;
    Query.SQL.Text := 'SELECT p.*, ' +
                    'plg.nama AS nama_pelanggan, ' +
                    'k.nama AS nama_kurir, ' +
                    'g.nama_gudang ' +
                    'FROM paket p ' +
                    'LEFT JOIN pelanggan plg ON p.id_pelanggan = plg.id_pelanggan ' +
                    'LEFT JOIN kurir k ON p.id_kurir = k.id_kurir ' +
                    'LEFT JOIN gudang g ON p.id_gudang = g.id_gudang ' +
                    'WHERE p.no_paket = :no_paket';
    Query.ParamByName('no_paket').AsString := NoPaket;
    Query.Open;
    
    if Query.IsEmpty then
    begin
      ShowMessage('Data paket tidak ditemukan!');
      Exit;
    end;
    
    // Isi data ke komponen QuickReport
    try
      QRLabel_NoPaket.Caption := 'No Resi: ' + Query.FieldByName('no_paket').AsString;
      QRLabel_TglKirim.Caption := 'Tanggal: ' + FormatDateTime('dd/mm/yyyy', Query.FieldByName('tanggal_kirim').AsDateTime);
      QRLabel_Pengirim.Caption := 'Pengirim: ' + Query.FieldByName('nama_pengirim').AsString;
      QRLabel_AlamatPengirim.Caption := Query.FieldByName('alamat_pengirim').AsString;
      QRLabel_Penerima.Caption := 'Penerima: ' + Query.FieldByName('nama_penerima').AsString;
      QRLabel_AlamatPenerima.Caption := Query.FieldByName('alamat_penerima').AsString;
      QRLabel_JenisPaket.Caption := 'Jenis: ' + Query.FieldByName('jenis_paket').AsString;
      QRLabel_Berat.Caption := 'Berat: ' + Query.FieldByName('berat').AsString + ' kg';
      QRLabel_Biaya.Caption := 'Biaya: Rp ' + FormatFloat('#,##0', Query.FieldByName('biaya').AsFloat);
    except
      on E: Exception do
      begin
        ShowMessage('Error saat mengisi data label: ' + E.Message);
        Exit;
      end;
    end;
    
    // Isi data relasi jika ada
    try
      if Query.FindField('nama_kurir') <> nil then
      begin
        if not Query.FieldByName('nama_kurir').IsNull then
          QRLabel_Kurir.Caption := 'Kurir: ' + Query.FieldByName('nama_kurir').AsString
        else
          QRLabel_Kurir.Caption := 'Kurir: -';
      end else
        QRLabel_Kurir.Caption := 'Kurir: -';
        
      if Query.FindField('nama_gudang') <> nil then
      begin
        if not Query.FieldByName('nama_gudang').IsNull then
          QRLabel_Gudang.Caption := 'Gudang: ' + Query.FieldByName('nama_gudang').AsString
        else
          QRLabel_Gudang.Caption := 'Gudang: -';
      end else
        QRLabel_Gudang.Caption := 'Gudang: -';
    except
      on E: Exception do
      begin
        ShowMessage('Error saat mengisi data relasi: ' + E.Message);
      end;
    end;
    
    // Set barcode
    QRLabelBarcode.Caption := Query.FieldByName('no_paket').AsString;
    
    // Preview resi
    try
      QRResi.Prepare;
      QRResi.Preview;
    except
      on E: Exception do
      begin
        ShowMessage('Error saat menampilkan preview: ' + E.Message);
      end;
    end;
  finally
    if Assigned(Query) then
      Query.Free;
    Screen.Cursor := crDefault;
  end;
end;

end.
