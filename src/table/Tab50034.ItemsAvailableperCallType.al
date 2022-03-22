table 50034 "Items Available per Call Type"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Call Type"; Code[20])
        {
            Caption = 'Call Type';
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF Item.GET("Item No.") THEN
                    "Item Description" := Item.Description;
            end;
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF Location.GET("Location Code") THEN
                    "Location Name" := Location.Name;
            end;
        }
        field(4; "Item Description"; Text[30])
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(5; "Available Inventory"; Decimal)
        {
            Caption = 'Available Inventory';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateProjectedBalance();
            end;
        }
        field(6; "Location Name"; Text[30])
        {
            Caption = 'Location Name';
            DataClassification = CustomerContent;
        }
        field(9; "Qty. on Purch. Order"; Decimal)
        {
            Caption = 'Qty. on Purch. Order';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateProjectedBalance();
            end;
        }
        field(10; "Qty. on Sales Order"; Decimal)
        {
            Caption = 'Qty. on Sales Order';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateProjectedBalance();
            end;
        }
        field(11; "Avail. Calc. Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(12; "Projected Balance"; Decimal)
        {
            Caption = 'Projected Balance';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Call Type", "Location Code", "Item No.")
        {
            Clustered = true;
        }
        key(Key2; "Call Type", "Item No.")
        {
            SumIndexFields = "Available Inventory", "Qty. on Purch. Order", "Qty. on Sales Order";
        }
    }

    var
        Item: Record Item;
        Location: Record Location;


    procedure UpdateProjectedBalance()
    begin
        "Projected Balance" := "Available Inventory" + "Qty. on Purch. Order" - "Qty. on Sales Order";
    end;
}

