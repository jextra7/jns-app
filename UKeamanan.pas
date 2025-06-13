unit UKeamanan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection, ZConnection;

type
  TFormKeamanan = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdtPasswordLama: TEdit;
    EdtPasswordBaru: TEdit;
    EdtKonfirmasiPassword: TEdit;
    Bevel1: TBevel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CbPertanyaanKeamanan: TComboBox;
    EdtJawabanKeamanan: TEdit;
    BtnSimpan: TBitBtn;
    BtnBatal: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtnSimpanClick(Sender: TObject);
    procedure BtnBatalClick(Sender: TObject);
  private
    { Private declarations }
    FUserID: string;
    FZConnection: TZConnection;
    procedure LoadUserData;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AConnection: TZConnection; const AUserID: string); reintroduce;
  end;

var
  FormKeamanan: TFormKeamanan;

implementation

{$R *.dfm}

constructor TFormKeamanan.Create(AOwner: TComponent; AConnection: TZConnection; const AUserID: string);
begin
  inherited Create(AOwner);
  FZConnection := AConnection;
  FUserID := AUserID;
end;

procedure TFormKeamanan.FormShow(Sender: TObject);
begin
  // Reset form
  EdtPasswordLama.Clear;
  EdtPasswordBaru.Clear;
  EdtKonfirmasiPassword.Clear;
  
  // Load user data
  LoadUserData;
  
  // Set focus
  PostMessage(EdtPasswordLama.Handle, WM_SETFOCUS, 0, 0);
end;

procedure TFormKeamanan.LoadUserData;
var
  Query: TZQuery;
begin
  // Load existing data
  if (FUserID <> '') and Assigned(FZConnection) then
  begin
    Query := TZQuery.Create(nil);
    try
      Query.Connection := FZConnection;
      Query.SQL.Text := 'SELECT pertanyaan_keamanan, jawaban_keamanan FROM admin WHERE id_admin = :id';
      Query.ParamByName('id').AsString := FUserID;
      Query.Open;
      
      if not Query.IsEmpty then
      begin
        // Set pertanyaan keamanan jika ada
        if not Query.FieldByName('pertanyaan_keamanan').IsNull then
        begin
          CbPertanyaanKeamanan.ItemIndex := CbPertanyaanKeamanan.Items.IndexOf(
            Query.FieldByName('pertanyaan_keamanan').AsString);
          
          // Jika tidak ditemukan di list, tambahkan sebagai custom
          if CbPertanyaanKeamanan.ItemIndex = -1 then
          begin
            CbPertanyaanKeamanan.Items.Add(Query.FieldByName('pertanyaan_keamanan').AsString);
            CbPertanyaanKeamanan.ItemIndex := CbPertanyaanKeamanan.Items.Count - 1;
          end;
        end;
        
        // Set jawaban keamanan jika ada
        if not Query.FieldByName('jawaban_keamanan').IsNull then
          EdtJawabanKeamanan.Text := Query.FieldByName('jawaban_keamanan').AsString;
      end;
    finally
      Query.Free;
    end;
  end;
end;

procedure TFormKeamanan.BtnSimpanClick(Sender: TObject);
var
  Query: TZQuery;
  OldPasswordCorrect: Boolean;
  SQL: string;
begin
  // Validasi input
  if (EdtPasswordLama.Text <> '') or (EdtPasswordBaru.Text <> '') or (EdtKonfirmasiPassword.Text <> '') then
  begin
    // Jika ada field password yang diisi, semua field password harus diisi
    if (EdtPasswordLama.Text = '') or (EdtPasswordBaru.Text = '') or (EdtKonfirmasiPassword.Text = '') then
    begin
      ShowMessage('Semua field password harus diisi jika ingin mengubah password!');
      Exit;
    end;
    
    // Validasi password baru = konfirmasi
    if EdtPasswordBaru.Text <> EdtKonfirmasiPassword.Text then
    begin
      ShowMessage('Password baru dan konfirmasi password tidak sama!');
      Exit;
    end;
  end;
  
  // Validasi pertanyaan keamanan
  if (CbPertanyaanKeamanan.ItemIndex = -1) or (EdtJawabanKeamanan.Text = '') then
  begin
    ShowMessage('Pertanyaan dan jawaban keamanan harus diisi!');
    Exit;
  end;
  
  // Verifikasi password lama jika ingin ubah password
  OldPasswordCorrect := True;
  if EdtPasswordLama.Text <> '' then
  begin
    Query := TZQuery.Create(nil);
    try
      Query.Connection := FZConnection;
      Query.SQL.Text := 'SELECT * FROM admin WHERE id_admin = :id AND password = MD5(:pass)';
      Query.ParamByName('id').AsString := FUserID;
      Query.ParamByName('pass').AsString := EdtPasswordLama.Text;
      Query.Open;
      
      OldPasswordCorrect := not Query.IsEmpty;
      
      if not OldPasswordCorrect then
      begin
        ShowMessage('Password lama tidak sesuai!');
        Exit;
      end;
    finally
      Query.Free;
    end;
  end;
  
  // Update data di database
  Query := TZQuery.Create(nil);
  try
    Query.Connection := FZConnection;
    
    // Buat SQL berdasarkan field yang diubah
    SQL := 'UPDATE admin SET pertanyaan_keamanan = :pertanyaan, jawaban_keamanan = :jawaban';
    
    // Tambahkan update password jika perlu
    if EdtPasswordBaru.Text <> '' then
      SQL := SQL + ', password = MD5(:password)';
      
    SQL := SQL + ' WHERE id_admin = :id';
    
    Query.SQL.Text := SQL;
    Query.ParamByName('pertanyaan').AsString := CbPertanyaanKeamanan.Text;
    Query.ParamByName('jawaban').AsString := EdtJawabanKeamanan.Text;
    Query.ParamByName('id').AsString := FUserID;
    
    if EdtPasswordBaru.Text <> '' then
      Query.ParamByName('password').AsString := EdtPasswordBaru.Text;
      
    Query.ExecSQL;
    
    ShowMessage('Pengaturan keamanan berhasil disimpan.');
    ModalResult := mrOk;
  finally
    Query.Free;
  end;
end;

procedure TFormKeamanan.BtnBatalClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
