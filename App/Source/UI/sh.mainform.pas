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
begin

end;

{ =========================================================================== }

end.
