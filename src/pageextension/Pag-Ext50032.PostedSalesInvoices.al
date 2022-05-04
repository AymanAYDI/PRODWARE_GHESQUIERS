pageextension 50032 "PWD PostedSalesInvoices" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = all;
            }
            field("PWD Seafrance Order No."; Rec."PWD Seafrance Order No.")
            {
                ApplicationArea = all;
            }
            field("PWD Sell-to Contact"; Rec."Sell-to Contact")
            {
                ApplicationArea = all;
            }
        }
        addafter("No. Printed")
        {
            field("PWD SeafranceOrderNo."; Rec."PWD Seafrance Order No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Shipment Date")
        {
            field("PWD Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("&Invoice")
        {
            group("PWD Print")
            {
                caption = 'Print';
                Action("Action20")
                {
                    ApplicationArea = all;
                    Ellipsis = true;
                    Caption = 'Print';
                    Promoted = True;
                    Image = Print;
                    PromotedCategory = Process;
                    Trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                        SalesInvHeader.PrintRecords(TRUE);
                    END;
                }
                Action("Action1000000001")
                {
                    ApplicationArea = all;
                    Caption = 'Impression classique';
                    Trigger OnAction()
                    VAR
                        RecLSalesInvoiceHeader: Record "Sales Invoice Header";
                    BEGIN
                        SalesInvHeader.SETRANGE("No.", Rec."No.");
                        REPORT.RUN(50118, TRUE, TRUE, SalesInvHeader);
                    END;
                }
            }
        }
        addafter(Print)
        {
            action("PWD Classic Print")
            {
                ApplicationArea = all;
                Caption = 'Impression classique';
                Trigger OnAction()
                VAR
                    RecLSalesInvoiceHeader: Record "Sales Invoice Header";
                BEGIN
                    SalesInvHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50118, TRUE, TRUE, SalesInvHeader);
                END;
            }
        }
    }
    var
        SalesInvHeader: Record "Sales Invoice Header";
}
