pageextension 50022 "PWD PurchaseList" extends "Purchase List"
{
    layout
    {
        addafter("Vendor Authorization No.")
        {
            field("PWD Reception OK"; Rec."PWD Reception OK")
            {
                ApplicationArea = all;
            }
            field("PWD Last Shipment Date"; Rec."PWD Last Shipment Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("Currency Code")
        {
            field("PWD Buy-from Contact"; Rec."Buy-from Contact")
            {
                ApplicationArea = all;
            }
        }
    }
}
