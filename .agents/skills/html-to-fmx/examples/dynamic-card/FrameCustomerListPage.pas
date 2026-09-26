unit FrameCustomerListPage;

interface

uses
  System.Classes,
  System.SysUtils,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Layouts,
  FMX.StdCtrls,
  FMX.ListBox,
  FrameCustomerCard;

type
  TCustomerSelectedEvent = procedure(Sender: TObject;
    const ACustomerID: string) of object;

  TFrameCustomerListPage = class(TFrame)
    HeaderLayout: TLayout;
    TitleLabel: TLabel;
    ReloadButton: TCornerButton;
    CustomersListBox: TListBox;
    StatusLabel: TLabel;
    procedure CustomersListBoxItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure ReloadButtonClick(Sender: TObject);
  private
    FOnCustomerSelected: TCustomerSelectedEvent;
    FOnReloadRequested: TNotifyEvent;
    procedure AddCustomer(const AData: TCustomerCardData);
  public
    procedure SetCustomers(const ACustomers: TArray<TCustomerCardData>);
    property OnCustomerSelected: TCustomerSelectedEvent
      read FOnCustomerSelected write FOnCustomerSelected;
    property OnReloadRequested: TNotifyEvent
      read FOnReloadRequested write FOnReloadRequested;
  end;

implementation

{$R *.fmx}

type
  // Runtime-only item: no component registration or designer installation required.
  TCustomerListBoxItem = class(TListBoxItem)
  private
    FCustomerID: string;
  public
    property CustomerID: string read FCustomerID write FCustomerID;
  end;

procedure TFrameCustomerListPage.AddCustomer(const AData: TCustomerCardData);
const
  CardGap = 8; // Example spacing; choose the actual source/project spacing.
var
  Item: TCustomerListBoxItem;
  Widget: TFrameCustomerCard;
begin
  Item := TCustomerListBoxItem.Create(CustomersListBox);
  try
    Item.Text := '';
    Item.Selectable := False;
    Item.CustomerID := AData.CustomerID;

    // This creates a frame instance; its static children are loaded from its .fmx.
    Widget := TFrameCustomerCard.Create(Item);
    Widget.Name := '';
    Widget.SetData(AData);
    // Reserve a row band for spacing and keep the painted frame above it.
    Item.Height := Widget.Height + CardGap;
    Widget.Margins.Bottom := CardGap;
    Widget.Parent := Item;
    Widget.Align := TAlignLayout.Client;

    // Commit to the visible list only after construction/binding has succeeded.
    Item.Parent := CustomersListBox;
  except
    // Item owns Widget, so freeing Item also frees any partially created widget.
    Item.Free;
    raise;
  end;
end;

procedure TFrameCustomerListPage.SetCustomers(
  const ACustomers: TArray<TCustomerCardData>);
var
  Customer: TCustomerCardData;
begin
  // Call on the UI thread. The host owns data fetching and any cancellation policy.
  CustomersListBox.BeginUpdate;
  try
    try
      CustomersListBox.Clear;
      StatusLabel.Text := 'Loading customers...';
      for Customer in ACustomers do
        AddCustomer(Customer);
      StatusLabel.Text := Format('%d customer(s)', [Length(ACustomers)]);
    except
      CustomersListBox.Clear;
      StatusLabel.Text := 'Could not display customers.';
      raise;
    end;
  finally
    CustomersListBox.EndUpdate;
  end;
end;

procedure TFrameCustomerListPage.CustomersListBoxItemClick(
  const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  if (Item is TCustomerListBoxItem) and Assigned(FOnCustomerSelected) then
    FOnCustomerSelected(Self, TCustomerListBoxItem(Item).CustomerID);
end;

procedure TFrameCustomerListPage.ReloadButtonClick(Sender: TObject);
begin
  if Assigned(FOnReloadRequested) then
    FOnReloadRequested(Self);
end;

end.
