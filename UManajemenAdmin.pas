unit UManajemenAdmin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    s: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EdtIdAdmin: TEdit;
    EdtNama: TEdit;
    EdtUsername: TEdit;
    EdtPassword: TEdit;
    CbLevel: TComboBox;
    BtnSimpan: TBitBtn;
    BtnUbah: TBitBtn;
    BtnHapus: TBitBtn;
    BtnBatal: TBitBtn;
    BtnKeluar: TBitBtn;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    ZConnection1: TZConnection;
    ZQueryAdmin: TZQuery;
    DataSource1: TDataSource;
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
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
  // Inisialisasi ComboBox Level
  CbLevel.Items.Add('Admin');
  CbLevel.Items.Add('Operator');
  CbLevel.Items.Add('Manager');
  CbLevel.Items.Add('Staff');
  
  // Atur koneksi database
  ZConnection1.Connected := True;
  ZQueryAdmin.Active := True;
  
  // Set form awal
  KosongkanForm;
  SetEditReadOnly(False);
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm3.KosongkanForm;
begin
  EdtIdAdmin.Clear;
  EdtNama.Clear;
  EdtUsername.Clear;
  EdtPassword.Clear;
  CbLevel.ItemIndex := -1;
  
  EdtIdAdmin.SetFocus;
end;

procedure TForm3.SetEditReadOnly(status: Boolean);
begin
  EdtIdAdmin.ReadOnly := status;
  EdtNama.ReadOnly := status;
  EdtUsername.ReadOnly := status;
  EdtPassword.ReadOnly := status;
  CbLevel.Enabled := not status;
end;

procedure TForm3.BtnSimpanClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdAdmin.Text = '' then
  begin
    ShowMessage('ID Admin tidak boleh kosong!');
    EdtIdAdmin.SetFocus;
    Exit;
  end;
  
  if EdtNama.Text = '' then
  begin
    ShowMessage('Nama Admin tidak boleh kosong!');
    EdtNama.SetFocus;
    Exit;
  end;
  
  if EdtUsername.Text = '' then
  begin
    ShowMessage('Username tidak boleh kosong!');
    EdtUsername.SetFocus;
    Exit;
  end;
  
  if EdtPassword.Text = '' then
  begin
    ShowMessage('Password tidak boleh kosong!');
    EdtPassword.SetFocus;
    Exit;
  end;
  
  if CbLevel.ItemIndex = -1 then
  begin
    ShowMessage('Level admin harus dipilih!');
    CbLevel.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID sudah ada
  ZQueryAdmin.SQL.Clear;
  ZQueryAdmin.SQL.Add('SELECT * FROM admin WHERE id_admin = "' + EdtIdAdmin.Text + '"');
  ZQueryAdmin.Open;
  
  if ZQueryAdmin.RecordCount > 0 then
  begin
    ShowMessage('ID Admin sudah ada!');
    EdtIdAdmin.Clear;
    EdtIdAdmin.SetFocus;
    Exit;
  end;
  
  // Cek apakah username sudah ada
  ZQueryAdmin.SQL.Clear;
  ZQueryAdmin.SQL.Add('SELECT * FROM admin WHERE username = "' + EdtUsername.Text + '"');
  ZQueryAdmin.Open;
  
  if ZQueryAdmin.RecordCount > 0 then
  begin
    ShowMessage('Username sudah digunakan!');
    EdtUsername.Clear;
    EdtUsername.SetFocus;
    Exit;
  end;
  
  // Simpan data baru
  try
    ZQueryAdmin.SQL.Clear;
    ZQueryAdmin.SQL.Add('INSERT INTO admin (id_admin, nama, username, password, level) ' +
                        'VALUES (:id, :nama, :username, :password, :level)');
    ZQueryAdmin.ParamByName('id').AsString := EdtIdAdmin.Text;
    ZQueryAdmin.ParamByName('nama').AsString := EdtNama.Text;
    ZQueryAdmin.ParamByName('username').AsString := EdtUsername.Text;
    ZQueryAdmin.ParamByName('password').AsString := EdtPassword.Text;
    ZQueryAdmin.ParamByName('level').AsString := CbLevel.Text;
    ZQueryAdmin.ExecSQL;

    ShowMessage('Data admin berhasil disimpan!');
    
    // Refresh data
    ZQueryAdmin.SQL.Clear;
    ZQueryAdmin.SQL.Add('SELECT * FROM admin ORDER BY id_admin');
    ZQueryAdmin.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm3.BtnUbahClick(Sender: TObject);
var
  OldUsername: string;
