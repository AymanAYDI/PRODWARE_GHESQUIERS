pageextension 50035 "PWD PurchaseJournal" extends "Purchase Journal"
{
    layout
    {
        modify("External Document No.")
        {
            visible = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Amount")
        {
            Visible = true;
        }
        addafter("Amount")
        {
            field("PWD VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = all;
            }
        }
        modify("VAT Difference")
        {
            Visible = true;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
    }
}