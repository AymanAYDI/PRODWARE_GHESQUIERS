pageextension 50005 "PWD CustomerCard" extends "Customer Card"
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        addfirst(General)
        {
            field("PWD No."; Rec."No.")
            {
                ApplicationArea = All;
                Importance = Standard;
            }
        }
        addafter("PWD No.")
        {
            field("PWD Additional name"; Rec."PWD Additional name")
            {
                ApplicationArea = All;
            }
            field("PWD C/O"; Rec."PWD C/O")
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
        }
        addafter(City)
        {
            field("PWD County"; Rec.County)
            {
                ApplicationArea = All;
            }
            field("PWD Flag"; Rec."PWD Flag")
            {
                ApplicationArea = All;
            }
            field("PWD Area"; Rec."PWD Area")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("PWD Last Shipping Date"; Rec."PWD Last Shipping Date")
            {
                ApplicationArea = All;
            }
            Field(Field_SetLastInvoiceNo; SetLastInvoiceNo())
            {
                Caption = 'Last invoice No.';
                ApplicationArea = All;
                trigger OnDrillDown()
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
        addafter("Fax No.")
        {
            field("PWD Mobil No.1"; Rec."PWD Mobil No. 1")
            {
                ApplicationArea = All;
            }
            field("PWD Mobil No. 2"; Rec."PWD Mobil No. 2")
            {
                ApplicationArea = All;
            }
            field("PWD Phone fixe No."; Rec."PWD Phone fixe No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("E-Mail")
        {
            field("PWD E-Mail 2"; Rec."PWD E-Mail 2")
            {
                ApplicationArea = All;
            }
            field("PWD E-Mail 3"; Rec."PWD E-Mail 3")
            {
                ApplicationArea = All;
            }
            field("PWD E-Mail 4"; Rec."PWD E-Mail 4")
            {
                ApplicationArea = All;
            }
            field("PWD Web Identifier"; Rec."PWD Web Identifier")
            {
                ApplicationArea = All;
            }
        }
        addafter("IC Partner Code")
        {
            field("PWD Acknowledgement"; Rec."PWD Acknowledgement")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("PWD Siret No."; Rec."PWD Siret No.")
            {
                ApplicationArea = All;
            }
            field("PWD Billing by Vendor"; Rec."PWD Billing by Vendor")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Registration No.")
        {
            field("PWD No. d accises"; Rec."PWD No. d accises")
            {
                ApplicationArea = All;
            }
        }
        addafter(Shipping)
        {
            group("PWD Specific")
            {
                Caption = 'Specific';
                field("PWD Business Initiator"; Rec."PWD Business Initiator")
                {
                    ApplicationArea = All;
                }
                field("PWD Payback Commission Rate"; Rec."PWD Payback Commission Rate")
                {
                    ApplicationArea = All;
                }
                field("Discount Profit %"; Rec."PWD Discount Profit %")
                {
                    ApplicationArea = All;
                }
                field("PWD Family Code"; Rec."PWD Family Code")
                {
                    ApplicationArea = All;
                }
                field("PWD Sub Family Code"; Rec."PWD Sub Family Code")
                {
                    ApplicationArea = All;
                }
                field("PWD Origin Certified"; Rec."PWD Origin Certified")
                {
                    ApplicationArea = All;
                }
                field("PWD Health Certificate Required"; Rec."PWD Health Certif Required")
                {
                    ApplicationArea = All;
                }
                field("PWD Conformity Certificate"; Rec."PWD Conformity Certificate")
                {
                    ApplicationArea = All;
                }
                field("PWD Customer No. COALA"; Rec."PWD Customer No. COALA")
                {
                    ApplicationArea = All;
                }
                field("PWD Technical Card"; Rec."PWD Technical Card")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("PWD Specific")
        {
            group("PWD Seafrance Order")
            {
                Caption = 'Seafrance Order';
                field("PWD Our Account No."; Rec."Our Account No.")
                {
                    ApplicationArea = All;
                }
                field("PWD Vendor code"; Rec."PWD Vendor code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
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
