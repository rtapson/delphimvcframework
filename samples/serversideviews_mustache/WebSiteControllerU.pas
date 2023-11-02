unit WebSiteControllerU;

interface

uses
  MVCFramework, System.Diagnostics, JsonDataObjects, MVCFramework.Commons, DAL,
  System.Generics.Collections;

type

  [MVCPath('/')]
  TWebSiteController = class(TMVCController)
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionNAme: string;
      var Handled: Boolean); override;
    procedure GeneratePeopleListAsCSV;
  public
    [MVCPath('/people')]
    [MVCHTTPMethods([httpGET])]
    [MVCProduces(TMVCMediaType.TEXT_HTML)]
    procedure PeopleList;

    [MVCPath('/people')]
    [MVCHTTPMethods([httpGET])]
    [MVCProduces(TMVCMediaType.TEXT_CSV)]
    // RESTful API, requires ACCEPT=text/csv
    procedure ExportPeopleListAsCSV_API;

    [MVCPath('/people/formats/csv')]
    [MVCHTTPMethods([httpGET])]
    // Route usable by the browser, doesn't requires ACCEPT=text/csv
    procedure ExportPeopleListAsCSV;

    [MVCPath('/people')]
    [MVCHTTPMethods([httpPOST])]
    [MVCConsumes(TMVCMediaType.APPLICATION_FORM_URLENCODED)]
    procedure SavePerson(const [MVCFromBody] Person: TPerson);

    [MVCPath('/deleteperson')]
    [MVCHTTPMethods([httpPOST])]
    [MVCConsumes(TMVCMediaType.APPLICATION_FORM_URLENCODED)]
    procedure DeletePerson;

    [MVCPath('/new')]
    [MVCHTTPMethods([httpGET])]
    [MVCProduces(TMVCMediaType.TEXT_HTML)]
    function NewPerson: String;

    [MVCPath('/edit/($guid)')]
    [MVCHTTPMethods([httpGET])]
    [MVCProduces(TMVCMediaType.TEXT_HTML)]
    function EditPerson(guid: string): String;

    [MVCPath('/')]
    [MVCHTTPMethods([httpGET])]
    [MVCProduces(TMVCMediaType.TEXT_HTML)]
    procedure Index;

    [MVCPath('/showcase')]
    [MVCHTTPMethods([httpGET])]
    [MVCProduces(TMVCMediaType.TEXT_HTML)]
    procedure MustacheTemplateShowCase;
  end;

implementation

{ TWebSiteController }

uses System.SysUtils, Web.HTTPApp;

procedure TWebSiteController.DeletePerson;
var
  lGUID: string;
  LDAL: IPeopleDAL;
begin
  lGUID := Context.Request.Params['guid'];
  LDAL := TServicesFactory.GetPeopleDAL;
  LDAL.DeleteByGUID(lGUID);
  Redirect('/people');
end;

function TWebSiteController.EditPerson(guid: string): String;
var
  LDAL: IPeopleDAL;
  lPerson: TPerson;
  lDevices: TArray<String>;
  lJDevices: TJSONArray;
  lItem: string;
  lIdx: Integer;
  lJObj: TJsonObject;
begin
  LDAL := TServicesFactory.GetPeopleDAL;
  lPerson := LDAL.GetPersonByGUID(guid);
  try
    lDevices := LDAL.GetDevicesList;
    ViewData['person'] := lPerson;
    lJObj := TJsonObject.Create;
    try
      lJDevices := lJObj.A['devices'];
      for lItem in lDevices do
      begin
        var lJItm := lJDevices.AddObject;
        lJItm.S['name'] := lItem;
        lJItm.B['selected'] := TArray.BinarySearch<String>(lDevices, lItem, lIdx);
      end;
      Result := GetRenderedView(['header', 'editperson', 'footer'], lJObj);
    finally
      lJObj.Free;
    end;
  finally
    lPerson.Free;
  end;
end;

