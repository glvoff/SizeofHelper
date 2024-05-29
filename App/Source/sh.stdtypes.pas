unit SH.StdTypes;

{$I 'app.inc'}

interface

uses
  SH.Core;

procedure RegisterSizeofInformation(const Collection: TSizeofInfoCollection);

implementation

uses
  Classes,
  SysUtils;

function InfoByte: TSizeofInfo; forward;
function InfoInteger: TSizeofInfo; forward;
function InfoWord: TSizeofInfo; forward;
function InfoLongInt: TSizeofInfo; forward;

function InfoCardinal: TSizeofInfo; forward;

function InfoString: TSizeofInfo; forward;
function InfoUnicodeString: TSizeofInfo; forward;
function InfoWideString: TSizeofInfo; forward;

procedure RegisterSizeofInformation(const Collection: TSizeofInfoCollection);
begin
  Collection.Add(InfoByte());
  Collection.Add(InfoWord());
  Collection.Add(InfoInteger());
  Collection.Add(InfoLongInt());
  //
  Collection.Add(InfoCardinal());
  // Строковые типы данных - размер указателя - платформозависимое
  Collection.Add(InfoString());
  Collection.Add(InfoUnicodeString());
  Collection.Add(InfoWideString());
end;

function InfoByte: TSizeofInfo;
begin
  Result.TypeName := 'Word';
  Result.Description := 'Целочисленный тип';
  Result.Value := Sizeof(word);
  Result.Range.Minimal := word.MinValue;
  Result.Range.Maximal := word.MaxValue;
end;

function InfoInteger: TSizeofInfo;
begin
  Result.TypeName := 'Integer';
  Result.Description := 'Целочисленный тип';
  Result.Value := Sizeof(integer);
  Result.Range.Minimal := integer.MinValue;
  Result.Range.Maximal := integer.MaxValue;
end;

function InfoWord: TSizeofInfo;
begin
  Result.TypeName := 'Word';
  Result.Description := 'Целочисленный тип';
  Result.Value := Sizeof(word);
  Result.Range.Minimal := word.MinValue;
  Result.Range.Maximal := word.MaxValue;
end;

function InfoLongInt: TSizeofInfo;
begin
  Result.TypeName := 'LongInt';
  Result.Description := 'Целочисленный тип';
  Result.Value := Sizeof(longint);
  Result.Range.Minimal := longint.MinValue;
  Result.Range.Maximal := longint.MaxValue;
end;

function InfoCardinal: TSizeofInfo;
begin
  Result.TypeName := 'Cardinal';
  Result.Description := 'Целочисленный тип';
  Result.Value := Sizeof(Cardinal);
  Result.Range.Minimal := Cardinal.MinValue;
  Result.Range.Maximal := Cardinal.MaxValue;
end;

function InfoString: TSizeofInfo;
begin
  Result.TypeName := 'string';
  Result.Description := 'Строковый тип - стандартный';
  Result.Value := Sizeof(string);
  Result.Range.Minimal := 0;
  Result.Range.Maximal := 0;
end;

function InfoUnicodeString: TSizeofInfo;
begin
  Result.TypeName := 'UnicodeString';
  Result.Description := 'Строковый тип - широкий';
  Result.Value := Sizeof(UnicodeString);
  Result.Range.Minimal := 0;
  Result.Range.Maximal := 0;
end;

function InfoWideString: TSizeofInfo;
begin
  Result.TypeName := 'WideString';
  Result.Description := 'Строковый тип - широкий';
  Result.Value := Sizeof(WideString);
  Result.Range.Minimal := 0;
  Result.Range.Maximal := 0;
end;

end.
