unit SH.ViewModel;

{$I 'app.inc'}

interface

uses
  SH.Core;

type
  TTitles = TArray<string>;

  TOnUpdate = reference to procedure(const Titles: TTitles; const Items: TSizeofInfoCollection);

  TViewModel = class abstract(TInterfacedObject)
  public
    procedure Update; virtual; abstract;
  end;

implementation

end.
