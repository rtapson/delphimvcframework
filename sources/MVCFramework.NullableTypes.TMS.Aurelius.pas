// ***************************************************************************
//
// Delphi MVC Framework
//
// Copyright (c) 2010-2023 Daniele Teti and the DMVCFramework Team
//
// https://github.com/danieleteti/delphimvcframework
//
// Collaborators on this file: Randy Tapson (rwtapson@gmail.com)
//
// TNullabletypes requires TMS Aurelius ORM.
//
// https://www.tmssoftware.com/site/aurelius.asp
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
// *************************************************************************** }
unit MVCFramework.NullableTypes.TMS.Aurelius;

interface

uses
  MVCFramework.Serializer.Intf,
  Aurelius.Types.Nullable;

type
  /// <summary>Alias for nullables types of TMS Aurelius</summary>
  TNullableInteger = Nullable<Integer>;
  TNullableInt64 = Nullable<Int64>;
  TNullableCurrency = Nullable<Currency>;
  TNullableString = Nullable<string>;
  TNullableDateTime = Nullable<TDateTime>;
  TNullableDate = Nullable<TDate>;
  TNullableTime = Nullable<TTime>;
  TNullableGuid = Nullable<TGuid>;
  TNullableDouble = Nullable<Double>;
  TNullableBoolean = Nullable<Boolean>;

  /// <summary>Register all NullablesSerializers in your serializer</summary>
  /// <param name="ASerializer">Aurelius Serializer</param>
procedure RegisterAureliusNullableTypeSerializersInSerializer(ASerializer: IMVCSerializer);

implementation

uses
  System.Rtti,
  System.SysUtils,
  JsonDataObjects,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons;

type
  TAureliusNullableIntegerSerializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableDoubleSerializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableInt64Serializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableCurrencySerializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableStringSerializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableDateTimeSerializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableDateSerializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableTimeSerializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableGuidSerializer = class(TInterfacedObject, IMVCTypeSerializer)
  private
    function GuidFromString(const AGuidStr: string): TGUID;
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

  TAureliusNullableBooleanSerializer = class(TInterfacedObject, IMVCTypeSerializer)
  public
    procedure SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
      const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);

    procedure DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
      const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);

    procedure DeserializeRoot(const ASerializerObject: TObject; const AObject: TObject;
      const AAttributes: TArray<TCustomAttribute>);
  end;

{ TNullableIntegerSerializer }

procedure TAureliusNullableIntegerSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullInt: TNullableInteger;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullInt := sNull;
  end
  else
  begin
    LNullInt := LJSON.I[APropertyName];
  end;
  AElementValue := TValue.From<TNullableInteger>(LNullInt);
end;

procedure TAureliusNullableIntegerSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableIntegerSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LNullInteger: TNullableInteger;
begin
  LNullInteger := AElementValue.AsType<TNullableInteger>;
  if LNullInteger.HasValue then
    (ASerializerObject as TJDOJsonObject).I[APropertyName] := LNullInteger.Value
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableIntegerSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableInt64Serializer }

procedure TAureliusNullableInt64Serializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullInt64: TNullableInt64;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullInt64 := sNull;
  end
  else
  begin
    LNullInt64 := LJSON.L[APropertyName];
  end;
  AElementValue := TValue.From<TNullableInt64>(LNullInt64);
end;

procedure TAureliusNullableInt64Serializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableInt64Serializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LNullInt64: TNullableInt64;
begin
  LNullInt64 := AElementValue.AsType<TNullableInt64>;
  if LNullInt64.HasValue then
    (ASerializerObject as TJDOJsonObject).L[APropertyName] := LNullInt64.Value
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableInt64Serializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableCurrencySerializer }

procedure TAureliusNullableCurrencySerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullCurrency: TNullableCurrency;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullCurrency := sNull;
  end
  else
  begin
    LNullCurrency := Currency(LJSON.F[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableCurrency>(LNullCurrency);
end;

procedure TAureliusNullableCurrencySerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableCurrencySerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LNullCurrency: TNullableCurrency;
begin
  LNullCurrency := AElementValue.AsType<TNullableCurrency>;
  if LNullCurrency.HasValue then
    (ASerializerObject as TJDOJsonObject).F[APropertyName] := LNullCurrency.Value
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableCurrencySerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableStringSerializer }

procedure TAureliusNullableStringSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullString: TNullableString;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullString := sNull;
  end
  else
  begin
    LNullString := LJSON.S[APropertyName];
  end;
  AElementValue := TValue.From<TNullableString>(LNullString);
end;

procedure TAureliusNullableStringSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableStringSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LNullString: TNullableString;
begin
  LNullString := AElementValue.AsType<TNullableString>;
  if LNullString.HasValue then
    (ASerializerObject as TJDOJsonObject).S[APropertyName] := LNullString.Value
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableStringSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableDateTimeSerializer }

procedure TAureliusNullableDateTimeSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullDateTime: TNullableDateTime;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullDateTime := sNull;
  end
  else
  begin
    LNullDateTime := ISOTimeStampToDateTime(LJSON.S[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableDateTime>(LNullDateTime);
end;

procedure TAureliusNullableDateTimeSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableDateTimeSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LNullDateTime: TNullableDateTime;
begin
  LNullDateTime := AElementValue.AsType<TNullableDateTime>;
  if LNullDateTime.HasValue then
    (ASerializerObject as TJDOJsonObject).S[APropertyName] := DateTimeToISOTimeStamp(LNullDateTime.Value)
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableDateTimeSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableDateSerializer }

procedure TAureliusNullableDateSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullDate: TNullableDate;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullDate := sNull;
  end
  else
  begin
    LNullDate := ISODateToDate(LJSON.S[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableDate>(LNullDate);
end;

procedure TAureliusNullableDateSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableDateSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LNullDate: TNullableDate;
begin
  LNullDate := AElementValue.AsType<TNullableDate>;
  if LNullDate.HasValue then
    (ASerializerObject as TJDOJsonObject).S[APropertyName] := DateToISODate(LNullDate.Value)
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableDateSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableTimeSerializer }

procedure TAureliusNullableTimeSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullTime: TNullableTime;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullTime := sNull;
  end
  else
  begin
    LNullTime := ISOTimeToTime(LJSON.S[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableTime>(LNullTime);
end;

procedure TAureliusNullableTimeSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableTimeSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LNullTime: TNullableTime;
begin
  LNullTime := AElementValue.AsType<TNullableTime>;
  if LNullTime.HasValue then
    (ASerializerObject as TJDOJsonObject).S[APropertyName] := TimeToISOTime(LNullTime.Value)
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableTimeSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableGuidSerializer }

procedure TAureliusNullableGuidSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullGuid: TNullableGuid;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullGuid := sNull;
  end
  else
  begin
    try
      LNullGuid := GuidFromString(LJSON.S[APropertyName]);
    except
      LNullGuid := sNull;
    end;
  end;
  AElementValue := TValue.From<TNullableGuid>(LNullGuid);
end;

procedure TAureliusNullableGuidSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

function TAureliusNullableGuidSerializer.GuidFromString(const AGuidStr: string): TGUID;
var
  LGuidStr: string;
begin
  // delphi uuid format: {ae502abe-430b-b23a-2878-2d18d6a6e465}

  // string uuid without braces and dashes: ae502abe430bb23a28782d18d6a6e465
  if AGuidStr.Length = 32 then
    LGuidStr := Format('{%s-%s-%s-%s-%s}', [AGuidStr.Substring(0, 8), AGuidStr.Substring(8, 4),
      AGuidStr.Substring(12, 4), AGuidStr.Substring(16, 4), AGuidStr.Substring(20, 12)])

    // string uuid without braces: ae502abe-430b-b23a-2878-2d18d6a6e465
  else if AGuidStr.Length = 36 then
    LGuidStr := Format('{%s}', [AGuidStr])
  else
    LGuidStr := AGuidStr;
  Result := StringToGUID(LGuidStr);
end;

procedure TAureliusNullableGuidSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LNullGuid: TNullableGuid;
begin
  LNullGuid := AElementValue.AsType<TNullableGuid>;
  if LNullGuid.HasValue then
  begin
    if TMVCSerializerHelper.AttributeExists<MVCSerializeGuidWithoutBracesAttribute>(AAttributes) then
      (ASerializerObject as TJDOJsonObject).S[APropertyName] := TMVCGuidHelper.GUIDToStringEx(LNullGuid.Value)
    else
      (ASerializerObject as TJDOJsonObject).S[APropertyName] := LNullGuid.Value.ToString
  end
  else
  begin
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
  end;
end;

procedure TAureliusNullableGuidSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableDoubleSerializer }

procedure TAureliusNullableDoubleSerializer.DeserializeAttribute(
  var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullDouble: TNullableDouble;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullDouble := sNull;
  end
  else
  begin
    LNullDouble := LJSON.F[APropertyName];
  end;
  AElementValue := TValue.From<TNullableDouble>(LNullDouble);
end;

procedure TAureliusNullableDoubleSerializer.DeserializeRoot(const ASerializerObject,
  AObject: TObject; const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableDoubleSerializer.SerializeAttribute(
  const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
var
  LNullDouble: TNullableDouble;
begin
  LNullDouble := AElementValue.AsType<TNullableDouble>;
  if LNullDouble.HasValue then
    (ASerializerObject as TJDOJsonObject).F[APropertyName] := LNullDouble.Value
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableDoubleSerializer.SerializeRoot(const AObject: TObject;
  out ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>;
  const ASerializationAction: TMVCSerializationAction);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableBooleanSerializer }

procedure TAureliusNullableBooleanSerializer.DeserializeAttribute(
  var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullBoolean: TNullableBoolean;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
      LNullBoolean := sNull;
  end
  else
  begin
    LNullBoolean := Boolean(LJSON.B[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableBoolean>(LNullBoolean);
end;

procedure TAureliusNullableBooleanSerializer.DeserializeRoot(
  const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TAureliusNullableBooleanSerializer.SerializeAttribute(
  const AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
var
  LNullBoolean: TNullableBoolean;
begin
  LNullBoolean := AElementValue.AsType<TNullableBoolean>;
  if LNullBoolean.HasValue then
    (ASerializerObject as TJDOJsonObject).B[APropertyName] := LNullBoolean.Value
  else
    (ASerializerObject as TJDOJsonObject).Values[APropertyName] := nil;
end;

procedure TAureliusNullableBooleanSerializer.SerializeRoot(const AObject: TObject;
  out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>;
  const ASerializationAction: TMVCSerializationAction);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure RegisterAureliusNullableTypeSerializersInSerializer(ASerializer: IMVCSerializer);
begin
  Assert(TObject(ASerializer).ClassName = 'TMVCJsonDataObjectsSerializer',
    'Nullables Custom Serializer can be used only with "TMVCJsonDataObjectsSerializer"');
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableInteger), TAureliusNullableIntegerSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableInt64), TAureliusNullableInt64Serializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableCurrency), TAureliusNullableCurrencySerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableString), TAureliusNullableStringSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableDateTime), TAureliusNullableDateTimeSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableDate), TAureliusNullableDateSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableTime), TAureliusNullableTimeSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableGuid), TAureliusNullableGuidSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableDouble), TAureliusNullableDoubleSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableBoolean), TAureliusNullableBooleanSerializer.Create);
end;

end.
