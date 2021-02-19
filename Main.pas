unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CPortCtl, CPort, ExtCtrls, IniFiles, RBufferedGraphic,
  RVer,
  RLedRectangle;

type
  TfTTY = class(TForm)
    pnl1: TPanel;
    cbPort: TComComboBox;
    bConnect: TButton;
    com1: TComPort;
    clConnected: TComLed;
    spl1: TSplitter;
    ctTerm: TComTerminal;
    clCTS: TComLed;
    clDSR: TComLed;
    clTx: TComLed;
    clRx: TComLed;
    cbBaudRate: TComComboBox;
    bSend: TButton;
    eTest: TEdit;
    ebyte: TEdit;
    clRI: TComLed;
    cbCR: TCheckBox;
    cbNL: TCheckBox;
    lrDTR: TRLedRectangle;
    procedure bConnectClick(Sender: TObject);
    procedure bSendClick(Sender: TObject);
    procedure eTestKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbPortDropDown(Sender: TObject);
    procedure com1Exception(Sender: TObject; TComException: TComExceptions; ComportMessage: string; WinError: Int64; WinMessage: string);
    procedure cbDTRClick(Sender: TObject);
    procedure eTestClick(Sender: TObject);
    procedure ctTermDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ini:TIniFile;
    procedure Connect;
    function  isConnected(autoConnect: boolean):boolean;
  end;

var
  fTTY: TfTTY;

implementation

{$R *.dfm}

procedure TfTTY.bConnectClick(Sender: TObject);
begin
  com1.Port:=cbPort.Text;
  com1.BaudRate:=TBaudrate( cbBaudRate.Itemindex);
  com1.Connected:= not com1.Connected;
  if com1.Connected then begin
    bConnect.Caption:='Disconnect';
    com1.SETDTR(lrDTR.Active);
  end else bConnect.Caption:='Connect';
end;

procedure TfTTY.bSendClick(Sender: TObject);
var
  b:Byte;
  endl:string;
begin
  if not isConnected(True) then Exit;
  
  endl:='';
  if cbCR.Checked then endl:=endl+#13;
  if cbNL.Checked then endl:=endl+#10;

  if ebyte.Text<>'' then begin
    b:=StrToInt(ebyte.Text);
    com1.Write(b,1);
  end else com1.WriteStr(eTest.Text+endl);
end;

procedure TfTTY.cbDTRClick(Sender: TObject);
begin
  if not com1.Connected then Exit;
  lrDTR.Active := not lrDTR.Active;
  com1.SetDTR(lrDTR.Active);
end;

procedure TfTTY.cbPortDropDown(Sender: TObject);
begin
  EnumComPorts(cbPort.Items);
end;

procedure TfTTY.com1Exception(Sender: TObject; TComException: TComExceptions; ComportMessage: string; WinError: Int64; WinMessage: string);
begin
//  if WinError=5 then MessageBox(handle,'COM port disappeared','COM port error', MB_ICONEXCLAMATION);
end;

procedure TfTTY.Connect;
begin
 if com1.Connected then exit;
 com1.Open;
 com1.SetDTR(lrDTR.Active);
end;

procedure TfTTY.ctTermDblClick(Sender: TObject);
begin
  ctTerm.ClearScreen;
end;

procedure TfTTY.eTestClick(Sender: TObject);
begin
  if (eTest.Text = 'Echo test string') then eTest.Text := '';
end;

procedure TfTTY.eTestKeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then bSendClick(Self);
end;

procedure TfTTY.FormCreate(Sender: TObject);
begin
  Caption := 'RCom v'+RVer.GetVersion;
  ini:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'RCOM.ini');
  com1.Port:=ini.ReadString('COM','Port','COM1');
  com1.BaudRate:=TBaudRate(ini.ReadInteger('COM','Baud',ORD(br115200)));
  Left:=ini.ReadInteger('MainWindow','Left', 10);
  Top:=ini.ReadInteger('MainWindow','Top', 10);
  Height := ini.ReadInteger('MainWindow','Height', Height);
  eTest.Text:=ini.ReadString('Data','Text', 'Echo test string');
  cbCR.Checked:=ini.ReadBool('MainWindow','CR', False);
  cbNL.Checked:=ini.ReadBool('MainWindow','NL', False);
  cbPort.UpdateSettings;
  cbBaudRate.UpdateSettings;
end;

procedure TfTTY.FormDestroy(Sender: TObject);
begin
  if com1.Connected then com1.Close;

  ini.WriteString('COM','Port',com1.Port);
  ini.WriteInteger('COM','Baud',Ord(com1.BaudRate));
  ini.WriteInteger('MainWindow','Left', Left);
  ini.WriteInteger('MainWindow','Top', Top);
  ini.WriteInteger('MainWindow','Height', Height);
  ini.WriteBool('MainWindow','CR', cbCR.Checked);
  ini.WriteBool('MainWindow','NL', cbNL.Checked);
  ini.WriteString('Data','Text', eTest.Text);
  ini.Free;
end;

function TfTTY.isConnected(autoConnect: boolean): boolean;
begin
  Result := com1.Connected;
  if not com1.Connected then begin
    if cbPort.ItemIndex<0 then Exit;
    bConnectClick(self);
    Result := com1.Connected;
  end;
end;

end.
