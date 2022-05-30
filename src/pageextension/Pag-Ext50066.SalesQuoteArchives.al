pageextension 50066 "PWD SalesQuoteArchives" extends "Sales Quote Archives"
{
    layout
    {
        addbefore("Version No.")
        {
            field("PWD No."; Rec."No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
