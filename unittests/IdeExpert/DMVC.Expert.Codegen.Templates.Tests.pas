unit DMVC.Expert.Codegen.Templates.Tests;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  TIDETemplateTests = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestBuildInterfaceUsesClause;

    [Test]
    procedure TestBuildInterfaceConstClause;
    [Test]
    procedure TestBuildInterfaceConstClauseWithMultipleConsts;

    [Test]
    procedure TestBuildInterfaceUsesAndConstClauses;

    [Test]
    procedure TestBuildInterfaceTypeClause;

    [Test]
    procedure TestBuildCode;

    [Test]
    procedure TestFBuildInitialization;
    [Test]
    procedure TestFinalization;

    [Test]
    procedure TestBuildControllerUnit;
  end;

implementation

uses
  SysUtils,
  Classes,
  Generics.Collections,
  DMVC.Expert.CodeGen.Templates.Intf,
  DMVC.Expert.CodeGen.Templates.BaseUnit,
  DMVC.Expert.CodeGen.Templates.ControllerUnit;

procedure TIDETemplateTests.Setup;
begin
end;

procedure TIDETemplateTests.TearDown;
begin
end;

procedure TIDETemplateTests.TestBuildCode;
var
  BaseTemplate: IDMVCCodeTemplate;
  Code: TStringList;
begin
  BaseTemplate := TMVCBaseUnitTemplate.Create('TestUnitName');
  BaseTemplate.InterfaceCode.Add('procedure TestProc(const TestInt: Integer);');
  BaseTemplate.ImplementationCode.Add('procedure TestProc(const TestInt: Integer);');
  BaseTemplate.ImplementationCode.Add('begin');
  BaseTemplate.ImplementationCode.Add('');
  BaseTemplate.ImplementationCode.Add('end;');

  Code :=  BaseTemplate.GetSource;
  try
    Assert.AreEqual(
      'unit TestUnitName;' + sLineBreak
      + sLineBreak
      + 'interface' + sLineBreak
      + sLineBreak
      + 'procedure TestProc(const TestInt: Integer);' + sLineBreak
      + sLineBreak
      + 'implementation' + sLineBreak
      + sLineBreak
      + 'procedure TestProc(const TestInt: Integer);' + sLineBreak
      + 'begin' + sLineBreak
      + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'end.' + sLineBreak
      , Code.Text);
  finally
    Code.Free;
  end;
end;

procedure TIDETemplateTests.TestBuildControllerUnit;
var
  ControllerUnit: IDMVCCodeTemplate;
  Code, Expected: TStringList;
