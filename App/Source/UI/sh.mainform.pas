unit SH.MainForm;

{$I 'app.inc'}

interface

uses
  Classes,
  SysUtils,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  Grids,
  SH.Core,
  SH.ViewModel;

type
  TMainForm = class(TForm)
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  strict private
    FModel: TViewModel;
    procedure OnUpdate(const Titles: TTitles; const Items: TSizeofInfoCollection);
    procedure InitializeGrid(const Count: integer);
    procedure RenderTitle(const Titles: TTitles);
    procedure RenderSizeofInfos(const Infos: TSizeofInfoCollection);
    procedure RenderSizeofInfoAt(var Info: TSizeofInfo; const Index: integer);
  end;

  TStringGridHelper = class helper for TStringGrid
  strict private
    function GetSmartCell(const Column, Row: integer): string;
    procedure SetSmartCell(const Column, Row: integer; const Value: string);
  public
    property SmartCell[const Column, Row: integer]: string read GetSmartCell write SetSmartCell;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.frm}

uses
  SH.MainViewModel;

{ ==== FUNCTION'S =========================================================== }

function IsEscape(const InCode: word): boolean;
begin
  Result := InCode = 27;
end;

function GetCellWidth(const InText: string): integer;
begin
  Result := Length(InText)*8;
end;

{ ==== TMainForm ============================================================ }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FModel := TMainViewModel.Create(OnUpdate);
  FModel.Update();
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FModel);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if IsEscape(Key) then
    Close();
end;

procedure TMainForm.OnUpdate(const Titles: TTitles; const Items: TSizeofInfoCollection);
begin
  Grid.BeginUpdate();
  try
    InitializeGrid(Items.Count);
    RenderTitle(Titles);
    RenderSizeofInfos(Items);
  finally
    Grid.EndUpdate();
  end;
end;

procedure TMainForm.InitializeGrid(const Count: integer);
begin
  Grid.ColCount := 4;
  Grid.RowCount := Count + 1;
end;

procedure TMainForm.RenderTitle(const Titles: TTitles);
var
  I: integer;
begin
  for I := 0 to Length(Titles) - 1 do
  begin
    Grid.Cells[I, 0] := Titles[I].Caption;
    Grid.ColWidths[I] := Titles[I].Width;
  end;
end;

procedure TMainForm.RenderSizeofInfos(const Infos: TSizeofInfoCollection);
var
  Index: integer;
  Rec: TSizeofInfo;
begin
  for Index := 0 to Infos.Count - 1 do
  begin
    Rec := Infos[Index];
    RenderSizeofInfoAt(Rec, Index + 1);
  end;
end;

procedure TMainForm.RenderSizeofInfoAt(var Info: TSizeofInfo; const Index: integer);
begin
  Grid.SmartCell[0, Index] := Info.TypeName;
  Grid.SmartCell[1, Index] := Info.Value.ToString();
  Grid.SmartCell[2, Index] := Info.Range.ToString();
  Grid.SmartCell[3, Index] := Info.Description;
end;

{ ==== TStringGridHelper ==================================================== }

function TStringGridHelper.GetSmartCell(const Column, Row: integer): string;
begin
  Result := Cells[Column, Row];
end;

procedure TStringGridHelper.SetSmartCell(const Column, Row: integer; const Value: string);
var
  TmpLen: integer;
begin
  Cells[Column, Row] := Value;
  TmpLen := GetCellWidth(Value);
  if TmpLen>ColWidths[Column] then
    ColWidths[Column] := TmpLen;
end;

{ =========================================================================== }

end.
