object GenerateAureliusControllersForm: TGenerateAureliusControllersForm
  Left = 0
  Top = 0
  Caption = 'Generate Controllers for Aurelius Entities'
  ClientHeight = 515
  ClientWidth = 820
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -24
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 192
  DesignSize = (
    820
    515)
  TextHeight = 32
  object Label1: TLabel
    Left = 11
    Top = 11
    Width = 529
    Height = 32
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Caption = 'Select the Entity classes to generate controller for'
  end
  object btnOK: TButton
    Left = 468
    Top = 449
    Width = 150
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    ExplicitLeft = 454
    ExplicitTop = 448
  end
  object btnCancel: TButton
    Left = 630
    Top = 449
    Width = 150
    Height = 50
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    ExplicitLeft = 616
    ExplicitTop = 448
  end
  object EntitiesList: TCheckListBox
    Left = 11
    Top = 48
    Width = 770
    Height = 389
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 34
    TabOrder = 2
    ExplicitWidth = 756
    ExplicitHeight = 388
  end
end
