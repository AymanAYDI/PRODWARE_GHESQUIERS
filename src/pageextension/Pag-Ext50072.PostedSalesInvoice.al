pageextension 50072 "PWD PostedSalesInvoice" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Order No.")
        {
            field("PWD Sell-to Contact No."; Rec."Sell-to Contact No.")
            {
                Visible = false;
                editable = false;
                ApplicationArea = All;
            }
            field("PWD Call No."; Rec."PWD Call No.")
            {
                ApplicationArea = All;
            }
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = All;
            }
            field("PWD Seafrance Order No."; Rec."PWD Seafrance Order No.")
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
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Name")
        {
            field("PWD Bill-to Name 2"; Rec."Bill-to Name 2")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            group("PWD &Print")
            {
                Caption = 'Print';
                action("PWD Impression classique")
                {
                    ApplicationArea = all;
                    caption = 'Impression classique';
                    Trigger OnAction()
                    BEGIN
                        SalesInvHeader.SETRANGE("No.", Rec."No.");
                        REPORT.RUN(50118, TRUE, TRUE, SalesInvHeader);
                    END;
                }
                action("PWD Imprimer Prestation M2")
                {
                    ApplicationArea = all;
                    caption = 'Imprimer Prestation M2';
                    trigger OnAction()
                    BEGIN
                        SalesInvHeader := Rec;
                        SalesInvHeader.SETRECFILTER();
                        REPORT.RUN(50109, TRUE, FALSE, SalesInvHeader);
                    END;
                }
            }
        }
    }
    var
        SalesInvHeader: Record "Sales Invoice Header";
}