table 50037 "PWD Listes de chargement"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Sales Ship. No."; Code[20])
        {
            Caption = 'Sales Ship. No.';
            DataClassification = CustomerContent;
        }
        field(20; "Location Filter"; Text[30])
        {
            Caption = 'Location Filter';
            DataClassification = CustomerContent;
        }
        field(30; "Nb. Loading List"; Decimal)
        {
            Caption = 'Nb. Loading List';
            DataClassification = CustomerContent;
        }
        field(40; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
        }
        field(50; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
        }
        field(60; "Parcel Nb"; Decimal)
        {
            Caption = 'Parcel Nb';
            DataClassification = CustomerContent;
        }
        field(70; "Stat. Value"; Decimal)
        {
            Caption = 'Stat. Value';
            DataClassification = CustomerContent;
        }
        field(80; "Item Nb"; Decimal)
        {
            Caption = 'Item Nb';
            DataClassification = CustomerContent;
        }
        field(90; "No. DAS"; Code[20])
        {
            Caption = 'No. DAS';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sales Ship. No.", "Location Filter")
        {
            Clustered = true;
            SumIndexFields = "Nb. Loading List";
        }
    }

    fieldgroups
    {
    }
}

