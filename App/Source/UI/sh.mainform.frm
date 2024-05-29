object MainForm: TMainForm
  Left = 0
  Height = 900
  Top = 0
  Width = 1209
  Caption = 'MainForm'
  ClientHeight = 900
  ClientWidth = 1209
  DesignTimePPI = 192
  KeyPreview = True
  LCLVersion = '8.3'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  object Grid: TStringGrid
    Left = 0
    Height = 900
    Top = 0
    Width = 1209
    Align = alClient
    FixedCols = 0
    TabOrder = 0
  end
end
