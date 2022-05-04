pageextension 50047 "PWD BlanketSalesOrder" extends "Blanket Sales Order"
{
    layout
    {
        addafter("No.")
        {
            field("PWD Call No."; Rec."PWD Call No.")
            {
                ApplicationArea = all;
            }
            field("PWD pwd Call Type"; Rec."pwd Call Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Document Date")
        {
            field("PWD Delivery time"; Rec."PWD Delivery time")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Contact No.")
        {
            field("PWD Bill-to Additional name"; Rec."PWD Bill-to Additional name")
            {
                ApplicationArea = All;
            }
            field("PWD Bill-to C/O"; Rec."PWD Bill-to C/O")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bill-to Name")
        {
            field("PWD Bill-to Name 2"; Rec."Bill-to Name 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Discount Profit %"; Rec."PWD Discount Profit %")
            {
                ApplicationArea = All;
            }
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = All;
            }

        }
    }
}
