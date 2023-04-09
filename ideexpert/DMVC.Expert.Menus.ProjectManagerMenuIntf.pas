unit DMVC.Expert.Menus.ProjectManagerMenuIntf;

interface

uses
  ToolsApi, Classes;

type
  TDMVCProjectManagerMenu = Class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
    //FWizard: TTestingHelperWizard;
    Procedure OptionsClick(Sender: TObject);
  Public
    //Constructor Create(Wizard: TTestingHelperWizard);
    Procedure AddMenu(Const Project: IOTAProject; Const IdentList: TStrings;
      Const ProjectManagerMenuList: IInterfaceList; IsMultiSelect: Boolean);
    Function CanHandle(Const Ident: String): Boolean;
    Procedure AfterSave;
    Procedure BeforeSave;
    Procedure Destroyed;
    Procedure Modified;

    class procedure RegisterDMVCProjectMenus(const APersonality: string);
  End;

  TDMVCHelperProjectMenu = Class(TNotifierObject, IOTALocalMenu, IOTAProjectManagerMenu)
    //FWizard  : TTestingHelperWizard;
    FProject : IOTAProject;
    FPosition: Integer;
    FCaption : String;
    FName    : String;
    FVerb    : String;
    FParent  : String;

    FFolder: string;
    //FSetting : TSetting;
  Public
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
    Procedure Execute(Const MenuContextList: IInterfaceList); Overload;
    Function PreExecute(Const MenuContextList: IInterfaceList): Boolean;
    Function PostExecute(Const MenuContextList: IInterfaceList): Boolean;
    Constructor Create(
      //Wizard: TTestingHelperWizard;
      Project: IOTAProject;
      strCaption, strName, strVerb, strParent: String;
      iPosition: Integer;
      Folder: string
      //Setting: TSetting
      );
  End;


implementation

uses
  SysUtils,
  Vcl.Controls,
  DMVC.Expert.CodeGen.NewControllerUnit,
  DMVC.Expert.Forms.NewUnitWizard;

resourcestring
  strNewControllerCaption = 'New Controller';
  strNewControllerName = 'dmvcNewControllerMenu';

var
  iPrjMgrMenu: Integer;

{ TProjectManagerMenu }

procedure TDMVCProjectManagerMenu.AddMenu(
  const Project: IOTAProject;
  const IdentList: TStrings;
  const ProjectManagerMenuList: IInterfaceList;
  IsMultiSelect: Boolean);
var
  i, j     : Integer;
  iPosition: Integer;
  M        : IOTAProjectManagerMenu;
begin

  if (IdentList.IndexOf(sFileContainer) > -1) and IdentList[1].EndsWith('Controllers', True) then
  begin
    ProjectManagerMenuList.Add(
      TDMVCHelperProjectMenu.Create(
        Project,
        strNewControllerCaption,
        strNewControllerName,
        strNewControllerName,
        '',
        iPosition,
        IdentList[1]));
  end;


//  for i := 0 To IdentList.Count - 1 do
//    if sProjectContainer = IdentList[i] then
//      begin
//        iPosition := 0;
//        For j     := 0 To ProjectManagerMenuList.Count - 1 Do
//          Begin
//            M := ProjectManagerMenuList.Items[j] As IOTAProjectManagerMenu;
//            If CompareText(M.Verb, 'Options') = 0 Then
//              Begin
//                iPosition := M.Position + 1;
//                Break;
//              End;
//          End;
//          ProjectManagerMenuList.Add(
//            TDMVCHelperProjectMenu.Create(
//              Project,
//              strNewControllerCaption,
//              strNewControllerName,
//              strNewControllerName,
//              '',
//              iPosition));
////        ProjectManagerMenuList.Add(TITHelperProjectMenu.Create(FWizard, Project,
////          strMainCaption, strMainName, strMainName, '', iPosition, seProject));
////        ProjectManagerMenuList.Add(TITHelperProjectMenu.Create(FWizard, Project,
////          strProjectCaption, strProjectName, strProjectName, strMainName, iPosition + 1,
////          seProject));
////        ProjectManagerMenuList.Add(TITHelperProjectMenu.Create(FWizard, Project,
////          strBeforeCaption, strBeforeName, strBeforeName, strMainName, iPosition + 2,
////          seBefore));
////        ProjectManagerMenuList.Add(TITHelperProjectMenu.Create(FWizard, Project,
////          strAfterCaption, strAfterName, strAfterName, strMainName, iPosition + 3,
////          seAfter));
////        ProjectManagerMenuList.Add(TITHelperProjectMenu.Create(FWizard, Project,
////          strZIPCaption, strZIPName, strZIPName, strMainName, iPosition + 4, seZIP));
//      End;
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
  var iPrjMgrMenu := (BorlandIDEServices As IOTAProjectManager).AddMenuItemCreatorNotifier(
    MenuNotifier);
end;

{ TITHelperProjectMenu }

Constructor TDMVCHelperProjectMenu.Create(
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

procedure TDMVCHelperProjectMenu.Execute(const MenuContextList: IInterfaceList);
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
    if WizardForm.ShowModal = mrOk then
    begin
      ControllerCreator := TNewControllerUnitEx.Create(
        WizardForm.CreateIndexMethod,
        WizardForm.CreateCRUDMethods,
        WizardForm.CreateActionFiltersMethods,
        WizardForm.ControllerClassName,
        sDelphiPersonality);

      TNewControllerUnitEx(ControllerCreator).ImplFileName := IncludeTrailingPathDelimiter(FFolder) + 'TestController.pas';
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

function TDMVCHelperProjectMenu.GetCaption: String;
begin
  Result := FCaption;
end;

function TDMVCHelperProjectMenu.GetChecked: Boolean;
begin
  Result := False;
end;

function TDMVCHelperProjectMenu.GetEnabled: Boolean;
begin
  Result := True;
end;

function TDMVCHelperProjectMenu.GetHelpContext: Integer;
begin
  Result := 0;
end;

function TDMVCHelperProjectMenu.GetIsMultiSelectable: Boolean;
begin
  Result := False;
end;

function TDMVCHelperProjectMenu.GetName: String;
begin
  Result := FName;
end;

function TDMVCHelperProjectMenu.GetParent: String;
begin
  Result := FParent;
end;

function TDMVCHelperProjectMenu.GetPosition: Integer;
begin
  Result := FPosition;
end;

function TDMVCHelperProjectMenu.GetVerb: String;
begin
  Result := FVerb;
end;

function TDMVCHelperProjectMenu.PostExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  Result := False;
end;

function TDMVCHelperProjectMenu.PreExecute(const MenuContextList: IInterfaceList): Boolean;
begin
  Result := False;
end;

procedure TDMVCHelperProjectMenu.SetCaption(const Value: String);
begin

end;

procedure TDMVCHelperProjectMenu.SetChecked(Value: Boolean);
begin

end;

procedure TDMVCHelperProjectMenu.SetEnabled(Value: Boolean);
begin

end;

procedure TDMVCHelperProjectMenu.SetHelpContext(Value: Integer);
begin

end;

procedure TDMVCHelperProjectMenu.SetIsMultiSelectable(Value: Boolean);
begin

end;

procedure TDMVCHelperProjectMenu.SetName(const Value: String);
begin

end;

procedure TDMVCHelperProjectMenu.SetParent(const Value: String);
begin

end;

procedure TDMVCHelperProjectMenu.SetPosition(Value: Integer);
begin

end;

procedure TDMVCHelperProjectMenu.SetVerb(const Value: String);
begin

end;

end.
