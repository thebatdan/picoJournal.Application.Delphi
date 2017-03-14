unit ApplicationOptionsFactory;

interface

uses
  ApplicationOptions, vcl.Forms, SysUtils;

type
  TApplicationOptionsFactory = class
     class function GetApplicationOptions: TApplicationOptions;
  end;

implementation

{ TApplicationOptionsFactory }

class function TApplicationOptionsFactory.GetApplicationOptions: TApplicationOptions;
begin
  result := TApplicationOptions.Create(ChangeFileExt(Application.ExeName,'.ini'));
end;

end.
