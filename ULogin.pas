unit ULogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection;

type
  TLogin = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    EdtUsername: TEdit;
    EdtPassword: TEdit;
    BtnLogin: TBitBtn;
    BtnBatal: TBitBtn;
    ZQueryLogin: TZQuery;
    procedure BtnLoginClick(Sender: TObject);
    procedure BtnBatalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FUserID: string;
    FUsername: string;
    FUserLevel: string;
  public
    { Public declarations }
    ZConnection: TZConnection;
    property UserID: string read FUserID;
    property Username: string read FUsername;
    property UserLevel: string read FUserLevel;
  end;

var
  Login: TLogin;

implementation

{$R *.dfm}

procedure TLogin.FormCreate(Sender: TObject);
begin
  // Center form on screen
  Position := poScreenCenter;
end;

procedure TLogin.FormShow(Sender: TObject);
begin
  EdtUsername.Clear;
  EdtPassword.Clear;
  
  // Gunakan PostMessage untuk menunda SetFocus hingga form benar-benar ditampilkan
  PostMessage(EdtUsername.Handle, WM_SETFOCUS, 0, 0);
end;

procedure TLogin.BtnLoginClick(Sender: TObject);
begin
  // Validasi input
  if EdtUsername.Text = '' then
  begin
    ShowMessage('Username tidak boleh kosong!');
    // Gunakan PostMessage atau jadwalkan fokus
    PostMessage(EdtUsername.Handle, WM_SETFOCUS, 0, 0);
    Exit;
  end;
  
  if EdtPassword.Text = '' then
  begin
    ShowMessage('Password tidak boleh kosong!');
    // Gunakan PostMessage atau jadwalkan fokus
    PostMessage(EdtPassword.Handle, WM_SETFOCUS, 0, 0);
    Exit;
  end;
  
  // Set koneksi untuk query
  try
    ZQueryLogin.Connection := ZConnection;
    
    // Cek login
    ZQueryLogin.Close;
    ZQueryLogin.SQL.Clear;
    ZQueryLogin.SQL.Add('SELECT * FROM admin WHERE username = :username AND password = MD5(:password)');
    ZQueryLogin.ParamByName('username').AsString := EdtUsername.Text;
    ZQueryLogin.ParamByName('password').AsString := EdtPassword.Text;
    ZQueryLogin.Open;
    
    if ZQueryLogin.RecordCount > 0 then
    begin
      // Login berhasil
      FUserID := ZQueryLogin.FieldByName('id_admin').AsString;
      FUsername := ZQueryLogin.FieldByName('username').AsString;
      FUserLevel := ZQueryLogin.FieldByName('level').AsString;
      
      ModalResult := mrOk;
    end
    else
    begin
      // Login gagal
      ShowMessage('Username atau password salah!');
      EdtUsername.Clear;
      EdtPassword.Clear;
      
      // Gunakan PostMessage untuk fokus
      PostMessage(EdtUsername.Handle, WM_SETFOCUS, 0, 0);
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Error saat login: ' + E.Message);
    end;
  end;
end;

procedure TLogin.BtnBatalClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
