pageextension 50054 "PWD CatalogItemCard" extends "Catalog Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("PWD Description 2"; Rec."PWD Description 2")

            {
                ApplicationArea = all;
            }
        }
        addafter("Last Date Modified")
        {
            field("PWD Tariff No."; Rec."PWD Tariff No.")
            {
                ApplicationArea = All;
            }
            field("PWD Shelf No."; Rec."PWD Shelf No.")
            {
                ApplicationArea = All;
            }
            field("PWD Family"; Rec."PWD Family")
            {
                ApplicationArea = All;
            }
            field("PWD National Add. Code"; Rec."PWD National Add. Code")
            {
                ApplicationArea = All;
            }
            field("PWD IMPA Code"; Rec."PWD IMPA Code")
            {
                ApplicationArea = All;
            }

        }
    }
}