begin
  ControllerUnit := TDMVCControllerUnitTemplate.Create('TestController', 'TTestController', '/api', '/test', True, True, True);

  Code :=  ControllerUnit.GetSource;
  try
    Expected := TStringList.Create;
    Expected.Text :=
      'unit TestController;' + sLineBreak
      + sLineBreak
      + 'interface' + sLineBreak
      + sLineBreak
      + 'uses' + sLineBreak
      + '  MVCFramework,' + sLineBreak
      + '  MVCFramework.Commons,' + sLineBreak
      + '  MVCFramework.Serializer.Commons;' + sLineBreak
      + sLineBreak
      + 'type' + sLineBreak                                                 //10
      + '  [MVCPath(''/api'')]' + sLineBreak
      + '  TTestController = class(TMVCController)' + sLineBreak
      + '  private' + sLineBreak
      + '  protected' + sLineBreak
      + '    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;' + sLineBreak
      + '    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;' + sLineBreak
      + '  public' + sLineBreak
      + '    [MVCPath]' + sLineBreak
      + '    [MVCHTTPMethod([httpGET])]' + sLineBreak
      + '    procedure Index;' + sLineBreak                                     //20
      + sLineBreak
      + '    [MVCPath(''/reversedstrings/($Value)'')]' + sLineBreak
      + '    [MVCHTTPMethod([httpGET])]' + sLineBreak
      + '    procedure GetReversedString(const Value: String);' + sLineBreak
      + sLineBreak
      + '    //Sample CRUD Actions for a "Test" entity' + sLineBreak
      + '    [MVCPath(''/test'')]' + sLineBreak
      + '    [MVCHTTPMethod([httpGET])]' + sLineBreak
      + '    procedure GetTests;' + sLineBreak
      + sLineBreak                                                              //30
      + '    [MVCPath(''/test/($id)'')]' + sLineBreak
      + '    [MVCHTTPMethod([httpGET])]' + sLineBreak
      + '    procedure GetTest(id: Integer);' + sLineBreak
      + sLineBreak
      + '    [MVCPath(''/test'')]' + sLineBreak
      + '    [MVCHTTPMethod([httpPOST])]' + sLineBreak
      + '    procedure CreateTest;' + sLineBreak
      + sLineBreak
      + '    [MVCPath(''/test/($id)'')]' + sLineBreak
      + '    [MVCHTTPMethod([httpPUT])]' + sLineBreak
      + '    procedure UpdateTest(id: Integer);' + sLineBreak
      + sLineBreak
      + '    [MVCPath(''/test/($id)'')]' + sLineBreak
      + '    [MVCHTTPMethod([httpDELETE])]' + sLineBreak
      + '    procedure DeleteTest(id: Integer);' + sLineBreak
      + sLineBreak
      + '  published' + sLineBreak
      + '  end;' + sLineBreak
      + sLineBreak
      + 'implementation' + sLineBreak
      + sLineBreak
      + 'uses' + sLineBreak
      + '  System.SysUtils,' + sLineBreak
      + '  MVCFramework.Logger,' + sLineBreak
      + '  System.StrUtils;' + sLineBreak
      + sLineBreak
      + 'procedure TTestController.OnAfterAction(Context: TWebContext; const AActionName: string);' + sLineBreak
      + 'begin' + sLineBreak
      + '  { Executed after each action }' + sLineBreak
      + '  inherited;' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'procedure TTestController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);' + sLineBreak
      + 'begin' + sLineBreak
      + '  { Executed before each action' + sLineBreak
      + '    if handled is true (or an exception is raised) the actual' + sLineBreak
      + '    action will not be called }' + sLineBreak
      + '  inherited;' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'procedure TTestController.Index;' + sLineBreak
      + 'begin' + sLineBreak
      + '  //use Context property to access to the HTTP request and response ' + sLineBreak
      + '  Render(''Hello DelphiMVCFramework World'');' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'procedure TTestController.GetReversedString(const Value: String);' + sLineBreak
      + 'begin' + sLineBreak
      + '  Render(System.StrUtils.ReverseString(Value.Trim));' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + '//Sample CRUD Actions for a "Test" entity' + sLineBreak
      + 'procedure TTestController.GetTests;' + sLineBreak
      + 'begin' + sLineBreak
      + '  //todo: render a list of Tests' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'procedure TTestController.GetTest(id: Integer);' + sLineBreak
      + 'begin' + sLineBreak
      + '  //todo: render the Test by id' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'procedure TTestController.CreateTest;' + sLineBreak
      + 'begin' + sLineBreak
      + '  //todo: create a new Test' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'procedure TTestController.UpdateTest(id: Integer);' + sLineBreak
      + 'begin' + sLineBreak
      + '  //todo: update Test by id' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'procedure TTestController.DeleteTest(id: Integer);' + sLineBreak
      + 'begin' + sLineBreak
      + '  //todo: delete Test by id' + sLineBreak
      + 'end;' + sLineBreak
      + sLineBreak
      + 'end.';

    Assert.AreEqual(Expected, Code);
  finally
    Expected.Free;
    Code.Free;
  end;


end;

procedure TIDETemplateTests.TestBuildInterfaceConstClause;
var
  BaseTemplate: IDMVCCodeTemplate;
  Code: TStringList;
