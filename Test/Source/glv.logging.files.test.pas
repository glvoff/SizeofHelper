unit GLV.Logging.Files.Test;

{$I 'test.inc'}

interface

uses
  Classes,
  SysUtils,
  fpcunit,
  testutils,
  testregistry;

type
  TStreamLoggingTest = class(TTEstCase)
  published
    procedure TestLoggingWithStringStreamWorksFine;
    procedure TestLoggingWithFileStream;
  end;

implementation

uses
  FileUtil,
  Glv.Logging.Ifaces,
  Glv.Logging.Files;

{ =========================================================================== }

function GetTestingStreamFilepath: UnicodeString;
begin
  Result := UTF8Decode(ExtractFilePath(ParamStr(0)) + 'test.log');
end;

procedure DeleteFileIfExists(const Path: UnicodeString);
begin
  if FileExists(Path) then
    DeleteFile(Path);
end;

{ =========================================================================== }

procedure TStreamLoggingTest.TestLoggingWithStringStreamWorksFine;
var
  Logging: TLogging;
  Stream: TStream;
begin
  Stream := TStringStream.Create('');
  Logging := TLogging.Create(Stream);
  try
    Logging.Info('work');
    // Откатываетмся в Stream на его
    // начало чтобы правильно прочитать.
    Stream.Seek(0, TSeekOrigin.soBeginning);
    AssertEquals('Try Work: Logging', 'work', Stream.ReadUnicodeString);
  finally
    // Stream умрет внутри Logging
    FreeAndNil(Logging);
  end;
end;

procedure TStreamLoggingTest.TestLoggingWithFileStream;
var
  Logging: TLogging;
  Stream: TStream;
  Filepath: UnicodeString;
begin
  Filepath := GetTestingStreamFilepath();
  Stream := TFileStream.Create(UTF8Encode(Filepath), fmCreate or fmOpenReadWrite);
  Logging := TLogging.Create(Stream);
  try
    Logging.Info('help');
    Stream.Seek(0, TSeekOrigin.soBeginning);
    AssertEquals('FileStream logging: Expected text not match!', Stream.ReadUnicodeString, 'help');
  finally
    DeleteFileIfExists(Filepath);
    FreeAndNil(Logging);
  end;
end;

{ =========================================================================== }

initialization
  RegisterTest(TStreamLoggingTest);
end.
