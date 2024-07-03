{******************************************************************************}
{                                                                              }
{                                  RainLohmus                                  }
{                                                                              }
{             Copyright(c) 2024 Pieter Valentijn                               }
{  Github Repository <https://github.com/PieterValentijn/rainlohmus.git>       }
{                                                                              }
{             Distributed under GNU AGPL v3.0 with Commons Clause              }
{                                                                              }
{   This program is free software: you can redistribute it and/or modify       }
{   it under the terms of the GNU Affero General Public License as published   }
{   by the Free Software Foundation, either version 3 of the License, or       }
{   (at your option) any later version.                                        }
{                                                                              }
{   This program is distributed in the hope that it will be useful,            }
{   but WITHOUT ANY WARRANTY; without even the implied warranty of             }
{   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              }
{   GNU Affero General Public License for more details.                        }
{                                                                              }
{   You should have received a copy of the GNU Affero General Public License   }
{   along with this program.  If not, see <https://www.gnu.org/licenses/>      }
{                                                                              }
{******************************************************************************}

unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Samples.Spin, SyncObjs,
  shellapi, System.Threading;

type
  TfmMain = class(TForm)
    bGo: TButton;
    bStop: TButton;
    bShowAccount: TButton;
    pcMain: TPageControl;
    tsLog: TTabSheet;
    tsAbout: TTabSheet;
    mabout: TMemo;
    mlog: TMemo;
    tsSettings: TTabSheet;
    spSleep: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    spThreads: TSpinEdit;
    Label3: TLabel;
    cbAlgo: TComboBox;
    procedure bGoClick(Sender: TObject);
    procedure bStopClick(Sender: TObject);
    procedure bShowAccountClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    DoStop: Boolean;
    TotalLogTimes: int64;
    aTask: ITask;
    procedure RunThread;
    procedure AddLine(aString: String);

  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  web3.eth.types, web3, web3.crypto, web3.utils, web3.eth.crypto;

const
  pubkey1 = '0x2B6eD29A95753C3Ad948348e3e7b1A251080Ffb9';

type
  TPrivateKeyHack = record

  public
    Inner: TBytes32;
    function ToString: string;
    class function Generate: TPrivateKeyHack; static;
    function GetAddress: IResult<TAddress>;
  end;

procedure TfmMain.AddLine(aString: String);
begin
  if mlog.Lines.Count > 1000 then
    mlog.Lines.Clear;
  mlog.Lines.add(aString);
end;

procedure TfmMain.bGoClick(Sender: TObject);
begin
  if fileexists(ChangeFileExt(Application.ExeName, '.YOU_WON_ETH')) then
  begin
    mlog.Lines.LoadFromFile(ChangeFileExt(Application.ExeName, '.YOU_WON_ETH'));
    Exit;
  end;

  tsSettings.Enabled := False;
  TotalLogTimes := 0;
  for var i := 1 to spThreads.Value do
    RunThread;
end;

procedure TfmMain.bStopClick(Sender: TObject);
begin
  DoStop := True;
  sleep(spSleep.Value);
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  DoStop := True;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  pcMain.ActivePageIndex := 0;
end;

procedure TfmMain.RunThread;

begin
  if spSleep.Value < 0 then
    spSleep.Value := 0;

  if spSleep.Value <> 0 then
    self.WindowState := TWindowState.wsMinimized;
  var
  sleepvalue := spSleep.Value;
  var
  Algo := cbAlgo.ItemIndex;
  pcMain.ActivePageIndex := 0;
  mlog.Clear;
  bGo.Enabled := False;
  bStop.Enabled := True;

  Application.ProcessMessages;
  DoStop := False;

  aTask := TTask.Create(
    procedure
    begin
      var
      totaltry := 0;
      var
      aMessage := '';
      var
        pr: TPrivateKeyHack;
      pr := TPrivateKeyHack.Generate;
      while True do
      begin
        aMessage := '';
        if not DoStop then
          sleep(sleepvalue);
        if Algo = 0 then
        begin
          pr := TPrivateKeyHack.Generate;
        end
        else if Algo = 1 then
        begin
          var
          rnd := random(32);
          pr.Inner[rnd] := (pr.Inner[rnd] + 1) mod 256;
        end;
        inc(totaltry);
        if pr.GetAddress.Value.SameAs(pubkey1) then
        begin
          var
          thelist := TStringList.Create();
          thelist.Text := pr.ToString;
          thelist.add('If you dont know what to do next contact me pvalentijn@delphidreams.nl');
          thelist.SaveToFile(ChangeFileExt(Application.ExeName, '.YOU_WON_ETH'));
          thelist.free;
          aMessage := ('You won a lot of ETH use the Private key to access the ETH');
          aMessage := aMessage + #13#10 + pr.ToString + #13#10 +
            'If you dont know what to do next contact me pvalentijn@delphidreams.nl';
          DoStop := True;
        end
        else
        begin
          var
          LogTimes := 1000;
          if sleepvalue > 10 then
            LogTimes := 100;
          if sleepvalue > 200 then
            LogTimes := 10;
          if (totaltry mod LogTimes) = 0 then
          begin
            TotalLogTimes := TotalLogTimes + totaltry;
            totaltry := 0;
            aMessage := ('Tryed ' + TotalLogTimes.ToString + ' times');
          end;
        end;

        TThread.Synchronize(TThread.Current,
          procedure
          begin
            if DoStop then
            begin
              self.WindowState := TWindowState.wsMaximized;
              TotalLogTimes := TotalLogTimes + totaltry;
              aMessage := ('Stopped trying ' + TotalLogTimes.ToString + ' times');
              bGo.Enabled := True;
              bStop.Enabled := False;
              tsSettings.Enabled := True;
            end;
            if aMessage <> '' then

              AddLine(aMessage);
          end);
        if DoStop then
          break;

      end;
    end);
  aTask.Start;
end;

procedure TfmMain.bShowAccountClick(Sender: TObject);
begin
  var
  aString := 'https://etherscan.io/address/0x2b6ed29a95753c3ad948348e3e7b1a251080ffb9';
  ShellExecute(self.Handle, 'OPEN', pchar(aString), '', '', 1);

end;

{ TPrivateKeyHack }

class function TPrivateKeyHack.Generate: TPrivateKeyHack;
begin
  const
    key = TPrivateKey(web3.crypto.generatePrivateKey('ECDSA', SECP256K1));
  const
    bytes = web3.utils.fromHex(key.ToString);
  Result.Inner := byteArrayToBytes32(bytes);
end;

function TPrivateKeyHack.GetAddress: IResult<TAddress>;
begin
  try
    const
      key = TPrivateKey(web3.utils.toHex('', bytes32ToByteArray(self.Inner)));

    Result := TResult<TAddress>.Ok(web3.eth.crypto.publicKeyToAddress(web3.crypto.publicKeyFromPrivateKey(key)));
  except
    Result := TResult<TAddress>.Err(TAddress.Zero, 'Private key is invalid');
  end;
end;

function TPrivateKeyHack.ToString: string;
begin
  Result := web3.utils.toHex('', bytes32ToByteArray(self.Inner));
end;

end.
