unit UMainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ZAbstractConnection, ZConnection,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Menus, Data.DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TFormMainMenu = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    BtnPaket: TBitBtn;
    BtnPelanggan: TBitBtn;
    BtnGudang: TBitBtn;
    BtnKurir: TBitBtn;
    BtnPembayaran: TBitBtn;
    BtnAdmin: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Label4: TLabel;
    ZConnection1: TZConnection;
    LblUserInfo: TLabel;
    BtnLogout: TBitBtn;
    procedure BtnPaketClick(Sender: TObject);
    procedure BtnPelangganClick(Sender: TObject);
    procedure BtnGudangClick(Sender: TObject);
    procedure BtnKurirClick(Sender: TObject);
    procedure BtnPembayaranClick(Sender: TObject);
    procedure BtnAdminClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnLogoutClick(Sender: TObject);
  private
    { Private declarations }
    FUserID: string;
    FUsername: string;
    FUserLevel: string;
    procedure ShowLoginForm;
    procedure SetMenuAccess(UserLevel: string);
    procedure OpenChildForm(FormClass: TFormClass; FormTitle: string);
  public
    { Public declarations }
    property UserID: string read FUserID write FUserID;
    property Username: string read FUsername write FUsername;
    property UserLevel: string read FUserLevel write FUserLevel;
    procedure HandleException(Sender: TObject; E: Exception);
  end;

var
  FormMainMenu: TFormMainMenu;

implementation

{$R *.dfm}

uses
  UManajemenPaket, UManajemenPelanggan, UManajemenGudang, UManajemenKurir,
  UManajemenPembayaran, UManajemenAdmin, ULogin;

type
  // Kelas helper untuk menangkap dan meredam error fokus
  TFocusErrorHandler = class
  public
    class procedure SafeSetFocus(Control: TWinControl);
  end;

procedure TFormMainMenu.FormCreate(Sender: TObject);
begin
  // Center form on screen
  Position := poScreenCenter;
  
  // Initialize database connection
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
  
  // Default - hide all menu buttons until login
  SetMenuAccess('');
end;

procedure TFormMainMenu.FormShow(Sender: TObject);
begin
  // Check if already logged in
  if FUsername = '' then
  begin
    // Gunakan try-except untuk menangkap error fokus
    try
      ShowLoginForm;
    except
      on E: Exception do
      begin
        ShowMessage('Error saat login: ' + E.Message);
        // Delay sebentar sebelum menutup aplikasi
        Sleep(500);
        Application.Terminate;
      end;
    end;
  end;
end;

procedure TFormMainMenu.ShowLoginForm;
var
  LoginForm: TLogin;
begin
  LoginForm := TLogin.Create(Self);
  try
    // Pastikan form utama tidak ditutup jika login dibatalkan
    LoginForm.ZConnection := ZConnection1;
    
    if LoginForm.ShowModal = mrOk then
    begin
      FUserID := LoginForm.UserID;
      FUsername := LoginForm.Username;
      FUserLevel := LoginForm.UserLevel;
      
      // Update user info label
      LblUserInfo.Caption := 'Login sebagai: ' + FUsername + ' (' + FUserLevel + ')';
      
      // Set menu access based on user level
      SetMenuAccess(FUserLevel);
    end
    else
    begin
      // Jika login dibatalkan, jangan langsung tutup aplikasi
      // Ini bisa jadi penyebab error fokus window
      Application.Terminate; // Gunakan Application.Terminate daripada Close
    end;
  finally
    LoginForm.Free;
  end;
end;

procedure TFormMainMenu.SetMenuAccess(UserLevel: string);
begin
  if UserLevel = 'Admin' then
  begin
    // Admin dapat mengakses semua menu
    BtnPaket.Enabled := True;
    BtnPelanggan.Enabled := True;
    BtnGudang.Enabled := True;
    BtnKurir.Enabled := True;
    BtnPembayaran.Enabled := True;
    BtnAdmin.Enabled := True;
  end
  else if UserLevel = 'Operator' then
  begin
    // Operator tidak dapat mengakses Manajemen Admin
    BtnPaket.Enabled := True;
    BtnPelanggan.Enabled := True;
    BtnGudang.Enabled := True;
    BtnKurir.Enabled := True;
    BtnPembayaran.Enabled := True;
    BtnAdmin.Enabled := False;
  end
  else if UserLevel = 'Staff' then
  begin
    // Staff hanya dapat mengakses Paket dan Pelanggan
    BtnPaket.Enabled := True;
    BtnPelanggan.Enabled := True;
    BtnGudang.Enabled := False;
    BtnKurir.Enabled := False;
    BtnPembayaran.Enabled := False;
    BtnAdmin.Enabled := False;
  end
  else
  begin
    // Belum login - semua menu tidak aktif
    BtnPaket.Enabled := False;
    BtnPelanggan.Enabled := False;
    BtnGudang.Enabled := False;
    BtnKurir.Enabled := False;
    BtnPembayaran.Enabled := False;
    BtnAdmin.Enabled := False;
  end;
  
  // Logout button hanya aktif jika sudah login
  BtnLogout.Enabled := (UserLevel <> '');
