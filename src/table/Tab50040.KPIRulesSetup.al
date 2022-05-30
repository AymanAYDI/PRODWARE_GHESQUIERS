table 50040 "PWD KPI Rules Setup"
{
    Caption = 'KPI Rules Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; ID; Code[10])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; KPI; BLOB)
        {
            Caption = 'Indicateur';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(3; Rule; Option)
        {
            Caption = 'Règle';
            OptionMembers = "=",">","<";
            DataClassification = CustomerContent;
        }
        field(4; Value; Decimal)
        {
            Caption = 'Valeur';
            DataClassification = CustomerContent;
        }
        field(5; Indicator; Code[10])
        {
            Caption = 'Indicateur';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Indicator, ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
