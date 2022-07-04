pageextension 50021 "PWD PurchaseCreditMemo" extends "Purchase Credit Memo"
{
    layout
    {
        addafter(Status)
        {
            field("PWD Buy-from Contact"; Rec."Buy-from Contact")
            {
                ApplicationArea = all;
                Caption = 'Buy-from Contact';
            }
        }
        modify("Buy-from Contact")
        {
            Visible = false;
        }
    }
}
