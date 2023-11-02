// *************************************************************************** }
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

unit MVCFramework.SQLGenerators.Firebird;

interface

uses
  System.Rtti,
  System.Generics.Collections,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  MVCFramework.ActiveRecord,
  MVCFramework.Commons,
  MVCFramework.RQL.Parser;

type
  TMVCSQLGeneratorFirebird = class(TMVCSQLGenerator)

  protected
    function GetCompilerClass: TRQLCompilerClass; override;
  public
    function CreateInsertSQL(
      const TableMap: TMVCTableMap;
      const ARInstance: TMVCActiveRecord): string; override;
    function GetSequenceValueSQL(const PKFieldName: string;
      const SequenceName: string;
      const Step: Integer = 1): string; override;
  end;

implementation

uses
  System.SysUtils,
  MVCFramework.RQL.AST2FirebirdSQL;

function TMVCSQLGeneratorFirebird.CreateInsertSQL(const TableMap: TMVCTableMap;
      const ARInstance: TMVCActiveRecord): string;
var
  lKeyValue: TPair<TRttiField, TFieldInfo>;
  lSB: TStringBuilder;
  lPKInInsert: Boolean;
  lFieldName: String;
begin
  lPKInInsert := (not TableMap.fPrimaryKeyFieldName.IsEmpty) and (not(TMVCActiveRecordFieldOption.foAutoGenerated in TableMap.fPrimaryKeyOptions));
  lPKInInsert := lPKInInsert and (not(TMVCActiveRecordFieldOption.foReadOnly in TableMap.fPrimaryKeyOptions));
  lSB := TStringBuilder.Create;
  try
    lSB.Append('INSERT INTO ' + GetTableNameForSQL(TableMap.fTableName) + ' (');
    if lPKInInsert then
    begin
      lSB.Append(GetFieldNameForSQL(TableMap.fPrimaryKeyFieldName) + ',');
    end;

    {partition}
    for lFieldName in fPartitionInfo.FieldNames do
    begin
      lSB.Append(GetFieldNameForSQL(lFieldName) + ',');
    end;
    {end-partition}

    for lKeyValue in TableMap.fMap do
    begin
      // if not(foTransient in lKeyValue.Value.FieldOptions) then
      if lKeyValue.Value.Writeable then
      begin
        lSB.Append(GetFieldNameForSQL(lKeyValue.Value.FieldName) + ',');
      end;
    end;

    lSB.Remove(lSB.Length - 1, 1);
    lSB.Append(') values (');
    if lPKInInsert then
    begin
      lSB.Append(':' + GetParamNameForSQL(TableMap.fPrimaryKeyFieldName) + ',');
    end;

    {partition}
    for lFieldName in fPartitionInfo.FieldNames do
    begin
      lSB.Append(':' + GetParamNameForSQL(lFieldName) + ',');
    end;
    {end-partition}

    for lKeyValue in TableMap.fMap do
    begin
      if lKeyValue.Value.IsVersion then
      begin
        lSB.Append(OBJECT_VERSION_STARTING_VALUE + ',');
      end else if lKeyValue.Value.Writeable then
      begin
        lSB.Append(':' + GetParamNameForSQL(lKeyValue.Value.FieldName) + ',');
      end;
    end;

    lSB.Remove(lSB.Length - 1, 1);
    lSB.Append(')');

    if TMVCActiveRecordFieldOption.foAutoGenerated in TableMap.fPrimaryKeyOptions then
    begin
      lSB.Append(' RETURNING ' + GetFieldNameForSQL(TableMap.fPrimaryKeyFieldName));
    end;
    Result := lSB.ToString;
  finally
    lSB.Free;
  end;
end;

function TMVCSQLGeneratorFirebird.GetCompilerClass: TRQLCompilerClass;
begin
  Result := TRQLFirebirdCompiler;
end;

function TMVCSQLGeneratorFirebird.GetSequenceValueSQL(
  const PKFieldName: string; const SequenceName: string; const Step: Integer): string;
begin
  Result := Format('select gen_id(%s,%d) %s from rdb$database', [GetFieldNameForSQL(SequenceName), Step, GetFieldNameForSQL(PKFieldName)]);
end;

initialization

TMVCSQLGeneratorRegistry.Instance.RegisterSQLGenerator('firebird', TMVCSQLGeneratorFirebird);

finalization

TMVCSQLGeneratorRegistry.Instance.UnRegisterSQLGenerator('firebird');

end.
