table 50003 "PWD Russian translate"
{
    Caption = 'Russian Translate';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; T1; Text[100])
        {
            Caption = 'T1';
            DataClassification = CustomerContent;
        }
        field(4; T2; Text[100])
        {
            Caption = 'T2';
            DataClassification = CustomerContent;
        }
        field(5; Family; Text[100])
        {
            Caption = 'Family';
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

    fieldgroups
    {
    }
}

