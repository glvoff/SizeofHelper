object MainForm: TMainForm
  Left = 0
  Height = 500
  Top = 0
  Width = 1003
  Caption = 'MainForm'
  ClientHeight = 500
  ClientWidth = 1003
  DesignTimePPI = 192
  KeyPreview = True
  LCLVersion = '8.3'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  object Grid: TStringGrid
    Left = 0
    Height = 500
    Top = 0
    Width = 1003
    Align = alClient
    FixedCols = 0
    TabOrder = 0
  end
end
