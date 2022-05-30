table 50004 "PWD RateRestitutionCalculation"
{
    Caption = 'Rate for Restitution Calculation';
    LookupPageID = "PWD RateCalculationRestitution";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Restitution Code"; Code[20])
        {
            Caption = 'Restitution Code';
            TableRelation = "PWD Item Restitution";
            DataClassification = CustomerContent;
        }
        field(2; "Valid Until"; Date)
        {
            Caption = 'Valid Until';
            DataClassification = CustomerContent;
        }
        field(3; "Rate (%)"; Decimal)
        {
            Caption = 'Rate (%)';
            DataClassification = CustomerContent;
        }
        field(4; "Unit Code"; Code[10])
        {
            Caption = 'Unit Code';
            TableRelation = "Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(5; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Restitution Code", "Valid Until")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
