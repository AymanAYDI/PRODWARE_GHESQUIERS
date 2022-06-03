pageextension 50052 "PWD SalesQuoteArchiveSubform" extends "Sales Quote Archive Subform"
{
    layout
    {
        addbefore("Item Reference No.")
        {
            field("PWD Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("PWD Vendor No."; Rec."PWD Vendor No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
