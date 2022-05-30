pageextension 50055 "PWD CatalogItemList" extends "Catalog Item List"
{
    layout
    {
        addafter(Description)
        {
            field("PWD Description 2"; Rec."PWD Description 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bar Code")
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
