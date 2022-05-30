table 50020 "PWD Personal Caption"
{
    // -----------------------------------------------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------------------------------------------------------------------------
    //
    // //>>NDBI (P25940_002)
    // LALE.RO : 03/09/2018 : cf NDBI ID 437
    //                        new Table

    Caption = 'Personnal Caption';
    LookupPageID = "PWD Personal Caption";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Fiscal Caption"; Text[150])
        {
            Caption = 'Fiscal Caption';
            TableRelation = "PWD Fiscal Caption";
            DataClassification = CustomerContent;
        }
        field(4; "Rate Of Alcohol By Volume"; Decimal)
        {
            Caption = 'Rate Of Alcohol By Volume';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }
}
