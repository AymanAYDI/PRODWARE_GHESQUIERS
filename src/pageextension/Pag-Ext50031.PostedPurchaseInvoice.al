pageextension 50031 "PWD PostedPurchaseInvoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addafter("Shipping and Payment")
        {
            Group("Vendor Quality")
            {
                Caption = 'Vendor Quality';
                field("PWD Delivery Time Rating"; Rec."PWD Delivery Time Rating")
                {
                    ApplicationArea = all;
                }
                field("PWD Delivered Quantity Rating"; Rec."PWD Delivered Quantity Rating")
                {
                    ApplicationArea = All;
                }
                field("PWD Technical Rating"; Rec."PWD Technical Rating")
                {
                    ApplicationArea = All;
                }
                field("PWD Documentation Rating"; Rec."PWD Documentation Rating")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