begin
  // Validasi input
  if EdtIdAdmin.Text = '' then
  begin
    ShowMessage('ID Admin tidak boleh kosong!');
    EdtIdAdmin.SetFocus;
    Exit;
  end;
  
  // Cek apakah ID ada
  ZQueryAdmin.SQL.Clear;
  ZQueryAdmin.SQL.Add('SELECT * FROM admin WHERE id_admin = "' + EdtIdAdmin.Text + '"');
  ZQueryAdmin.Open;
  
  if ZQueryAdmin.RecordCount = 0 then
  begin
    ShowMessage('ID Admin tidak ditemukan!');
    KosongkanForm;
    Exit;
  end;
  
  OldUsername := ZQueryAdmin.FieldByName('username').AsString;
  
  // Cek username jika berubah
  if (EdtUsername.Text <> OldUsername) then
  begin
    ZQueryAdmin.SQL.Clear;
    ZQueryAdmin.SQL.Add('SELECT * FROM admin WHERE username = "' + EdtUsername.Text + '"');
    ZQueryAdmin.Open;
    
    if ZQueryAdmin.RecordCount > 0 then
    begin
      ShowMessage('Username sudah digunakan!');
      EdtUsername.Text := OldUsername;
      EdtUsername.SetFocus;
      Exit;
    end;
  end;
  
  // Update data
  try
    ZQueryAdmin.SQL.Clear;
    ZQueryAdmin.SQL.Add('UPDATE admin SET nama = :nama, username = :username, ' +
                        'password = :password, level = :level ' +
                        'WHERE id_admin = :id');
    ZQueryAdmin.ParamByName('id').AsString := EdtIdAdmin.Text;
    ZQueryAdmin.ParamByName('nama').AsString := EdtNama.Text;
    ZQueryAdmin.ParamByName('username').AsString := EdtUsername.Text;
    ZQueryAdmin.ParamByName('password').AsString := EdtPassword.Text;
    ZQueryAdmin.ParamByName('level').AsString := CbLevel.Text;
    ZQueryAdmin.ExecSQL;
    
    ShowMessage('Data admin berhasil diubah!');
    
    // Refresh data
    ZQueryAdmin.SQL.Clear;
    ZQueryAdmin.SQL.Add('SELECT * FROM admin ORDER BY id_admin');
    ZQueryAdmin.Open;
    
    KosongkanForm;
  except
    on E: Exception do
      ShowMessage('Terjadi kesalahan: ' + E.Message);
  end;
end;

procedure TForm3.BtnHapusClick(Sender: TObject);
begin
  // Validasi input
  if EdtIdAdmin.Text = '' then
  begin
    ShowMessage('ID Admin tidak boleh kosong!');
    EdtIdAdmin.SetFocus;
    Exit;
  end;
  
  // Konfirmasi penghapusan
  if MessageDlg('Apakah Anda yakin ingin menghapus data admin ini?', 
     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // Hapus data
    try
      ZQueryAdmin.SQL.Clear;
      ZQueryAdmin.SQL.Add('DELETE FROM admin WHERE id_admin = :id');
      ZQueryAdmin.ParamByName('id').AsString := EdtIdAdmin.Text;
      ZQueryAdmin.ExecSQL;
      
      ShowMessage('Data admin berhasil dihapus!');
      
      // Refresh data
      ZQueryAdmin.SQL.Clear;
      ZQueryAdmin.SQL.Add('SELECT * FROM admin ORDER BY id_admin');
      ZQueryAdmin.Open;
      
      KosongkanForm;
    except
      on E: Exception do
        ShowMessage('Terjadi kesalahan: ' + E.Message);
    end;
  end;
end;

procedure TForm3.BtnBatalClick(Sender: TObject);
begin
  KosongkanForm;
end;

procedure TForm3.BtnKeluarClick(Sender: TObject);
begin
  Close;
end;

procedure TForm3.DBGrid1CellClick(Column: TColumn);
begin
  // Tampilkan data yang dipilih di form
  EdtIdAdmin.Text := ZQueryAdmin.FieldByName('id_admin').AsString;
  EdtNama.Text := ZQueryAdmin.FieldByName('nama').AsString;
  EdtUsername.Text := ZQueryAdmin.FieldByName('username').AsString;
  EdtPassword.Text := ZQueryAdmin.FieldByName('password').AsString;
  
  // Set level di combobox
  if ZQueryAdmin.FieldByName('level').AsString = 'Admin' then
    CbLevel.ItemIndex := 0
  else if ZQueryAdmin.FieldByName('level').AsString = 'Operator' then
    CbLevel.ItemIndex := 1
  else if ZQueryAdmin.FieldByName('level').AsString = 'Manager' then
    CbLevel.ItemIndex := 2
  else if ZQueryAdmin.FieldByName('level').AsString = 'Staff' then
    CbLevel.ItemIndex := 3
  else
    CbLevel.ItemIndex := -1;
end;

end.
