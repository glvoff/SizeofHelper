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
  SH.Core;

type
  TMainForm = class(TForm)
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  strict private
    FInfos: TSizeofInfoCollection;
    procedure FillGrid;
    procedure InitializeGrid;
    procedure RenderTitle;
    procedure RenderSizeofInfos;
    procedure RenderSizeofInfoAt(const Info: TSizeofInfo; const Index: integer);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.frm}

uses
  SH.StdTypes;

{ =========================================================================== }

function IsEscape(const InCode: word): boolean;
begin
  Result := InCode = 27;
end;

function CalcWidth(const InText: string): integer;
begin
  Result := Length(InText)*8;
end;

procedure SetCellAt(const Grid: TStringGrid; const InPosition: integer; const InText: string);
begin
  Grid.Cells[InPosition, 0]  := InText;
  Grid.ColWidths[InPosition] := CalcWidth(InText);
end;

{ ==== TMainForm ============================================================ }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FInfos := TSizeofInfoCollection.Create();
  SH.StdTypes.RegisterSizeofInformation(FInfos);
  FillGrid();
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FInfos);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if IsEscape(Key) then
    Close();
end;

procedure TMainForm.FillGrid;
begin
  InitializeGrid;
  RenderTitle;
  RenderSizeofInfos;
end;

procedure TMainForm.InitializeGrid;
begin
  Grid.ColCount := 4;
  Grid.RowCount := FInfos.Count+1;
end;

procedure TMainForm.RenderTitle;
begin
  SetCellAt(Grid, 0, 'Тип данных');
  SetCellAt(Grid, 1, 'Размер');
  SetCellAt(Grid, 2, 'Описание');
  SetCellAt(Grid, 3, 'Граничные значения (если есть)');
end;

procedure TMainForm.RenderSizeofInfos;
var
  Index: integer;
begin
  for Index := 1 to FInfos.Count do
    RenderSizeofInfoAt(FInfos[Index-1], Index);
end;

procedure TMainForm.RenderSizeofInfoAt(const Info: TSizeofInfo; const Index: integer);
begin
  Grid.Cells[0, Index] := Info.TypeName;
  Grid.Cells[1, Index] := Info.Value.ToString();
  Grid.Cells[2, Index] := Info.Range.ToString();
  Grid.Cells[3, Index] := Info.Description;
end;

{ =========================================================================== }

end.
