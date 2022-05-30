pageextension 50015 "PWD SalesInvoice" extends "Sales Invoice"
{
    layout
    {
        addafter("Sell-to Contact No.")
        {
            field("PWD Call Type"; Rec."PWD Call Type")
            {
                ApplicationArea = all;
            }
            field("PWD Delivery time"; Rec."PWD Delivery time")
            {
                ApplicationArea = all;
            }
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = all;
            }
            field("PWD DSA No."; Rec."PWD DSA No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Document Date")
        {
            Enabled = false;
        }
        addafter("Bill-to Contact No.")
        {
            field("PWD Discount Profit %"; Rec."PWD Discount Profit %")
            {
                ApplicationArea = all;
            }
            field("PWD Bill-to Additional name"; Rec."PWD Bill-to Additional name")
            {
                ApplicationArea = all;
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
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter(PostAndSend)
        {
            action("PWD Impression Test Prestation M2")
            {
                ApplicationArea = all;
                Ellipsis = true;
                Caption = 'Impression Test Prestation M2';
                Image = PostBatch;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                BEGIN
                    SalesHeader := Rec;
                    SalesHeader.SETRECFILTER();
                    REPORT.RUN(50110, TRUE, FALSE, SalesHeader);
                END;
            }
        }
    }
}
