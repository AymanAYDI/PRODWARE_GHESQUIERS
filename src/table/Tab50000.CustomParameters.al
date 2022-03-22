table 50000 "PWD Custom Parameters"
{
    Caption = 'Custom Parameters';
    DrillDownPageID = "PWD Custom Parameters";
    LookupPageID = "PWD Custom Parameters";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = CustomerContent;
        }
        field(2; "Field ID"; Integer)
        {
            Caption = 'Field ID';
            DataClassification = CustomerContent;
        }
        field(3; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Table ID", "Field ID", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

