unit DMVC.Expert.CodeGen.Templates.AureliusControllerUnit;

interface

uses
  Generics.Collections,
  DMVC.Expert.CodeGen.Templates.BaseUnit,
  DMVC.Expert.CodeGen.Templates.Intf,
  DMVC.Expert.CodeGen.GenerateAureliusControllers,
  DMVC.Expert.CodeGen.Templates.ControllerUnit;

type
  TDMVCAureliusControllerUnitTemplate = class(TDMVCControllerUnitTemplate)
  private
    FControllerClassName: string;
    FActionFilters: Boolean;
    FEndPoint: string;
    FPath: string;
    FAureliusItem: TAureliusListItem;

    FControllerType: TObjectList<TTypeDefinitionEntry>;

  protected
    procedure AddCode; override;
//    procedure BuildTemplate; override;
  public
    constructor Create(
      const AureliusItem: TAureliusListItem;
      const FileName: string;
      const ControllerName: string;
      const Path: string;
      const EndPoint: string;
      const IncludeActionFilters: Boolean = False); reintroduce;
    destructor Destroy; override;
  end;


implementation

uses
  SysUtils;

{ TDMVCAureliusControllerUnitTemplate }

procedure TDMVCAureliusControllerUnitTemplate.AddCode;
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

constructor TDMVCAureliusControllerUnitTemplate.Create(
  const AureliusItem: TAureliusListItem;
  const FileName, ControllerName, Path, EndPoint: string;
  const IncludeActionFilters: Boolean);
begin
  FAureliusItem := AureliusItem;
  FActionFilters := IncludeActionFilters;
  FPath := Path;
  FEndPoint := EndPoint;
end;

destructor TDMVCAureliusControllerUnitTemplate.Destroy;
begin
  FControllerType.Free;
  inherited;
end;

end.
