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
unit DMVC.Expert.BaseProjectOption;

interface

uses
  DMVC.Expert.CodeGen.NewUnit;

type
  IProjectOption = interface
    ['{8F5EA04B-9E12-4251-8D91-AC30111BECB5}']
    function GetCaption: string;
    function GetVisible: Boolean;
    function GetSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
//    function GetCodeGenerator: TNewUnit;
//    procedure SetCodeGenerator(const Value: TNewUnit);

    property Caption: string read GetCaption;
    property Visible: Boolean read GetVisible;

    property Selected: Boolean read GetSelected write SetSelected;
//    property CodeGenerator: TNewUnit read GetCodeGenerator write SetCodeGenerator;
  end;

  TBaseProjectOption = class(TInterfacedObject, IProjectOption)
  private
    FCodeGenerator: TNewUnit;
    FSelected: Boolean;
    function GetCodeGenerator: TNewUnit;
    procedure SetCodeGenerator(const Value: TNewUnit);
    function GetSelected: Boolean;
    procedure SetSelected(const Value: Boolean);
  protected
    function GetCaption: string; virtual; abstract;
    function GetVisible: Boolean; virtual;
  public
    //constructor Create(const CodeGenerator: TNewUnit);
    property Caption: string read GetCaption;
    property Visible: Boolean read GetVisible;

    property Selected: Boolean read GetSelected write SetSelected;
    //property CodeGenerator: TNewUnit read GetCodeGenerator write SetCodeGenerator;
  end;

implementation

{ TBaseProjectOption }

{constructor TBaseProjectOption.Create(const CodeGenerator: TNewUnit);
begin
  FCodeGenerator := CodeGenerator;
end;}

function TBaseProjectOption.GetCodeGenerator: TNewUnit;
begin
  Result := FCodeGenerator;
end;

function TBaseProjectOption.GetSelected: Boolean;
begin
  Result := FSelected;
end;

function TBaseProjectOption.GetVisible: Boolean;
begin
  Result := True;
end;

procedure TBaseProjectOption.SetCodeGenerator(const Value: TNewUnit);
begin
  FCodeGenerator := Value;
end;

procedure TBaseProjectOption.SetSelected(const Value: Boolean);
begin
  FSelected := Value;
end;

end.
