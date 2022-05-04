pageextension 50036 "PWD CashReceiptJournal" extends "Cash Receipt Journal"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
            Editable = true;
        }
        modify("Gen. Posting Type")
        {
            visible = true;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter("Debit Amount")
        {
            field("PWD VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
            }
        }
    }
}
