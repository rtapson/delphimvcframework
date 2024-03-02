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

unit DMVC.Expert.CodeGen.Templates.EmptyUnit;

interface

uses
  Generics.Collections,
  DMVC.Expert.CodeGen.Templates.BaseUnit,
  DMVC.Expert.CodeGen.Templates.Intf;

type
  TDMVCUnitTemplate = class(TMVCBaseUnitTemplate)
  protected
    procedure AddCode; override;
    procedure BuildTemplate; override;
  public
    constructor Create(const FileName: string); reintroduce;
  end;

implementation

{ TDMVCControllerUnitTemplate }

procedure TDMVCUnitTemplate.AddCode;
begin

end;

procedure TDMVCUnitTemplate.BuildTemplate;
begin
  inherited;
end;

constructor TDMVCUnitTemplate.Create(const FileName: string);
begin
  inherited Create(FileName);
end;

end.
