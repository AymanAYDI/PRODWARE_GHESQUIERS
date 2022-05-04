pageextension 50033 "PWD PostedSalesCreditMemos" extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = All;
            }
            field("PWD Sell-to Contact"; Rec."Sell-to Contact")
            {
                ApplicationArea = all;
            }
        }
    }
}
