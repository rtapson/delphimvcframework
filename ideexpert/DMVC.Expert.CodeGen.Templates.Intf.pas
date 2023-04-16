unit DMVC.Expert.CodeGen.Templates.Intf;

interface

uses
  Generics.Collections,
  Classes;

type
  TVisibility = (cvPrivate, cvProtected, cvPublic, cvPublished);
  TTextType = (ttField, ttMethod, ttProperty, ttconst, ttType);
  TAddBlankLine = (blNone, blBefore, blAfter, blBoth);

  TTypeDefinitionEntry = class
  private
    FVisibility: TVisibility;
    FText: string;
    FTextType: TTextType;
    FAttributes: TStringList;
    FAddBlankLine: TAddBlankLine;
    FComment: TStringList;
  public
    constructor Create(const Visibility: TVisibility; const TextType: TTextType; const Text: string; const AddBlankLine: TAddBlankLine = blNone); overload;
    destructor Destroy;
    property Text: string read FText;
    property Visibility: TVisibility read FVisibility;
    property TextType: TTextType read FTextType;
    property Attributes: TStringList read FAttributes;
    property BlankLines: TAddBlankLine read FAddBlankLine;
    property Comment: TStringList read FComment;
  end;

  IDMVCCodeTemplate = interface
    function GetInterfaceConst: TStringList;
    function GetInterfaceType: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
    function GetInterfaceUses: TStringList;
    function GetFileName: string;
    procedure SetFileName(const Value: string);
    function GetImplementationCode: TStringList;
    function GetImplementationConst: TStringList;
    function GetImplementationType: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>>;
    function GetImplementationUses: TStringList;
    function GetInterfaceCode: TStringList;
    function GetFinalizationSection: TStringList;
    function GetInitializationSection: TStringList;

    procedure BuildTemplate;

    function GetSource: TStringList;

    property FileName: string read GetFileName write SetFileName;
    property InterfaceUses: TStringList read GetInterfaceUses;
    property InterfaceConst: TStringList read GetInterfaceConst;
    property InterfaceTypes: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>> read GetInterfaceType;
    property InterfaceCode: TStringList read GetInterfaceCode;
    property ImplementationUses: TStringList read GetImplementationUses;
    property ImplementationConst: TStringList read GetImplementationConst;
    property ImplementationTypes: TObjectDictionary<string, TObjectList<TTypeDefinitionEntry>> read GetImplementationType;
    property ImplementationCode: TStringList read GetImplementationCode;
    property InitializationSection: TStringList read GetInitializationSection;
    property FinalizationSection: TStringList read GetFinalizationSection;
  end;

implementation


{ TTypeDefinitionEntry }

constructor TTypeDefinitionEntry.Create(const Visibility: TVisibility; const TextType: TTextType; const Text: string; const AddBlankLine: TAddBlankLine = blNone);
begin
  FAttributes := TStringList.Create;
  FComment := TSTringList.Create;
  FVisibility := Visibility;
  FTextType := TextType;
  FText := Text;
  FAddBlankLine := AddBlankLine;
end;

destructor TTypeDefinitionEntry.Destroy;
begin
  FAttributes.Free;
  FComment.Free;
end;

end.
