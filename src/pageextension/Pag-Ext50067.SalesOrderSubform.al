pageextension 50067 "PWD SalesOrderSubform" extends "Sales Order Subform"
{
    layout
    {
        addbefore(Type)
        {
            field("PWD Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Type)
        {
            field("PWD Family Code"; Rec."PWD Family Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("PWD Item SEAF Code"; Rec."PWD Item SEAF Code")
            {
                ApplicationArea = All;
            }
            field("PWD Item SEAF Code 2"; Rec."PWD Item SEAF Code 2")
            {
                ApplicationArea = All;
            }
            field("PWD Item SEAF Code 3"; Rec."PWD Item SEAF Code 3")
            {
                ApplicationArea = All;
            }
            field("PWD Item SEAF Code 4"; Rec."PWD Item SEAF Code 4")
            {
                ApplicationArea = All;
            }
            field("PWD Item SEAF Code 5"; Rec."PWD Item SEAF Code 5")
            {
                ApplicationArea = All;
            }
            field("PWD Vendor No."; Rec."PWD Vendor No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("PWD VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Prod. Posting Group")
        {
            field("PWD Propriete Seafrance"; Rec."PWD Propriete Seafrance")
            {
                ApplicationArea = All;
            }
            field("PWD DCG Tariff No."; Rec."PWD DCG Tariff No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("PWD Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
            field("PWD Designation ENU"; Rec."PWD Designation ENU")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field("PWD Prepared Quantity"; Rec."PWD Prepared Quantity")
            {
                ApplicationArea = All;
            }
            field("PWD Purchasing Code"; Rec."Purchasing Code")
            {
                ApplicationArea = All;
            }
            field("PWD Order Trading brand"; Rec."PWD Order Trading brand")
            {
                ApplicationArea = All;
            }
            field("Valeur douane (correction)"; Rec."Valeur douane (correction)")
            {
                ApplicationArea = All;
            }
            field("PWD Substitution Available"; Rec."Substitution Available")
            {
                ApplicationArea = All;
            }
            field("PWD Drop Shipment"; Rec."Drop Shipment")
            {
                ApplicationArea = All;
            }
            field("PWD Special Order"; Rec."Special Order")
            {
                ApplicationArea = All;
            }
            field("PWD Special Order Purchase No."; Rec."Special Order Purchase No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("PWD Quantity Seafrance"; Rec."PWD Quantity Seafrance")
            {
                ApplicationArea = All;
            }
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        addafter("Unit of Measure")
        {
            field("PWD Parcel Nb."; Rec."PWD Parcel Nb.")
            {
                ApplicationArea = All;
            }
            field("PWD Unit per Parcel"; Rec."PWD Unit per Parcel")
            {
                ApplicationArea = All;
            }
            field("PWD Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Trading Brand"; Rec."PWD Trading Brand")
            {
                ApplicationArea = All;
            }
            field("PWD Nb Appeal for tenders"; Rec."PWD Nb Appeal for tenders")
            {
                ApplicationArea = All;
            }
            field("PWD Nb Purchase Quote"; Rec."PWD Nb Purchase Quote")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Cost (LCY)")
        {
            field("PWD Specific Cost"; Rec."PWD Specific Cost")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line Amount")
        {
            field("PWD Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Inv. Discount Amount")
        {
            field("PWD Origin Area"; Rec."PWD Origin Area")
            {
                ApplicationArea = All;
            }
            field("PWD Code Continent"; Rec."PWD Code Continent")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Planned Shipment Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("PWD Health Certificate Required"; Rec."PWD Health Certificate Required")
            {
                ApplicationArea = All;
            }
            field("PWD Conformity Certificate"; Rec."PWD Conformity Certificate")
            {
                ApplicationArea = All;
            }
            field("PWD Technical Card"; Rec."PWD Technical Card")
            {
                ApplicationArea = All;
            }
            field("PWD OriginArea"; Rec."PWD Origin Area")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode8)
        {
            field("PWD Quantity Ordered Purch."; Rec."PWD Quantity Ordered Purch.")
            {
                ApplicationArea = All;
            }
            field("PWD Quantity Receipted Purch."; Rec."PWD Quantity Receipted Purch.")
            {
                ApplicationArea = All;
            }
            field("PWD Quantity Ordered Sp. Order"; Rec."PWD Quantity Ordered Sp. Order")
            {
                ApplicationArea = All;
            }
            field("PWD Quantity Receipted Sp. Order"; Rec."PWD Quantity Receipted Sp. Order")
            {
                ApplicationArea = All;
            }
            field("PWD Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
            {
                ApplicationArea = All;
            }
            field("PWD Family"; Rec."PWD Family")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("PWD Seafrance Order Line No."; Rec."PWD Seafrance Order Line No.")
            {
                ApplicationArea = All;
            }
            field("PWD New Item"; Rec."PWD New Item")
            {
                ApplicationArea = All;
            }
        }
        addafter("Line No.")
        {
            field("PWD KPI"; Rec."PWD KPI")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(OrderPromising)
        {
            action("PWD ExtraireCodeFournisseurEtCoutUnitaireDirect")
            {
                ApplicationArea = All;
                Caption = 'Extraire code Fournisseur et co–t unitaire direct';
                ShortCutKey = 'Shift+Ctrl+F';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.FctPushVendorAndUnitCostItem();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        DescriptionOnFormat();
        UnitPriceOnFormat();
        UpdateKPI();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    BEGIN
        Rec."PWD Linked Sales Line" := Rec.GetLinkedSalesLine();
    END;

    PROCEDURE DescriptionOnFormat()
    BEGIN
        IF (Rec.Type = Rec.Type::Item) AND (Item.GET(Rec."No.")) THEN BEGIN
            Item.CALCFIELDS(Comment);
            IF Item.Comment = TRUE THEN
                ;
        END;
    END;

    PROCEDURE UnitPriceOnFormat()
    BEGIN
        ParamsVente.GET();
        CoefPrixUnitaire := ParamsVente."PWD Coef Controle prix unitaire";
    END;

    PROCEDURE PrintHealthCertificate()
    VAR
        CustomsCertif: Record "PWD Customs Documents Template";
        SalesLine: Record "Sales Line";
        HealthCertifWordMngt: Codeunit "PWD Customs Sales Doc WordMngt";
        AssignDocTemplateCode: Page "Choose Customs Doc Template";
        DocTemplateCode: Code[10];
    BEGIN
        CLEAR(AssignDocTemplateCode);
        AssignDocTemplateCode.LOOKUPMODE := TRUE;
        IF AssignDocTemplateCode.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            AssignDocTemplateCode.GetFields(DocTemplateCode);
            CustomsCertif.GET(DocTemplateCode);
            CLEAR(HealthCertifWordMngt);
            CurrPage.SETSELECTIONFILTER(SalesLine);
            //ToDo
            //HealthCertifWordMngt.Merge(SalesLine, CustomsCertif, CustomsCertif."No.");
        END;
    END;

    PROCEDURE ShowItemComments()
    VAR
        ItemComment: Record "Comment Line";
        FormComment: Page "Comment Sheet";
        Text1000000003: label 'L''article %1 n''a pas de commentaires associ‚s';
    BEGIN
        IF (Rec.Type = Rec.Type::Item) AND (Item.GET(Rec."No.")) THEN BEGIN
            Item.CALCFIELDS(Comment);
            IF Item.Comment = TRUE THEN BEGIN
                ItemComment.SETRANGE("Table Name", ItemComment."Table Name"::Item);
                ItemComment.SETRANGE("No.", Item."No.");
                IF ItemComment.FIND('-') THEN BEGIN
                    FormComment.SETTABLEVIEW(ItemComment);
                    FormComment.EDITABLE(FALSE);
                    FormComment.RUN();
                END;
            END ELSE
                MESSAGE(Text1000000003, Item."No.");
        END;
    END;

    PROCEDURE UpdateKPI()
    VAR
        RecLKPIRulesSetup: Record "PWD KPI Rules Setup";
    BEGIN
        IF NOT RecLKPIRulesSetup.GET('', 1) THEN EXIT;
        RecLKPIRulesSetup.CALCFIELDS(RecLKPIRulesSetup.KPI);
        ParamsVente.GET();
        CoefPrixUnitaire := ParamsVente."PWD Coef Controle prix unitaire";
        IF Rec."Unit Price" * (1 - (Rec."Line Discount %" / 100)) < Rec."Unit Cost" * CoefPrixUnitaire THEN BEGIN
            Rec."PWD KPI" := RecLKPIRulesSetup.KPI;
            Rec.CALCFIELDS(Rec."PWD KPI");
        END ELSE
            CLEAR(Rec."PWD KPI");
    END;

    var
        Item: Record Item;
        ParamsVente: Record "Sales & Receivables Setup";
        CoefPrixUnitaire: Decimal;
}
