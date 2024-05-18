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
    procedure FillGridTitle;
    procedure FillGrid;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.frm}

{ =========================================================================== }

function IsEscape(const InCode: Word): Boolean;
begin
  Result := InCode = 27;
end;

function CalcWidth(const InText: string): Integer;
begin
  Result := Length(InText) * 8;
end;

procedure SetCellAt(const Grid: TStringGrid; const InPosition: Integer; const InText: string);
begin
  Grid.Cells[InPosition, 0] := InText;
  Grid.ColWidths[InPosition] := CalcWidth(InText);
end;

{ ==== TMainForm ============================================================ }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FillGridTitle();
  FillGrid();
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  if IsEscape(Key) then
    Close();
end;

procedure TMainForm.FillGridTitle;
begin
  Grid.ColCount := 4;
  SetCellAt(Grid, 0, 'Тип данных');
  SetCellAt(Grid, 1, 'Размер');
  SetCellAt(Grid, 2, 'Описание');
  SetCellAt(Grid, 3, 'Граничные значения (если есть)');
end;

procedure TMainForm.FillGrid;
var
  Items: TSizeofInfoCollection;
  SB: TSizeofInfoBuilder;
  P: TSizeofInfo;
  I: Integer;
begin
  Items := TSizeofInfoCollection.Create;
  Items.Capacity := 0;
  Items.Count :=0;
  SB := TSizeofInfoBuilder.Create();
  try
    P := SB.WithTypeName('Integer')
      .WithDescription('This is simple Integer type')
      .WithRange(TValueRange.Create(0,0))
      .WithValue(Sizeof(Integer))
      .Build();
    Items.Add(P);

    Grid.RowCount := Items.Count + 1;
    for I := 1 to Items.Count do
    begin
      Grid.Cells[0, I] := P.TypeName;
      Grid.Cells[1, I] := '<todo>';
      Grid.Cells[2, I] := '<todo>';
      Grid.Cells[3, I] := '<todo>';
    end;
  finally
    FreeAndNil(SB);
    FreeAndNil(Items);
  end;
end;

{ =========================================================================== }

end.
