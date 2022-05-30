table 50019 "PWD Fiscal Caption"
{
    // -----------------------------------------------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------------------------------------------------------------------------
    //
    // //>>NDBI (P25940_002)
    // LALE.RO : 03/09/2018 : cf NDBI ID 437
    //                        new Table

    Caption = 'Fiscal Caption';
    LookupPageID = "PWD Fiscal Caption";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Name; Text[150])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
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
