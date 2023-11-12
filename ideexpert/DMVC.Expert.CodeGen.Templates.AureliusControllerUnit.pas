unit DMVC.Expert.CodeGen.Templates.AureliusControllerUnit;

interface

uses
  Generics.Collections,
  DMVC.Expert.CodeGen.Templates.BaseUnit,
  DMVC.Expert.CodeGen.Templates.Intf,
  DMVC.Expert.CodeGen.GenerateAureliusControllers;

type
  TDMVCAureliusControllerUnitTemplate = class(TMVCBaseUnitTemplate)
  private
    FControllerClassName: string;
    FActionFilters: Boolean;
    FEndPoint: string;
    FPath: string;
    FAureliusItem: TAureliusListItem;

    FControllerType: TObjectList<TTypeDefinitionEntry>;

    procedure AddActionFilters;
    procedure AddCode;
  protected
    procedure BuildTemplate; override;
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

{ TDMVCAureliusControllerUnitTemplate }

procedure TDMVCAureliusControllerUnitTemplate.AddActionFilters;
begin

end;

procedure TDMVCAureliusControllerUnitTemplate.AddCode;
begin

end;

procedure TDMVCAureliusControllerUnitTemplate.BuildTemplate;
begin
  inherited;

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
