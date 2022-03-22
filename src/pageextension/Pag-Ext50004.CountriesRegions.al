pageextension 50004 "PWD CountriesRegions" extends "Countries/Regions"
{
    layout
    {
        addafter("EU Country/Region Code")
        {
            field("PWD Monthly Code"; Rec."PWD Monthly Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Intrastat Code")
        {
            field("PWD Continental Code"; Rec."PWD Continental Code")
            {
                ApplicationArea = All;
            }
            field("PWD Flag"; Rec."PWD Flag")
            {
                ApplicationArea = All;
            }
        }
    }
}
