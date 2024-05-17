object MainForm: TMainForm
  Left = 0
  Height = 367
  Top = 0
  Width = 630
  Caption = 'MainForm'
  ClientHeight = 367
  ClientWidth = 630
  DesignTimePPI = 192
  KeyPreview = True
  LCLVersion = '8.3'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  object Grid: TStringGrid
    Left = 0
    Height = 367
    Top = 0
    Width = 630
    Align = alClient
    FixedCols = 0
    TabOrder = 0
  end
end
