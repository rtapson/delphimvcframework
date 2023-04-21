unit DMVC.Expert.Menus.ProjectManagerMenuIntf;

interface

uses
  ToolsApi, Classes;

type
  TDMVCProjectManagerMenu = Class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
    //FWizard: TTestingHelperWizard;
    Procedure OptionsClick(Sender: TObject);
  public
    //Constructor Create(Wizard: TTestingHelperWizard);
    Procedure AddMenu(Const Project: IOTAProject; Const IdentList: TStrings;
      Const ProjectManagerMenuList: IInterfaceList; IsMultiSelect: Boolean);
    Function CanHandle(Const Ident: String): Boolean;
    Procedure AfterSave;
    Procedure BeforeSave;
    Procedure Destroyed;
    Procedure Modified;

    class procedure RegisterDMVCProjectMenus(const APersonality: string);
  end;

  TDMVCProjectMenuCreatorHelper = Class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
    FProject : IOTAProject;
    FPosition: Integer;
    FCaption : String;
    FName    : String;
    FVerb    : String;
    FParent  : String;
    FFolder: string;

    Function GetCaption: String;
    Function GetChecked: Boolean;
    Function GetEnabled: Boolean;
    Function GetHelpContext: Integer;
    Function GetName: String;
    Function GetParent: String;
    Function GetPosition: Integer;
    Function GetVerb: String;
    Procedure SetCaption(Const Value: String);
    Procedure SetChecked(Value: Boolean);
    Procedure SetEnabled(Value: Boolean);
    Procedure SetHelpContext(Value: Integer);
    Procedure SetName(Const Value: String);
    Procedure SetParent(Const Value: String);
    Procedure SetPosition(Value: Integer);
    Procedure SetVerb(Const Value: String);
    Function GetIsMultiSelectable: Boolean;
    Procedure SetIsMultiSelectable(Value: Boolean);

    procedure NewController;
    procedure NewUnit;
  public
    procedure Execute(Const MenuContextList: IInterfaceList);
    function PreExecute(Const MenuContextList: IInterfaceList): Boolean;
    function PostExecute(Const MenuContextList: IInterfaceList): Boolean;
    constructor Create(
      Project: IOTAProject;
      strCaption, strName, strVerb, strParent: String;
      iPosition: Integer;
      Folder: string);
  end;




implementation

uses
  Vcl.Dialogs,
  SysUtils,
  Vcl.Controls,
  DMVC.Expert.CodeGen.NewControllerUnit,
  DMVC.Expert.Forms.NewUnitWizard,
//  DMVC.Expert.CodeGen.Templates.EmptyUnit,
  DMVC.Expert.CodeGen.NewEmptyUnit;

resourcestring
  strSepCaption = '-';
  strSepName = 'dmvcSeperation';
  strAddNewCaption = 'Add Ne&w';
  strAddNewName = 'dmvcAddNewMenu';
  strNewControllerCaption = '&Controller';
  strNewControllerName = 'dmvcNewControllerMenu';
  strNewUnitCaption = '&Unit';
  strNewUnitName = 'dmvcNewUnitMenu';

var
  iPrjMgrMenu: Integer;

{ TProjectManagerMenu }

procedure TDMVCProjectManagerMenu.AddMenu(
  const Project: IOTAProject;
  const IdentList: TStrings;
  const ProjectManagerMenuList: IInterfaceList;
  IsMultiSelect: Boolean);
var
  j: Integer;
  iPosition: Integer;
  M: IOTAProjectManagerMenu;
