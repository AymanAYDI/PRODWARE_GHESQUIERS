pageextension 50074 "PWD PostedPurchaseRcptSubform" extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        modify(Type)
        {
            Editable = false;
        }
        modify("No.")
        {
            Enabled = false;
            Editable = false;
        }
        modify("Cross-Reference No.")
        {
            Editable = false;
        }
        modify("Variant Code")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Return Reason Code")
        {
            Editable = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        modify(Quantity)
        {
            Editable = false;
        }
        addafter(Quantity)
        {
            field("PWD Entry Point"; Rec."Entry Point")
            {
                ApplicationArea = All;
            }
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Unit of Measure")
        {
            Editable = false;
        }
        modify("Requested Receipt Date")
        {
            Editable = false;
        }
        modify("Promised Receipt Date")
        {
            Editable = false;
        }
        modify("Planned Receipt Date")
        {
            Editable = false;
        }
        modify("Expected Receipt Date")
        {
            Editable = false;
        }
        modify("Order Date")
        {
            Editable = false;
        }
        modify("Lead Time Calculation")
        {
            Editable = false;
        }
        modify("Job No.")
        {
            Editable = false;
        }
        modify("Prod. Order No.")
        {
            Editable = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Editable = false;
        }
        modify("Appl.-to Item Entry")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = false;
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("PWD Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Parcel Nb."; Rec."PWD Parcel Nb.")
            {
                ApplicationArea = All;
            }
            field("PWD Unit per Parcel"; Rec."PWD Unit per Parcel")
            {
                ApplicationArea = All;
            }
            field("PWD Cetificate Transit No."; Rec."PWD Cetificate Transit No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("PWD No. avis de placement"; Rec."PWD No. avis de placement")
            {
                ApplicationArea = All;
            }
        }
    }
}
