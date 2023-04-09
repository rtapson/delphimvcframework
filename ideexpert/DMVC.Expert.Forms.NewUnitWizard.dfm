object frmDMVCNewUnit: TfrmDMVCNewUnit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'New DMVC Controller Unit Wizard'
  ClientHeight = 352
  ClientWidth = 347
  Color = clBtnFace
  Constraints.MinHeight = 145
  Constraints.MinWidth = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    347
    352)
  TextHeight = 13
  object btnOK: TButton
    Left = 175
    Top = 319
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 0
    ExplicitLeft = 169
    ExplicitTop = 303
  end
  object btnCancel: TButton
    Left = 256
    Top = 319
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
    ExplicitLeft = 250
    ExplicitTop = 303
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 328
    Height = 302
    ActivePage = OptionsTabSheet
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    ExplicitWidth = 322
    ExplicitHeight = 286
    object StartTabSheet: TTabSheet
      Caption = 'StartTabSheet'
      TabVisible = False
      object Label1: TLabel
        Left = 13
        Top = 3
        Width = 218
        Height = 13
        Caption = 'Please select the type of controller to create.'
        WordWrap = True
      end
      object ButtonGroup1: TButtonGroup
        Left = 39
        Top = 35
        Width = 185
        Height = 52
        ButtonOptions = [gboFullSize, gboShowCaptions]
        Items = <
          item
            Action = DMVCAction
          end
          item
            Action = AureliusAction
          end>
        TabOrder = 0
      end
    end
    object AureliusTabSheet: TTabSheet
      Caption = 'AureliusTabSheet'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        320
        292)
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 248
        Height = 13
        Caption = 'Select the Aurelius Entities to create controllers for.'
      end
      object AureliusEntitiesCheckListBox: TCheckListBox
        Left = 3
        Top = 32
        Width = 314
        Height = 224
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 17
        TabOrder = 0
        ExplicitWidth = 312
        ExplicitHeight = 209
      end
      object AureliusSelectButton: TButton
        Left = 242
        Top = 263
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Select'
        TabOrder = 1
        OnClick = AureliusSelectButtonClick
        ExplicitLeft = 240
        ExplicitTop = 248
      end
    end
    object OptionsTabSheet: TTabSheet
      Caption = 'OptionsTabSheet'
      ImageIndex = 2
      TabVisible = False
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 314
        Height = 286
        Align = alClient
        Caption = 'Controller Unit Options'
        TabOrder = 0
        ExplicitWidth = 312
        ExplicitHeight = 271
        DesignSize = (
          314
          286)
        object lblClassName: TLabel
          Left = 16
          Top = 20
          Width = 105
          Height = 13
          Caption = 'Controller Class Name'
        end
        object edtClassName: TEdit
          Left = 14
          Top = 39
          Width = 288
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
        end
        object chkCreateIndexMethod: TCheckBox
          Left = 16
          Top = 68
          Width = 286
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Create Index Action'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object chkCreateActionFiltersMethods: TCheckBox
          Left = 16
          Top = 91
          Width = 304
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Create Action Filters Methods'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object chkCreateCRUDMethods: TCheckBox
          Left = 16
          Top = 114
          Width = 304
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Create CRUD Actions'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
      end
    end
  end
  object Button1: TButton
    Left = 8
    Top = 316
    Width = 75
    Height = 26
    Anchors = [akLeft, akBottom]
    Caption = 'Debug'
    TabOrder = 3
    OnClick = Button1Click
    ExplicitTop = 304
  end
  object ActionList: TActionList
    Left = 40
    Top = 208
    object DMVCAction: TAction
      Caption = 'DMVC Controller'
      OnExecute = DMVCActionExecute
    end
    object AureliusAction: TAction
      Caption = 'Aurelius Controller'
      OnExecute = AureliusActionExecute
    end
  end
end
