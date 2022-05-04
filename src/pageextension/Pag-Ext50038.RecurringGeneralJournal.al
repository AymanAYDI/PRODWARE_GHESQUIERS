pageextension 50038 "PWD RecurringGeneralJournal" extends "Recurring General Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field("PWD External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("PWD VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
            }
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
        modify("VAT Difference")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = true;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("PWD Due Date"; Rec."Due Date")
            {
                ApplicationArea = All;
            }

        }
    }
}
