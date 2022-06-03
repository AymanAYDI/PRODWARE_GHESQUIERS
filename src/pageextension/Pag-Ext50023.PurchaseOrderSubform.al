pageextension 50023 "PWD PurchaseOrderSubform" extends "Purchase Order Subform"
{
    layout
    {
        addbefore(Type)
        {
            field("PWD Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("PWD Description 2"; Rec."Description 2")
            {
                ApplicationArea = all;
            }
            field("PWD Designation FR"; Rec."PWD Designation FR")
            {
                ApplicationArea = all;
            }
            field("PWD Cetificate Transit No."; Rec."PWD Cetificate Transit No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Reserved Quantity")
        {
            Visible = FALSE;
        }
        addafter("Reserved Quantity")
        {
            field("PWD Parcel Nb."; Rec."PWD Parcel Nb.")
            {
                ApplicationArea = all;
            }
            field("PWD Units per Parcel"; Rec."Units per Parcel")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit of Measure")
        {
            field("PWD Special Order Sales No."; Rec."Special Order Sales No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Line Amount")
        {
            field("PWD Appeal for tenders"; Rec."PWD Appeal for tenders")
            {
                ApplicationArea = all;
            }
        }
        addafter("Inv. Discount Amount")
        {
            field("PWD Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = all;
            }
            field("PWD Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("PWD VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = all;
            }
            field("PWD VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("PWD Origin"; Rec."PWD Origin")
            {
                ApplicationArea = all;
            }
            field("PWD Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("PWD Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = all;
            }
        }
        addafter("Promised Receipt Date")
        {
            field("PWD Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                ApplicationArea = all;
            }
            field("PWD Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("ShortcutDimCode8")
        {
            field("PWD Sales Type Doc Appeal tenders"; Rec."PWD SalesTypeDocAppealTend.")
            {
                ApplicationArea = all;
            }
            field("PWD Sales No. Appeal Tenders"; Rec."PWD Sales No. Appeal Tenders")
            {
                ApplicationArea = all;
            }
            field("PWD AppealForTenders"; Rec."PWD Appeal for tenders")
            {
                ApplicationArea = All;
            }
            field("PWD Family"; Rec."PWD Family")
            {
                ApplicationArea = All;
            }
            field("PWD Special Order Sales Line No."; Rec."Special Order Sales Line No.")
            {
                ApplicationArea = all;
            }
            field("PWD CetificateTransitNo"; Rec."PWD Cetificate Transit No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
