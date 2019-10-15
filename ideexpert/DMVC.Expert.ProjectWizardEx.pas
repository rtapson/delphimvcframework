{ *************************************************************************** }
{ }
{ Delphi MVC Framework }
{ }
{ Copyright (c) 2010-2017 Daniele Teti and the DMVCFramework Team }
{ }
{ https://github.com/danieleteti/delphimvcframework }
{ }
{ *************************************************************************** }
{ }
{ Licensed under the Apache License, Version 2.0 (the "License"); }
{ you may not use this file except in compliance with the License. }
{ You may obtain a copy of the License at }
{ }
{ http://www.apache.org/licenses/LICENSE-2.0 }
{ }
{ Unless required by applicable law or agreed to in writing, software }
{ distributed under the License is distributed on an "AS IS" BASIS, }
{ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{ See the License for the specific language governing permissions and }
{ limitations under the License. }
{ }
{ This IDE expert is based off of the one included with the DUnitX }
{ project.  Original source by Robert Love.  Adapted by Nick Hodges. }
{ }
{ The DUnitX project is run by Vincent Parrett and can be found at: }
{ }
{ https://github.com/VSoftTechnologies/DUnitX }
{ *************************************************************************** }

unit DMVC.Expert.ProjectWizardEx;

interface

uses
  ToolsApi,
  VCL.Graphics,
  PlatformAPI;

type
  TDMVCNewProjectWizard = class
  private
    class function GetUnitName(aFilename: string): string;
  public
    class procedure RegisterDMVCProjectWizard(const APersonality: string);
  end;

implementation

uses
  DccStrs,
  System.Generics.Collections,
  System.IOUtils,
  VCL.Controls,
  VCL.Forms,
  WinApi.Windows,
  System.SysUtils,
  DMVC.Expert.Forms.NewProjectWizard,
  DMVC.Expert.CodeGen.NewDMVCStandaloneProject,
  DMVC.Expert.CodeGen.NewDMVCWindowsServiceProject,
  DMVC.Expert.CodeGen.NewDMVCISAPIProject,
  DMVC.Expert.CodeGen.NewControllerUnit,
  DMVC.Expert.CodeGen.NewWebModuleUnit,
  DMVC.Expert.CodeGen.NewSpring4DDIConfigurationUnit,
  DMVC.Expert.Consts,
  ExpertsRepository;

resourcestring
  sNewDMVCProjectCaption = 'DelphiMVCFramework Project';
  sNewDMVCProjectHint = 'Create New DelphiMVCFramework Project with Controller';

  { TDUnitXNewProjectWizard }

class function TDMVCNewProjectWizard.GetUnitName(aFilename: string): string;
begin
  Result := TPath.GetFileNameWithoutExtension(aFilename);
end;

class procedure TDMVCNewProjectWizard.RegisterDMVCProjectWizard(const APersonality: string);
begin
  RegisterPackageWizard(TExpertsRepositoryProjectWizardWithProc.Create(
    APersonality,
    sNewDMVCProjectHint,
    sNewDMVCProjectCaption,
    'DMVC.Wizard.NewProjectWizard', // do not localize
    'DMVCFramework',
    'DMVCFramework Team - https://github.com/danieleteti/delphimvcframework', // do not localize
    procedure
    var
      WizardForm: TfrmDMVCNewProject;
      ModuleServices: IOTAModuleServices;
      Projects: TList<IOTAProject>;

      Project: IOTAProject;
      Config: IOTABuildConfiguration;
      ControllerUnit: IOTAModule;
      DIConfigurationUnit: IOTAModule;
      WebModuleUnit: IOTAModule;
      ControllerCreator: IOTACreator;
      WebModuleCreator: IOTAModuleCreator;
      lProjectSourceCreator: IOTACreator;

      SpringDIConfigurationController: IOTAModuleCreator;
    begin
      WizardForm := TfrmDMVCNewProject.Create(Application);
      try
        if WizardForm.ShowModal = mrOk then
        begin
          if not WizardForm.AddToProjectGroup then
          begin
            (BorlandIDEServices as IOTAModuleServices).CloseAll;
          end;
          ModuleServices := (BorlandIDEServices as IOTAModuleServices);

          Projects := TList<IOTAProject>.Create;
          try
            if ptStandalone in WizardForm.ProjectTypes  then
            begin
              // Create Project Source
              lProjectSourceCreator := TDMVCStandaloneProjectFile.Create(APersonality);
              TDMVCStandaloneProjectFile(lProjectSourceCreator).DefaultPort := WizardForm.ServerPort;
              ModuleServices.CreateModule(lProjectSourceCreator);
              Project := GetActiveProject;
              Projects.Add(Project);

              Config := (Project.ProjectOptions as IOTAProjectOptionsConfigurations).BaseConfiguration;
              Config.SetValue(sUnitSearchPath, '$(DMVC)');
              Config.SetValue(sFramework, 'VCL');
            end;
            if ptWindowsService in WizardForm.ProjectTypes  then
            begin
              // Create Project Source
              {lProjectSourceCreator := TDMVCWindowsServiceProjectFile.Create(APersonality);
              TDMVCWindowsServiceProjectFile(lProjectSourceCreator).DefaultPort := WizardForm.ServerPort;
              ModuleServices.CreateModule(lProjectSourceCreator);
              Project := GetActiveProject;
              Projects.Add(Project);

              Config := (Project.ProjectOptions as IOTAProjectOptionsConfigurations).BaseConfiguration;
              Config.SetValue(sUnitSearchPath, '$(DMVC)');
              Config.SetValue(sFramework, 'VCL');}
            end;
            if ptISAPI in WizardForm.ProjectTypes then
            begin
              // Create Project Source
              lProjectSourceCreator := TDMVCISAPIProjectFile.Create(APersonality);
              ModuleServices.CreateModule(lProjectSourceCreator);
              Project := GetActiveProject;
              Projects.Add(Project);

              Config := (Project.ProjectOptions as IOTAProjectOptionsConfigurations).BaseConfiguration;
              Config.SetValue(sUnitSearchPath, '$(DMVC)');
              Config.SetValue(sFramework, 'VCL');
            end;

            // Create Controller Unit
            if WizardForm.CreateControllerUnit then
            begin
              ControllerCreator := TNewControllerUnitEx.Create(WizardForm.CreateIndexMethod, WizardForm.CreateCRUDMethods,
                WizardForm.CreateActionFiltersMethods, WizardForm.Spring4DDI, WizardForm.ControllerClassName, APersonality);
              ControllerUnit := ModuleServices.CreateModule(ControllerCreator);
              for Project in Projects do
                Project.AddFile(ControllerUnit.FileName, True);
            end;

            if WizardForm.Spring4DDI then
            begin
              SpringDIConfigurationController := TNewSpring4DDIConfigurationUnit.Create(GetUnitName(ControllerUnit.FileName), WizardForm.ControllerClassName, APersonality);
              DIConfigurationUnit := ModuleServices.CreateModule(SpringDIConfigurationController);
              for Project in Projects do
                Project.AddFile(DIConfigurationUnit.FileName, True);
            end;

            if WizardForm.CreateServiceUnit then
            begin

            end;

            // Create Webmodule Unit
            WebModuleCreator := TNewWebModuleUnitEx.Create(WizardForm.WebModuleClassName, WizardForm.ControllerClassName,
              GetUnitName(ControllerUnit.FileName), WizardForm.Middlewares, APersonality, WizardForm.Spring4DDI);
            WebModuleUnit := ModuleServices.CreateModule(WebModuleCreator);
            for Project in Projects do
              Project.AddFile(WebModuleUnit.FileName, True);

          finally
            Projects.Free;
          end;
        end;
      finally
        WizardForm.Free;
      end;
    end,
    function: Cardinal
    begin
      Result := LoadIcon(HInstance, 'DMVCNewProjectIcon');
    end, TArray<string>.Create(cWin32Platform, cWin64Platform), nil));
end;

end.
