pageextension 50006 "PWD CustomerList" extends "Customer List"
{
    layout
    {
        modify("No.")
        {
            Editable = false;
        }
        modify(Name)
        {
            Editable = false;
        }
        addbefore("No.")
        {
            field("PWD Group In EMail"; Rec."PWD Group In EMail")
            {
                ApplicationArea = All;
                trigger OnValidate()
                VAR
                    RecLCustomer: Record Customer;
                BEGIN
                    COMMIT();
                    CurrPage.UPDATE();
                    TxtGAddressList := '';
                    RecLCustomer.RESET();
                    RecLCustomer.SETCURRENTKEY("PWD Group In EMail");
                    RecLCustomer.SETRANGE("PWD Group In EMail", TRUE);
                    IF RecLCustomer.Find() THEN
                        REPEAT
                            IF RecLCustomer."E-Mail" <> '' THEN
                                IF TxtGAddressList = '' THEN
                                    TxtGAddressList := RecLCustomer."E-Mail"
                                ELSE
                                    TxtGAddressList := TxtGAddressList + ';' + RecLCustomer."E-Mail";
                            IF RecLCustomer."PWD E-Mail 2" <> '' THEN
                                IF TxtGAddressList = '' THEN
                                    TxtGAddressList := RecLCustomer."PWD E-Mail 2"
                                ELSE
                                    TxtGAddressList := TxtGAddressList + ';' + RecLCustomer."PWD E-Mail 2";
                            IF RecLCustomer."PWD E-Mail 3" <> '' THEN
                                IF TxtGAddressList = '' THEN
                                    TxtGAddressList := RecLCustomer."PWD E-Mail 3"
                                ELSE
                                    TxtGAddressList := TxtGAddressList + ';' + RecLCustomer."PWD E-Mail 3";
                            IF RecLCustomer."PWD E-Mail 4" <> '' THEN
                                IF TxtGAddressList = '' THEN
                                    TxtGAddressList := RecLCustomer."PWD E-Mail 4"
                                ELSE
                                    TxtGAddressList := TxtGAddressList + ';' + RecLCustomer."PWD E-Mail 4";
                        UNTIL RecLCustomer.NEXT() = 0;
                    CurrPage.UPDATE();
                END;
            }
        }
        addafter("No.")
        {
            field("PWD Customer No. COALA"; Rec."PWD Customer No. COALA")
            {
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field("PWD Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
            }
            field("PWD Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field("PWD Address"; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("PWD City"; Rec.City)
            {
                ApplicationArea = All;
            }
            field("PWD Post Code"; Rec."Post Code")
            {
                ApplicationArea = All;
            }
            field("PWD VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
            field("PWD Siret No."; Rec."PWD Siret No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Responsibility Center")
        {
            Editable = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        modify("Post Code")
        {
            Editable = false;
        }
        modify("Country/Region Code")
        {
            Editable = false;
        }
        modify("Phone No.")
        {
            Editable = false;
        }
        modify("IC Partner Code")
        {
            Editable = false;
        }
        modify(Contact)
        {
            Editable = false;
        }
        modify("Salesperson Code")
        {
            Editable = false;
        }
        modify("Customer Posting Group")
        {
            Editable = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Editable = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Editable = false;
        }
        modify("Customer Price Group")
        {
            Editable = false;
        }
        modify("Customer Disc. Group")
        {
            Editable = false;
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }
        modify("Reminder Terms Code")
        {
            Editable = false;
        }
        modify("Fin. Charge Terms Code")
        {
            Editable = false;
        }
        modify("Currency Code")
        {
            Editable = false;
        }
        modify("Language Code")
        {
            Editable = false;
        }
        modify("Search Name")
        {
            Editable = false;
        }
        modify("Credit Limit (LCY)")
        {
            Editable = false;
        }
        modify(Blocked)
        {
            Editable = false;
        }
        modify("Application Method")
        {
            Editable = false;
        }
        modify("Combine Shipments")
        {
            Editable = false;
        }
        modify(Reserve)
        {
            Editable = false;
        }
        modify("Shipping Advice")
        {
            Editable = false;
        }
        modify("Shipping Agent Code")
        {
            Editable = false;
        }
        modify("Base Calendar Code")
        {
            Editable = false;
        }
        addafter("Base Calendar Code")
        {
            field("PWD Mobil No.1"; Rec."PWD Mobil No. 1")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PWD Mobil No.2"; Rec."PWD Mobil No. 2")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PWD Phone fixe No."; Rec."PWD Phone fixe No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PWD E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PWD E-Mail 2"; Rec."PWD E-Mail 2")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PWD E-Mail 3"; Rec."PWD E-Mail 3")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PWD E-Mail 4"; Rec."PWD E-Mail 4")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PWD Web Identifier"; Rec."PWD Web Identifier")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("PWD Last Shipping Date"; Rec."PWD Last Shipping Date")
            {
                ApplicationArea = All;
            }
            field("PWD SetLastInvoiceNo"; SetLastInvoiceNo())
            {
                Caption = 'Last invoice No.';
                ApplicationArea = all;
                Trigger OnAssistEdit()
                VAR
                    recLSalesInvoiceHeader: Record "Sales Invoice Header";
                    PPostedSalesInvoices: Page "Posted Sales Invoices";
                BEGIN
                    recLSalesInvoiceHeader.RESET();
                    recLSalesInvoiceHeader.SETCURRENTKEY("Sell-to Customer No.", "Posting Date");
                    recLSalesInvoiceHeader.SETRANGE("Sell-to Customer No.", Rec."No.");
                    PPostedSalesInvoices.SETRECORD(recLSalesInvoiceHeader);
                    PPostedSalesInvoices.SETTABLEVIEW(recLSalesInvoiceHeader);
                    PPostedSalesInvoices.RUN();
                END;
            }
        }
        addafter(Control1)
        {
            group("PWD EMail")
            {
                Caption = 'Email sur groupe de client';
                field("PWD TxtGAddressList"; TxtGAddressList)
                {
                    ApplicationArea = All;
                    Caption = 'Adresse Mail';
                    Editable = false;
                }
            }
        }
        modify(SalesHistSelltoFactBox)
        {
            Editable = false;
        }
        modify(SalesHistBilltoFactBox)
        {
            Editable = false;
        }
        modify(CustomerStatisticsFactBox)
        {
            Editable = false;
        }
        modify(CustomerDetailsFactBox)
        {
            Editable = false;
        }
        modify(Control1907829707)
        {
            Editable = false;
        }
        modify(Control1902613707)
        {
            Editable = false;
        }
        modify(Control1905767507)
        {
            Editable = false;
        }
    }
    var
        TxtGAddressList: Text[1024];

    trigger OnOpenPage()
    VAR
        RecLCustomer: Record Customer;
        RecLCustomer2: Record Customer;
    BEGIN
        RecLCustomer.RESET();
        RecLCustomer.SETCURRENTKEY("PWD Group In EMail");
        RecLCustomer.SETRANGE("PWD Group In EMail", TRUE);
        IF RecLCustomer.FIND() THEN
            REPEAT
                RecLCustomer2.GET(RecLCustomer."No.");
                RecLCustomer2."PWD Group In EMail" := FALSE;
                RecLCustomer2.MODIFY();
            UNTIL RecLCustomer.NEXT() = 0;
        TxtGAddressList := '';
    end;

    trigger OnClosePage()
    VAR
        RecLCustomer: Record Customer;
        RecLCustomer2: Record Customer;
    BEGIN
        RecLCustomer.RESET();
        RecLCustomer.SETCURRENTKEY("PWD Group In EMail");
        RecLCustomer.SETRANGE("PWD Group In EMail", TRUE);
        IF RecLCustomer.FIND() THEN
            REPEAT
                RecLCustomer2.GET(RecLCustomer."No.");
                RecLCustomer2."PWD Group In EMail" := FALSE;
                RecLCustomer2.MODIFY();
            UNTIL RecLCustomer.NEXT() = 0;
        TxtGAddressList := '';
    END;

    PROCEDURE SetLastInvoiceNo(): Code[20];
    VAR
        recLSalesInvoiceHeader: Record "Sales Invoice Header";
    BEGIN
        recLSalesInvoiceHeader.RESET();
        recLSalesInvoiceHeader.SETCURRENTKEY("Sell-to Customer No.", "Posting Date");
        recLSalesInvoiceHeader.SETRANGE("Sell-to Customer No.", Rec."No.");
        IF recLSalesInvoiceHeader.FINDLAST() THEN
            EXIT(recLSalesInvoiceHeader."No.");

        EXIT('');
    END;
}