begin
  BaseTemplate := TMVCBaseUnitTemplate.Create('TestUnitName');
  BaseTemplate.InterfaceConst.Add('MY_CONST_1 = ''Test Const'';');

  Code :=  BaseTemplate.GetSource;
  try
    Assert.AreEqual(
      'unit TestUnitName;' + sLineBreak
      + sLineBreak
      + 'interface' + sLineBreak
      + sLineBreak
      + 'const' + sLineBreak
      + '  MY_CONST_1 = ''Test Const'';' + sLineBreak
      + sLineBreak
      + 'implementation' + sLineBreak
      + sLineBreak
      + 'end.' + sLineBreak
      , Code.Text);
  finally
    Code.Free;
  end;

end;

procedure TIDETemplateTests.TestBuildInterfaceConstClauseWithMultipleConsts;
var
  BaseTemplate: IDMVCCodeTemplate;
  Code: TStringList;
begin
  BaseTemplate := TMVCBaseUnitTemplate.Create('TestUnitName');
  BaseTemplate.InterfaceConst.Add('MY_CONST_1 = ''Test Const'';');
  BaseTemplate.InterfaceConst.Add('MY_CONST_2 = ''Test Const 2'';');
  BaseTemplate.InterfaceConst.Add('MY_CONST_3 = ''Test Const 3'';');

  Code :=  BaseTemplate.GetSource;
  try
    Assert.AreEqual(
      'unit TestUnitName;' + sLineBreak
      + sLineBreak
      + 'interface' + sLineBreak
      + sLineBreak
      + 'const' + sLineBreak
      + '  MY_CONST_1 = ''Test Const'';' + sLineBreak
      + '  MY_CONST_2 = ''Test Const 2'';' + sLineBreak
      + '  MY_CONST_3 = ''Test Const 3'';' + sLineBreak
      + sLineBreak
      + 'implementation' + sLineBreak
      + sLineBreak
      + 'end.' + sLineBreak
      , Code.Text);
  finally
    Code.Free;
  end;
end;

procedure TIDETemplateTests.TestBuildInterfaceTypeClause;
var
  BaseTemplate: IDMVCCodeTemplate;
  Code: TStringList;
  aType: TObjectList<TTypeDefinitionEntry>;
begin
  BaseTemplate := TMVCBaseUnitTemplate.Create('TestUnitName');

  aType := TObjectList<TTypeDefinitionEntry>.Create(True);
  try
    aType.Add(TTypeDefinitionEntry.Create(cvPublic, ttType, 'TTestType = class'));
    aType.Add(TTypeDefinitionEntry.Create(cvPrivate, ttField, 'FTestInt: Integer;'));
    aType.Add(TTypeDefinitionEntry.Create(cvPublic, ttMethod, 'procedure TestProcedure;'));
    BaseTemplate.InterfaceTypes.Add('TTestType', aType);

    Code :=  BaseTemplate.GetSource;
    try
      Assert.AreEqual(
        'unit TestUnitName;' + sLineBreak
        + sLineBreak
        + 'interface' + sLineBreak
        + sLineBreak
        + 'type' + sLineBreak
        + '  TTestType = class' + sLineBreak
        + '  private' + sLineBreak
        + '    FTestInt: Integer;' + sLineBreak
        + '  protected' + sLineBreak
        + '  public' + sLineBreak
        + '    procedure TestProcedure;' + sLineBreak
        + '  published' + sLineBreak
        + '  end;' + sLineBreak
        + sLineBreak
        + 'implementation' + sLineBreak
        + sLineBreak
        + 'end.' + sLineBreak
        , Code.Text);
    finally
      Code.Free;
    end;
  finally
    aType.Free;
  end;
end;

procedure TIDETemplateTests.TestBuildInterfaceUsesAndConstClauses;
var
  BaseTemplate: IDMVCCodeTemplate;
  Code: TStringList;
