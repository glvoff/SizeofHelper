unit GLV.Logging.Ifaces;

{$IFDEF FPC}
{$MODE DELPHI}{$H+}
{$ENDIF FPC}

interface

type
  ILogging = interface
    ['{0E408B92-3C6D-4447-B00D-8E6615BD7FC4}']
    procedure Info(const Text: UnicodeString);
  end;

implementation

end.

