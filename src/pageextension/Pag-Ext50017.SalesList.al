pageextension 50017 "PWD SalesList" extends "Sales List"
{
    layout
    {
        addafter("No.")
        {
            field("PWD Call No."; Rec."PWD Call No.")
            {
                ApplicationArea = all;
            }
            field("PWD Call Type"; Rec."PWD Call Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Posting Date")
        {
            field("PWD Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = all;
            }
            field("PWD Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = all;
            }
            field("PWD Delivery time"; Rec."PWD Delivery time")
            {
                ApplicationArea = all;
            }
            field("PWD Livraison OK"; Rec."PWD Livraison OK")
            {
                ApplicationArea = all;
            }
        }
        addafter("Salesperson Code")
        {
            field("PWD User Id"; Rec."PWD User Id")
            {
                ApplicationArea = all;
            }
        }
    }
}
