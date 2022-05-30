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
                field("Substr Document No."; STRSUBSTNO(Text1000000002, Rec."Document No."))
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("STRSUBSTNO_SalesHeader_Salesperson Code"; STRSUBSTNO(Text1000000004, SalesHeader."Salesperson Code"))
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("STRSUBSTNOText1000000001_Cust_No."; STRSUBSTNO(Text1000000001, Cust."No."))
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("STRSUBSTNO(Cust.Name)"; STRSUBSTNO(Cust.Name))
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("STRSUBSTNO(SalesHeader.""Ship-to Address"")"; STRSUBSTNO(SalesHeader."Ship-to Address"))
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("STRSUBSTNO(SalesHeader.""Ship-to Address 2"")"; STRSUBSTNO(SalesHeader."Ship-to Address 2"))
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("STRSUBSTNO(SalesHeader.""Ship-to Post Code"" + ' ' + SalesHeader.""Ship-to City"")"; STRSUBSTNO(SalesHeader."Ship-to Post Code" + ' ' + SalesHeader."Ship-to City"))
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("STRSUBSTNO(SalesHeader.""Ship-to Country/Region Code"")"; STRSUBSTNO(SalesHeader."Ship-to Country/Region Code"))
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group("Document de Vente")
            {
                Caption = 'Document de Vente';
                repeater(Control1)
                {
                    Editable = false;
                    ShowCaption = false;
                    field("Document No."; Rec."Document No.")
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
                    SubPageLink = "PWD Sales Type Doc Appeal tenders" = FIELD("Document Type"), "PWD Sales No. Appeal Tenders" = FIELD("Document No."), "PWD Sales Line No. Appeal Tenders" = FIELD("Line No.");
                    SubPageView = SORTING("PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders");
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
        DescriptionOnFormat();
    end;

    var
        Cust: Record Customer;
        SalesHeader: Record "Sales Header";
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        "Document No.Emphasize": Boolean;
        [InDataSet]
        "No.Emphasize": Boolean;
        Text1000000001: Label 'Customer No.';
        Text1000000002: Label 'Document No. %1';
        Text1000000004: Label 'Salesperson/Purchaser %1';

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

    local procedure DescriptionOnFormat()
    begin
        IF Rec."PWD Trading Brand" = TRUE THEN
            DescriptionEmphasize := TRUE;
    end;
}
