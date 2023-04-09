object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Generate Controllers for Aurelius Entities'
  ClientHeight = 258
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    403
    258)
  TextHeight = 15
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 97
    Height = 15
    Caption = 'Controllers Folder:'
  end
  object Label2: TLabel
    Left = 40
    Top = 96
    Width = 143
    Height = 15
    Caption = 'Controller Registration File:'
  end
  object btnOK: TButton
    Left = 239
    Top = 225
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    ExplicitLeft = 268
    ExplicitTop = 305
  end
  object btnCancel: TButton
    Left = 320
    Top = 225
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    ExplicitLeft = 349
    ExplicitTop = 305
  end
  object ButtonedEdit1: TButtonedEdit
    Left = 48
    Top = 48
    Width = 313
    Height = 23
    TabOrder = 2
    Text = 'ButtonedEdit1'
  end
end
