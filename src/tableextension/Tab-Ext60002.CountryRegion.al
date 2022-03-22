tableextension 60002 "PWD CountryRegion" extends "Country/Region"
{
    fields
    {
        field(50000; "PWD Monthly Code"; Code[10])
        {
            Caption = 'Monthly Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Continental Code"; Code[10])
        {
            Caption = 'Continental Code';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(9), "Field ID" = CONST(50001));
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Flag"; Code[20])
        {
            Caption = 'Flag';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}