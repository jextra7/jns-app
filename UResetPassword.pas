unit UResetPassword;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection;

type
  TFormResetPassword = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    EdtUsername: TEdit;
    EdtEmail: TEdit;
    BtnResetPassword: TBitBtn;
    BtnBatal: TBitBtn;
    Label4: TLabel;
    EdtPertanyaanKeamanan: TEdit;
    Label5: TLabel;
    EdtJawabanKeamanan: TEdit;
    ZQueryReset: TZQuery;
    procedure BtnResetPasswordClick(Sender: TObject);
    procedure BtnBatalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FZConnection: TZConnection;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TZConnection); reintroduce;
  end;

var
  FormResetPassword: TFormResetPassword;

implementation

{$R *.dfm}

constructor TFormResetPassword.Create(AOwner: TComponent; AConnection: TZConnection);
begin
  inherited Create(AOwner);
  FZConnection := AConnection;
  // Pastikan ZQueryReset menggunakan koneksi yang diberikan
  if Assigned(ZQueryReset) then
    ZQueryReset.Connection := FZConnection;
end;

procedure TFormResetPassword.FormShow(Sender: TObject);
begin
  EdtUsername.Clear;
  EdtEmail.Clear;
  EdtPertanyaanKeamanan.Clear;
  EdtJawabanKeamanan.Clear;
  
  PostMessage(EdtUsername.Handle, WM_SETFOCUS, 0, 0);
end;

procedure TFormResetPassword.BtnResetPasswordClick(Sender: TObject);
var
  NewPassword: string;
  Query: TZQuery;
begin
  // Validasi input
  if EdtUsername.Text = '' then
  begin
    ShowMessage('Username tidak boleh kosong!');
    PostMessage(EdtUsername.Handle, WM_SETFOCUS, 0, 0);
    Exit;
  end;
  
  if EdtEmail.Text = '' then
  begin
    ShowMessage('Email tidak boleh kosong!');
    PostMessage(EdtEmail.Handle, WM_SETFOCUS, 0, 0);
    Exit;
  end;
  
  if EdtPertanyaanKeamanan.Text = '' then
  begin
    ShowMessage('Pertanyaan keamanan tidak boleh kosong!');
    PostMessage(EdtPertanyaanKeamanan.Handle, WM_SETFOCUS, 0, 0);
    Exit;
  end;
  
  if EdtJawabanKeamanan.Text = '' then
  begin
    ShowMessage('Jawaban keamanan tidak boleh kosong!');
    PostMessage(EdtJawabanKeamanan.Handle, WM_SETFOCUS, 0, 0);
    Exit;
  end;
  
  // Cek kecocokan data
  Query := TZQuery.Create(nil);
  try
    Query.Connection := FZConnection;
    Query.SQL.Text := 'SELECT * FROM admin WHERE username = :username AND email = :email ' +
                      'AND pertanyaan_keamanan = :pertanyaan AND jawaban_keamanan = :jawaban';
    Query.ParamByName('username').AsString := EdtUsername.Text;
    Query.ParamByName('email').AsString := EdtEmail.Text;
    Query.ParamByName('pertanyaan').AsString := EdtPertanyaanKeamanan.Text;
    Query.ParamByName('jawaban').AsString := EdtJawabanKeamanan.Text;
    Query.Open;
    
    if Query.RecordCount > 0 then
    begin
      // Generate password baru (8 karakter alfanumerik)
      NewPassword := '';
      Randomize;
      for var i := 1 to 8 do
      begin
        case Random(3) of
          0: NewPassword := NewPassword + Chr(Random(26) + Ord('a'));
          1: NewPassword := NewPassword + Chr(Random(26) + Ord('A'));
          2: NewPassword := NewPassword + Chr(Random(10) + Ord('0'));
        end;
      end;
      
      // Update password di database
      Query.Close;
      Query.SQL.Text := 'UPDATE admin SET password = MD5(:password) WHERE username = :username';
      Query.ParamByName('password').AsString := NewPassword;
      Query.ParamByName('username').AsString := EdtUsername.Text;
      Query.ExecSQL;
      
      // Tampilkan password baru ke user
      ShowMessage('Password baru Anda: ' + NewPassword + #13#10 +
                  'Silakan login dengan password baru ini dan segera ubah password Anda.');
      
      ModalResult := mrOk;
    end
    else
    begin
      ShowMessage('Data yang Anda masukkan tidak cocok!');
    end;
  finally
    Query.Free;
  end;
end;

procedure TFormResetPassword.BtnBatalClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