begin
  iPosition := 0;
  for j := 0 To ProjectManagerMenuList.Count - 1 Do
  begin
    M := ProjectManagerMenuList.Items[j] As IOTAProjectManagerMenu;
    if CompareText(M.Caption, 'Compare') = 0 Then
      begin
        iPosition := M.Position + 1;
        Break;
      end;
  end;

  if (IdentList.IndexOf(sFileContainer) > -1) and (IdentList.IndexOf(sProjectContainer) < 0) then
  begin
    ProjectManagerMenuList.Add(
      TDMVCProjectMenuCreatorHelper.Create(
        Project,
        strSepCaption,
        strSepName,
        strSepName,
        '',
        iPosition,
        IdentList[1]));

    ProjectManagerMenuList.Add(
      TDMVCProjectMenuCreatorHelper.Create(
        Project,
        strAddNewCaption,
        strAddNewName,
        strAddNewName,
        '',
        iPosition + 1,
        IdentList[1]));
  end;



  if (IdentList.IndexOf(sFileContainer) > -1) and (IdentList.IndexOf(sProjectContainer) < 0) then
  begin
    ProjectManagerMenuList.Add(
      TDMVCProjectMenuCreatorHelper.Create(
        Project,
        strNewUnitCaption,
        strNewUnitName,
        strNewUnitName,
        strAddNewName,
        iPosition + 2,
        IdentList[1]));
  end;


  if (IdentList.IndexOf(sFileContainer) > -1) and IdentList[1].EndsWith('Controllers', True) then
  begin
    ProjectManagerMenuList.Add(
      TDMVCProjectMenuCreatorHelper.Create(
        Project,
        strNewControllerCaption,
        strNewControllerName,
        strNewControllerName,
        strAddNewName,
        iPosition + 3,
        IdentList[1]));
  end;
end;

procedure TDMVCProjectManagerMenu.AfterSave;
begin

end;

procedure TDMVCProjectManagerMenu.BeforeSave;
begin

end;

function TDMVCProjectManagerMenu.CanHandle(const Ident: String): Boolean;
begin
  Result := sProjectContainer = Ident;
end;

procedure TDMVCProjectManagerMenu.Destroyed;
begin

end;

procedure TDMVCProjectManagerMenu.Modified;
begin

end;

procedure TDMVCProjectManagerMenu.OptionsClick(Sender: TObject);
begin

end;

class procedure TDMVCProjectManagerMenu.RegisterDMVCProjectMenus(const APersonality: string);
var
  MenuNotifier: TDMVCProjectManagerMenu;
begin
  MenuNotifier := TDMVCProjectManagerMenu.Create();
  iPrjMgrMenu := (BorlandIDEServices As IOTAProjectManager)
    .AddMenuItemCreatorNotifier(MenuNotifier);
end;

{ TITHelperProjectMenu }

Constructor TDMVCProjectMenuCreatorHelper.Create(
      //Wizard: TTestingHelperWizard;
      Project: IOTAProject;
      strCaption, strName, strVerb, strParent: String;
      iPosition: Integer;
      Folder: string
      //Setting: TSetting
      );
begin
  FProject  := Project;
  FPosition := iPosition;
  FCaption  := strCaption;
  FName     := strName;
  FVerb     := strVerb;
  FParent   := strParent;
  FFolder   := Folder;
end;

procedure TDMVCProjectMenuCreatorHelper.Execute(const MenuContextList: IInterfaceList);
begin
  if FName = strNewControllerName then NewController;
  if FName = strNewUnitName then NewUnit;


end;

function TDMVCProjectMenuCreatorHelper.GetCaption: String;
begin
  Result := FCaption;
end;

function TDMVCProjectMenuCreatorHelper.GetChecked: Boolean;
begin
  Result := False;
end;

function TDMVCProjectMenuCreatorHelper.GetEnabled: Boolean;
begin
  Result := True;
end;

function TDMVCProjectMenuCreatorHelper.GetHelpContext: Integer;
begin
  Result := 0;
end;

function TDMVCProjectMenuCreatorHelper.GetIsMultiSelectable: Boolean;
begin
  Result := False;
end;

function TDMVCProjectMenuCreatorHelper.GetName: String;
begin
  Result := FName;
end;

function TDMVCProjectMenuCreatorHelper.GetParent: String;
begin
  Result := FParent;
end;

function TDMVCProjectMenuCreatorHelper.GetPosition: Integer;
begin
  Result := FPosition;
