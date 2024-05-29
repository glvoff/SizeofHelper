unit SH.Core;

{$I 'app.inc'}

interface

uses
  Generics.Collections;

type
  TValueRange = packed record
    Minimal: LongInt;
    Maximal: LongWord;
    constructor Create(const InMinimal, InMaximal: LongInt);
    function ToString: string;
  end;

  PSizeofInfo = ^TSizeofInfo;

  TSizeofInfo = packed record
    TypeName: string;
    Description: string;
    Value: LongInt;
    Range: TValueRange;
    constructor Create(const InTypename, InDescription: string; const InValue: integer; const InRange: TValueRange); overload;
    constructor Create(const Source: TSizeofInfo); overload;
  end;

  TSizeofInfoCollection = TList<TSizeofInfo>;

implementation

uses
  SysUtils;

constructor TValueRange.Create(const InMinimal, InMaximal: LongInt);
begin
  Self.Minimal := InMinimal;
  Self.Maximal := InMaximal;
end;

function TValueRange.ToString: string;
begin
  if (Minimal = Maximal) and (Minimal = 0) then
    Result := 'Nothing'
  else
    Result := Format('%d .. %d', [Minimal, Maximal]);
end;

constructor TSizeofInfo.Create(const InTypename, InDescription: string; const InValue: LongInt; const InRange: TValueRange);
begin
  Self.TypeName := InTypeName;
  Self.Description := InDescription;
  Self.Value := InValue;
  Self.Range := InRange;
end;

constructor TSizeofInfo.Create(const Source: TSizeofInfo);
begin
  Self.TypeName := Source.TypeName;
  Self.Description := Source.Description;
  Self.Value := Source.Value;
  Self.Range := Source.Range;
end;

end.
