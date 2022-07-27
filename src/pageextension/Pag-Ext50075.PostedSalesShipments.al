pageextension 50075 "PWD PostedSalesShipments" extends "Posted Sales Shipments"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        addafter("No.")
        {
            field("PWD DSA No."; Rec."PWD DSA No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Sell-to Customer No.")
        {
            Editable = false;
        }
        modify("Sell-to Customer Name")
        {
            Editable = false;
        }
        addafter("Sell-to Customer Name")
        {
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Sell-to Post Code")
        {
            Editable = false;
        }
        addafter("Sell-to Post Code")
        {
            field("PWD Sell-to County"; Rec."Sell-to County")
            {
                ApplicationArea = All;
            }
        }
        modify("Sell-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Sell-to Contact")
        {
            Editable = false;
        }
        modify("Bill-to Customer No.")
        {
            Editable = false;
        }
        modify("Bill-to Name")
        {
            Editable = false;
        }
        modify("Bill-to Post Code")
        {
            Editable = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Bill-to Contact")
        {
            Editable = false;
        }
        modify("Ship-to Code")
        {
            Editable = false;
        }
        modify("Ship-to Name")
        {
            Editable = false;
        }
        modify("Ship-to Post Code")
        {
            Editable = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Editable = false;
        }
        modify("Ship-to Contact")
        {
            Editable = false;
        }
        modify("Posting Date")
        {
            Editable = false;
        }
        modify("Salesperson Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = false;
        }
        modify("Currency Code")
        {
            Editable = false;
        }
        addafter("No. Printed")
        {
            field("PWD Seafrance Order No."; Rec."PWD Seafrance Order No.")
            {
                ApplicationArea = All;
                AutoFormatType = 0;
            }
            field("PWD Generate Export File"; Rec."PWD Generate Export File")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Date")
        {
            field("PWD Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Shipment")
        {
            group("PWD Imprimer")
            {
                Caption = 'Imprimer';
                Action("Bon de livraison")
                {
                    ApplicationArea = all;
                    Caption = 'Bon de livraison';
                    Image = Print;
                    trigger OnAction()
                    BEGIN
                        SalesShptHeader := Rec;
                        SalesShptHeader.SETRECFILTER();
                        //REPORT.RUN(50102, FALSE, FALSE, SalesShptHeader);
                        REPORT.RUN(Report::"Sales - Shipment BL bac blanc", FALSE, FALSE, SalesShptHeader);
                    END;
                }
                Action("PWD Bon d'Avitaillement")
                {
                    Caption = 'Bon d''Avitaillement';
                    ApplicationArea = All;
                    Image = Print;
                    trigger OnAction()
                    BEGIN
                        SalesShptHeader := Rec;
                        SalesShptHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Sales - Shipmt BLAVI bac blanc", FALSE, FALSE, SalesShptHeader);
                    END;
                }
                Action("PWD DAA")
                {
                    Caption = 'DAA';
                    Image = Print;
                    ApplicationArea = All;
                    trigger OnAction()
                    BEGIN
                        SalesShptHeader := Rec;
                        SalesShptHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Sales - Shipment AVITA - DAA", TRUE, FALSE, SalesShptHeader);
                    END;
                }
                Action("PWD T5")
                {
                    Caption = 'T5';
                    Image = Print;
                    ApplicationArea = All;
                    trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        CLEAR(PWDFunctionMgt);
                        PWDFunctionMgt.PrintT5(Rec);
                    END;
                }
                Action("PWD T1")
                {
                    Caption = 'T1';
                    Image = Print;
                    ApplicationArea = All;
                    trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        CLEAR(PWDFunctionMgt);
                        PWDFunctionMgt.PrintT1(Rec);
                    END;
                }
                Action("PWD TM")
                {
                    Caption = 'TM';
                    Image = Print;
                    ApplicationArea = All;
                    trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                        CLEAR(PWDFunctionMgt);
                        PWDFunctionMgt.PrintTM(Rec);
                    END;
                }
            }
        }
    }
    var
        SalesShptHeader: Record "Sales Shipment Header";
        PWDFunctionMgt: Codeunit "PWD Function Mgt";
}