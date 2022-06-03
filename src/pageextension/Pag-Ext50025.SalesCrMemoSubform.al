pageextension 50025 "PWD SalesCrMemoSubform" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addbefore("Item Reference No.")
        {
            field("PWD Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
        }
        addafter(Nonstock)
        {
            field("PWD VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
    PROCEDURE UnitPriceOnFormat()
    BEGIN
        ParamsVente.GET();
        CoefPrixUnitaire := ParamsVente."PWD Coef Ctrl Prix Unit";
    END;

    var
        ParamsVente: Record "Sales & Receivables Setup";
        CoefPrixUnitaire: Decimal;
}
