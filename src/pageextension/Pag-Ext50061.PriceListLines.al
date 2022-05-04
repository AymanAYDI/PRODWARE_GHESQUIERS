pageextension 50061 "PWD PriceListLines" extends "Price List Lines"
{
    layout
    {
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
