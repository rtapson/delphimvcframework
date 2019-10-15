unit DMVC.Expert.Forms.NewProjectWizard;

interface

uses
  WinAPI.Windows,
  WinAPI.Messages,
  WinAPI.ShellAPI,
  System.SysUtils,
  System.Variants,
  System.Classes,
  VCL.Graphics,
  VCL.Controls,
  VCL.Forms,
  VCL.Dialogs,
  VCL.StdCtrls,
  VCL.Imaging.pngimage, VCL.ExtCtrls, Vcl.ComCtrls, System.Actions, Vcl.ActnList,
  DMVC.Expert.Consts, Vcl.CheckLst;

type
  TfrmDMVCNewProject = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    Image1: TImage;
    lblFrameworkVersion: TLabel;
    Pages: TPageControl;
    tabStart: TTabSheet;
    tabController: TTabSheet;
    Service: TTabSheet;
    Summary: TTabSheet;
    lblWbModule: TLabel;
    chkAddToProjectGroup: TCheckBox;
    edtWebModuleName: TEdit;
    chkCreateControllerUnit: TCheckBox;
    gbControllerUnitOptions: TGroupBox;
    lblClassName: TLabel;
    Label1: TLabel;
    chkCreateIndexMethod: TCheckBox;
    edtClassName: TEdit;
    chkCreateActionFiltersMethods: TCheckBox;
    chkCreateCRUDMethods: TCheckBox;
    Label2: TLabel;
    edtServerPort: TEdit;
    chkCreateService: TCheckBox;
    tbsProjects: TTabSheet;
    GroupBox1: TGroupBox;
    btnPrev: TButton;
    btnNext: TButton;
    ActionList1: TActionList;
    actPrevPage: TAction;
    actNextPage: TAction;
    lstProjectTypes: TCheckListBox;
    mmoSummary: TMemo;
    actCreate: TAction;
    GroupBox2: TGroupBox;
    chlProjectOptions: TCheckListBox;
    procedure chkCreateControllerUnitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure actPrevPageExecute(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actNextPageUpdate(Sender: TObject);
    procedure actPrevPageUpdate(Sender: TObject);
    procedure PagesChange(Sender: TObject);
    procedure actCreateUpdate(Sender: TObject);
    procedure ServiceShow(Sender: TObject);
    procedure chlProjectOptionsClickCheck(Sender: TObject);
    procedure chlProjectOptionsClick(Sender: TObject);
    procedure lstProjectTypesClick(Sender: TObject);
  private
    { Private declarations }
    function GetAddToProjectGroup: boolean;
    function GetCreateIndexMethod: boolean;
    function GetCreateControllerUnit: boolean;
    function GetControllerClassName: string;
    function GetWebModuleClassName: string;
    function GetCreateActionFiltersMethods: boolean;
    function GetServerPort: Integer;
    function GetCreateCRUDMethods: boolean;
    function GetAnalyticsSupport: boolean;
    function GetMiddlewares: TArray<String>;
    function GetSpring4DDI: boolean;
    function GetProjectTypes: TProjectTypes;
    function GetCreateServiceUnit: Boolean;
  public
    { Public declarations }
    // Read Only Properties to extract values without having to know control values.
    property ControllerClassName: string read GetControllerClassName;
    property CreateControllerUnit: boolean read GetCreateControllerUnit;
    property AddToProjectGroup: boolean read GetAddToProjectGroup;
    property CreateIndexMethod: boolean read GetCreateIndexMethod;
    property CreateCRUDMethods: boolean read GetCreateCRUDMethods;
    property AnalyticsSupport: boolean read GetAnalyticsSupport;
    property Middlewares: TArray<String> read GetMiddlewares;
    property CreateActionFiltersMethods: boolean read GetCreateActionFiltersMethods;
    property WebModuleClassName: string read GetWebModuleClassName;
    property ServerPort: Integer read GetServerPort;
    property Spring4DDI: boolean read GetSpring4DDI;
    property ProjectTypes: TProjectTypes read GetProjectTypes;
    property CreateServiceUnit: Boolean read GetCreateServiceUnit;
  end;

var
  frmDMVCNewProject: TfrmDMVCNewProject;

implementation

uses
  DMVC.Expert.CodeGen.Templates,
  MVCFramework.Commons,
  DMVC.Expert.ProjectOptionRegistration,
  DMVC.Expert.BaseProjectOption;

{$R *.dfm}

procedure TfrmDMVCNewProject.actCreateUpdate(Sender: TObject);
begin
  actCreate.Enabled := Pages.ActivePage = Summary;
end;

procedure TfrmDMVCNewProject.actNextPageExecute(Sender: TObject);
begin
  Pages.SelectNextPage(True, False);
end;

procedure TfrmDMVCNewProject.actNextPageUpdate(Sender: TObject);
begin
  btnNext.Enabled := Pages.ActivePageIndex < (Pages.PageCount - 1);
end;

procedure TfrmDMVCNewProject.actPrevPageExecute(Sender: TObject);
begin
  Pages.SelectNextPage(False, False);
end;

procedure TfrmDMVCNewProject.actPrevPageUpdate(Sender: TObject);
begin
  btnPrev.Enabled := Pages.ActivePageIndex > 0;
end;

procedure TfrmDMVCNewProject.chkCreateControllerUnitClick(Sender: TObject);
begin
  gbControllerUnitOptions.Enabled := chkCreateIndexMethod.Checked;
  chkCreateIndexMethod.Enabled := chkCreateControllerUnit.Checked;
  chkCreateActionFiltersMethods.Enabled := chkCreateControllerUnit.Checked;
  edtClassName.Enabled := chkCreateControllerUnit.Checked;
end;

procedure TfrmDMVCNewProject.chlProjectOptionsClick(Sender: TObject);
begin
  chlProjectOptions.Checked[chlProjectOptions.ItemIndex] := not chlProjectOptions.Checked[chlProjectOptions.ItemIndex];
end;

procedure TfrmDMVCNewProject.chlProjectOptionsClickCheck(Sender: TObject);
var
  ProjectOption: IProjectOption;
begin
  ProjectOption := (TPNGObject(chlProjectOptions.Items.Objects[chlProjectOptions.ItemIndex]) as IProjectOption);
  ProjectOption.Selected := chlProjectOptions.Checked[chlProjectOptions.ItemIndex];
end;

procedure TfrmDMVCNewProject.FormCreate(Sender: TObject);
var
  i: Integer;
  ProjectOption: IProjectOption;
begin
  for i := 0 to Pages.PageCount - 1 do
    Pages.Pages[i].TabVisible := False;
  Pages.ActivePageIndex := 0;
  edtClassName.TextHint := sDefaultControllerName;
  edtWebModuleName.TextHint := sDefaultWebModuleName;
  edtServerPort.TextHint := sDefaultServerPort;
  lblFrameworkVersion.Caption := DMVCFRAMEWORK_VERSION;

  chlProjectOptions.Items.Clear;
  for ProjectOption in ProjectOptions do
  begin
    if ProjectOption.Visible then
      chlProjectOptions.Items.AddObject(ProjectOption.Caption, TObject(ProjectOption));
  end;

end;

function TfrmDMVCNewProject.GetAddToProjectGroup: boolean;
begin
  Result := chkAddToProjectGroup.Checked;
end;

function TfrmDMVCNewProject.GetAnalyticsSupport: boolean;
begin
//  Result := chkAnalyticsMiddleware.Checked;
end;

function TfrmDMVCNewProject.GetCreateIndexMethod: boolean;
begin
  Result := chkCreateIndexMethod.Checked;
end;

function TfrmDMVCNewProject.GetCreateServiceUnit: Boolean;
begin
  Result := chkCreateService.Checked;
end;

function TfrmDMVCNewProject.GetMiddlewares: TArray<String>;
begin
  Result := [];
  if AnalyticsSupport then
  begin
    Result := Result + ['TMVCAnalyticsMiddleware.Create(GetLoggerForAnalytics)'];
  end;
end;

function TfrmDMVCNewProject.GetProjectTypes: TProjectTypes;
var
  i: Integer;
begin
  for i := 0 to lstProjectTypes.Items.Count - 1 do
    if lstProjectTypes.Checked[i] then
      Result := Result + [TProjectType(i)];
end;

function TfrmDMVCNewProject.GetServerPort: Integer;
var
  lServerPort: Integer;
begin
  Result := StrToInt(sDefaultServerPort);
  if (Trim(edtServerPort.Text) <> '') and TryStrToInt(edtServerPort.Text,
    lServerPort) then
  begin
    if (lServerPort > 0) and (lServerPort < 65535) then
      Result := lServerPort;
  end;
end;

function TfrmDMVCNewProject.GetSpring4DDI: boolean;
begin
//  Result := chkSpring4DDI.Checked;
end;

function TfrmDMVCNewProject.GetWebModuleClassName: string;
begin
  if Trim(edtWebModuleName.Text) = '' then
  begin
    Result := sDefaultWebModuleName
  end
  else
  begin
    Result := Trim(edtWebModuleName.Text);
  end;
end;

procedure TfrmDMVCNewProject.Image1Click(Sender: TObject);
begin
  ShellExecute(0, PChar('open'),
    PChar('https://www.gitbook.com/book/danieleteti/delphimvcframework/details'),
    nil, nil, SW_SHOW);
end;

procedure TfrmDMVCNewProject.lstProjectTypesClick(Sender: TObject);
begin
//  lstProjectTypes.Checked[lstProjectTypes.ItemIndex] := not lstProjectTypes.Checked[lstProjectTypes.ItemIndex];
end;

procedure TfrmDMVCNewProject.PagesChange(Sender: TObject);

  function AddOption(const Option, Options : string; const Seperator: string = ' and '): string;
  begin
    if Options <> '' then
      Result := Options + Seperator + Option
    else
      Result := Option;
  end;

const
  Indent: string = '  ';
var
  Options: string;
begin
  if Pages.ActivePage = Summary then
  begin
    if AddToProjectGroup then
      mmoSummary.Lines.Add('Add projects to existing project group.');

    mmoSummary.Lines.Add('');

    if ProjectTypes <> [] then
    begin
      mmoSummary.Lines.Add('Create projects for:');
      if ptStandalone in ProjectTypes then
        mmoSummary.Lines.Add(Indent + 'Standalone application');
      if ptWindowsService in ProjectTypes then
        mmoSummary.Lines.Add(Indent + 'Windows service application');
      if ptISAPI in ProjectTypes then
        mmoSummary.Lines.Add(Indent + 'ISAPI application');
    end;

    mmoSummary.Lines.Add('');
    if Spring4DDI then
       Options := AddOption('Spring4D DI', Options);
    if AnalyticsSupport then
      Options := AddOption('Analytics', Options);

    if Options <> '' then
      mmoSummary.Lines.Add(Format('WebModule %s, listening on port %d will be created with support for %s.', [WebModuleClassName, ServerPort, Options]))
    else
      mmoSummary.Lines.Add(Format('WebModule %s, listening on port %d will be created.', [WebModuleClassName, ServerPort]));

    mmoSummary.Lines.Add('');
    if CreateControllerUnit then
    begin
      Options := '';
      if CreateActionFiltersMethods then
        Options := AddOption('action filter methods', Options, ', ');
      if CreateCRUDMethods then
        Options := AddOption('CRUD methods', Options, ', ');
      if CreateIndexMethod then
        Options := AddOption('index method', Options, ' and an ');
      mmoSummary.Lines.Add(Format('Controller %s will created with these options, %s', [ControllerClassName, Options]));
    end;
  end;
end;

procedure TfrmDMVCNewProject.ServiceShow(Sender: TObject);
begin
  chkCreateService.Enabled := Spring4DDI;
end;

function TfrmDMVCNewProject.GetCreateActionFiltersMethods: boolean;
begin
  Result := chkCreateActionFiltersMethods.Checked;
end;

function TfrmDMVCNewProject.GetCreateControllerUnit: boolean;
begin
  Result := chkCreateControllerUnit.Checked;
end;

function TfrmDMVCNewProject.GetCreateCRUDMethods: boolean;
begin
  Result := chkCreateCRUDMethods.Checked;
end;

function TfrmDMVCNewProject.GetControllerClassName: string;
begin
  if Trim(edtClassName.Text) = '' then
  begin
    Result := sDefaultControllerName
  end
  else
  begin
    Result := Trim(edtClassName.Text);
  end;
end;

end.
