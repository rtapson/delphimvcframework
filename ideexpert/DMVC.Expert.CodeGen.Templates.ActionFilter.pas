unit DMVC.Expert.CodeGen.Templates.ActionFilter;

interface

uses
  Classes,
  DMVC.Expert.CodeGen.Templates.Intf;

type
  TDMVCActionFilterTemplate = class(TInterfacedObject)//, IDMVCCodeTemplate)
  public
    function GetSource: TStringList;
  end;

implementation

{ TDMVCActionFilterTemplate }

function TDMVCActionFilterTemplate.GetSource: TStringList;
begin
  Result.Add('    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;');
  Result.Add('    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;');

//  Result.Text :=
//    '  protected' + sLineBreak +
//    '    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;'
//    + sLineBreak +
//    '    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;' +
//    sLineBreak;
end;

end.
