table 50015 "PWD Purchase Order Seafrance"
{
    Caption = 'Purchase Order Seafrance';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Purchase Order Seafrance No."; Code[30])
        {
            Caption = 'Purchase Order Seafrance No.';
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(3; Quantity; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(4; "Seafrance Unit"; Code[10])
        {
            Caption = 'Seafrance Unit';
            DataClassification = CustomerContent;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(6; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(7; "Order Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Order Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Vendor No."; Code[20])
        {
            CalcFormula = Lookup(Item."Vendor No." WHERE("No." = FIELD("Item No.")));
            Caption = 'Vendor No.';
            FieldClass = FlowField;
        }
        field(9; "Base Unit of Measure"; Code[10])
        {
            CalcFormula = Lookup(Item."Base Unit of Measure" WHERE("No." = FIELD("Item No.")));
            Caption = 'Base Unit of Measure';
            FieldClass = FlowField;
        }
        field(10; "Encode Performance"; Code[10])
        {
            Caption = 'Encode Performance';
            TableRelation = "PWD Prestations";
            DataClassification = CustomerContent;
        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(12; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(13; "Controlled line"; Boolean)
        {
            Caption = 'Controlled line';
            DataClassification = CustomerContent;
        }
        field(14; "Seafrance Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Seafrance Quantity';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Posting Date", "Purchase Order Seafrance No.", "Order Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Controlled line")
        {
        }
    }

    fieldgroups
    {
    }
}

