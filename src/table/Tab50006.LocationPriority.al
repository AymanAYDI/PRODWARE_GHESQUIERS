table 50006 "PWD Location Priority"
{
    Caption = 'Location Priority';
    Description = 'Navita360';
    LookupPageID = "PWD Priority Location";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "PWD Call Type Code"; Code[20])
        {
            Caption = 'Call Type Code';
            NotBlank = true;
            TableRelation = "PWD Call Type".Code;
            DataClassification = CustomerContent;
        }
        field(2; "PWD Location priority"; Integer)
        {
            Caption = 'Location priority';
            DataClassification = CustomerContent;
        }
        field(3; "PWD Location code"; Code[20])
        {
            Caption = 'Location code';
            NotBlank = true;
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "PWD Call Type Code", "PWD Location code")
        {
            Clustered = true;
        }
        key(Key2; "PWD Call Type Code", "PWD Location priority")
        {
        }
    }

    fieldgroups
    {
    }
}

