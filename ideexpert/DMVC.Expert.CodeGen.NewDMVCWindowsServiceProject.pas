{***************************************************************************}
{                                                                           }
{                      Delphi MVC Framework                                 }
{                                                                           }
{     Copyright (c) 2010-2018 Daniele Teti and the DMVCFramework Team       }
{                                                                           }
{           https://github.com/danieleteti/delphimvcframework               }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{  This IDE expert is based off of the one included with the DUnitX         }
{  project.  Original source by Robert Love.  Adapted by Nick Hodges.       }
{                                                                           }
{  The DUnitX project is run by Vincent Parrett and can be found at:        }
{                                                                           }
{            https://github.com/VSoftTechnologies/DUnitX                    }
{***************************************************************************}
unit DMVC.Expert.CodeGen.NewDMVCWindowsServiceProject;

interface

uses
  ToolsAPI,
  DMVC.Expert.CodeGen.NewProject;

type
  TDMVCWindowsServiceProjectFile = class(TNewProjectEx)
  private
    FDefaultPort: Integer;
    procedure SetDefaultPort(const Value: Integer);
  protected
    function NewProjectSource(const ProjectName: string): IOTAFile; override;
    function GetFrameworkType: string; override;
  public
    constructor Create; overload;
    constructor Create(const APersonality: string); overload;
    property DefaultPort: Integer read FDefaultPort write SetDefaultPort;
  end;

implementation

uses
  DMVC.Expert.CodeGen.SourceFile,
  DMVC.Expert.CodeGen.Templates,
  System.SysUtils;

{ TDMVCWindowsServiceProjectFile }

constructor TDMVCWindowsServiceProjectFile.Create(const APersonality: string);
begin
  Create;
  Personality := APersonality;
end;

constructor TDMVCWindowsServiceProjectFile.Create;
begin
  // TODO: Figure out how to make this be DMVCProjectX where X is the next available.
  // Return Blank and the project will be 'ProjectX.dpr' where X is the next available number
  FFileName := '';
  FDefaultPort := 0;
end;

function TDMVCWindowsServiceProjectFile.GetFrameworkType: string;
begin
  Result := 'VCL';
end;

function TDMVCWindowsServiceProjectFile.NewProjectSource(const ProjectName: string): IOTAFile;
begin

end;

procedure TDMVCWindowsServiceProjectFile.SetDefaultPort(const Value: Integer);
begin
  FDefaultPort := Value;
end;

end.
