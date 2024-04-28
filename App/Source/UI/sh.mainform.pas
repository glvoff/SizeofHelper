unit SH.MainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  Generics.Collections,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  Grids;

type
  TMainForm = class(TForm)
    Grid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.frm}

{ ==== TMainForm ============================================================ }

procedure TMainForm.FormCreate(Sender: TObject);
begin

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin

end;

{ =========================================================================== }

end.
