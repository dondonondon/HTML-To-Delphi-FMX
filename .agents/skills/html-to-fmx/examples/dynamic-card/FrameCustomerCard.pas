unit FrameCustomerCard;

interface

uses
  System.Classes,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.StdCtrls;

type
  TCustomerCardData = record
    CustomerID: string;
    DisplayName: string;
    Detail: string;
  end;

  TFrameCustomerCard = class(TFrame)
    BackgroundPanel: TPanel;
    CustomerNameLabel: TLabel;
    CustomerDetailLabel: TLabel;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetData(const AData: TCustomerCardData);
  end;

implementation

{$R *.fmx}

procedure MakeInputTransparent(const AObject: TFmxObject);
var
  I: Integer;
  Control: TControl;
begin
  if AObject is TControl then
  begin
    Control := TControl(AObject);
    Control.HitTest := False;
    Control.TabStop := False;
    Control.CanFocus := False;
  end;

  for I := 0 to AObject.ChildrenCount - 1 do
    MakeInputTransparent(AObject.Children[I]);
end;

constructor TFrameCustomerCard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Controls already exist in the .fmx. Only configure input behavior here.
  MakeInputTransparent(Self);
end;

procedure TFrameCustomerCard.SetData(const AData: TCustomerCardData);
begin
  CustomerNameLabel.Text := AData.DisplayName;
  CustomerDetailLabel.Text := AData.Detail;
end;

end.
