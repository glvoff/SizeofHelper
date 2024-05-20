unit SH.StdTypes;

{$I 'app.inc'}

interface

uses
  SH.Core;

procedure RegisterSizeofInformation(const Collection: TSizeofInfoCollection);

implementation

uses
  Classes, SysUtils;

procedure RegisterSizeofInformation(const Collection: TSizeofInfoCollection);
var
  SB: TSizeofInfoBuilder;
  P: TSizeofInfo;
begin
  SB := TSizeofInfoBuilder.Create();
  try
    P := SB
      .WithTypeName('Integer')
      .WithDescription('This is simple Integer type')
      .WithRange(
        TValueRange.Create(
          Integer.MinValue,
          Integer.MaxValue
        )
      )
      .WithValue(Sizeof(integer))
      .Build();
    Collection.Add(P);
  finally
    FreeAndNil(SB);
  end;
end;

end.

