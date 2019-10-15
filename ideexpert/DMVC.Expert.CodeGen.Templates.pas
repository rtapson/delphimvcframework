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

unit DMVC.Expert.CodeGen.Templates;

interface

resourcestring

  { Delphi template code }
  // 0 - project name
  // 1 - http/s port
  sDMVCDPR =
    'program %0:s;' + sLineBreak +
    sLineBreak +
    ' {$APPTYPE CONSOLE}' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  System.SysUtils,' + sLineBreak +
    '  MVCFramework.Logger,' + sLineBreak +
    '  MVCFramework.Commons,' + sLineBreak +
    '  MVCFramework.REPLCommandsHandlerU,' + sLineBreak +
    '  Web.ReqMulti, {If you have problem with this unit, see https://quality.embarcadero.com/browse/RSP-17216}' + sLineBreak +
    '  Web.WebReq,' + sLineBreak +
    '  Web.WebBroker,' + sLineBreak +
    '  IdHTTPWebBrokerBridge;' + sLineBreak +
    '' + sLineBreak +
    '{$R *.res}' + sLineBreak + sLineBreak +
    'procedure RunServer(APort: Integer);' + sLineBreak +
    'var' + sLineBreak +
    '  lServer: TIdHTTPWebBrokerBridge;' + sLineBreak +
    '  lCustomHandler: TMVCCustomREPLCommandsHandler;' + sLineBreak +
    '  lCmd: string;' + sLineBreak +
    'begin' + sLineBreak +
    '  Writeln(''** DMVCFramework Server ** build '' + DMVCFRAMEWORK_VERSION);' + sLineBreak +
    '  if ParamCount >= 1 then' + sLineBreak +
    '    lCmd := ParamStr(1)' + sLineBreak +
    '  else' + sLineBreak +
    '    lCmd := ''start'';' + sLineBreak +
    '' + sLineBreak +
    '  lCustomHandler := function(const Value: String; const Server: TIdHTTPWebBrokerBridge; out Handled: Boolean): THandleCommandResult' + sLineBreak +
    '    begin' + sLineBreak +
    '      Handled := False;' + sLineBreak +
    '      Result := THandleCommandResult.Unknown;' + sLineBreak +
    '' + sLineBreak +
    '      // Write here your custom command for the REPL using the following form...' + sLineBreak +
    '      // ***' + sLineBreak +
    '      // Handled := False;' + sLineBreak +
    '      // if (Value = ''apiversion'') then' + sLineBreak +
    '      // begin' + sLineBreak +
    '      // REPLEmit(''Print my API version number'');' + sLineBreak +
    '      // Result := THandleCommandResult.Continue;' + sLineBreak +
    '      // Handled := True;' + sLineBreak +
    '      // end' + sLineBreak +
    '      // else if (Value = ''datetime'') then' + sLineBreak +
    '      // begin' + sLineBreak +
    '      // REPLEmit(DateTimeToStr(Now));' + sLineBreak +
    '      // Result := THandleCommandResult.Continue;' + sLineBreak +
    '      // Handled := True;' + sLineBreak +
    '      // end;' + sLineBreak +
    '    end;' + sLineBreak +
    '' + sLineBreak +
    '  LServer := TIdHTTPWebBrokerBridge.Create(nil);' + sLineBreak +
    '  try' + sLineBreak +
    '    LServer.DefaultPort := APort;' + sLineBreak +
    '' + sLineBreak +
    '    { more info about MaxConnections' + sLineBreak +
    '      http://www.indyproject.org/docsite/html/frames.html?frmname=topic&frmfile=TIdCustomTCPServer_MaxConnections.html }' + sLineBreak +
    '    LServer.MaxConnections := 0;' + sLineBreak +
    '' + sLineBreak +
    '    { more info about ListenQueue' + sLineBreak +
    '      http://www.indyproject.org/docsite/html/frames.html?frmname=topic&frmfile=TIdCustomTCPServer_ListenQueue.html }' + sLineBreak +
    '    LServer.ListenQueue := 200;' + sLineBreak +
    '' + sLineBreak +
    '    WriteLn(''Write "quit" or "exit" to shutdown the server'');' + sLineBreak +
    '    repeat' + sLineBreak +
    '      if lCmd.IsEmpty then' + sLineBreak +
    '      begin' + sLineBreak +
    '        Write(''-> '');' + sLineBreak +
    '        ReadLn(lCmd)' + sLineBreak +
    '      end;' + sLineBreak +
    '      try' + sLineBreak +
    '        case HandleCommand(lCmd.ToLower, LServer, lCustomHandler) of' + sLineBreak +
    '          THandleCommandResult.Continue:' + sLineBreak +
    '            begin' + sLineBreak +
    '              Continue;' + sLineBreak +
    '            end;' + sLineBreak +
    '          THandleCommandResult.Break:' + sLineBreak +
    '            begin' + sLineBreak +
    '              Break;' + sLineBreak +
    '            end;' + sLineBreak +
    '          THandleCommandResult.Unknown:' + sLineBreak +
    '            begin' + sLineBreak +
    '              REPLEmit(''Unknown command: '' + lCmd);' + sLineBreak +
    '            end;' + sLineBreak +
    '        end;' + sLineBreak +
    '      finally' + sLineBreak +
    '        lCmd := '''';' + sLineBreak +
    '      end;' + sLineBreak +
    '    until false;' + sLineBreak +
    '' + sLineBreak +
    '  finally' + sLineBreak +
    '    LServer.Free;' + sLineBreak +
    '  end;' + sLineBreak +

    'end;' + sLineBreak +
    sLineBreak +
    'begin' + sLineBreak +
    '  ReportMemoryLeaksOnShutdown := True;' + sLineBreak +
    '  IsMultiThread := True;' + sLineBreak +
    '  try' + sLineBreak +
    '    if WebRequestHandler <> nil then' + sLineBreak +
    '      WebRequestHandler.WebModuleClass := WebModuleClass;' + sLineBreak +
    '    WebRequestHandlerProc.MaxConnections := 1024;' + sLineBreak +
    '    RunServer(%1:d);' + sLineBreak +
    '  except' + sLineBreak +
    '    on E: Exception do' + sLineBreak +
    '      Writeln(E.ClassName, '': '', E.Message);' + sLineBreak +
    '  end;' + sLineBreak +
    'end.' + sLineBreak;

  // 0 - Unit Name
  // 1 - Class Name
  // 2 - Sample Methods - Interface
  // 3 - Sample Methods - Implementation
  // 4 - Action Filters - Interface
  // 5 - Action Filters - Implementation
  sControllerUnit = 'unit %0:s;' + sLineBreak +
    sLineBreak +
    'interface' + sLineBreak +
    sLineBreak +
    'uses' + sLineBreak +
    '  MVCFramework, MVCFramework.Commons;' + sLineBreak +
    sLineBreak +
    'type' + sLineBreak +
    sLineBreak +
    '  [MVCPath(''/api'')]' + sLineBreak +
    '  %1:s = class(TMVCController) ' + sLineBreak +
    '  public' + sLineBreak +
    '%2:s' +
    '%4:s' +
    '%6:s' +
    '  end;' + sLineBreak +
    sLineBreak +
    'implementation' + sLineBreak + sLineBreak +
    'uses' + sLineBreak +
    '  System.SysUtils, MVCFramework.Logger, System.StrUtils;' + sLineBreak +
    sLineBreak +
    '%3:s' + sLineBreak +
    '%5:s' + sLineBreak +
    '%7:s' + sLineBreak +
    sLineBreak +
    'end.' + sLineBreak;

  sIndexMethodIntf =
    '    [MVCPath(''/'')]' + sLineBreak +
    '    [MVCHTTPMethod([httpGET])]' + sLineBreak +
    '    procedure Index;' + sLineBreak + sLineBreak +
    '    [MVCPath(''/reversedstrings/($Value)'')]' + sLineBreak +
    '    [MVCHTTPMethod([httpGET])]' + sLineBreak +
    '    procedure GetReversedString(const Value: String);' + sLineBreak;

  // 0 - Class Name
  sIndexMethodImpl =
    'procedure %0:s.Index;' + sLineBreak +
    'begin' + sLineBreak +
    '  //use Context property to access to the HTTP request and response ' + sLineBreak +
    '  Render(''Hello DelphiMVCFramework World'');' + sLineBreak +
    'end;' + sLineBreak + sLineBreak +
    'procedure %0:s.GetReversedString(const Value: String);' + sLineBreak +
    'begin' + sLineBreak +
    '  Render(System.StrUtils.ReverseString(Value.Trim));' + sLineBreak +
    'end;' + sLineBreak;

  sCRUDMethodsIntf =
    sLineBreak +
		'  public' + sLineBreak + 
    '    //Sample CRUD Actions for a "Customer" entity' + sLineBreak +
    '    [MVCPath(''/customers'')]' + sLineBreak +
    '    [MVCHTTPMethod([httpGET])]' + sLineBreak +
    '    procedure GetCustomers;' + sLineBreak + sLineBreak +
    '    [MVCPath(''/customers/($id)'')]' + sLineBreak +
    '    [MVCHTTPMethod([httpGET])]' + sLineBreak +
    '    procedure GetCustomer(id: Integer);' + sLineBreak + sLineBreak +
    '    [MVCPath(''/customers'')]' + sLineBreak +
    '    [MVCHTTPMethod([httpPOST])]' + sLineBreak +
    '    procedure CreateCustomer;' + sLineBreak + sLineBreak +
    '    [MVCPath(''/customers/($id)'')]' + sLineBreak +
    '    [MVCHTTPMethod([httpPUT])]' + sLineBreak +
    '    procedure UpdateCustomer(id: Integer);' + sLineBreak + sLineBreak +
    '    [MVCPath(''/customers/($id)'')]' + sLineBreak +
    '    [MVCHTTPMethod([httpDELETE])]' + sLineBreak +
    '    procedure DeleteCustomer(id: Integer);' + sLineBreak + sLineBreak;

  sCRUDMethodsImpl =
    '//Sample CRUD Actions for a "Customer" entity' + sLineBreak +
    'procedure %0:s.GetCustomers;' + sLineBreak +
    'begin' + sLineBreak +
    '  //todo: render a list of customers' + sLineBreak +
    'end;' + sLineBreak + sLineBreak +
    'procedure %0:s.GetCustomer(id: Integer);' + sLineBreak +
    'begin' + sLineBreak +
    '  //todo: render the customer by id' + sLineBreak +
    'end;' + sLineBreak + sLineBreak +
    'procedure %0:s.CreateCustomer;' + sLineBreak + sLineBreak +
    'begin' + sLineBreak +
    '  //todo: create a new customer' + sLineBreak +
    'end;' + sLineBreak + sLineBreak +
    'procedure %0:s.UpdateCustomer(id: Integer);' + sLineBreak +
    'begin' + sLineBreak +
    '  //todo: update customer by id' + sLineBreak +
    'end;' + sLineBreak + sLineBreak +
    'procedure %0:s.DeleteCustomer(id: Integer);' + sLineBreak +
    'begin' + sLineBreak +
    '  //todo: delete customer by id' + sLineBreak +
    'end;' + sLineBreak + sLineBreak;

  sActionFiltersIntf =
    '  protected' + sLineBreak +
    '    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;'
    + sLineBreak +
    '    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;' +
    sLineBreak;

  sActionFiltersImpl =
    'procedure %0:s.OnAfterAction(Context: TWebContext; const AActionName: string); ' + sLineBreak +
    'begin' + sLineBreak +
    '  { Executed after each action }' + sLineBreak +
    '  inherited;' + sLineBreak +
    'end;' + sLineBreak +
    sLineBreak +
    'procedure %0:s.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);'
    + sLineBreak +
    'begin' + sLineBreak +
    '  { Executed before each action' + sLineBreak +
    '    if handled is true (or an exception is raised) the actual' + sLineBreak +
    '    action will not be called }' + sLineBreak +
    '  inherited;' + sLineBreak +
    'end;' + sLineBreak;

  sDefaultControllerName = 'TMyController';
  sDefaultWebModuleName = 'TMyWebModule';
  sDefaultServerPort = '8080';

  // 0 = unit name
  // 1 = webmodule classname
  // 2 = controller unit
  // 3 - controller class name
  sWebModuleUnit =
    'unit %0:s;' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    sLineBreak +
    'uses System.SysUtils,' + sLineBreak +
    '     System.Classes,' + sLineBreak +
    '     Web.HTTPApp,' + sLineBreak +
    '     MVCFramework;' + sLineBreak +
    sLineBreak +
    'type' + sLineBreak +
    '  %1:s = class(TWebModule)' + sLineBreak +
    '    procedure WebModuleCreate(Sender: TObject);' + sLineBreak +
    '    procedure WebModuleDestroy(Sender: TObject);' + sLineBreak +
    '  private' + sLineBreak +
    '    FMVC: TMVCEngine;' + sLineBreak +
    '  public' + sLineBreak +
    '    { Public declarations }' + sLineBreak +
    '  end;' + sLineBreak +
    sLineBreak +
    'var' + sLineBreak +
    '  WebModuleClass: TComponentClass = %1:s;' + sLineBreak +
    sLineBreak +
    'implementation' + sLineBreak +
    sLineBreak +
    '{$R *.dfm}' + sLineBreak +
    sLineBreak +
    'uses %2:s, System.IOUtils, MVCFramework.Commons, MVCFramework.Middleware.Compression;' + sLineBreak +
    sLineBreak +
    'procedure %1:s.WebModuleCreate(Sender: TObject);' + sLineBreak +
    'begin' + sLineBreak +
    '  FMVC := TMVCEngine.Create(Self,' + sLineBreak +
    '    procedure(Config: TMVCConfig)' + sLineBreak +
    '    begin' + sLineBreak +
    '      //enable static files' + sLineBreak +
		'      Config[TMVCConfigKey.DocumentRoot] := TPath.Combine(ExtractFilePath(GetModuleName(HInstance)), ''www'');'
    + sLineBreak +
    '      // session timeout (0 means session cookie)' + sLineBreak +
    '      Config[TMVCConfigKey.SessionTimeout] := ''0'';' + sLineBreak +
    '      //default content-type' + sLineBreak +
    '      Config[TMVCConfigKey.DefaultContentType] := TMVCConstants.DEFAULT_CONTENT_TYPE;' +
    sLineBreak +
    '      //default content charset' + sLineBreak +
    '      Config[TMVCConfigKey.DefaultContentCharset] := TMVCConstants.DEFAULT_CONTENT_CHARSET;' +
    sLineBreak +
    '      //unhandled actions are permitted?' + sLineBreak +
    '      Config[TMVCConfigKey.AllowUnhandledAction] := ''false'';' + sLineBreak +
    '      //default view file extension' + sLineBreak +
    '      Config[TMVCConfigKey.DefaultViewFileExtension] := ''html'';' + sLineBreak +
    '      //view path' + sLineBreak +
    '      Config[TMVCConfigKey.ViewPath] := ''templates'';' + sLineBreak +
    '      //Max Record Count for automatic Entities CRUD' + sLineBreak +
    '      Config[TMVCConfigKey.MaxEntitiesRecordCount] := ''20'';' + sLineBreak +   
	'      //Enable Server Signature in response' + sLineBreak +
    '      Config[TMVCConfigKey.ExposeServerSignature] := ''true'';' + sLineBreak +
    '      // Define a default URL for requests that don''t map to a route or a file (useful for client side web app)' + sLineBreak +
    '      Config[TMVCConfigKey.FallbackResource] := ''index.html'';' + sLineBreak +
    '      // Max request size in bytes' + sLineBreak +
    '      Config[TMVCConfigKey.MaxRequestSize] := IntToStr(TMVCConstants.DEFAULT_MAX_REQUEST_SIZE);' + sLineBreak +	
    '    end);' + sLineBreak +
    '  FMVC.AddController(%3:s);' + sLineBreak +
    '  // To enable compression (deflate, gzip) just add this middleware as the last one ' + sLineBreak +
    '  FMVC.AddMiddleware(TMVCCompressionMiddleware.Create);' + sLineBreak +
    'end;' + sLineBreak +
    sLineBreak +
    'procedure %1:s.WebModuleDestroy(Sender: TObject);' + sLineBreak +
    'begin' + sLineBreak +
    '  FMVC.Free;' + sLineBreak +
    'end;' + sLineBreak +
    sLineBreak +
    'end.' + sLineBreak;

  sWebModuleDFM =
    'object %0:s: %1:s' + sLineBreak +
    '  OldCreateOrder = False' + sLineBreak +
    '  OnCreate = WebModuleCreate' + sLineBreak +
    '  OnDestroy = WebModuleDestroy' + sLineBreak +
    '  Height = 230' + sLineBreak +
    '  Width = 415' + sLineBreak +
    'end';

  // 0: DIConfiguration unit name
  // 1: ControllerUnit
  // 2: ControllerClass
  sSpring4DDIConfiguration =
    'unit %0:s;' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  Spring, Spring.Container;' + sLineBreak +
    '' + sLineBreak +
    'procedure BuildContainer;' + sLineBreak +
    'function Container: TContainer;' + sLineBreak +
    '' + sLineBreak +
    'implementation' + sLineBreak +
    '' + sLineBreak +
    'uses Spring.Container.Common, %1:s;' + sLineBreak +
    '' + sLineBreak +
    'var' + sLineBreak +
    '  GContainer: TContainer = nil;' + sLineBreak +
    '' + sLineBreak +
    'function Container: TContainer;' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := GContainer;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure BuildContainer;' + sLineBreak +
    'begin' + sLineBreak +
    '  Assert(not Assigned(GContainer), ''Container already built'');' + sLineBreak +
    '  GContainer := TContainer.Create;' + sLineBreak +
    '  // Registering controllers' + sLineBreak +
    '  GContainer.RegisterType<%2:s>;' + sLineBreak +
    '' + sLineBreak +
    '  // Registering Services' + sLineBreak +
    '  //GContainer.RegisterType<TUsersService>.Implements<IUsersService>;' + sLineBreak +
    '  //GContainer.RegisterType<TCustomersService>.Implements<ICustomersService>;' + sLineBreak +
    '' + sLineBreak +
    '  // Maybe that the common service must be register as singleton or as singleton per thread' + sLineBreak +
    '  // because must be the same instances between the first and the second service (e.g. DB transaction)' + sLineBreak +
    '' + sLineBreak +
    '  // Transient registration (default)' + sLineBreak +
    '  // GContainer.RegisterType<TCommonService>.Implements<ICommonService>;' + sLineBreak +
    '' + sLineBreak +
    '  // Singleton registration for all thread. WARNING!!! It is shared between HTTP calls.' + sLineBreak +
    '  // GContainer.RegisterType<TCommonService>.Implements<ICommonService>.AsSingleton(TRefCounting.True);' + sLineBreak +
    '' + sLineBreak +
    '  // Singleton per thread registration. WARNING!!! (read below) Shared by all services within the same HTTP call.' + sLineBreak +
    '  // GContainer.RegisterType<TCommonService>.Implements<ICommonService>.AsSingletonPerThread(TRefCounting.True);' + sLineBreak +
    '' + sLineBreak +
    '  {' + sLineBreak +
    '   About "AsSingletonPerThread" Stefan Glienke said:' + sLineBreak +
    '   It might be confusing as people are assuming that the container magically' + sLineBreak +
    '   knows when a thread ends to destroy a singleton per thread. But that is not the case.' +  sLineBreak +
    '   In fact it gets created once per threadid. That means even if your thread has' + sLineBreak +
    '   ended and a new one starts later using the same threadid you get the' + sLineBreak +
    '   same object as before.' + sLineBreak +
    '   If you don''t use a threadpool where you have the same threads running all the' + sLineBreak +
    '   time performing tasks it is not a good idea to use singleton per thread.' + sLineBreak +
    '   You might use transient then to always create a new instance or - and this' + sLineBreak +
    '   is imo the better solution - use a threadpool which limits the objects' + sLineBreak +
    '   created (and also reduce the creation of thread objects).' + sLineBreak +
    '   Nevertheless singleton per thread instances will always be destroyed' + sLineBreak +
    '   when the container is getting destroyed, not earlier.' + sLineBreak +
    '   This is also not a strange behavior of our container but also Castle Windsor' + sLineBreak +
    '   or Unity. However there is also advice against using it there.' + sLineBreak +
    '   If you are looking more for something like singleton per request I suggest' + sLineBreak +
    '   using transient and making sure that at the start of the request it gets' + sLineBreak +
    '   resolved from the container and then passed around where ever needed (think' + sLineBreak +
    '   about implementing refcounting to your data module!) and dropping it at the' + sLineBreak +
    '   end of the request which makes it getting destroyed due to ref counting.' + sLineBreak +
    '  }' + sLineBreak +
    '' + sLineBreak +
    '  // Build the container' + sLineBreak +
    '  GContainer.Build;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'initialization' + sLineBreak +
    '' + sLineBreak +
    'finalization' + sLineBreak +
    '  GContainer.Free;' + sLineBreak +
    '' + sLineBreak +
    'end.';

  // 0 - Unit Name
  // 1 - Class Name
  // 2 - Sample Methods - Interface
  // 3 - Sample Methods - Implementation
  // 4 - Action Filters - Interface
  // 5 - Action Filters - Implementation
  // 8: Controller path
  sSpring4DController =
    'unit %0:s;' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  MVCFramework, MVCFramework.Commons, Spring.Container.Common;' + sLineBreak +
    '' + sLineBreak +
    'type' + sLineBreak +
    '' + sLineBreak +
    '  [MVCPath(''/%8:s'')]' + sLineBreak +
    '  %1:s = class(TMVCController)' + sLineBreak +
    '  private' + sLineBreak +
    '    //[Inject]' + sLineBreak +
    '    //fUsersService: IUsersService;' + sLineBreak +
    '  public' + sLineBreak +
    '    [MVCPath]' + sLineBreak +
    '    [MVCHTTPMethod([httpGET])]' + sLineBreak +
    '    procedure Index;' + sLineBreak +
    '  end;' + sLineBreak +
    '' + sLineBreak +
    'implementation' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  System.SysUtils, MVCFramework.Logger, System.StrUtils;' + sLineBreak +
    '' + sLineBreak +
    'procedure %1:s.Index;' + sLineBreak +
    'begin' + sLineBreak +
    '  //ContentType := BuildContentType(TMVCMediaType.TEXT_PLAIN, TMVCCharSet.ISO88591);' + sLineBreak +
    '  //ResponseStream.AppendLine(''THIS IS A TEST FOR SPRING4D INTEGRATION'');' + sLineBreak +
    '  //ResponseStream.AppendLine(''==============================================================='');' + sLineBreak +
    '  //ResponseStream.AppendLine(''fUsersService.GetUserNameByID(1234)          => '' + ' + sLineBreak +
    '  //fUsersService.GetUserNameByID(1234));' + sLineBreak +
    '  RenderResponseStream;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'end.';

  // 0 = unit name
  // 1 = webmodule classname
  // 2 = controller unit
  // 3 - controller class name
  sSpring4DWebModule =
  'unit %0:s;' + sLineBreak +
  '' + sLineBreak +
  'interface' + sLineBreak +
  '' + sLineBreak +
  'uses' + sLineBreak +
  '  System.SysUtils,' + sLineBreak +
  '  System.Classes,' + sLineBreak +
  '  Web.HTTPApp,' + sLineBreak +
  '  MVCFramework;' + sLineBreak +
  '' + sLineBreak +
  'type' + sLineBreak +
  '  %1:s = class(TWebModule)' + sLineBreak +
  '    procedure WebModuleCreate(Sender: TObject);' + sLineBreak +
  '    procedure WebModuleDestroy(Sender: TObject);' + sLineBreak +
  '  private' + sLineBreak +
  '    FMVC: TMVCEngine;' + sLineBreak +
  '  public' + sLineBreak +
  '  end;' + sLineBreak +
  '' + sLineBreak +
  'var' + sLineBreak +
  '  WebModuleClass: TComponentClass = %1:s;' + sLineBreak +
  '' + sLineBreak +
  'implementation' + sLineBreak +
  '' + sLineBreak +
  '{$R *.dfm}' + sLineBreak +
  '' + sLineBreak +
  'uses' + sLineBreak +
  ' %2:s,' + sLineBreak +
  ' System.IOUtils,' + sLineBreak +
  ' MVCFramework.Commons,' + sLineBreak +
  ' MVCFramework.Middleware.Compression,' + sLineBreak +
  ' //CustomTypesSerializersU,' + sLineBreak +
  ' Spring;' + sLineBreak +
  '' + sLineBreak +
  'procedure %1:s.WebModuleCreate(Sender: TObject);' + sLineBreak +
  'begin' + sLineBreak +
  '  FMVC := TMVCEngine.Create(Self,' + sLineBreak +
  '    procedure(Config: TMVCConfig)' + sLineBreak +
  '    begin' + sLineBreak +
  '      // enable static files' + sLineBreak +
  '      Config[TMVCConfigKey.DocumentRoot] := TPath.Combine(ExtractFilePath(GetModuleName(HInstance)), ''www'');' + sLineBreak +
  '      // session timeout (0 means session cookie)' + sLineBreak +
  '      Config[TMVCConfigKey.SessionTimeout] := ''0'';' + sLineBreak +
  '      // default content-type' + sLineBreak +
  '      Config[TMVCConfigKey.DefaultContentType] := TMVCConstants.DEFAULT_CONTENT_TYPE;' + sLineBreak +
  '      // default content charset' + sLineBreak +
  '      Config[TMVCConfigKey.DefaultContentCharset] := TMVCConstants.DEFAULT_CONTENT_CHARSET;' + sLineBreak +
  '      // unhandled actions are permitted?' + sLineBreak +
  '      Config[TMVCConfigKey.AllowUnhandledAction] := ''false'';' + sLineBreak +
  '      // default view file extension' + sLineBreak +
  '      Config[TMVCConfigKey.DefaultViewFileExtension] := ''html'';' + sLineBreak +
  '      // view path' + sLineBreak +
  '      Config[TMVCConfigKey.ViewPath] := ''templates'';' + sLineBreak +
  '      // Max Record Count for automatic Entities CRUD' + sLineBreak +
  '      Config[TMVCConfigKey.MaxEntitiesRecordCount] := ''20'';' + sLineBreak +
  '      // Enable Server Signature in response' + sLineBreak +
  '      Config[TMVCConfigKey.ExposeServerSignature] := ''true'';' + sLineBreak +
  '      // Define a default URL for requests that don''t map to a route or a file (useful for client side web app)' + sLineBreak +
  '      Config[TMVCConfigKey.FallbackResource] := ''index.html'';' + sLineBreak +
  '    end);' + sLineBreak +
  '  FMVC.AddController(%3:s);' + sLineBreak +
  '  // To enable compression (deflate, gzip) just add this middleware as the last one' + sLineBreak +
  '  FMVC.AddMiddleware(TMVCCompressionMiddleware.Create);' + sLineBreak +
  '  //FMVC.Serializers.Items[''application/json''].RegisterTypeSerializer(typeinfo(Nullable<System.Integer>),' + sLineBreak +
  '  //TNullableIntegerSerializer.Create);' + sLineBreak +
  '  //FMVC.Serializers.Items[''application/json''].RegisterTypeSerializer(typeinfo(Nullable<System.Currency>),' + sLineBreak +
  '  //TNullableCurrencySerializer.Create);' + sLineBreak +
  '  //FMVC.Serializers.Items[''application/json''].RegisterTypeSerializer(typeinfo(Nullable<System.string>),' + sLineBreak +
  '  //TNullableStringSerializer.Create);' + sLineBreak +
  'end;' + sLineBreak +
  '' + sLineBreak +
  'procedure %1:s.WebModuleDestroy(Sender: TObject);' + sLineBreak +
  'begin' + sLineBreak +
  ' FMVC.Free;' + sLineBreak +
  'end;' + sLineBreak +
  '' + sLineBreak +
  'end.';

  { Delphi template code }
  // 0 - project name
  sISAPIProject =
    'library %0:s;' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  Winapi.ActiveX,' + sLineBreak +
    '  System.Win.ComObj,' + sLineBreak +
    '  System.SysUtils,' + sLineBreak +
    '  MVCFramework.Logger,' + sLineBreak +
    '  MVCFramework.Commons,' + sLineBreak +
    '  MVCFramework.REPLCommandsHandlerU,' + sLineBreak +
    '  Web.ReqMulti,' + sLineBreak +
    '  Web.WebReq,' + sLineBreak +
    '  Web.WebBroker,' + sLineBreak +
    '  Web.Win.ISAPIApp,' + sLineBreak +
    '  Web.Win.ISAPIThreadPool,' + sLineBreak +
    '  IdHTTPWebBrokerBridge;' + sLineBreak +
    '' + sLineBreak +
    '' + sLineBreak +
    'exports' + sLineBreak +
    '  GetExtensionVersion,' + sLineBreak +
    '  HttpExtensionProc,' + sLineBreak +
    '  TerminateExtension;' + sLineBreak +
    'begin' + sLineBreak +
    '  CoInitFlags := COINIT_MULTITHREADED;' + sLineBreak +
    '  Application.Initialize;' + sLineBreak +
    '  Application.WebModuleClass := WebModuleClass;' + sLineBreak +
    '  Application.Run;' + sLineBreak +
    '' + sLineBreak +
    'end.';



implementation

end.
