pageextension 50071 "PWD PostedSalesShptSubform" extends "Posted Sales Shpt. Subform"
{
    Editable = true;
    layout
    {
        modify(Type)
        {
            Editable = false;
        }
        modify("No.")
        {
            Editable = false;
        }
        modify("Item Reference No.")
        {
            Editable = false;
        }
        modify("Variant Code")
        {
            Editable = false;
        }
        addafter("Variant Code")
        {
            field("PWD Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("PWD Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
        }
        modify(Description)
        {
            Editable = false;
        }
        addafter(Description)
        {
            field("PWD Origin Area"; Rec."PWD Origin Area")
            {
                ApplicationArea = All;
            }
            field("PWD Continental Code"; Rec."PWD Continental Code")
            {
                ApplicationArea = All;
            }
            field("PWD Certified Origin"; Rec."PWD Certified Origin")
            {
                ApplicationArea = All;
            }
        }
        modify("Return Reason Code")
        {
            Editable = false;
        }
        modify("Location Code")
        {
            Editable = false;
        }
        modify("Bin Code")
        {
            Editable = false;
        }
        modify(Quantity)
        {
            Editable = false;
        }
        addafter(Quantity)
        {
            field("PWD Quantity Seafrance"; Rec."PWD Quantity Seafrance")
            {
                ApplicationArea = All;
            }
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Unit of Measure")
        {
            Editable = false;
        }
        addafter("Unit of Measure")
        {
            field("PWD Parcel Nb."; Rec."PWD Parcel Nb.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Requested Delivery Date")
        {
            Editable = false;
        }
        modify("Promised Delivery Date")
        {
            Editable = false;
        }
        modify("Planned Delivery Date")
        {
            Editable = false;
        }
        modify("Shipment Date")
        {
            Editable = false;
        }
        modify("Shipping Time")
        {
            editable = false;
        }
        modify("Outbound Whse. Handling Time")
        {
            editable = false;
        }
        modify("Appl.-to Item Entry")
        {
            editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            editable = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("PWD Provision/materiel"; Rec."PWD Provision/materiel")
            {
                ApplicationArea = All;
            }
            field("PWD National Add. Code"; Rec."PWD National Add. Code")
            {
                ApplicationArea = All;
            }
            field("PWD DCG Tariff No."; Rec."PWD DCG Tariff No.")
            {
                ApplicationArea = All;
            }
            field("PWD Cle (restitution)"; Rec."PWD Cle (restitution)")
            {
                ApplicationArea = All;
            }
            field("PWD Monthly Code"; Rec."PWD Monthly Code")
            {
                ApplicationArea = All;
            }
            field("PWD Valeur douane (correction)"; Rec."PWD Valeur douane (correction)")
            {
                ApplicationArea = All;
            }
        }
        addafter(Correction)
        {
            field("PWD Seafrance Order Line No."; Rec."PWD Seafrance Order Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            action("PWD Update Document")
            {
                ApplicationArea = Suite;
                Caption = 'Update Document';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    PostedSalesShipmentUpdate: Page "PWD Pos Sales Shpt.Sub Update";
                begin
                    PostedSalesShipmentUpdate.LookupMode := true;
                    PostedSalesShipmentUpdate.SetRec(Rec);
                    PostedSalesShipmentUpdate.RunModal();
                end;
            }
        }
    }

    PROCEDURE PrintHealthCertificate();
    VAR
        CustomsCertif: Record "PWD Customs Documents Template";
        ShipmentLine: Record "Sales Shipment Line";
        HealthCertifWordMngt: Codeunit "Customs Shipmt Doc WordMngt";
        AssignDocTemplateCode: Page "Choose Customs Doc Template";
        DocTemplateCode: Code[10];
    BEGIN
        CLEAR(AssignDocTemplateCode);
        AssignDocTemplateCode.LOOKUPMODE := TRUE;
        IF AssignDocTemplateCode.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            AssignDocTemplateCode.GetFields(DocTemplateCode);
            CustomsCertif.GET(DocTemplateCode);
            CLEAR(HealthCertifWordMngt);
            CurrPage.SETSELECTIONFILTER(ShipmentLine);
            //TODO
            //HealthCertifWordMngt.Merge(ShipmentLine, CustomsCertif, CustomsCertif."No.");
        END;
    END;

    PROCEDURE DescriptionOnFormat();
    BEGIN
        IF (Rec.Type = Rec.Type::Item) AND (Item.GET(Rec."No.")) THEN
            Item.CALCFIELDS(Comment);
    END;

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.RUN(CODEUNIT::"PWD Shipment Line - Edit", Rec);
        EXIT(FALSE);
    end;

    VAR
        Item: Record Item;
}
