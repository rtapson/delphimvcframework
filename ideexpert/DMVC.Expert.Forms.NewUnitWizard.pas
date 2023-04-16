// ***************************************************************************
//
// Delphi MVC Framework
//
// Copyright (c) 2010-2023 Daniele Teti and the DMVCFramework Team
//
// https://github.com/danieleteti/delphimvcframework
//
// ***************************************************************************
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ***************************************************************************
//
// This IDE expert is based off of the one included with the DUnitX }
// project.  Original source by Robert Love.  Adapted by Nick Hodges. }
//
// The DUnitX project is run by Vincent Parrett and can be found at: }
//
// https://github.com/VSoftTechnologies/DUnitX }
// ***************************************************************************

unit DMVC.Expert.Forms.NewUnitWizard;

interface

uses
  WinAPI.Windows,
  WinAPI.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  VCL.Graphics,
  VCL.Controls,
  VCL.Forms,
  VCL.Dialogs,
  VCL.StdCtrls, Vcl.ComCtrls, Vcl.ButtonGroup, System.Actions, Vcl.ActnList,
  Vcl.CheckLst, Vcl.Mask, Vcl.ExtCtrls;

type
  TAureliusListItem = class
  private
    FFileName: string;
    FEntityName: string;
    FClassName: string;
    FEntityUnitName: string;
  public
    constructor Create(
      const FileName: string;
      const EntityName: string;
      const ClassName: string;
      const EntityUnitName: string);
    property FileName: string read FFileName;
    property EntityName: string read FEntityName;
    property ClassName: string read FClassName;
    property EnityUnitName: string read FEntityUnitName;
  end;

  TfrmDMVCNewUnit = class(TForm)
    GroupBox1: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    lblClassName: TLabel;
    edtClassName: TEdit;
    chkCreateIndexMethod: TCheckBox;
    chkCreateActionFiltersMethods: TCheckBox;
    chkCreateCRUDMethods: TCheckBox;
    PageControl1: TPageControl;
    StartTabSheet: TTabSheet;
    AureliusTabSheet: TTabSheet;
    OptionsTabSheet: TTabSheet;
    ButtonGroup1: TButtonGroup;
    Label1: TLabel;
    ActionList: TActionList;
    DMVCAction: TAction;
    AureliusAction: TAction;
    AureliusEntitiesCheckListBox: TCheckListBox;
    Label2: TLabel;
    Button1: TButton;
    AureliusSelectButton: TButton;
    FileLocationEdit: TLabeledEdit;
    ApiPathEdit: TLabeledEdit;
    ControllerEndpointEdit: TLabeledEdit;
    ValidationAction: TAction;
    procedure FormCreate(Sender: TObject);
    procedure DMVCActionExecute(Sender: TObject);
    procedure AureliusActionExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AureliusSelectButtonClick(Sender: TObject);
    procedure edtClassNameChange(Sender: TObject);
  private
    FDefaultFileLocation: string;
    function GetCreateIndexMethod: boolean;
    function GetControllerClassName: string;
    function GetCreateActionFiltersMethods: boolean;
    function GetCreateCRUDMethods: boolean;
    function GetAddAnalyticsMiddleware: boolean;

    function AureliusInstalled: Boolean;
    procedure ScanFile(const FileName: string);
    function UnitHasAureliusEntities(const FileName: string): Boolean;
    function GetApiPath: string;
    function GetControllerEndpoint: string;
    function GetFileLocation: string;
    { Private declarations }
  public
    { Public declarations }
    property DefaultFileLocation: string read FDefaultFileLocation write FDefaultFileLocation;
    property ControllerClassName: string read GetControllerClassName;
    property CreateIndexMethod: boolean read GetCreateIndexMethod;
    property CreateCRUDMethods: boolean read GetCreateCRUDMethods;
    property CreateActionFiltersMethods: boolean read GetCreateActionFiltersMethods;
    property AddAnalyticsMiddleware: boolean read GetAddAnalyticsMiddleware;
    property FileLocation: string read GetFileLocation;
    property ApiPath: string read GetApiPath;
    property ControllerEndpoint: string read GetControllerEndpoint;

  end;

var
  frmDMVCNewUnit: TfrmDMVCNewUnit;

implementation

uses
  Toolsapi,
  Registry,
  IOUtils,
  DMVC.Expert.CodeGen.Templates;

{$R *.dfm}

procedure TfrmDMVCNewUnit.DMVCActionExecute(Sender: TObject);
begin
  PageControl1.ActivePage := OptionsTabSheet;
end;

procedure TfrmDMVCNewUnit.edtClassNameChange(Sender: TObject);
var
  ControllerClassName: string;
begin
  ControllerClassName := edtClassName.Text;
  ControllerEndpointEdit.Text := '/' + ControllerClassName.Substring(1).Replace('Controller', '', [rfIgnoreCase]).ToLower;
  FileLocationEdit.Text := IncludeTrailingPathDelimiter(DefaultFileLocation) + ControllerClassName.Substring(1) + '.pas';

  btnOK.Enabled := edtClassName.Text <> '';
end;

procedure TfrmDMVCNewUnit.FormCreate(Sender: TObject);
begin
  edtClassName.TextHint := sDefaultControllerName;
  ApiPathEdit.TextHint := sDefaultApiPath;
  if AureliusInstalled then
    PageControl1.ActivePage := StartTabSheet
  else
    PageControl1.ActivePage := OptionsTabSheet;
