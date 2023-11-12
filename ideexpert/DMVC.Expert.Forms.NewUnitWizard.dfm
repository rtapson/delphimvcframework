object frmDMVCNewUnit: TfrmDMVCNewUnit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'New DMVC Controller Unit Wizard'
  ClientHeight = 690
  ClientWidth = 1114
  Color = clBtnFace
  Constraints.MinHeight = 290
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -22
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 192
  TextHeight = 27
  object PageControl1: TPageControl
    AlignWithMargins = True
    Left = 6
    Top = 6
    Width = 1102
    Height = 596
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    ActivePage = AureliusTabSheet
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    ExplicitWidth = 1088
    ExplicitHeight = 595
    object OptionsTabSheet: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'OptionsTabSheet'
      ImageIndex = 2
      TabVisible = False
      object GroupBox1: TGroupBox
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 1074
        Height = 566
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Caption = ' Controller Unit Options '
        TabOrder = 0
        DesignSize = (
          1074
          566)
        object lblClassName: TLabel
          Left = 32
          Top = 40
          Width = 215
          Height = 27
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Controller Class Name'
        end
        object edtClassName: TEdit
          Left = 28
          Top = 78
          Width = 1022
          Height = 35
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnChange = edtClassNameChange
        end
        object chkCreateIndexMethod: TCheckBox
          Left = 32
          Top = 136
          Width = 489
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Create Index Action'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object chkCreateActionFiltersMethods: TCheckBox
          Left = 32
          Top = 182
          Width = 1054
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Create Action Filters Methods'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object chkCreateCRUDMethods: TCheckBox
          Left = 32
          Top = 228
          Width = 1054
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Create CRUD Actions'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object FileLocationEdit: TLabeledEdit
          Left = 28
          Top = 320
          Width = 1012
          Height = 35
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 81
          EditLabel.Height = 27
          EditLabel.Margins.Left = 6
          EditLabel.Margins.Top = 6
          EditLabel.Margins.Right = 6
          EditLabel.Margins.Bottom = 6
          EditLabel.Caption = 'Location'
          TabOrder = 5
          Text = ''
        end
        object ApiPathEdit: TLabeledEdit
          Left = 32
          Top = 400
          Width = 1008
          Height = 35
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 80
          EditLabel.Height = 27
          EditLabel.Margins.Left = 6
          EditLabel.Margins.Top = 6
          EditLabel.Margins.Right = 6
          EditLabel.Margins.Bottom = 6
          EditLabel.Caption = 'Api Path'
          TabOrder = 6
          Text = ''
        end
        object ControllerEndpointEdit: TLabeledEdit
          Left = 32
          Top = 496
          Width = 1008
          Height = 35
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 185
          EditLabel.Height = 27
          EditLabel.Margins.Left = 6
          EditLabel.Margins.Top = 6
          EditLabel.Margins.Right = 6
          EditLabel.Margins.Bottom = 6
          EditLabel.Caption = 'Controller Endpoint'
          TabOrder = 7
          Text = ''
        end
        object chkUseAurelius: TCheckBox
          Left = 496
          Top = 136
          Width = 433
          Height = 34
          Margins.Left = 6
          Margins.Top = 6
          Margins.Right = 6
          Margins.Bottom = 6
          Caption = 'Use Aurelius'
          TabOrder = 4
        end
      end
    end
    object AureliusTabSheet: TTabSheet
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = 'AureliusTabSheet'
      ImageIndex = 1
      TabVisible = False
      object CommandPanel: TPanel
        Left = 0
        Top = 502
        Width = 1086
        Height = 76
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitTop = 501
        ExplicitWidth = 1072
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 608
    Width = 1114
    Height = 82
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 607
    ExplicitWidth = 1100
    DesignSize = (
      1114
      82)
    object btnCancel: TButton
      Left = 868
      Top = 18
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
      TabOrder = 0
      ExplicitLeft = 854
    end
    object btnOK: TButton
      Left = 706
      Top = 18
      Width = 150
      Height = 50
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Action = NextOkAction
      Anchors = [akRight, akBottom]
      Default = True
      ModalResult = 1
      TabOrder = 1
      ExplicitLeft = 692
    end
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 712
    Top = 192
    object DMVCAction: TAction
      Caption = 'DMVC Controller'
      OnExecute = DMVCActionExecute
    end
    object ValidationAction: TAction
      Caption = 'ValidationAction'
    end
    object NextOkAction: TAction
      Caption = 'NextOkAction'
      OnExecute = NextOkActionExecute
    end
  end
end
