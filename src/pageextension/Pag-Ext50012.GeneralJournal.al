pageextension 50012 "PWD GeneralJournal" extends "General Journal"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = TRUE;
        }

        modify("VAT Bus. Posting Group")
        {
            Visible = TRUE;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = TRUE;
        }
        addafter(Amount)
        {
            field("PWD VAT Base Amount"; Rec."VAT Base Amount")
            {
                applicationarea = all;
            }
        }
        modify("VAT Amount")
        {
            Visible = TRUE;
        }
        modify("VAT Difference")
        {
            Visible = TRUE;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = TRUE;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = TRUE;
        }
    }
}
