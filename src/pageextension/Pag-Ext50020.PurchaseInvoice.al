pageextension 50020 "PWD PurchaseInvoice" extends "Purchase Invoice"
{
    layout
    {
        addafter(Status)
        {
            field("PWD Buy-from Contact"; Rec."Buy-from Contact")
            {
                ApplicationArea = all;
            }
        }
    }
}
