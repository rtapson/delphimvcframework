// ***************************************************************************
//
// Delphi MVC Framework
//
// Copyright (c) 2010-2023 Daniele Teti and the DMVCFramework Team
//
// https://github.com/danieleteti/delphimvcframework
//
// Collaborators on this file: João Antônio Duarte (joao.antonioduarte@hotmail.com)
//
// TNullabletypes requires spring4d framework
//
// https://bitbucket.org/sglienke/spring4d.git
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

unit MVCFramework.NullableTypes.Spring;

interface

uses
  MVCFramework.Serializer.Intf,
  Spring;

type
  TNullableInteger = Spring.TNullableInteger;
  TNullableInt64 = Spring.TNullableInt64;
  TNullableCurrency = Spring.TNullableCurrency;
  TNullableString = Spring.TNullableString;
  TNullableDateTime = Spring.TNullableDateTime;
  TNullableDate = Spring.Nullable<TDate>;
  TNullableTime = Spring.Nullable<TTime>;
  TNullableGuid = Spring.TNullableGuid;
  TNullableDouble = Spring.TNullableDouble;
  TNullableBoolean = Spring.TNullableBoolean;

  /// <summary>Register all NullablesSerializers in your serializer</summary>
  /// <param name="ASerializer">Your Serializer</param>
procedure RegisterSpringNullableTypeSerializersInSerializer(ASerializer: IMVCSerializer);

implementation

uses
  System.SysUtils,
  JsonDataObjects,
  MVCFramework.Serializer.Commons,
  System.Rtti,
  MVCFramework.Commons;

type
  TSpringNullableIntegerSerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableDoubleSerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableInt64Serializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableCurrencySerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableStringSerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableDateTimeSerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableDateSerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableTimeSerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableGuidSerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

  TSpringNullableBooleanSerializer = class(TInterfacedObject, IMVCTypeSerializer)
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

procedure TSpringNullableIntegerSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullInt: TNullableInteger;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullInt := nil;
  end
  else
  begin
    LNullInt := LJSON.I[APropertyName];
  end;
  AElementValue := TValue.From<TNullableInteger>(LNullInt);
end;

procedure TSpringNullableIntegerSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableIntegerSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
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

procedure TSpringNullableIntegerSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableInt64Serializer }

procedure TSpringNullableInt64Serializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullInt64: TNullableInt64;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullInt64 := nil;
  end
  else
  begin
    LNullInt64 := LJSON.L[APropertyName];
  end;
  AElementValue := TValue.From<TNullableInt64>(LNullInt64);
end;

procedure TSpringNullableInt64Serializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableInt64Serializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
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

procedure TSpringNullableInt64Serializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableCurrencySerializer }

procedure TSpringNullableCurrencySerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullCurrency: TNullableCurrency;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullCurrency := nil;
  end
  else
  begin
    LNullCurrency := Currency(LJSON.F[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableCurrency>(LNullCurrency);
end;

procedure TSpringNullableCurrencySerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableCurrencySerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
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

procedure TSpringNullableCurrencySerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableStringSerializer }

procedure TSpringNullableStringSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullString: TNullableString;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullString := nil;
  end
  else
  begin
    LNullString := LJSON.S[APropertyName];
  end;
  AElementValue := TValue.From<TNullableString>(LNullString);
end;

procedure TSpringNullableStringSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableStringSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
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

procedure TSpringNullableStringSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableDateTimeSerializer }

procedure TSpringNullableDateTimeSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullDateTime: TNullableDateTime;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullDateTime := nil;
  end
  else
  begin
    LNullDateTime := ISOTimeStampToDateTime(LJSON.S[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableDateTime>(LNullDateTime);
end;

procedure TSpringNullableDateTimeSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableDateTimeSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
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

procedure TSpringNullableDateTimeSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableDateSerializer }

procedure TSpringNullableDateSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullDate: TNullableDate;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullDate := nil;
  end
  else
  begin
    LNullDate := ISODateToDate(LJSON.S[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableDate>(LNullDate);
end;

procedure TSpringNullableDateSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableDateSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
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

procedure TSpringNullableDateSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableTimeSerializer }

procedure TSpringNullableTimeSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullTime: TNullableTime;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullTime := nil;
  end
  else
  begin
    LNullTime := ISOTimeToTime(LJSON.S[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableTime>(LNullTime);
end;

procedure TSpringNullableTimeSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableTimeSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
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

procedure TSpringNullableTimeSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableGuidSerializer }

procedure TSpringNullableGuidSerializer.DeserializeAttribute(var AElementValue: TValue; const APropertyName: string;
  const ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>);
var
  LJSON: TJDOJsonObject;
  LNullGuid: TNullableGuid;
begin
  LJSON := ASerializerObject as TJDOJsonObject;
  if LJSON.Values[APropertyName].Typ in [jdtNone, jdtObject] then { json nulls are recognized as jdtObject }
  begin
    LNullGuid := nil;
  end
  else
  begin
    try
      LNullGuid := GuidFromString(LJSON.S[APropertyName]);
    except
      LNullGuid := nil;
    end;
  end;
  AElementValue := TValue.From<TNullableGuid>(LNullGuid);
end;

procedure TSpringNullableGuidSerializer.DeserializeRoot(const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

function TSpringNullableGuidSerializer.GuidFromString(const AGuidStr: string): TGUID;
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

procedure TSpringNullableGuidSerializer.SerializeAttribute(const AElementValue: TValue; const APropertyName: string;
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

procedure TSpringNullableGuidSerializer.SerializeRoot(const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>; const ASerializationAction: TMVCSerializationAction = nil);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TNullableDoubleSerializer }

procedure TSpringNullableDoubleSerializer.DeserializeAttribute(
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
    LNullDouble := nil;
  end
  else
  begin
    LNullDouble := LJSON.F[APropertyName];
  end;
  AElementValue := TValue.From<TNullableDouble>(LNullDouble);
end;

procedure TSpringNullableDoubleSerializer.DeserializeRoot(const ASerializerObject,
  AObject: TObject; const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableDoubleSerializer.SerializeAttribute(
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

procedure TSpringNullableDoubleSerializer.SerializeRoot(const AObject: TObject;
  out ASerializerObject: TObject; const AAttributes: TArray<TCustomAttribute>;
  const ASerializationAction: TMVCSerializationAction);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

{ TSptringNullableBooleanSerializer }

procedure TSpringNullableBooleanSerializer.DeserializeAttribute(
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
      LNullBoolean := nil;
  end
  else
  begin
    LNullBoolean := Boolean(LJSON.B[APropertyName]);
  end;
  AElementValue := TValue.From<TNullableBoolean>(LNullBoolean);
end;

procedure TSpringNullableBooleanSerializer.DeserializeRoot(
  const ASerializerObject, AObject: TObject;
  const AAttributes: TArray<TCustomAttribute>);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure TSpringNullableBooleanSerializer.SerializeAttribute(
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

procedure TSpringNullableBooleanSerializer.SerializeRoot(
  const AObject: TObject; out ASerializerObject: TObject;
  const AAttributes: TArray<TCustomAttribute>;
  const ASerializationAction: TMVCSerializationAction);
begin
  raise EMVCSerializationException.Create('Not implemented');
end;

procedure RegisterSpringNullableTypeSerializersInSerializer(ASerializer: IMVCSerializer);
begin
  Assert(TObject(ASerializer).ClassName = 'TMVCJsonDataObjectsSerializer',
    'Nullables Custom Serializer can be used only with "TMVCJsonDataObjectsSerializer"');
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableInteger), TSpringNullableIntegerSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableInt64), TSpringNullableInt64Serializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableCurrency), TSpringNullableCurrencySerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableString), TSpringNullableStringSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableDateTime), TSpringNullableDateTimeSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableDate), TSpringNullableDateSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableTime), TSpringNullableTimeSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableGuid), TSpringNullableGuidSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableDouble), TSpringNullableDoubleSerializer.Create);
  ASerializer.RegisterTypeSerializer(TypeInfo(TNullableBoolean), TSpringNullableBooleanSerializer.Create);
end;

end.
