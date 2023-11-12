unit DMVC.Expert.Codegen.GenerateAureliusControllers;

interface

uses
  Classes, Generics.Collections;

type
  TAureliusListItem = class
  private
    FFileName: string;
    FEntityName: string;
    FEntityClassName: string;
    FEntityUnitName: string;
  public
    constructor Create(
      const FileName: string;
      const EntityName: string;
      const EntityClassName: string;
      const EntityUnitName: string);

    procedure Assign(const Source: TAureliusListItem);

    property FileName: string read FFileName;
    property EntityName: string read FEntityName;
    property EntityClassName: string read FEntityClassName;
    property EnityUnitName: string read FEntityUnitName;
  end;

  TGenerateAureliusControllers = class
  private
    FEntityNames: TObjectList<TAureliusListItem>;

    procedure ParseUnitForEntities(const FileName: string; const EntityList: TObjectList<TAureliusListItem>);
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetAureliusEntities;
    property EntityNames: TObjectList<TAureliusListItem> read FEntityNames write FEntityNames;
  end;

implementation

uses
  ToolsApi, SysUtils, IOUtils;

{ TGenerateAureliusControllers }

constructor TGenerateAureliusControllers.Create;
begin
  FEntityNames := TObjectList<TAureliusListItem>.Create(True);
end;

destructor TGenerateAureliusControllers.Destroy;
begin
  FEntityNames.Free;
  inherited;
end;

{ TODO : Should the list of entities be filtered by entities that already have a controller. }
procedure TGenerateAureliusControllers.GetAureliusEntities;
var
  Project: IOTAProject;
  FileList: TStringList;
  FileName: string;
begin
  Project := GetActiveProject;
  FileList := TStringList.Create;
  try
    Project.GetCompleteFileList(FileList);
    for FileName in FileList do
    begin
      ParseUnitForEntities(FileName, EntityNames);
    end;
  finally
    FileList.Free;
  end;
end;

procedure TGenerateAureliusControllers.ParseUnitForEntities(
  const FileName: string; const EntityList: TObjectList<TAureliusListItem>);
var
  LookingForEntityClass: Boolean;
begin
  LookingForEntityClass := False;

  if not FileName.EndsWith('.pas', True) then Exit;

  var sData := TFile.ReadAllLines(FileName);

  for var sLine in sData do
  begin
    if sLine.StartsWith('implementation') then Break;

    if LookingForEntityClass then
    begin
      if sLine.Contains('class') then
      begin
        //Parse the line for the Aurelius data
        var EntityClassName := sLine.SubString(1, sLine.IndexOf('=') - 2).Trim;
        var EntityUnitName := TPath.GetFileNameWithoutExtension(FileName);
        var EntityName := EntityClassName.Substring(1);

        EntityList.Add(TAureliusListItem.Create(FileName, EntityName, EntityClassName, EntityUnitName));

        LookingForEntityClass := False;
      end;
    end;

    LookingForEntityClass := LookingForEntityClass or sLine.Contains('[Entity]')
  end;
end;


{ TAureliusListItem }

procedure TAureliusListItem.Assign(const Source: TAureliusListItem);
begin
  Self.FFileName := Source.FileName;
  Self.FEntityName := Source.EntityName;
  Self.FEntityClassName := Source.EntityClassName;
  Self.FEntityUnitName := Source.FEntityUnitName;
end;

constructor TAureliusListItem.Create(const FileName, EntityName,
  EntityClassName, EntityUnitName: string);
begin
  FFileName := FileName;
  FEntityName := EntityName;
  FEntityClassName := EntityClassName;
  FEntityUnitName := EntityUnitName;
end;

end.
