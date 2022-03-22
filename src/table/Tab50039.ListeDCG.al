table 50039 "PWD Liste DCG"
{
    DataClassification = CustomerContent;

    fields
    {
        field(20; "Code regime"; Code[20])
        {
            Caption = 'Code régime';
            DataClassification = CustomerContent;
        }
        field(30; "Periode DCG"; Code[10])
        {
            Caption = 'Période DCG';
            DataClassification = CustomerContent;
        }
        field(40; "No. DCG"; Code[20])
        {
            Caption = 'N° DCG';
            DataClassification = CustomerContent;
        }
        field(50; "Code magasin"; Code[10])
        {
            Caption = 'Code magasin';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code regime", "Periode DCG")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

