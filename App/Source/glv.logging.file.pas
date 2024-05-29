unit GLV.Logging.Files;

{$IFDEF FPC}
{$MODE DELPHI}{$H+}
{$ENDIF FPC}

interface

uses
  GLV.Logging.Ifaces;

type
  TLogging = class(TInterfacedObject, ILogging)
  public
    procedure Info(const Text: WideString);
  end;

implementation

uses
  IOUtils;

procedure TLogging.Info(const Text: WideString);
begin

end;

end.