end;

function TDMVCProjectMenuCreatorHelper.GetVerb: String;
begin
  Result := FVerb;
end;

procedure TDMVCProjectMenuCreatorHelper.NewController;
var
  ModuleServices: IOTAModuleServices;
  Project: IOTAProject;
  ControllerCreator: IOTACreator;
  ControllerUnit: IOTAModule;
  WizardForm: TfrmDMVCNewUnit;
begin
  ModuleServices := (BorlandIDEServices as IOTAModuleServices);
  Project := GetActiveProject;

  WizardForm := TfrmDMVCNewUnit.Create(nil);
  try
    WizardForm.DefaultFileLocation := FFolder;
    WizardForm.FileLocationEdit.Text := FFolder;

    if WizardForm.ShowModal = mrOk then
    begin
      ControllerCreator := TNewControllerUnitEx.Create(
        WizardForm.CreateIndexMethod,
        WizardForm.CreateCRUDMethods,
        WizardForm.CreateActionFiltersMethods,
        WizardForm.ControllerClassName,
        WizardForm.FileLocation,
        WizardForm.ApiPath,
        WizardForm.ControllerEndpoint,
        sDelphiPersonality);

      TNewControllerUnitEx(ControllerCreator).ImplFileName := WizardForm.FileLocationEdit.Text;
      ControllerUnit := ModuleServices.CreateModule(ControllerCreator);
      if Project <> nil then
      begin
        Project.AddFile(ControllerUnit.FileName, True);
      end;
    end;
  finally
    WizardForm.Free;
    end;
end;

procedure TDMVCProjectMenuCreatorHelper.NewUnit;
var
  ModuleServices: IOTAModuleServices;
  Project: IOTAProject;
  UnitCreator: IOTACreator;
  NewUnit: IOTAModule;

  lUnitIdent: string;
  lFormName: string;
  lFileName: string;

begin
  ModuleServices := (BorlandIDEServices as IOTAModuleServices);
  Project := GetActiveProject;

//  if ModuleIdent = '' then
//  begin
    // http://stackoverflow.com/questions/4196412/how-do-you-retrieve-a-new-unit-name-from-delphis-open-tools-api
    // So using method mentioned by Marco Cantu.
    (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName('',
      lUnitIdent, lFormName, lFileName);
//  end
//  else
//  begin
//    lUnitIdent := ModuleIdent;
//  end;

  UnitCreator := TNewUnitEx.Create(lUnitIdent, sDelphiPersonality);

  TNewUnitEx(UnitCreator).ImplFileName := IncludeTrailingPathDelimiter(FFolder) + lUnitIdent + '.pas';

  NewUnit := ModuleServices.CreateModule(UnitCreator);
  if Project <> nil then
  begin
    Project.AddFile(NewUnit.FileName, True);
  end;

end;

function TDMVCProjectMenuCreatorHelper.PostExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  Result := False;
end;

function TDMVCProjectMenuCreatorHelper.PreExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  Result := False;
end;

procedure TDMVCProjectMenuCreatorHelper.SetCaption(const Value: String);
begin

end;

procedure TDMVCProjectMenuCreatorHelper.SetChecked(Value: Boolean);
begin

end;

procedure TDMVCProjectMenuCreatorHelper.SetEnabled(Value: Boolean);
begin

end;

procedure TDMVCProjectMenuCreatorHelper.SetHelpContext(Value: Integer);
begin

end;

procedure TDMVCProjectMenuCreatorHelper.SetIsMultiSelectable(Value: Boolean);
begin

end;

procedure TDMVCProjectMenuCreatorHelper.SetName(const Value: String);
begin

end;

procedure TDMVCProjectMenuCreatorHelper.SetParent(const Value: String);
begin

end;

procedure TDMVCProjectMenuCreatorHelper.SetPosition(Value: Integer);
begin
  FPosition := Value;
end;

procedure TDMVCProjectMenuCreatorHelper.SetVerb(const Value: String);
begin

end;

end.
