page 50045 "PWD Sales Line to Correct"
{
    AutoSplitKey = true;
    Caption = 'Sales Order Subform';
    DelayedInsert = true;
    Description = 'Text19027551';
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Sales Line";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            label(Control1000000020)
            {
                CaptionClass = Text19027551;
                Editable = false;
                Enabled = false;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
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

                    trigger OnValidate()
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Prepared Quantity"; Rec."PWD Prepared Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida();
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
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
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Special Order"; Rec."Special Order")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ReserveOnAfterValidate();
                    end;
                }
                field("Trading Brand"; Rec."PWD Trading Brand")
                {
                    ApplicationArea = All;
                }
                field("Nb Appeal for tenders"; Rec."PWD Nb Appeal for tenders")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Nb Purchase Quote"; Rec."PWD Nb Purchase Quote")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(SalesPriceExist; Rec.PriceExists())
                {
                    Caption = 'Sales Price Exists';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(SalesLineDiscExists; Rec.LineDiscExists())
                {
                    Caption = 'Sales Line Disc. Exists';
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Ship"; Rec."Qty. to Ship")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(FALSE);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    BlankZero = true;
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD();
                        Rec.ShowItemChargeAssgnt();
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Quantity Ordered Purch."; Rec."PWD Quantity Ordered Purch.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Receipted Purch."; Rec."PWD Quantity Receipted Purch.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Family; Rec."PWD Family")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnClosePage()
    begin
        SalesHeader.RESET();
        SalesHeader.SETRANGE(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(SalesHeader.Status, SalesHeader.Status::Open);
        SalesHeader.SETRANGE(SalesHeader."PWD Preparation in process", TRUE);
        SalesHeader.SETRANGE(SalesHeader."PWD User Id", USERID);
        IF SalesHeader.FIND('-') THEN
            REPEAT
                ReleaseSalesDoc.RUN(SalesHeader);
            UNTIL SalesHeader.NEXT() = 0;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        DeleteAnomalie: Codeunit "PWD delete ligne anomalie";
    begin
        CLEAR(DeleteAnomalie);
        DeleteAnomalie.RUN(Rec);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type;
        CLEAR(ShortcutDimCode);
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ShortcutDimCode: array[8] of Code[20];
        Text19027551: Label 'Sales Lines to modify';

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        CurrPage.SAVERECORD();
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM", Rec);
        CurrPage.UPDATE();
    end;

    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SETRANGE("No.", Rec."Purchase Order No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN();
    end;

    procedure OpenSpecialPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        PurchHeader.SETRANGE("No.", Rec."Special Order Purchase No.");
        PurchOrder.SETTABLEVIEW(PurchHeader);
        PurchOrder.EDITABLE := FALSE;
        PurchOrder.RUN();
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD();
            TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate() THEN
            UpdateForm(TRUE);
    end;

    procedure ShowReservation()
    begin
        Rec.FIND();
        Rec.ShowReservation();
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        //ToDo
        //Rec.ItemAvailability(AvailabilityType);
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;

    procedure ShowDimensions()
    begin
        Rec.ShowDimensions();
    end;

    procedure ShowItemSub()
    begin
        Rec.ShowItemSub();
    end;

    procedure ShowNonstockItems()
    begin
        Rec.ShowNonstock();
    end;

    procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines();
    end;

    procedure ShowTracking()
    var
        TrackingForm: Page "Order Tracking";
    begin
        TrackingForm.SetSalesLine(Rec);
        TrackingForm.RUNMODAL();
    end;

    procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure ShowPrices()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader, Rec);
    end;

    procedure PrintHealthCertificate()
    var
        CustomsCertif: Record "PWD Customs Documents Template";
        SalesLine: Record "Sales Line";
        HealthCertifWordMngt: Codeunit "PWD Customs Sales Doc WordMngt";
        AssignDocTemplateCode: Page "Choose Customs Doc Template";
        DocTemplateCode: Code[10];
    begin
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
    end;

    procedure InitSalesLine(SalesLine2: Record "Sales Line")
    begin
        SalesLine := SalesLine2;
        SalesLine.SETRECFILTER();
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Rec.Type = Rec.Type::"Charge (Item)") AND (Rec."No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD();
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        IF Rec.Reserve = Rec.Reserve::Always THEN BEGIN
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(FALSE);
        END;
    end;

    local procedure ReserveOnAfterValidate()
    begin
        IF (Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) THEN BEGIN
            CurrPage.SAVERECORD();
            Rec.AutoReserve();
            CurrPage.UPDATE(FALSE);
        END;
    end;
}
