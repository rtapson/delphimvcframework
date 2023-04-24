// ***************************************************************************
//
// Delphi MVC Framework
//
// Copyright (c) 2010-2023 Daniele Teti and the DMVCFramework Team
//
// https://github.com/danieleteti/delphimvcframework
//
// ***************************************************************************
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// ***************************************************************************
//
// This IDE expert is based off of the one included with the DUnitX
// project.  Original source by Robert Love.  Adapted by Nick Hodges.
//
// The DUnitX project is run by Vincent Parrett and can be found at:
//
// https://github.com/VSoftTechnologies/DUnitX
// ***************************************************************************

unit DMVC.Expert.CodeGen.Templates.BaseUnit;

interface

uses
  Classes,
  Rtti,
  Generics.Collections,
  DMVC.Expert.CodeGen.Templates.Intf;

type
  TMVCBaseUnitTemplate = class(TInterfacedObject, IDMVCCodeTemplate)
  private
    FInterfaceUses: TStringList;
    FInterfaceConst: TStringList;
    FInterfaceType: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
    FInterfaceCode: TStringList;
    FFileName: string;
    FImplementationUses: TStringList;
    FImplementationConst: TStringList;
    FImplementationType: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
    FImplementationCode: TStringList;
    FInitializationSection: TStringList;
    FFinalizationSection: TStringList;

    procedure ProcessUses(const UsesClause: TStringList; const UnitText: TStringList);
    procedure ProcessConst(const Consts: TStringList; const UnitText: TStringList);
    procedure ProcessTypes(const Types: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>; const UnitText: TStringList);
    procedure ProcessCode(const Code: TStringList; const UnitText: TStringList);
    procedure ProcessSection(const SectionName: string; const Section: TStringList; const UnitText: TStringList);
    procedure ProcessAttributes(const ClassDef: TTypeDefinitionEntry; const UnitText: TStringList; const Indent: Integer);
    procedure ProcessComments(const ClassDef: TTypeDefinitionEntry; const UnitText: TStringList; const Indent: Integer);

    function GetInterfaceConst: TStringList;
    function GetInterfaceType: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
    function GetInterfaceUses: TStringList;
    function GetFileName: string;
    procedure SetFileName(const Value: string);
    function GetImplementationCode: TStringList;
    function GetImplementationConst: TStringList;
    function GetImplementationType: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
    function GetImplementationUses: TStringList;
    function GetInterfaceCode: TStringList;
    function GetFinalizationSection: TStringList;
    function GetInitializationSection: TStringList;
  protected
    procedure BuildTemplate; virtual;
  public
    constructor Create(const UnitName: string); virtual;
    destructor Destroy; override;
    function GetSource: TStringList; virtual;

    property FileName: string read GetFileName write SetFileName;
    property InterfaceUses: TStringList read GetInterfaceUses;
    property InterfaceConst: TStringList read GetInterfaceConst;
    property InterfaceTypes: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>> read GetInterfaceType;
    property InterfaceCode: TStringList read GetInterfaceCode;

    property ImplementationUses: TStringList read GetImplementationUses;
    property ImplementationConst: TStringList read GetImplementationConst;
    property ImplementationTypes: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>> read GetImplementationType;
    property ImplementationCode: TStringList read GetImplementationCode;

    property InitializationSection: TStringList read GetInitializationSection;
    property FinalizationSection: TStringList read GetFinalizationSection;

  end;

implementation

uses
  SysUtils;

{ TMVCBaseUnitTemplate }

procedure TMVCBaseUnitTemplate.BuildTemplate;
begin
  //override in descendants
end;

constructor TMVCBaseUnitTemplate.Create(const UnitName: string);
begin
  FFileName := UnitName;
  FInterfaceUses := TStringList.Create;
  FInterfaceConst := TStringList.Create;
  FInterfaceType := TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>.Create;
  FInterfaceCode := TStringList.Create;
  FImplementationUses := TStringList.Create;
  FImplementationConst := TStringList.Create;
  FImplementationType := TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>.Create;
  FImplementationCode := TStringlist.Create;
  FFinalizationSection := TStringList.Create;
  FInitializationSection := TStringList.Create;
  BuildTemplate;
end;

destructor TMVCBaseUnitTemplate.Destroy;
begin
  FInterfaceUses.Free;
  FInterfaceConst.Free;
  FInterfaceType.Free;
  FInterfaceCode.Free;
  FImplementationUses.Free;
  FImplementationConst.Free;
  FImplementationType.Free;
  FImplementationCode.Free;
  FFinalizationSection.Free;
  FInitializationSection.Free;
  inherited;
end;

function TMVCBaseUnitTemplate.GetImplementationCode: TStringList;
begin
  Result := FImplementationCode;
end;

function TMVCBaseUnitTemplate.GetImplementationConst: TStringList;
begin
  Result := FImplementationConst;
end;

function TMVCBaseUnitTemplate.GetImplementationType: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
begin
  Result := FImplementationType;
end;

function TMVCBaseUnitTemplate.GetImplementationUses: TStringList;
begin
  Result := FImplementationUses
end;

function TMVCBaseUnitTemplate.GetInitializationSection: TStringList;
begin
  Result := FInitializationSection;
end;

function TMVCBaseUnitTemplate.GetInterfaceCode: TStringList;
begin
  Result := FInterfaceCode;
end;

function TMVCBaseUnitTemplate.GetInterfaceConst: TStringList;
begin
  Result := FInterfaceConst;
end;

function TMVCBaseUnitTemplate.GetInterfaceType: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
begin
  Result := FInterfaceType;
end;

