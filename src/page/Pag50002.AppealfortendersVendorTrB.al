page 50002 "Appeal for tenders/Vendor -TrB"
{
    AutoSplitKey = true;
    Caption = 'Appeal for tenders/Vendor Avita';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = "PWD Appeal for Tenders";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field(ShowDetail; ShowDetail)
            {
                ApplicationArea = all;
                Caption = 'Show detail';

                trigger OnValidate()
                begin
                    IF ShowDetail = TRUE THEN
                        Rec.SETRANGE(Detail)
                    ELSE
                        Rec.SETRANGE(Detail, FALSE);
                    ShowDetailOnAfterValidate();
                end;
            }
            repeater(Control1)
            {
                Caption = 'Control';
                IndentationColumn = "Description 2Indent";
                IndentationControls = "No.";
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Line No. document"; Rec."Line No. document")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Numb. of detail line"; Rec."Numb. of detail line")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Detail; Rec.Detail)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                }
            }
            part(Control1000000006; "Appeal for tenders/Vendor det")
            {
                ApplicationArea = all;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No. document" = FIELD("Line No. document");
            }
            group(Control20)
            {
                ShowCaption = false;
                field(Description2; Description2)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                    Editable = false;
                }
                field(BuyFromVendorName; BuyFromVendorName)
                {
                    ApplicationArea = all;
                    Caption = 'Buy-from Vendor Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Fonction&s")
            {
                Caption = 'F&unctions';
                action("&Visualiser document")
                {
                    Caption = 'Sales &Order';
                    ApplicationArea = all;
                    Image = Card;
                    trigger OnAction()
                    begin
                        IF Rec."Document Type" = Rec."Document Type"::Quote THEN BEGIN
                            SalesHeader.SETRANGE("No.", Rec."Document No.");
                            SalesQuote.SETTABLEVIEW(SalesHeader);
                            SalesQuote.EDITABLE := FALSE;
                            SalesQuote.RUN();
                        END ELSE BEGIN
                            SalesHeader.SETRANGE("No.", Rec."Document No.");
                            SalesOrder.SETTABLEVIEW(SalesHeader);
                            SalesOrder.EDITABLE := FALSE;
                            SalesOrder.RUN();
                        END;
                    end;
                }
                action("Créer demande de prix")
                {
                    ApplicationArea = all;
                    Caption = 'Créer demande de prix';
                    RunObject = Report "Create Purchase Quote r -TrB";
                    Visible = false;
                    Image = CreateDocument;
                }
                separator(Action1000000009)
                {
                }
                action("Créer nouvelle demande d'achat")
                {
                    ApplicationArea = all;
                    Caption = 'Créer nouvelle demande d''achat';
                    Image = CreateDocument;

                    trigger OnAction()
                    var
                    begin
                        AddNewLine(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "No.Indent" := 0;
        NoOnFormat();
        DescriptionOnFormat();
        Description2OnFormat();
    end;

    trigger OnOpenPage()
    begin
        ShowDetail := FALSE;
        Rec.SETRANGE(Detail, FALSE);
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
        SalesQuote: Page "Sales Quote";
        "Description 2Emphasize": Boolean;
        // DescriptionEmphasize: Boolean;
        "No.Emphasize": Boolean;
        ShowDetail: Boolean;
        "Description 2Indent": Integer;
        // DescriptionIndent: Integer;
        "No.Indent": Integer;
        Text1000000000: Label 'New line added';
        BuyFromVendorName: Text[30];
        Description2: Text[30];

    procedure AddNewLine(AppTenders: Record "PWD Appeal for Tenders")
    var
        AppTendersNew: Record "PWD Appeal for Tenders";
        NewLineNo: Integer;
    begin
        IF AppTendersNew.GET(AppTenders."Document Type", AppTenders."Document No.", AppTenders."Line No. document", AppTenders."Line No.") THEN
            NewLineNo := ROUND(((AppTendersNew."Line No." - AppTenders."Line No.") / 2) + AppTenders."Line No.", 1)
        ELSE
            NewLineNo := AppTenders."Line No." + 10000;

        AppTendersNew.INIT();
        AppTendersNew := AppTenders;
        AppTendersNew."Line No." := NewLineNo;

        AppTendersNew.VALIDATE("Vendor No.", '');
        AppTendersNew.Detail := TRUE;
        AppTendersNew.INSERT();
        MESSAGE(Text1000000000);
    end;

    local procedure ShowDetailOnAfterValidate()
    begin
        CurrPage.UPDATE();
    end;

    local procedure NoOnFormat()
    begin
        IF Rec.Detail = TRUE THEN
            "No.Indent" := 500
        ELSE
            "No.Emphasize" := TRUE;
    end;

    local procedure DescriptionOnFormat()
    begin
        // IF Rec.Detail = TRUE THEN
        //     DescriptionIndent := 500
        // ELSE
        //     DescriptionEmphasize := TRUE;
    end;

    local procedure Description2OnFormat()
    begin

        IF Rec.Detail = TRUE THEN
            "Description 2Indent" := 500
        ELSE
            "Description 2Emphasize" := TRUE;
    end;
}
