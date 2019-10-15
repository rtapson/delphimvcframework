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
unit DMVC.Expert.CodeGen.NewSpring4DDIConfigurationUnit;
// This is done to Warnings that I can't control, as Embarcadero has
// deprecated the functions, but due to design you are still required to
// to implement.
{$WARN SYMBOL_DEPRECATED OFF}
interface

uses
  ToolsAPI,
  DMVC.Expert.CodeGen.NewUnit;

type
  TNewSpring4DDIConfigurationUnit = class(TNewUnit)
  private
    FControllerClassName: string;
    FControllerUnitName: string;
  protected
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile; override;
  public
    constructor Create(const AControllerUnitName: string; const AControllerClassName: string; const APersonality: string = '');
  end;

implementation

uses
  System.SysUtils,
  VCL.Dialogs,
  DMVC.Expert.CodeGen.Templates,
  DMVC.Expert.CodeGen.SourceFile;

{ TNewSpring4DDIConfigurationUnit }

constructor TNewSpring4DDIConfigurationUnit.Create(const AControllerUnitName: string; const AControllerClassName: string; const APersonality: string = '');
begin
  FAncestorName := '';
  FFormName := '';
  FImplFileName := '';
  FIntfFileName := '';
  FControllerUnitName := AControllerUnitName;
  FControllerClassName := AControllerClassName;
  Personality := APersonality;
end;

function TNewSpring4DDIConfigurationUnit.NewImplSource(const ModuleIdent,
  FormIdent, AncestorIdent: string): IOTAFile;
var
  lUnitIdent: string;
  lFormName: string;
  lFileName: string;
  lControllerUnit: string;
begin
  lControllerUnit := sSpring4DDIConfiguration;
//  lUnitIdent := 'DIConfiguration';

  // http://stackoverflow.com/questions/4196412/how-do-you-retrieve-a-new-unit-name-from-delphis-open-tools-api
  // So using method mentioned by Marco Cantu.
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName('', lUnitIdent, lFormName, lFileName);
  Result := TSourceFile.Create(lControllerUnit, [lUnitIdent, FControllerUnitName, FControllerClassName]);
end;

end.
