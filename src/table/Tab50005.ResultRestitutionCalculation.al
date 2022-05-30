table 50005 "Result Restitution Calculation"
{
    Caption = 'Result Restitution Calculation';
    LookupPageID = "Result Restitution Calculation";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(2; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
        }
        field(3; "Shipment No."; Code[10])
        {
            Caption = 'Shipment No.';
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[10])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(5; "Quantity (Base)"; Integer)
        {
            Caption = 'Quantity (Base)';
            DataClassification = CustomerContent;
        }
        field(6; "Unit (Base)"; Code[10])
        {
            Caption = 'Unit (Base)';
            DataClassification = CustomerContent;
        }
        field(7; "Restitution Quantity"; Decimal)
        {
            Caption = 'Restitution Quantity';
            DataClassification = CustomerContent;
        }
        field(8; "Restitution Unit"; Code[10])
        {
            Caption = 'Restitution Unit';
            DataClassification = CustomerContent;
        }
        field(9; "Rate (%)"; Decimal)
        {
            Caption = 'Rate (%)';
            DataClassification = CustomerContent;
        }
        field(10; "Restitution Amount"; Decimal)
        {
            Caption = 'Restitution Amount';
            DataClassification = CustomerContent;
        }
        field(11; "NDP 13"; Code[19])
        {
            Caption = 'NDP 13';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Line No.", "Shipment No.", "Item No.")
        {
            Clustered = true;
        }
        key(Key2; "Shipment Date")
        {
            Enabled = false;
        }
        key(Key3; "Shipment No.", "NDP 13")
        {
        }
    }

    fieldgroups
    {
    }
}
