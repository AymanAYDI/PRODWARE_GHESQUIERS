table 50035 "PWD National Add. Code"
{
    Caption = 'Description';
    DrillDownPageID = "PWD Codes Add. National";
    LookupPageID = "PWD Codes Add. National";
    DataClassification = CustomerContent;

    fields
    {
        field(50000; "National Add. Code"; Code[19])
        {
            Caption = 'National Add. Code';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(50001; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "National Add. Code")
        {
            Clustered = true;
        }
    }
}
