// ***************************************************************************
//
// Delphi MVC Framework
//
// Copyright (c) 2010-2019 Daniele Teti and the DMVCFramework Team
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
// This IDE expert is based off of the one included with the DUnitX
// project.  Original source by Robert Love.  Adapted by Nick Hodges.
//
// The DUnitX project is run by Vincent Parrett and can be found at:
//
// https://github.com/VSoftTechnologies/DUnitX
// ***************************************************************************
unit DMVC.Expert.AureliusSupportProjectOption;

interface

uses
  DMVC.Expert.BaseProjectOption;

type
  TAureliusSupportProjectOption = class(TBaseProjectOption)
  protected
    function GetVisible: Boolean; override;
    function GetCaption: string; override;
  end;

implementation

uses
  System.Win.Registry;

{ TAureliusSupportProjectOption }

function TAureliusSupportProjectOption.GetCaption: string;
begin
  Result := 'Add TMS Aurelius Support';
end;

function TAureliusSupportProjectOption.GetVisible: Boolean;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Result := Reg.KeyExists('Software\TMSSoftware\TMS Aurelius');
  finally
    Reg.Free;
  end;
end;

end.
