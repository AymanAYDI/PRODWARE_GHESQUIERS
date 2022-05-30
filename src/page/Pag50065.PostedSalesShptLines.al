page 50065 "PWD Posted Sales Shpt. Lines"
{
    AutoSplitKey = true;
    Caption = 'Posted Sales Shpt. Subform';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Sales Shipment Line" = rm;
    SourceTable = "Sales Shipment Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."PWD Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Valeur douane (correction)"; Rec."Valeur douane (correction)")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Origin Area"; Rec."PWD Origin Area")
                {
                    ApplicationArea = All;
                }
                field("Continental Code"; Rec."PWD Continental Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Certified Origin"; Rec."PWD Certified Origin")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Parcel Nb."; Rec."PWD Parcel Nb.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. Shipped Not Invoiced"; Rec."Qty. Shipped Not Invoiced")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("National Add. Code"; Rec."PWD National Add. Code")
                {
                    ApplicationArea = All;
                }
                field("Cle (restitution)"; Rec."PWD Cle (restitution)")
                {
                    ApplicationArea = All;
                }
                field("Monthly Code"; Rec."PWD Monthly Code")
                {
                    ApplicationArea = All;
                }
                field(Correction; Rec.Correction)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.RUN(CODEUNIT::"PWD Shipment Line - Edit", Rec);
        EXIT(FALSE);
    end;

    procedure ShowTracking()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TrackingForm: Page "Order Tracking";
    begin
        Rec.TESTFIELD(Type, Rec.Type::Item);
        Rec.TESTFIELD("Item Shpt. Entry No.");
        ItemLedgEntry.GET(Rec."Item Shpt. Entry No.");

        TrackingForm.SetItemLedgEntry(ItemLedgEntry);
        TrackingForm.RUNMODAL();
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions();
    end;

    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines();
    end;

    procedure UndoShipmentPosting()
    var
        SalesShptLine: Record "Sales Shipment Line";
    begin
        SalesShptLine.COPY(Rec);
        CurrPage.SETSELECTIONFILTER(SalesShptLine);
        CODEUNIT.RUN(CODEUNIT::"Undo Sales Shipment Line", SalesShptLine);
    end;

    procedure InvoiceLines()
    var
        ShipmentInvoiced: Record "Shipment Invoiced";
    begin
        ShipmentInvoiced.RESET();
        ShipmentInvoiced.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        ShipmentInvoiced.SETRANGE("Shipment No.", Rec."Document No.");
        ShipmentInvoiced.SETRANGE("Shipment Line No.", Rec."Line No.");
        Page.RUNMODAL(Page::"Invoices bound by Shipment", ShipmentInvoiced);
    end;

    procedure PrintHealthCertificate()
    var
        CustomsCertif: Record "PWD Customs Documents Template";
        ShipmentLine: Record "Sales Shipment Line";
        HealthCertifWordMngt: Codeunit "Customs Shipmt Doc WordMngt";
        AssignDocTemplateCode: page "Choose Customs Doc Template";
        DocTemplateCode: Code[10];
    begin
        CLEAR(AssignDocTemplateCode);
        AssignDocTemplateCode.LOOKUPMODE := TRUE;
        IF AssignDocTemplateCode.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            AssignDocTemplateCode.GetFields(DocTemplateCode);
            CustomsCertif.GET(DocTemplateCode);
            CLEAR(HealthCertifWordMngt);
            CurrPage.SETSELECTIONFILTER(ShipmentLine);
            //ToDo
            // HealthCertifWordMngt.Merge(ShipmentLine, CustomsCertif, CustomsCertif."No.");
        END;
    end;
}
