unit SH.MainViewModel;

{$I 'app.inc'}

interface

uses
  Classes,
  SysUtils,
  SH.Core,
  SH.ViewModel;

type

  TMainViewModel = class(TViewModel)
  strict private
    FInfos: TSizeofInfoCollection;
    FOnUpdate: TOnUpdate;
    function GetTitles: TTitles;
    function GetInfos(const Index: integer): TSizeofInfo;
    function GetInfosCount: integer;
    function GetInfosItems: TSizeofInfoCollection;
    procedure SetOnUpdate(const Value: TOnUpdate);
  public
    constructor Create(const OnUpdate: TOnUpdate);
    destructor Destroy; override;
    procedure Update; override;
    property Titles: TTitles read GetTitles;
    property OnUpdate: TOnUpdate read FOnUpdate write FOnUpdate;
    property InfosCount: integer read GetInfosCount;
    property Infos[const Index: integer]: TSizeofInfo read GetInfos;
    property InfosItems: TSizeofInfoCollection read GetInfosItems;
  end;

implementation

uses
  SH.StdTypes;

{ ==== TMainViewModel======================================================== }

function TMainViewModel.GetTitles: TTitles;
begin
  Result := ['Тип данных', 'Размер', 'Описание', 'Граничные значения (если есть)'];
end;

function TMainViewModel.GetInfos(const Index: integer): TSizeofInfo;
begin
  Result := FInfos[Index];
end;

function TMainViewModel.GetInfosCount: integer;
begin
  Result := FInfos.Count;
end;

function TMainViewModel.GetInfosItems: TSizeofInfoCollection;
begin
  Result := FInfos;
end;

procedure TMainViewModel.SetOnUpdate(const Value: TOnUpdate);
begin
  if @FOnUpdate <> @Value then
    FOnUpdate := Value;
end;

constructor TMainViewModel.Create(const OnUpdate: TOnUpdate);
begin
  inherited Create;
  FInfos    := TSizeofInfoCollection.Create();
  FOnUpdate := OnUpdate;
end;

destructor TMainViewModel.Destroy;
begin
  FOnUpdate := nil;
  FreeAndNil(FInfos);
  inherited Destroy;
end;

procedure TMainViewModel.Update;
begin
  FInfos.Clear();
  SH.StdTypes.RegisterSizeofInformation(FInfos);
  if Assigned(FOnUpdate) then
    FOnUpdate(Titles, Finfos);
end;

{ =========================================================================== }

end.
