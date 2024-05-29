unit SH.ViewModel;

{$I 'app.inc'}

interface

uses
  SH.Core;

type
  TTitle = packed record
    Caption: string;
    Width: Integer;
    constructor Create(const Caption: string; const Width: Integer);
  end;

  TTitles = TArray<TTitle>;

  TOnUpdate = reference to procedure(const Titles: TTitles; const Items: TSizeofInfoCollection);

  TViewModel = class abstract(TInterfacedObject)
  public
    procedure Update; virtual; abstract;
  end;

implementation

constructor TTitle.Create(const Caption: string; const Width: Integer);
begin
  Self.Caption := Caption;
  Self.Width := Width;
end;

end.
