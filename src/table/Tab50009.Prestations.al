table 50009 "PWD Prestations"
{
    DrillDownPageID = "PWD Liste préstations";
    LookupPageID = "PWD Liste préstations";
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(20; Designation; Text[50])
        {
            Caption = 'Designation';
            DataClassification = CustomerContent;
        }
        field(30; "Type de prestation"; Enum "PWD Prestations Type")
        {
            Caption = 'Type de prestation';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
}
