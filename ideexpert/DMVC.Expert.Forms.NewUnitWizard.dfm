object frmDMVCNewUnit: TfrmDMVCNewUnit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'New DMVC Controller Unit Wizard'
  ClientHeight = 380
  ClientWidth = 366
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
    366
    380)
  TextHeight = 13
  object btnOK: TButton
    Left = 194
    Top = 347
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 275
    Top = 347
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 347
    Height = 330
    ActivePage = OptionsTabSheet
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
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
        339
        320)
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
        Width = 333
        Height = 252
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
      end
      object AureliusSelectButton: TButton
        Left = 261
        Top = 291
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Select'
        TabOrder = 1
        OnClick = AureliusSelectButtonClick
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
        Width = 333
        Height = 314
        Align = alClient
        Caption = 'Controller Unit Options'
        TabOrder = 0
        DesignSize = (
          333
          314)
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
          Width = 307
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 3
          OnChange = edtClassNameChange
        end
        object chkCreateIndexMethod: TCheckBox
          Left = 16
          Top = 68
          Width = 305
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
          Width = 323
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
          Width = 323
          Height = 17
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Create CRUD Actions'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object FileLocationEdit: TLabeledEdit
          Left = 14
          Top = 160
          Width = 302
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 40
          EditLabel.Height = 13
          EditLabel.Caption = 'Location'
          TabOrder = 4
          Text = ''
        end
        object ApiPathEdit: TLabeledEdit
          Left = 16
          Top = 200
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 40
          EditLabel.Height = 13
          EditLabel.Caption = 'Api Path'
          TabOrder = 5
          Text = ''
        end
        object ControllerEndpointEdit: TLabeledEdit
          Left = 16
          Top = 248
          Width = 300
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 92
          EditLabel.Height = 13
          EditLabel.Caption = 'Controller Endpoint'
          TabOrder = 6
          Text = ''
        end
      end
    end
  end
  object Button1: TButton
    Left = 8
    Top = 344
    Width = 75
    Height = 26
    Anchors = [akLeft, akBottom]
    Caption = 'Debug'
    TabOrder = 3
    OnClick = Button1Click
  end
  object ActionList: TActionList
    Left = 120
    Top = 320
    object DMVCAction: TAction
      Caption = 'DMVC Controller'
      OnExecute = DMVCActionExecute
    end
    object AureliusAction: TAction
      Caption = 'Aurelius Controller'
      OnExecute = AureliusActionExecute
    end
    object ValidationAction: TAction
      Caption = 'ValidationAction'
    end
  end
end