end;

function TfrmDMVCNewUnit.GetCreateActionFiltersMethods: boolean;
begin
  Result := chkCreateActionFiltersMethods.Checked;
end;

function TfrmDMVCNewUnit.GetCreateCRUDMethods: boolean;
begin
  Result := chkCreateCRUDMethods.Checked;
end;

function TfrmDMVCNewUnit.GetCreateIndexMethod: boolean;
begin
  Result := chkCreateIndexMethod.Checked;
end;

function TfrmDMVCNewUnit.GetFileLocation: string;
begin
  Result := FileLocationEdit.Text;
end;

procedure TfrmDMVCNewUnit.ScanFile(const FileName: string);
var
  FileContents: TStringList;
  SourceLine: string;
  EntityFound: Boolean;
  EntityName: string;
  ClassName: string;
  EntityUnitName: string;
begin
  FileContents := TStringList.Create;
  try
    FileContents.LoadFromFile(FileName);
    for SourceLine in FileContents do
    begin
      if not EntityFound then EntityFound := SourceLine.Contains('[Entity]');

      if SourceLine.Contains('[Table(') then
      begin
        EntityName := SourceLine.Remove(SourceLine.IndexOf(')') - 1).Remove(1, SourceLine.IndexOf('(') + 1).TrimEnd(['s']).TrimLeft;
      end;
      if SourceLine.Contains('class(') then
      begin
        ClassName := SourceLine.SubString(1, SourceLine.IndexOf('=') - 2).TrimLeft;

        EntityUnitName := TPath.GetFileNameWithoutExtension(FileName);

        if EntityName = '' then Exit;

        if EntityFound then
          AureliusEntitiesCheckListBox.Items.AddObject(
            EntityName,
            TAureliusListItem.Create(FileName, EntityName, ClassName, EntityUnitName));

//        if EntityFound then
//          BuildController(ControllerFolder, TemplateFolder, EntityName, ClassName, EntityUnitName);

        EntityFound := False;
      end;
    end;

  finally
    FileContents.Free;
  end;
end;

function TfrmDMVCNewUnit.UnitHasAureliusEntities(const FileName: string): Boolean;
begin

end;

procedure TfrmDMVCNewUnit.AureliusActionExecute(Sender: TObject);
var
  ModuleServices: IOTAModuleServices;
  Project: IOTAProject;
//  ModuleCount: Integer;
  i: Integer;
  ModuleInfo: IOTAModuleInfo;
  Files: TStringList;
begin
  PageControl1.ActivePage := AureliusTabSheet;

  ModuleServices := (BorlandIDEServices as IOTAModuleServices);
  Project := GetActiveProject;

  Files := TStringList.Create;
  try

    Project.GetCompleteFileList(Files);

    for i := 0 to Files.Count - 1 do
    begin
      ModuleInfo := Project.GetModule(i);
      if ModuleInfo.ModuleType = omtUnit then
      begin
        ScanFile(ModuleInfo.FileName);
      end;
    end;
  finally
    Files.Free;
  end;
end;

function TfrmDMVCNewUnit.AureliusInstalled: Boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Result := Reg.KeyExists('Software\tmssoftware\TMS Aurelius');
  finally
    Reg.Free;
  end;
end;

procedure TfrmDMVCNewUnit.AureliusSelectButtonClick(Sender: TObject);
begin
  PageControl1.ActivePage := OptionsTabSheet;
end;

procedure TfrmDMVCNewUnit.Button1Click(Sender: TObject);
var
  DebugString: TStringList;
  i: Integer;
  TempItem: TAureliusListItem;
begin
  DebugString := TStringList.Create;
  try
    for i := 0 to AureliusEntitiesCheckListBox.Items.Count - 1 do
    begin
      if not AureliusEntitiesCheckListBox.Checked[i] then Continue;
      
      TempItem := TAureliusListItem(AureliusEntitiesCheckListBox.Items.Objects[i]);
      DebugString.Add(TempItem.FileName + ', ' + TempItem.EntityName + ', ' + TempItem.ClassName + ', ' + TempItem.EnityUnitName)
    end;
    ShowMessage(DebugString.Text);
  finally
    DebugString.Free;
  end;
end;

function TfrmDMVCNewUnit.GetAddAnalyticsMiddleware: boolean;
begin
  Result := False;
end;

function TfrmDMVCNewUnit.GetApiPath: string;
begin
  if Trim(ApiPathEdit.Text) = '' then
  begin
    Result := sDefaultApiPath;
  end
  else
  begin
    Result := Trim(ApiPathEdit.Text);
  end;
end;

function TfrmDMVCNewUnit.GetControllerClassName: string;
begin
  if Trim(edtClassName.Text) = '' then
  begin
    Result := sDefaultControllerName
  end
  else
  begin
    Result := Trim(edtClassName.Text);
  end;
end;

function TfrmDMVCNewUnit.GetControllerEndpoint: string;
begin

end;

{ TAureliusListItem }

constructor TAureliusListItem.Create(
      const FileName: string;
      const EntityName: string;
      const ClassName: string;
      const EntityUnitName: string);
begin
  FFileName := FileName;
  FEntityName := EntityName;
  FClassName := ClassName;
  FEntityUnitName := EntityUnitName;
end;

end.
