page 50004 "Vendors offers to select -TrB"
{
    Caption = 'Vendors offers to select';
    PageType = Card;
    SourceTable = "Sales Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(Control1000000010)
            {
                ShowCaption = false;
                field("Document No."; STRSUBSTNO(Text02, Rec."Document No."))
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Document No.';
                }
                field("Salesperson Code"; STRSUBSTNO(Text04, SalesHeader."Salesperson Code"))
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Salesperson Code';
                }
                field("Cust_No."; STRSUBSTNO(Text01, Cust."No."))
                {
                    ApplicationArea = all;
                    Editable = false;
                    caption = 'Customer No';
                }
                field("Cust.Name"; STRSUBSTNO(Cust.Name))
                {
                    ApplicationArea = all;
                    Editable = false;
                    caption = 'Customer Name';
                }
                field("Ship-to Address"; STRSUBSTNO(SalesHeader."Ship-to Address"))
                {
                    ApplicationArea = all;
                    Editable = false;
                    caption = 'Ship-to Address';

                }
                field("Ship-to Address 2"; STRSUBSTNO(SalesHeader."Ship-to Address 2"))
                {
                    ApplicationArea = all;
                    Editable = false;
                    caption = 'Ship-to Address 2';
                }
                field("Ship-to Post Code_Ship-to City"; STRSUBSTNO(SalesHeader."Ship-to Post Code" + ' ' + SalesHeader."Ship-to City"))
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Ship-to Code/City';
                }
                field("Ship-to Country/Region Code"; STRSUBSTNO(SalesHeader."Ship-to Country/Region Code"))
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Ship-to Country/Region Code';
                }
            }
            group("Document de Vente")
            {
                Caption = 'Document de Vente';
                repeater(Control1)
                {
                    Editable = false;
                    ShowCaption = false;
                    field("Document No"; Rec."Document No.")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    field("Line No."; Rec."Line No.")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = all;
                    }
                    field(Description; Rec.Description)
                    {
                        ApplicationArea = all;
                    }
                    field("Description 2"; Rec."Description 2")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    field(Quantity; Rec.Quantity)
                    {
                        ApplicationArea = all;
                    }
                    field("Nb Purchase Quote"; Rec."PWD Nb Purchase Quote")
                    {
                        ApplicationArea = all;
                    }
                    field("Unit of Measure Code"; Rec."Unit of Measure Code")
                    {
                        ApplicationArea = all;
                    }
                    field("Unit of Measure"; Rec."Unit of Measure")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                }
            }
            group("Demande de Prix")
            {
                Caption = 'Demande de Prix';
                part(VendorsReply; "PWD Vendor reply -TrB")
                {
                    ApplicationArea = all;
                    SubPageLink = "PWD SalesTypeDocAppealTend." = FIELD("Document Type"), "PWD Sales No. Appeal Tenders" = FIELD("Document No."), "PWD SalesLineNoAppealTenders" = FIELD("Line No.");
                    SubPageView = SORTING("PWD SalesTypeDocAppealTend.", "PWD Sales No. Appeal Tenders", "PWD SalesLineNoAppealTenders");
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF NOT Cust.GET(Rec."Sell-to Customer No.") THEN
            Cust.INIT();
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        DocumentNoOnFormat();
        NoOnFormat();
    end;

    var
        Cust: Record Customer;
        SalesHeader: Record "Sales Header";
        "Document No.Emphasize": Boolean;
        "No.Emphasize": Boolean;
        Text01: Label 'Customer No. %1';
        Text02: Label 'Document No. %1';
        Text04: Label 'Salesperson/Purchaser %1';

    local procedure DocumentNoOnFormat()
    begin
        IF Rec."PWD Trading Brand" = TRUE THEN
            "Document No.Emphasize" := TRUE;
    end;

    local procedure NoOnFormat()
    begin
        IF Rec."PWD Trading Brand" = TRUE THEN
            "No.Emphasize" := TRUE;
    end;
}
