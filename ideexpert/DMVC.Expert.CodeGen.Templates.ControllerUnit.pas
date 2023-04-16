unit DMVC.Expert.CodeGen.Templates.ControllerUnit;

interface

uses
  Generics.Collections,
  DMVC.Expert.CodeGen.Templates.BaseUnit,
  DMVC.Expert.CodeGen.Templates.Intf;

type
  TDMVCControllerUnitTemplate = class(TMVCBaseUnitTemplate)
  private
    FControllerClassName: string;
    FActionFilters: Boolean;
    FSampleMethods: Boolean;
    FCRUDActions: Boolean;
    FEndPoint: string;
    FPath: string;

    FControllerType: TObjectList<TTypeDefinitionEntry>;

    procedure AddActionFilters;
    procedure AddSampleMethods;
    procedure AddCRUDMethods;
    procedure AddCode;
  protected
    procedure BuildTemplate; override;
  public
    constructor Create(
      const FileName: string;
      const ControllerName: string;
      const Path: string;
      const EndPoint: string;
      const IncludeCRUDACtions: Boolean = True;
      const IncludeActionFilters: Boolean = False;
      const IncludeSampleMethods: Boolean = False);
    destructor Destroy; override;

//    property ControllerClassName: string read FControllerClassName;
  end;

implementation

uses
  SysUtils;

{ TDMVCControllerUnitTemplate }

procedure TDMVCControllerUnitTemplate.AddActionFilters;
begin
  if not FActionFilters then Exit;

  FControllerType.AddRange([
    TTypeDefinitionEntry.Create(cvProtected, ttMethod,
    'procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;'),
    TTypeDefinitionEntry.Create(cvProtected, ttMethod,
    'procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;')]);

  if (ImplementationCode.Count > 0) and (ImplementationCode[ImplementationCode.Count- 1] <> '') then
    ImplementationCode.Add('');

  ImplementationCode.AddStrings([
    Format('procedure %s.OnAfterAction(Context: TWebContext; const AActionName: string);', [FControllerClassName]),
    'begin',
    '  { Executed after each action }',
    '  inherited;',
    'end;',
    '',
    Format('procedure %s.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);', [FControllerClassName]),
    'begin',
    '  { Executed before each action',
    '    if handled is true (or an exception is raised) the actual',
    '    action will not be called }',
    '  inherited;',
    'end;']);
end;

procedure TDMVCControllerUnitTemplate.AddCode;
var
  EntityName: string;
begin
  EntityName := FControllerClassName.Substring(1);
  if EntityName.EndsWith('Controller') then
    EntityName := EntityName.Replace('Controller', '');

  ImplementationCode.Add('');
  ImplementationCode.Add(Format('//Sample CRUD Actions for a "%s" entity', [EntityName]));
  ImplementationCode.Add(Format('procedure %0:s.Get%1:ss;', [FControllerClassName, EntityName]));
  ImplementationCode.Add('begin');
  ImplementationCode.Add(Format('  //todo: render a list of %ss', [EntityName]));
  ImplementationCode.Add('end;');
  ImplementationCode.Add('');
  ImplementationCode.Add(Format('procedure %0:s.Get%1:s(id: Integer);', [FControllerClassName, EntityName]));
  ImplementationCode.Add('begin');
  ImplementationCode.Add(Format('  //todo: render the %s by id', [EntityName]));
  ImplementationCode.Add('end;');
  ImplementationCode.Add('');
  ImplementationCode.Add(Format('procedure %0:s.Create%1:s;', [FControllerClassName, EntityName]));
  ImplementationCode.Add('begin');
  ImplementationCode.Add(Format('  //todo: create a new %s', [EntityName]));
  ImplementationCode.Add('end;');
  ImplementationCode.Add('');
  ImplementationCode.Add(Format('procedure %0:s.Update%1:s(id: Integer);', [FControllerClassName, EntityName]));
  ImplementationCode.Add('begin');
  ImplementationCode.Add(Format('  //todo: update %s by id', [EntityName]));
  ImplementationCode.Add('end;');
  ImplementationCode.Add('');
  ImplementationCode.Add(Format('procedure %0:s.Delete%1:s(id: Integer);', [FControllerClassName, EntityName]));
  ImplementationCode.Add('begin');
  ImplementationCode.Add(Format('  //todo: delete %s by id', [EntityName]));
  ImplementationCode.Add('end;');
end;

procedure TDMVCControllerUnitTemplate.AddCRUDMethods;
var
  CreateProc, GetProc, GetListProc, UpdateProc, DeleteProc: TTypeDefinitionEntry;
  EntityName: string;
