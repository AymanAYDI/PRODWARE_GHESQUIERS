tableextension 60051 "PWD SalesLineArchive" extends "Sales Line Archive"
{
    fields
    {
        field(55041; "PWD Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            Description = 'SOBI';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
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
