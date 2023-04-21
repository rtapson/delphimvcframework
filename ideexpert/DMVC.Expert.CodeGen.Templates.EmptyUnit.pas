unit DMVC.Expert.CodeGen.Templates.EmptyUnit;

interface

uses
  Generics.Collections,
  DMVC.Expert.CodeGen.Templates.BaseUnit,
  DMVC.Expert.CodeGen.Templates.Intf;

type
  TDMVCUnitTemplate = class(TMVCBaseUnitTemplate)
  protected
    procedure BuildTemplate; override;
  public
    constructor Create(const FileName: string);
  end;

implementation

{ TDMVCControllerUnitTemplate }

procedure TDMVCUnitTemplate.BuildTemplate;
begin
  inherited;
end;

constructor TDMVCUnitTemplate.Create(const FileName: string);
begin
  inherited Create(FileName);
end;

end.
