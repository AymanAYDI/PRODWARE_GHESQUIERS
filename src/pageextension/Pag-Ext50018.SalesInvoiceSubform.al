pageextension 50018 "PWD SalesInvoiceSubform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("PWD No. DOC saisie presta"; Rec."PWD No. DOC saisie presta")
            {
                ApplicationArea = all;
            }
        }
        addafter(Nonstock)
        {
            field("PWD VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit of Measure")
        {
            field("PWD Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("PWD Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field("PWD Specific Cost"; Rec."PWD Specific Cost")
            {
                ApplicationArea = all;
            }
        }
    }
    PROCEDURE UnitPriceOnFormat();
    VAR
        ParamsVente: Record "Sales & Receivables Setup";
        CoefPrixUnitaire: Decimal;
    BEGIN
        ParamsVente.GET();
        CoefPrixUnitaire := ParamsVente."PWD Coef Controle prix unitaire";
    END;
}
