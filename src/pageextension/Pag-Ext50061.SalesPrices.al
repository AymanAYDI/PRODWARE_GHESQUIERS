pageextension 50061 "PWD SalesPrices" extends "Sales Prices"
{
    layout
    {
        addafter("Item No.")
        {
            field("PWD Description"; Rec."PWD Description")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit Price")
        {
            field("PWD Purch. Cost"; Rec."PWD Purch. Cost")
            {
                ApplicationArea = all;
            }
            field("PWD Percentage Profit"; Rec."PWD Percentage Profit")
            {
                ApplicationArea = all;
            }
        }
    }
}