function TMVCBaseUnitTemplate.GetInterfaceUses: TStringList;
begin
  Result := FInterfaceUses;
end;

function TMVCBaseUnitTemplate.GetSource: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('unit ' + FileName + ';');
  Result.Add('');
  Result.Add('interface');
  Result.Add('');
  ProcessUses(InterfaceUses, Result);
  ProcessConst(InterfaceConst, Result);
  ProcessTypes(InterfaceTypes, Result);
  ProcessCode(InterfaceCode, Result);
  Result.Add('implementation');
  Result.Add('');
  ProcessUses(ImplementationUses, Result);
  ProcessConst(ImplementationConst, Result);
  ProcessTypes(ImplementationTypes, Result);
  ProcessCode(ImplementationCode, Result);
  ProcessSection('initialization', InitializationSection, Result);
  ProcessSection('finalization', FinalizationSection, Result);
  Result.Add('end.');
end;

function TMVCBaseUnitTemplate.GetFileName: string;
begin
  Result := FFileName;
end;

function TMVCBaseUnitTemplate.GetFinalizationSection: TStringList;
begin
  Result := FFinalizationSection;
end;

procedure TMVCBaseUnitTemplate.ProcessAttributes(
  const ClassDef: TTypeDefinitionEntry;
  const UnitText: TStringList;
  const Indent: Integer);
var
  IndentStr: string;
begin
  for var Attribute in ClassDef.Attributes do
  begin
    if Attribute.Length > 0 then
      IndentStr := InDentStr.Create(' ', Indent);
    UnitText.Add(IndentStr + Attribute);
  end;
end;

procedure TMVCBaseUnitTemplate.ProcessCode(const Code, UnitText: TStringList);
begin
  if Code.Count = 0 then Exit;
  for var value in Code do
  begin
    UnitText.Add(value);
  end;
  UnitText.Add('');
end;

procedure TMVCBaseUnitTemplate.ProcessComments(
  const ClassDef: TTypeDefinitionEntry;
  const UnitText: TStringList;
  const Indent: Integer);
var
  IndentStr: string;
begin
  for var Comment in ClassDef.Comment do
  begin
    if Comment.Length > 0 then
      IndentStr := InDentStr.Create(' ', Indent);
    UnitText.Add(IndentStr + Comment);
  end;
end;

procedure TMVCBaseUnitTemplate.ProcessConst(const Consts: TStringList; const UnitText: TStringList);
begin
  if Consts.Count = 0 then Exit;

  UnitText.Add('const');
  for var value in Consts do
  begin
    UnitText.Add('  ' + value);
  end;
  UnitText.Add('');
end;

procedure TMVCBaseUnitTemplate.ProcessSection(const SectionName: string; const Section, UnitText: TStringList);
begin
  if Section.Count = 0 then Exit;
  UnitText.Add(SectionName);
  for var value in Section do
  begin
    UnitText.Add(value);
  end;
  UnitText.Add('');
end;

procedure TMVCBaseUnitTemplate.ProcessTypes(
  const Types: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
  const UnitText: TStringList);
begin
  if TYpes.Count = 0 then Exit;

  UnitText.Add('type');
  for var ClassType in Types do
  begin
    //type definition
    for var ClassDef in ClassType.Value do
    begin
      if ClassDef.TextType = ttType then
      begin
        ProcessAttributes(ClassDef, UnitText, 2);
        UnitText.Add('  ' + ClassDef.Text);
      end;
    end;

    //private
    UnitText.Add('  private');
    for var ClassDef in ClassType.Value do
    begin
      if ClassDef.Visibility = cvPrivate then
      begin
        ProcessAttributes(ClassDef, UnitText, 4);
        UnitText.Add('    ' + ClassDef.Text);
      end;
    end;


    //protected
    UnitText.Add('  protected');
    for var ClassDef in ClassType.Value do
    begin
      if ClassDef.Visibility = cvProtected then
      begin
        ProcessAttributes(ClassDef, UnitText, 4);
        UnitText.Add('    ' + ClassDef.Text);
      end;
    end;


    //public
    UnitText.Add('  public');
    for var ClassDef in ClassType.Value do
    begin
      if (ClassDef.Visibility = cvPublic) and (ClassDef.TextType <> ttType) then
      begin
        if ClassDef.BlankLines in [blBefore, blBoth] then UnitText.Add('');
        ProcessComments(ClassDef, UnitText, 4);
        ProcessAttributes(ClassDef, UnitText, 4);
        UnitText.Add('    ' + ClassDef.Text);
        if ClassDef.BlankLines in [blAfter, blBoth] then UnitText.Add('');
      end;
    end;

    //published
    UnitText.Add('  published');
    for var ClassDef in ClassType.Value do
    begin
      if ClassDef.Visibility = cvPublished then
      begin
        ProcessAttributes(ClassDef, UnitText, 4);
        UnitText.Add('    ' + ClassDef.Text);
      end;
    end;

    UnitText.Add('  end;');
    UnitText.Add('');
  end;


end;

procedure TMVCBaseUnitTemplate.ProcessUses(const UsesClause: TStringList; const UnitText: TStringList);
begin
  if UsesClause.Count = 0 then Exit;

  UnitText.Add('uses');
  for var value in UsesClause do
  begin
    UnitText.Add('  ' + value + ',');
  end;
  UnitText[UnitText.Count - 1] := UnitText[UnitText.Count - 1].Remove(UnitText[UnitText.Count - 1].LastDelimiter(',')) + ';';
  UnitText.Add('');
end;

procedure TMVCBaseUnitTemplate.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

end.