procedure TWebSiteController.ExportPeopleListAsCSV;
begin
  GeneratePeopleListAsCSV;
  // define the correct behaviour to download the csv inside the browser
  ContentType := TMVCMediaType.TEXT_CSV;
  Context.Response.CustomHeaders.Values['Content-Disposition'] :=
    'attachment; filename=people.csv';
end;

procedure TWebSiteController.ExportPeopleListAsCSV_API;
begin
  GeneratePeopleListAsCSV;
end;

procedure TWebSiteController.GeneratePeopleListAsCSV;
var
  LDAL: IPeopleDAL;
  lPeople: TPeople;
begin
  LDAL := TServicesFactory.GetPeopleDAL;
  lPeople := LDAL.GetPeople;
  try
    ViewData['people'] := lPeople;
    LoadView(['people_header.csv', 'people_list.csv']);
    RenderResponseStream; // rember to call RenderResponseStream!!!
  finally
    lPeople.Free;
  end;
end;

procedure TWebSiteController.Index;
begin
  Redirect('/people');
end;

procedure TWebSiteController.MustacheTemplateShowCase;
var
  LDAL: IPeopleDAL;
  lPeople, lPeople2: TPeople;
  lMyObj: TMyObj;
begin
  LDAL := TServicesFactory.GetPeopleDAL;
  lPeople := LDAL.GetPeople;
  try
    lPeople2 := TPeople.Create;
    try
      lMyObj := TMyObj.Create;
      try
        lMyObj.RawHTML := '<h1>This is</h1>Raw<br><span>HTML</span>';
        ViewData['people'] := lPeople;
        ViewData['people2'] := lPeople2;
        ViewData['myobj'] := lMyObj;
        LoadView(['showcase']);
        RenderResponseStream;
      finally
        lMyObj.Free;
      end;
    finally
      lPeople2.Free;
    end;
  finally
    lPeople.Free;
  end;
end;

function TWebSiteController.NewPerson: String;
var
  LDAL: IPeopleDAL;
  lDevices: TArray<String>;
  lJObj: TJsonObject;
begin
  LDAL := TServicesFactory.GetPeopleDAL;
  lDevices := LDAL.GetDevicesList;
  lJObj := TJsonObject.Create;
  try
    var lJDevices := lJObj.A['devices'];
    for var lItem in lDevices do
    begin
      var lJItm := lJDevices.AddObject;
      lJItm.S['name'] := lItem;
      lJItm.B['selected'] := False;
    end;
    Result := GetRenderedView(['header', 'editperson', 'footer'], lJObj);
  finally
    lJObj.Free;
  end;
end;

procedure TWebSiteController.OnBeforeAction(Context: TWebContext;
  const AActionNAme: string; var Handled: Boolean);
begin
  inherited;
  ContentType := 'text/html';
  Handled := False;
end;

procedure TWebSiteController.PeopleList;
var
  LDAL: IPeopleDAL;
  lPeople: TPeople;
begin
  LDAL := TServicesFactory.GetPeopleDAL;
  lPeople := LDAL.GetPeople;
  try
    ViewData['people'] := lPeople;
    LoadView(['header', 'people_list', 'footer']);
    RenderResponseStream; // rember to call RenderResponseStream!!!
  finally
    lPeople.Free;
  end;

end;

procedure TWebSiteController.SavePerson(const [MVCFromBody] Person: TPerson);
var
  LPeopleDAL: IPeopleDAL;
begin
  if Person.FirstName.IsEmpty or Person.LastName.IsEmpty or (Person.Age <= 0) then
  begin
    { TODO -oDaniele -cGeneral : Show how to properly render an exception }
    raise EMVCException.Create('Invalid data',
      'First name, last name and age are not optional', 0);
  end;

  LPeopleDAL := TServicesFactory.GetPeopleDAL;
  LPeopleDAL.AddPerson(Person.FirstName, Person.LastName,
    Person.Age, Person.Devices);
  Redirect('/people');
end;

end.
