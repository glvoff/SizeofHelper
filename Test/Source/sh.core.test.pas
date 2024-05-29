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
  TSizeofInfoTest = class(TTestCase)
  published
    procedure TestConstruction;
    procedure TestCopyConstructor;
  end;

  TValueRangeTest = class(TTestCase)
  published
    procedure TestToString;
    procedure TestToStringWithLimits;
    procedure TestWhenHasAllZeroesWeReturnNothingText;
  end;

implementation

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

procedure TValueRangeTest.TestWhenHasAllZeroesWeReturnNothingText;
begin
  AssertEquals('Nothing', TValueRange.Create(0, 0).ToString());
end;

{ =========================================================================== }

initialization
  RegisterTest(TSizeofInfoTest);
  RegisterTest(TValueRangeTest);
end.