begin
  if not FCRUDActions then Exit;

  EntityName := FControllerClassName.Substring(1);
  if EntityName.EndsWith('Controller') then
    EntityName := EntityName.Replace('Controller', '');

  GetListProc := TTypeDefinitionEntry.Create(cvPublic, ttMethod, Format('procedure Get%ss;', [EntityName]), blBoth);
  GetListProc.Attributes.Add(Format('[MVCPath(''/%s'')]', [FEndPoint]));
  GetListProc.Attributes.Add('[MVCHTTPMethod([httpGET])]');
  GetListProc.Comment.Add(Format('//Sample CRUD Actions for a "%s" entity', [EntityName]));

  GetProc := TTypeDefinitionEntry.Create(cvPublic, ttMethod, Format('procedure Get%s(id: Integer);', [EntityName]), blAFter);
  GetProc.Attributes.Add(Format('[MVCPath(''/%s/($id)'')]', [FEndPoint]));
  GetProc.Attributes.Add('[MVCHTTPMethod([httpGET])]');

  CreateProc := TTypeDefinitionEntry.Create(cvPublic, ttMethod, Format('procedure Create%s;', [EntityName]), blAfter);
  CreateProc.Attributes.Add(Format('[MVCPath(''/%s'')]', [FEndPoint]));
  CreateProc.Attributes.Add('[MVCHTTPMethod([httpPOST])]');

  UpdateProc := TTypeDefinitionEntry.Create(cvPublic, ttMethod, Format('procedure Update%s(id: Integer);', [EntityName]), blAfter);
  UpdateProc.Attributes.Add(Format('[MVCPath(''/%s/($id)'')]', [FEndPoint]));
  UpdateProc.Attributes.Add('[MVCHTTPMethod([httpPUT])]');

  DeleteProc := TTypeDefinitionEntry.Create(cvPublic, ttMethod, Format('procedure Delete%s(id: Integer);', [EntityName]), blAfter);
  DeleteProc.Attributes.Add(Format('[MVCPath(''/%s/($id)'')]', [FEndPoint]));
  DeleteProc.Attributes.Add('[MVCHTTPMethod([httpDELETE])]');

  FControllerType.AddRange([GetListProc, GetProc, CreateProc, UpdateProc, DeleteProc]);
end;

procedure TDMVCControllerUnitTemplate.AddSampleMethods;
var
  IndexProc: TTypeDefinitionEntry;
  ReverseStringProc: TTypeDefinitionEntry;
begin
  if not FSampleMethods then Exit;

  IndexProc := TTypeDefinitionEntry.Create(cvPublic, ttMethod, 'procedure Index;');
  IndexProc.Attributes.Add('[MVCPath]');
  IndexProc.Attributes.Add('[MVCHTTPMethod([httpGET])]');

  ReverseStringProc := TTypeDefinitionEntry.Create(cvPublic, ttMethod, 'procedure GetReversedString(const Value: String);');
  ReverseStringProc.Attributes.Add(''); //Add a blank line before the attributes start
  ReverseStringProc.Attributes.Add('[MVCPath(''/reversedstrings/($Value)'')]');
  ReverseStringProc.Attributes.Add('[MVCHTTPMethod([httpGET])]');

  FControllerType.AddRange([IndexProc, ReverseStringProc]);

  if (ImplementationCode.Count > 0) and (ImplementationCode[ImplementationCode.Count- 1] <> '') then
    ImplementationCode.Add('');

  ImplementationCode.AddStrings([
  Format('procedure %s.Index;', [FControllerClassName]),
  'begin',
  '  //use Context property to access to the HTTP request and response ',
  '  Render(''Hello DelphiMVCFramework World'');',
  'end;',
  '',
  Format('procedure %s.GetReversedString(const Value: String);', [FControllerClassName]),
  'begin',
  '  Render(System.StrUtils.ReverseString(Value.Trim));',
  'end;']);
end;

procedure TDMVCControllerUnitTemplate.BuildTemplate;
var
  ControllerClass: TTypeDefinitionEntry;
begin
  inherited;
  InterfaceUses.AddStrings(['MVCFramework', 'MVCFramework.Commons', 'MVCFramework.Serializer.Commons']);

  FControllerType := TObjectList<TTypeDefinitionEntry>.Create(True);
  ControllerClass := TTypeDefinitionEntry.Create(cvPublic, ttType, Format('%s = class(TMVCController)', [FControllerClassName]));

  { TODO -oRWT : Replace hard coded api path }
  ControllerClass.Attributes.Add(Format('[MVCPath(''%s'')]', [FPath]));
  FControllerType.Add(ControllerClass);

  AddActionFilters;
  AddSampleMethods;
  AddCRUDMethods;
  AddCode;

  InterfaceTypes.Add('TestController', FControllerType);

  ImplementationUses.AddStrings(['System.SysUtils', 'MVCFramework.Logger', 'System.StrUtils']);
end;

constructor TDMVCControllerUnitTemplate.Create(
      const FileName: string;
      const ControllerName: string;
      const Path: string;
      const EndPoint: string;
      const IncludeCRUDACtions: Boolean = True;
      const IncludeActionFilters: Boolean = False;
      const IncludeSampleMethods: Boolean = False);
begin
  FControllerClassName := ControllerName;
  FSampleMethods := IncludeSampleMethods;
  FActionFilters := IncludeActionFilters;
  FCRUDActions := IncludeCRUDACtions;
  FPath := Path;
  if EndPoint.StartsWith('/') then
    FEndPoint := EndPoint.Substring(1)
  else
    FEndPoint := EndPoint;
  inherited Create(FileName);
end;

destructor TDMVCControllerUnitTemplate.Destroy;
begin
  FControllerType.Free;
  inherited;
end;

end.
