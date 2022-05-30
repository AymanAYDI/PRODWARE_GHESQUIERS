table 50021 "PWD CIEL Data"
{
    // -----------------------------------------------------------------------------------------------------------------
    // Prodware - www.prodware.fr
    // -----------------------------------------------------------------------------------------------------------------
    //
    // //>>NDBI (P25940_002)
    // LALE.RO : 03/09/2018 : cf NDBI ID 437
    //                        new Table

    Caption = 'CIEL Data';
    LookupPageID = "PWD CIEL Data";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Filter"; Text[100])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(2; "Personnal Caption"; Text[50])
        {
            Caption = 'Personnal Caption';
            DataClassification = CustomerContent;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(5; "Right Type"; Option)
        {
            Caption = 'Right Type';
            OptionCaption = 'Value acquittees,Value suspended';
            OptionMembers = "Value acquittees","Value suspended";
            DataClassification = CustomerContent;
        }
        field(6; "Fiscal Caption"; Text[150])
        {
            Caption = 'Fiscal Caption';
            DataClassification = CustomerContent;
        }
        field(7; "Rate Of Alcohol By Volume"; Decimal)
        {
            Caption = 'Rate Of Alcohol By Volume';
            DataClassification = CustomerContent;
        }
        field(8; Observation; Text[250])
        {
            Caption = 'Observation';
            DataClassification = CustomerContent;
        }
        field(9; "Begin Period Stock"; Decimal)
        {
            Caption = 'Begin Period Stock';
            DataClassification = CustomerContent;
        }
        field(10; Purchase; Decimal)
        {
            Caption = 'Purchase';
            DataClassification = CustomerContent;
        }
        field(11; Sales; Decimal)
        {
            Caption = 'Sales';
            DataClassification = CustomerContent;
        }
        field(12; "Suspension Replacement"; Decimal)
        {
            Caption = 'Suspension Replacement';
            DataClassification = CustomerContent;
        }
        field(13; "End Period Stock"; Decimal)
        {
            Caption = 'End Period Stock';
            DataClassification = CustomerContent;
        }
        field(14; "Item Volume"; Decimal)
        {
            Caption = 'Item Volume';
            DataClassification = CustomerContent;
        }
        field(15; "Item Suspended Rights"; Decimal)
        {
            Caption = 'Item Suspended Rights';
            DataClassification = CustomerContent;
        }
        field(16; "Input Work With Way"; Decimal)
        {
            Caption = 'Input Work With Way';
            DataClassification = CustomerContent;
        }
        field(17; "Output With Current Year Paym"; Decimal)
        {
            Caption = 'Output With Current Year Paym';
            DataClassification = CustomerContent;
        }
        field(18; "Definitive Output"; Decimal)
        {
            Caption = 'Definitive Output';
            DataClassification = CustomerContent;
        }
        field(19; "Exemption Rights"; Decimal)
        {
            Caption = 'Exemption Rights';
            DataClassification = CustomerContent;
        }
        field(20; "Output Work With Way"; Decimal)
        {
            Caption = 'Output Work With Way';
            DataClassification = CustomerContent;
        }
        field(21; "Other Item Production"; Decimal)
        {
            Caption = 'Other Item Production';
            DataClassification = CustomerContent;
        }
        field(22; "Distil Wine Lees"; Decimal)
        {
            Caption = 'Distil Wine Lees';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Location Filter", "Personnal Caption")
        {
            Clustered = true;
        }
    }
}
