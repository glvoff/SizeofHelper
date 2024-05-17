unit SH.Core;

{$I 'app.inc'}

interface

uses
  Generics.Collections;

type
  TValueRange = packed record
    Minimal: integer;
    Maximal: integer;
    constructor Create(const InMinimal: integer; const InMaximal: integer);
  end;

  PSizeofInfo = ^TSizeofInfo;

  TSizeofInfo = packed record
    TypeName: WideString;
    Description: WideString;
    Value: integer;
    Range: TValueRange;
    constructor Create(const InTypename: WideString; const InDescription: WideString; const InValue: integer; const InRange: TValueRange);
  end;

  TSizeofInfoCollection = specialize TList<PSizeofInfo>;

  TSizeInfoBuilder = class
  strict private
    FBufferInfo: TSizeofInfo;
  public
    constructor Create;
    destructor Destroy; override;
    function Build: PSizeofInfo;
    function WithTypeName(const InTypeName: WideString): TSizeInfoBuilder;
    function WithDescription(const Description: WideString): TSizeInfoBuilder;
    function WithValue(const Value: integer): TSizeInfoBuilder;
    function WithRange(const Range: TValueRange): TSizeInfoBuilder;
  end;

implementation

constructor TValueRange.Create(const InMinimal: integer; const InMaximal: integer);
begin
  Self.Minimal := InMinimal;
  Self.Maximal := InMaximal;
end;

constructor TSizeofInfo.Create(const InTypename: WideString; const InDescription: WideString; const InValue: integer; const InRange: TValueRange);
begin
  Self.TypeName := InTypeName;
  Self.Description := InDescription;
  Self.Value := InValue;
  Self.Range := InRange;
end;

constructor TSizeInfoBuilder.Create;
begin
  inherited Create;
  FBufferInfo := TSizeofInfo.Create('', '', 0, TValueRange.Create(0, 0));
end;

destructor TSizeInfoBuilder.Destroy;
begin
  inherited Destroy;
end;

function TSizeInfoBuilder.Build: PSizeofInfo;
begin
  New(Result);
  Result^.Description := FBufferInfo.Description;
  Result^.TypeName := FBufferInfo.TypeName;
  Result^.Value := FBufferInfo.Value;
  Result^.Range := FBufferInfo.Range;
end;

function TSizeInfoBuilder.WithTypeName(const InTypeName: WideString): TSizeInfoBuilder;
begin
  FBufferInfo.TypeName := InTypeName;
  Result := Self;
end;

function TSizeInfoBuilder.WithDescription(const Description: WideString): TSizeInfoBuilder;
begin
  FBufferInfo.Description := Description;
  Result := Self;
end;

function TSizeInfoBuilder.WithValue(const Value: integer): TSizeInfoBuilder;
begin
  FBufferInfo.Value := Value;
  Result := Self;
end;

function TSizeInfoBuilder.WithRange(const Range: TValueRange): TSizeInfoBuilder;
begin
  FBufferInfo.Range := Range;
  Result := Self;
end;

end.
