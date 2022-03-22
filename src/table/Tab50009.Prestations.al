table 50009 "PWD Prestations"
{
    // 03.11.2004    C2A.LLE    Add Option Entree/Sortie in field  Type de préstation

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
        field(30; "Type de prestation"; Option)
        {
            Caption = 'Type de prestation';
            OptionMembers = "Entrée",Sortie,"Entrée/Sortie";
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

