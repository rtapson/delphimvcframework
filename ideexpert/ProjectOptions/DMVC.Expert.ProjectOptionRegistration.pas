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
unit DMVC.Expert.ProjectOptionRegistration;

interface

uses
  System.Generics.Collections,
  DMVC.Expert.BaseProjectOption;

type
  TProjectOptions = TList<IProjectOption>;

function ProjectOptions: TProjectOptions;

implementation

uses
  DMVC.Expert.Spring4DDIProjectOption,
  DMVC.Expert.AnalyticsSupportProjectOption,
  DMVC.Expert.AureliusSupportProjectOption;

var
  FProjectOptions: TProjectOptions;

function ProjectOptions: TProjectOptions;
begin
  if not Assigned(FProjectOptions) then
    FProjectOptions := TList<IProjectOption>.Create;
  Result := FProjectOptions;
end;

initialization
  ProjectOptions.Add(TSpring4DDIProjectOption.Create);
  ProjectOptions.Add(TAnalyticsSupportProjectOption.Create);
  ProjectOptions.Add(TAureliusSupportProjectOption.Create);

finalization
  FProjectOptions.Free;

end.
