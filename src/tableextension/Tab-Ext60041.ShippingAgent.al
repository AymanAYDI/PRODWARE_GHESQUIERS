tableextension 60041 "PWD ShippingAgent" extends "Shipping Agent"
{
    fields
    {
        field(50000; "PWD Ville"; Text[30])
        {
            Caption = 'Ville';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Pays"; Text[30])
        {
            Caption = 'Pays';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}

