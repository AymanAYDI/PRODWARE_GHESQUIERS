pageextension 50058 "PWD ItemTrackingSummary" extends "Item Tracking Summary"
{
    layout
    {
        addbefore("Lot No.")
        {
            field("PWD Origin Area"; Rec."PWD Origin Area")
            {
                ApplicationArea = All;
            }
            field("PWD Source Subtype"; Rec."Source Subtype")
            {
                ApplicationArea = All;
            }
            field("PWD Entry No."; Rec."Entry No.")
            {
                ApplicationArea = All;
            }
            field("PWD Table ID"; Rec."Table ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Total Reserved Quantity")
        {
            field("PWD Certificat Transit No."; Rec."PWD Certificat Transit No.")
            {
                ApplicationArea = all;
            }
            field("PWD Stocking Advice No."; Rec."PWD Stocking Advice No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
