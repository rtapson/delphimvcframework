unit DMVC.Expert.Menus.NewController;

interface

uses
  Classes,
  ToolsApi;

//type
//  TDMVCProjectMenuItemNotifier = class(TNotifierObject, IOTAProjectMenuItemCreatorNotifier)
//  public
//    // IOTAProjectMenuItemCreatorNotifier
//    procedure AddMenu(const Project: IOTAProject;
//                      const IdentList: TStrings;
//                      const ProjectManagerMenuList: IInterfaceList;
//                            IsMultiSelect: Boolean);
//  end;

//  TDMVCProjectNewControllerMenuItem = class(TInterfacedObject, IOTALocalMenu, IOTAProjectManagerMenu)
//  public
//    // IOTALocalMenu
//    function GetCaption: string;
//    function GetChecked: Boolean;
//    function GetEnabled: Boolean;
//    function GetHelpContext: Integer;
//    function GetName: string;
//    function GetParent: string;
//    function GetPosition: Integer;
//    function GetVerb: string;
//    procedure SetCaption(const Value: string);
//    procedure SetChecked(Value: Boolean);
//    procedure SetEnabled(Value: Boolean);
//    procedure SetHelpContext(Value: Integer);
//    procedure SetName(const Value: string);
//    procedure SetParent(const Value: string);
//    procedure SetPosition(Value: Integer);
//    procedure SetVerb(const Value: string);
//
//    // IOTAProjectManagerMenu
//    function GetIsMultiSelectable: Boolean;
//    procedure SetIsMultiSelectable(Value: Boolean);
//    procedure Execute(const MenuContextList: IInterfaceList); overload;
//    function PreExecute(const MenuContextList: IInterfaceList): Boolean;
//    function PostExecute(const MenuContextList: IInterfaceList): Boolean;
//   end;

implementation

{ TDMVCProjectNewControllerMenuItem }



{ TDMVCProjectNewControllerMenuItem }

//procedure TDMVCProjectNewControllerMenuItem.Execute(const MenuContextList: IInterfaceList);
//var
//  MenuContext: IOTAProjectMenuContext;
//  Project: IOTAProject;
//begin
//  MenuContext := MenuContextList.Items[0] as IOTAProjectMenuContext;
//  Project := MenuContext.Project;
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetCaption: string;
//begin
//  Result := 'New Aurelius Controller';
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetChecked: Boolean;
//begin
//  Result := False;
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetEnabled: Boolean;
//begin
//  Result := True;
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetHelpContext: Integer;
//begin
//  Result := -1;
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetIsMultiSelectable: Boolean;
//begin
//  Result := False;
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetName: string;
//begin
//
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetParent: string;
//begin
//
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetPosition: Integer;
//begin
//
//end;
//
//function TDMVCProjectNewControllerMenuItem.GetVerb: string;
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.Modified;
//begin
//
//end;
//
//function TDMVCProjectNewControllerMenuItem.PostExecute(
//  const MenuContextList: IInterfaceList): Boolean;
//begin
//
//end;
//
//function TDMVCProjectNewControllerMenuItem.PreExecute(
//  const MenuContextList: IInterfaceList): Boolean;
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetCaption(
//  const Value: string);
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetChecked(Value: Boolean);
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetEnabled(Value: Boolean);
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetHelpContext(Value: Integer);
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetIsMultiSelectable(
//  Value: Boolean);
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetName(const Value: string);
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetParent(const Value: string);
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetPosition(Value: Integer);
//begin
//
//end;
//
//procedure TDMVCProjectNewControllerMenuItem.SetVerb(const Value: string);
//begin
//
//end;
//
//{ TDMVCProjectMenuItemNotifier }
//
//procedure TDMVCProjectMenuItemNotifier.AddMenu(
//  const Project: IOTAProject;
//  const IdentList: TStrings;
//  const ProjectManagerMenuList: IInterfaceList;
//        IsMultiSelect: Boolean);
//var
//  NewControllerMenu: TDMVCProjectNewControllerMenuItem;
//begin
//  if IdentList.IndexOf(sDirectoryContainer) <> -1 then
//  begin
//    NewControllerMenu := TDMVCProjectNewControllerMenuItem.Create;
//    // Set menu item properties here
//    NewControllerMenu.OnExecute := MenuClickHandler;
//    ProjectManagerMenuList.Add(NewControllerMenu);
//  end;
//end;

end.
