unit LogUtils;

interface

Type
  ILog = interface
    ['{DB781E2D-D528-4C7C-B46A-4F3FFB1CB508}']
    procedure Debug(const aMessage, aTag: string; aVersaoSistema: string);
    procedure Info(const aMessage, aTag: string; aVersaoSistema: string);
    procedure Warn(const aMessage, aTag: string; aVersaoSistema: string);
    procedure Error(const aMessage, aTag: string; aVersaoSistema: string);
  end;

  TLog = class(TInterfacedObject, ILog)
  private
    function Espacos(const aInput: string; aLength: integer): string;
  public
    constructor Create(aDiretorio: string);
    class function New(aDiretorio: string): ILog;
    procedure Debug(const aMessage, aTag: string; aVersaoSistema: string);
    procedure Info(const aMessage, aTag: string; aVersaoSistema: string);
    procedure Warn(const aMessage, aTag: string; aVersaoSistema: string);
    procedure Error(const aMessage, aTag: string; aVersaoSistema: string);
  end;

implementation

{ TLog }

uses
  System.SysUtils,
  System.StrUtils,
  LoggerPro,
  LoggerPro.FileAppender;

var Log :ILogWriter;

constructor TLog.Create(aDiretorio: string);
begin
  if not Assigned(Log) then
    Log := BuildLogWriter([TLoggerProFileAppender.Create(5, 2000, aDiretorio)], nil, TLogType.Info);
end;

class function TLog.New(aDiretorio: string): ILog;
begin
  Result := TLog.Create(aDiretorio);
end;

procedure TLog.Debug(const aMessage, aTag: string; aVersaoSistema: string);
begin
  Log.Debug('['+Espacos(aTag,30)+'] '+ ReplaceStr(ReplaceStr(aMessage,#$A,''),#$D,''), aVersaoSistema);
end;

procedure TLog.Error(const aMessage, aTag: string; aVersaoSistema: string);
begin
  Log.Error('['+Espacos(aTag,30)+'] '+aMessage, aVersaoSistema);
end;

function TLog.Espacos(const aInput: string; aLength: integer): string;
var
  j, i: integer;
begin
  j := aLength - Length(aInput);
  Result := aInput;
  for i := 1 to j do
    Result := Result + ' ';
end;

procedure TLog.Info(const aMessage, aTag: string; aVersaoSistema: string);
begin
  Log.Info('['+Espacos(aTag,30) +'] '+aMessage, aVersaoSistema);
end;

procedure TLog.Warn(const aMessage, aTag: string; aVersaoSistema: string);
begin
  Log.Warn('['+Espacos(aTag,30) +'] '+aMessage, aVersaoSistema);
end;

end.
