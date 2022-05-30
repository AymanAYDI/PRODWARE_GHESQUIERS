table 50012 "PWD Ligne saisie prestation"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'N°';
            DataClassification = CustomerContent;
        }
        field(20; "No. ligne"; Integer)
        {
            Caption = 'N° ligne';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", "No. ligne")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
