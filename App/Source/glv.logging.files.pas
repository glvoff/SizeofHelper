unit GLV.Logging.Files;

{$IFDEF FPC}
{$MODE DELPHI}{$H+}
{$ENDIF FPC}

interface

uses
  Classes,
  GLV.Logging.Ifaces;

type
  IOpenClose = interface
    ['{B8B0F173-263D-4515-8BC3-40E00466EE0E}']
    procedure Open;
    procedure Close;
  end;

  TLogging = class(TInterfacedObject, ILogging)
  strict private
    FStream: TStream;
  public
    constructor Create(const Stream: TStream);
    destructor Destroy; override;
    procedure Info(const Text: UnicodeString); virtual;
  end;

implementation

uses
  SysUtils;

constructor TLogging.Create(const Stream: TStream);
begin
  inherited Create;
  FStream   := Stream;
end;

destructor TLogging.Destroy;
begin
  FreeAndNil(FStream);
  inherited Destroy;
end;

procedure TLogging.Info(const Text: UnicodeString);
begin
  FStream.WriteUnicodeString(Text);
end;

end.
