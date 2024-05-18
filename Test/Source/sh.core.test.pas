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
    procedure TestCopyConstructor;
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
    P := B.WithTypeName('typename')
      .WithDescription('description')
      .WithRange(TValueRange.Create(1, 10))
      .WithValue(228)
      .Build();
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

{ ==== TSizeofInfoTest ====================================================== }

initialization
  RegisterTest(TSizeofInfoBuilderTest);
  RegisterTest(TSizeofInfoTest);
end.
