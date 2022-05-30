tableextension 60050 "PWD SalesHeaderArchive" extends "Sales Header Archive"
{
    fields
    {
        field(50110; "PWD Bill-to C/O"; Boolean)
        {
            Caption = 'c/o';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50111; "PWD Bill-to Additional name"; Text[50])
        {
            Caption = 'Nom complémentaire';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(70060; "PWD Last Version"; Boolean)
        {
            Caption = 'Last Version';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}
