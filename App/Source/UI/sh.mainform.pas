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
  TTItles = specialize TArray<string>;

  TOnUpdate = reference to procedure;

  TMainViewModel = class(TInterfacedObject)
  strict private
    FInfos: TSizeofInfoCollection;
    FOnUpdate: TOnUpdate;
    function GetTitles: TTitles;
    function GetInfos(const Index: Integer): TSizeofInfo;
    function GetInfosCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Update;
    property Titles: TTitles read GetTitles;
    property OnUpdate: TOnUpdate read FOnUpdate write FOnUpdate;
    property InfosCount: Integer read GetInfosCount;
    property Infos[const Index: Integer]: TSizeofInfo read GetInfos;
  end;

  TMainForm = class(TForm)
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
  strict private
    FModel: TMainViewModel;
    procedure FillGrid;
    procedure InitializeGrid;
    procedure OnUpdate;
    procedure RenderTitle;
    procedure RenderSizeofInfos;
    procedure RenderSizeofInfoAt(var Info: TSizeofInfo; const Index: integer);
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

procedure SetCellAt(const Grid: TStringGrid; const InColumn: integer; const InText: string);
var
  TmpLen: Integer;
begin
  Grid.Cells[InColumn, 0] := InText;
  TmpLen := CalcWidth(InText);
  if TmpLen > Grid.ColWidths[InColumn] then
    Grid.ColWidths[InColumn] := TmpLen;
end;

procedure SetCellAt(const Grid: TStringGrid; const InColumn, InPosition: integer; const InText: string);
var
  TmpLen: Integer;
begin
  Grid.Cells[InColumn, InPosition] := InText;
  TmpLen := CalcWidth(InText);
  if TmpLen > Grid.ColWidths[InColumn] then
    Grid.ColWidths[InColumn] := CalcWidth(InText);
end;

{ ==== TMainViewModel======================================================== }

function TMainViewModel.GetTitles: TTitles;
begin
  Result := ['Тип данных', 'Размер', 'Описание', 'Граничные значения (если есть)'];
end;

function TMainViewModel.GetInfos(const Index: Integer): TSizeofInfo;
begin
  Result := FInfos[Index];
end;

function TMainViewModel.GetInfosCount: Integer;
begin
  Result := FInfos.Count;
end;

constructor TMainViewModel.Create;
begin
  inherited Create;
  FInfos := TSizeofInfoCollection.Create();
  FOnUpdate := nil;
end;

destructor TMainViewModel.Destroy;
begin
  FOnUpdate := nil;
  FreeAndNil(FInfos);
  inherited Destroy;
end;

procedure TMainViewModel.Update;
begin
  SH.StdTypes.RegisterSizeofInformation(FInfos);
  if Assigned(FOnUpdate) then
    FOnUpdate();
end;

{ ==== TMainForm ============================================================ }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FModel := TMainViewModel.Create;
  Fmodel.OnUpdate := @OnUpdate;
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

procedure TMainForm.FillGrid;
begin
  InitializeGrid;
  RenderTitle;
  RenderSizeofInfos;
end;

procedure TMainForm.InitializeGrid;
begin
  Grid.ColCount := 4;
  Grid.RowCount := FModel.InfosCount + 1;
end;

procedure TMainForm.OnUpdate;
begin
  FillGrid;
end;

procedure TMainForm.RenderTitle;
var
  Titles: TTitles;
  I: integer;
begin
  Titles := FModel.Titles;
  for I := 0 to Length(Titles)-1 do
    SetCellAt(Grid, I, Titles[I]);
end;

procedure TMainForm.RenderSizeofInfos;
var
  Index: integer;
  rec: TSizeofInfo;
begin
  for Index := 0 to FModel.InfosCount - 1 do
  begin
    rec := FModel.Infos[Index];
    RenderSizeofInfoAt(Rec, Index + 1);
  end;
end;

procedure TMainForm.RenderSizeofInfoAt(var Info: TSizeofInfo; const Index: integer);
begin
  SetCellAt(Grid, 0, Index, Info.TypeName);
  SetCellAt(Grid, 1, Index, Info.Value.ToString());
  SetCellAt(Grid, 2, Index, Info.Range.ToString());
  SetCellAt(Grid, 3, Index, Info.Description);
end;

{ =========================================================================== }

end.
