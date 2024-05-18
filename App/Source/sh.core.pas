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
    constructor Create(const Source: TSizeofInfo);
  end;

  TSizeofInfoCollection = specialize TList<TSizeofInfo>;

  TSizeofInfoBuilder = class
  strict private
    FBufferInfo: TSizeofInfo;
  public
    constructor Create;
    destructor Destroy; override;
    function Build: TSizeofInfo;
    function WithTypeName(const InTypeName: WideString): TSizeofInfoBuilder;
    function WithDescription(const Description: WideString): TSizeofInfoBuilder;
    function WithValue(const Value: integer): TSizeofInfoBuilder;
    function WithRange(const Range: TValueRange): TSizeofInfoBuilder;
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

constructor TSizeofInfo.Create(const Source: TSizeofInfo);
begin
  Self.TypeName := Source.TypeName;
  Self.Description := Source.Description;
  Self.Value := Source.Value;
  Self.Range := Source.Range;
end;

constructor TSizeofInfoBuilder.Create;
begin
  inherited Create;
  FBufferInfo := TSizeofInfo.Create('', '', 0, TValueRange.Create(0, 0));
end;

destructor TSizeofInfoBuilder.Destroy;
begin
  inherited Destroy;
end;

function TSizeofInfoBuilder.Build: TSizeofInfo;
begin
  Result := TSizeofInfo.Create(FBufferInfo);
end;

function TSizeofInfoBuilder.WithTypeName(const InTypeName: WideString): TSizeofInfoBuilder;
begin
  FBufferInfo.TypeName := InTypeName;
  Result := Self;
end;

function TSizeofInfoBuilder.WithDescription(const Description: WideString): TSizeofInfoBuilder;
begin
  FBufferInfo.Description := Description;
  Result := Self;
end;

function TSizeofInfoBuilder.WithValue(const Value: integer): TSizeofInfoBuilder;
begin
  FBufferInfo.Value := Value;
  Result := Self;
end;

function TSizeofInfoBuilder.WithRange(const Range: TValueRange): TSizeofInfoBuilder;
begin
  FBufferInfo.Range := Range;
  Result := Self;
end;

end.
