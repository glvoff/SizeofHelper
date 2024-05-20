unit SH.Core.Test;

{$I 'test.inc'}

interface

uses
  Classes,
  SysUtils,
  fpcunit,
  testutils,
  testregistry,
  SH.Core;

type
  TSizeofInfoBuilderTest = class(TTestCase)
  published
    procedure TestBuild;
  end;

  TSizeofInfoTest = class(TTestCase)
  published
    procedure TestConstruction;
    procedure TestCopyConstructor;
  end;

  TValueRangeTest = class(TTestCase)
  published
    procedure TestToString;
    procedure TestToStringWithLimits;
  end;

implementation

{ ==== TSizeofInfoBuilderTest =============================================== }

procedure TSizeofInfoBuilderTest.TestBuild;
var
  P: TSizeofInfo;
  B: TSizeofInfoBuilder;
begin
  B := TSizeofInfoBuilder.Create;
  try
    P := B.WithTypeName('typename').WithDescription('description').WithRange(TValueRange.Create(1, 10)).WithValue(228).Build();
    AssertEquals('typename', P.TypeName);
    AssertEquals('description', P.Description);
    AssertEquals(228, P.Value);
    AssertEquals(10, P.Range.Maximal);
    AssertEquals(1, P.Range.Minimal);
  finally
    FreeAndNil(B);
  end;
end;

{ ==== TSizeofInfoTest ====================================================== }

procedure TSizeofInfoTest.TestConstruction;
var
  S: TSizeofInfo;
begin
  S := TSizeofInfo.Create('a', 'b', 2, TValueRange.Create(3, 4));
  AssertEquals(3, S.Range.Minimal);
  AssertEquals(4, S.Range.Maximal);
end;

procedure TSizeofInfoTest.TestCopyConstructor;
var
  S, C: TSizeofInfo;
begin
  S := TSizeofInfo.Create('a', 'b', 2, TValueRange.Create(3, 4));
  C := TSizeofInfo.Create(S);
  AssertEquals('a', C.TypeName);
  AssertEquals('b', C.Description);
  AssertEquals(2, C.Value);
  AssertEquals(3, C.Range.Minimal);
  AssertEquals(4, C.Range.Maximal);
end;

{ ==== TValueRangeTest ===================================================== }

procedure TValueRangeTest.TestToString;
begin
  AssertEquals('1 .. 2', TValueRange.Create(1, 2).ToString());
end;

procedure TValueRangeTest.TestToStringWithLimits;
begin
  AssertEquals('-2147483648 .. 2147483647', TValueRange.Create(Integer.MinValue, Integer.MaxValue).ToString());
end;

{ =========================================================================== }

initialization
  RegisterTest(TSizeofInfoBuilderTest);
  RegisterTest(TSizeofInfoTest);
  RegisterTest(TValueRangeTest);
end.