begin
  BaseTemplate := TMVCBaseUnitTemplate.Create('TestUnitName');
  BaseTemplate.InterfaceUses.Add('MyTestUnit1');
  BaseTemplate.InterfaceUses.Add('MyTestUnit2');
  BaseTemplate.InterfaceUses.Add('MyTestUnit3');

  BaseTemplate.InterfaceConst.Add('MY_CONST_1 = ''Test Const'';');
  BaseTemplate.InterfaceConst.Add('MY_CONST_2 = ''Test Const 2'';');
  BaseTemplate.InterfaceConst.Add('MY_CONST_3 = ''Test Const 3'';');

  Code :=  BaseTemplate.GetSource;
  try
    Assert.AreEqual(
      'unit TestUnitName;' + sLineBreak
      + sLineBreak
      + 'interface' + sLineBreak
      + sLineBreak
      + 'uses' + sLineBreak
      + '  MyTestUnit1,' + sLineBreak
      + '  MyTestUnit2,' + sLineBreak
      + '  MyTestUnit3;' + sLineBreak
      + sLineBreak
      + 'const' + sLineBreak
      + '  MY_CONST_1 = ''Test Const'';' + sLineBreak
      + '  MY_CONST_2 = ''Test Const 2'';' + sLineBreak
      + '  MY_CONST_3 = ''Test Const 3'';' + sLineBreak
      + sLineBreak
      + 'implementation' + sLineBreak
      + sLineBreak
      + 'end.' + sLineBreak
      , Code.Text);
  finally
    Code.Free;
  end;

end;

procedure TIDETemplateTests.TestBuildInterfaceUsesClause;
var
  BaseTemplate: IDMVCCodeTemplate;
  Code: TStringList;
begin
  BaseTemplate := TMVCBaseUnitTemplate.Create('TestUnitName');
  BaseTemplate.InterfaceUses.Add('MyTestUnit1');
  BaseTemplate.InterfaceUses.Add('MyTestUnit2');
  BaseTemplate.InterfaceUses.Add('MyTestUnit3');

  Code :=  BaseTemplate.GetSource;
  try
    Assert.AreEqual(
      'unit TestUnitName;' + sLineBreak
      + sLineBreak
      + 'interface' + sLineBreak
      + sLineBreak
      + 'uses' + sLineBreak
      + '  MyTestUnit1,' + sLineBreak
      + '  MyTestUnit2,' + sLineBreak
      + '  MyTestUnit3;' + sLineBreak
      + sLineBreak
      + 'implementation' + sLineBreak
      + sLineBreak
      + 'end.' + sLineBreak
      , Code.Text);

  finally
    Code.Free;
  end;
end;

procedure TIDETemplateTests.TestFBuildInitialization;
var
  BaseTemplate: IDMVCCodeTemplate;
  Code: TStringList;
begin
  BaseTemplate := TMVCBaseUnitTemplate.Create('TestUnitName');
  BaseTemplate.InitializationSection.Add('  Register;');

  Code :=  BaseTemplate.GetSource;
  try
    Assert.AreEqual(
      'unit TestUnitName;' + sLineBreak
      + sLineBreak
      + 'interface' + sLineBreak
      + sLineBreak
      + 'implementation' + sLineBreak
      + sLineBreak
      + 'initialization' + sLineBreak
      + '  Register;' + sLineBreak
      + sLineBreak
      + 'end.' + sLineBreak
      , Code.Text);

  finally
    Code.Free;
  end;
end;

procedure TIDETemplateTests.TestFinalization;
var
  BaseTemplate: IDMVCCodeTemplate;
  Code: TStringList;
begin
  BaseTemplate := TMVCBaseUnitTemplate.Create('TestUnitName');
  BaseTemplate.FinalizationSection.Add('  UnRegister;');

  Code :=  BaseTemplate.GetSource;
  try
    Assert.AreEqual(
      'unit TestUnitName;' + sLineBreak
      + sLineBreak
      + 'interface' + sLineBreak
      + sLineBreak
      + 'implementation' + sLineBreak
      + sLineBreak
      + 'finalization' + sLineBreak
      + '  UnRegister;' + sLineBreak
      + sLineBreak
      + 'end.' + sLineBreak
      , Code.Text);

  finally
    Code.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TIDETemplateTests);

end.
