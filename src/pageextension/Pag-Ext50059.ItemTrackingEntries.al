pageextension 50059 "PWD ItemTrackingEntries" extends "Item Tracking Entries"
{
    layout
    {
        addbefore(Positive)
        {
            field("PWD Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Item No.")
        {
            field("PWD Origin"; Rec."PWD Origin")
            {
                ApplicationArea = All;
            }
        }
    }
}
