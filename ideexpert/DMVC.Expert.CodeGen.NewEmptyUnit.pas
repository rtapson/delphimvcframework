unit DMVC.Expert.CodeGen.NewEmptyUnit;

interface

uses
  ToolsApi,
  System.IOUtils,
  DMVC.Expert.CodeGen.NewUnit;

type
  TNewUnitEx = class(TNewUnit)
  private
    FUnitIdent: string;
  protected
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile; override;
  public
    constructor Create(
      const UnitIdent: string;
      const APersonality: string = '');
  end;

implementation

uses
  SysUtils,
  DMVC.Expert.CodeGen.SourceFile,
  DMVC.Expert.CodeGen.Templates.Intf,
  DMVC.Expert.CodeGen.Templates.EmptyUnit;

{ TNewUnitEx }

constructor TNewUnitEx.Create(
      const UnitIdent: string;
      const APersonality: string = '');
begin
  FUnitIdent := UnitIdent;
  Personality := APersonality;
end;

function TNewUnitEx.NewImplSource(
  const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
var
  EmptyUnit: IDMVCCodeTemplate;
begin
  EmptyUnit := TDMVCUnitTemplate.Create(FUnitIdent);
  Result := TSourceFile.Create(EmptyUnit.GetSource.Text, []);

end;

end.