end;

procedure TFormMainMenu.BtnLogoutClick(Sender: TObject);
begin
  // Clear user information
  FUserID := '';
  FUsername := '';
  FUserLevel := '';
  
  // Update label
  LblUserInfo.Caption := 'Belum login';
  
  // Disable all menus
  SetMenuAccess('');
  
  // Show login form again
  ShowLoginForm;
end;

procedure TFormMainMenu.OpenChildForm(FormClass: TFormClass; FormTitle: string);
var
  ChildForm: TForm;
begin
  Screen.Cursor := crHourGlass;
  try
    try
      // Nonaktifkan terlebih dahulu
      Self.Enabled := False;
      
      // Buat form dengan owner nil dan set propertinya
      ChildForm := FormClass.Create(nil);
      try
        // Pastikan semua properti diset dengan benar
        ChildForm.Position := poScreenCenter;
        ChildForm.FormStyle := fsNormal;
        
        // Penting: Tambahkan handler OnActivate
        ChildForm.OnActivate := nil; // Hapus event handler yang mungkin ada
        
        // Tunggu sebentar sebelum menampilkan form
        Application.ProcessMessages;
        Sleep(100);
        
        // Tampilkan form - gunakan Show dan tunggu sampai selesai, bukan ShowModal
        ChildForm.ShowModal;
      finally
        ChildForm.Free;
        Self.Enabled := True;
        Self.BringToFront;
        Self.SetFocus;
      end;
    except
      on E: Exception do
      begin
        Self.Enabled := True;
        if not (E is EAbort) then // Abaikan exception jenis abort
          ShowMessage('Error saat membuka Form ' + FormTitle + ': ' + E.Message);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormMainMenu.BtnPaketClick(Sender: TObject);
begin
  OpenChildForm(TForm14, 'Paket');
end;

procedure TFormMainMenu.BtnPelangganClick(Sender: TObject);
begin
  // Gunakan pendekatan yang berbeda - lebih sederhana
  try
    with TForm1.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
  except
    on E: Exception do
    begin
      if not (E is EAbort) then
        ShowMessage('Error: ' + E.Message);
    end;
  end;
end;

procedure TFormMainMenu.BtnGudangClick(Sender: TObject);
begin
  OpenChildForm(TForm2, 'Gudang');
end;

procedure TFormMainMenu.BtnKurirClick(Sender: TObject);
begin
  OpenChildForm(TForm4, 'Kurir');
end;

procedure TFormMainMenu.BtnPembayaranClick(Sender: TObject);
begin
  OpenChildForm(TForm5, 'Pembayaran');
end;

procedure TFormMainMenu.BtnAdminClick(Sender: TObject);
begin
  OpenChildForm(TForm3, 'Admin');
end;

class procedure TFocusErrorHandler.SafeSetFocus(Control: TWinControl);
begin
  if Assigned(Control) and Control.CanFocus and Control.Showing and
     Control.Enabled and Control.Visible then
  begin
    try
      Control.SetFocus;
    except
      on E: Exception do
      begin
        // Hanya log error fokus tanpa menampilkan pesan
        OutputDebugString(PChar('Focus error: ' + E.Message));
      end;
    end;
  end;
end;

procedure TFormMainMenu.HandleException(Sender: TObject; E: Exception);
begin
  // Tangani khusus error fokus
  if (E is EInvalidOperation) and (Pos('Cannot focus', E.Message) > 0) then
  begin
    // Abaikan error fokus
    OutputDebugString(PChar('Focus error suppressed: ' + E.Message));
  end
  else
  begin
    ShowMessage('Error dalam aplikasi: ' + E.Message);
  end;
end;

end.
