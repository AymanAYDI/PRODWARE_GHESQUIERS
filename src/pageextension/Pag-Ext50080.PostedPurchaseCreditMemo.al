pageextension 50080 "PWD PostedPurchaseCreditMemo" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Ship-to Contact")
        {
            field("PWD Documentation Rating"; Rec."PWD Documentation Rating")
            {
                ApplicationArea = All;
            }
            field("PWD Technical Rating"; Rec."PWD Technical Rating")
            {
                ApplicationArea = All;
            }
            field("PWD Delivered Quantity Rating"; Rec."PWD Delivered Quantity Rating")
            {
                ApplicationArea = All;
            }
            field("PWD Delivery Time Rating"; Rec."PWD Delivery Time Rating")
            {
                ApplicationArea = All;
            }
        }
    }
}
