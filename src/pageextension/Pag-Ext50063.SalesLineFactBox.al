pageextension 50063 "PWD SalesLineFactBox" extends "Sales Line FactBox"
{
    layout
    {
        addafter(SalesLineDiscounts)
        {
            field("PWD Purchase Prices"; STRSUBSTNO('%1', PWDFunctionMgt.CalcNoOfPurchasePrices(Rec)))
            {
                Caption = 'Purchase Prices';
                ApplicationArea = All;
            }

        }
    }
    VAR
        PWDFunctionMgt: Codeunit "PWD Function Mgt";
}
