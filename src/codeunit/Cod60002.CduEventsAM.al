codeunit 60002 "PWD CduEvents AM"
{
    //--Page10--

    [EventSubscriber(ObjectType::Page, Page::"Countries/Regions", 'OnOpenPageEvent', '', false, false)]
    procedure OnOpenPageEvent_CountriesRegions(var Rec: Record "Country/Region")
    var
        PagCountriesRegions: Page "Countries/Regions";
    begin
        IF PagCountriesRegions.LOOKUPMODE THEN PagCountriesRegions.EDITABLE(FALSE);
    end;
    //--Page21--
    [EventSubscriber(ObjectType::Page, Page::"Customer Card", 'OnBeforeGetSalesPricesAndSalesLineDisc', '', false, false)]
    local procedure OnBeforeGetSalesPricesAndSalesLineDisc(var LoadOnDemand: Boolean)
    var
        CustCard: page "Customer Card";
    begin
        CustCard.PWDSetNoFieldVisible();
    end;
    //--Page26--
    [EventSubscriber(ObjectType::Page, Page::"Vendor Card", 'OnOpenPageEvent', '', false, false)]
    local procedure VendorCard_OnOpenPageEvent(var rec: record Vendor)
    var
        VendCard: page "Vendor Card";
    begin
        VendCard.PWDSetNoFieldVisible();
    end;

    //--Page41--
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenPageEvent_SalesQuote(var Rec: Record "Sales Header")
    var
        SalesQuote: page "Sales Quote";
    begin
        SalesQuote.PWDSetDocNoVisible();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeActionEvent', 'MakeOrder', false, false)]
    local procedure OnBeforeActionEvent_SalesQuote_MakeOrder(var Rec: Record "Sales Header")
    var
        RecLSalesLines: Record "Sales Line";
        Gtext001: Label 'La ligne %1 pour l''article %2 ne possŠde pas de quantit‚.';
    begin
        RecLSalesLines.RESET();
        RecLSalesLines.SETRANGE("Document Type", Rec."Document Type");
        RecLSalesLines.SETRANGE("Document No.", Rec."No.");
        RecLSalesLines.SETRANGE(Type, RecLSalesLines.Type::Item);
        RecLSalesLines.SETFILTER(Quantity, '%1', 0);
        IF RecLSalesLines.FINDFIRST() THEN
            ERROR(Gtext001, RecLSalesLines."Line No.", RecLSalesLines."No.");
    end;
    //--Page42--
    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', 'Release', false, false)]
    local procedure OnAfterActionEvent_SalesOrder_Release(var Rec: Record "Sales Header")
    var
        SalesLine2_local: Record "Sales Line";
        CstG003: Label 'Une ligne au moins a un prix nul.\Voulez-vous lancer quand mˆme la commande ?';
    begin
        SalesLine2_local.RESET();
        SalesLine2_local.SETRANGE(SalesLine2_local."Document Type", Rec."Document Type");
        SalesLine2_local.SETRANGE(SalesLine2_local."Document No.", Rec."No.");
        SalesLine2_local.SETRANGE(SalesLine2_local.Type, SalesLine2_local.Type::Item);
        SalesLine2_local.SETRANGE(SalesLine2_local."Unit Price", 0);
        IF SalesLine2_local.COUNT <> 0 THEN BEGIN
            IF CONFIRM(STRSUBSTNO(CstG003), FALSE) THEN
                CODEUNIT.RUN(Codeunit::"Release Sales Document", Rec);
        END ELSE
            CODEUNIT.RUN(Codeunit::"Release Sales Document", Rec);
    end;
    //--Page43--
    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateEvent_SalesInvoice_No(var Rec: Record "Sales Header")
    var
        RecCust: Record Customer;
        RecCall: Record "PWD Call";
        CstG001: Label 'Indiquez un Nø de client factur‚ dans la fiche client';
    BEGIN
        IF RecCall.GET(Rec."PWD Call No.") THEN
            IF RecCust.GET(RecCall.Ship) THEN
                IF RecCust."Bill-to Customer No." = '' THEN
                    ERROR(CstG001);
    end;
    //--Page46--
    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterValidateEvent', 'Unit Price', false, false)]
    local procedure OnAfterValidateEvent_SalesOrderSubform_UnitPrice(var Rec: Record "Sales Line")
    var
        SalesOrderSubform: Page "Sales Order Subform";
    begin
        SalesOrderSubform.UpdateKPI();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure OnAfterGetRecordEvent_SalesOrderSubform(var Rec: Record "Sales Line")
    var
        SalesOrderSubform: Page "Sales Order Subform";
    begin
        SalesOrderSubform.DescriptionOnFormat();
        SalesOrderSubform.UnitPriceOnFormat();
        SalesOrderSubform.UpdateKPI();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnInsertRecordEvent', '', false, false)]
    local procedure OnInsertRecordEvent_SalesOrderSubform(var Rec: Record "Sales Line"; BelowxRec: Boolean; var xRec: Record "Sales Line"; var AllowInsert: Boolean)
    begin
        if not AllowInsert then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec."PWD Linked Sales Line" := rec.GetLinkedSalesLine();
    end;
    //--Page50--
    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnAfterSetOpenPage', '', false, false)]
    local procedure OnAfterSetOpenPage_PurchaseOrder()
    var
        SalesQuoteSubform: Page "Purchase Order";
    begin
        SalesQuoteSubform.PWDSetDocNoVisible();
    end;
    //--Page95--
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote Subform", 'OnAfterValidateEvent', 'Unit Price', false, false)]
    local procedure OnAfterValidateEvent_SalesQuoteSubform_UnitPrice(var Rec: Record "Sales Line")
    var
        SalesQuoteSubform: Page "Sales Quote Subform";
    begin
        SalesQuoteSubform.UpdateKPI();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Quote Subform", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure OnAfterGetRecordEvent_SalesQuoteSubform(var Rec: Record "Sales Line")
    var
        SalesQuoteSubform: Page "Sales Quote Subform";
    begin
        SalesQuoteSubform.UpdateKPI();
    end;
    //--Page131--
    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shpt. Subform", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure OnAfterGetRecordEvent_SalesShptSubform(var Rec: Record "Sales Shipment Line")
    var
        SalesShptSubform: Page "Posted Sales Shpt. Subform";
    begin
        SalesShptSubform.DescriptionOnFormat();
    end;
    //--Page306--
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', false, false)]
    local procedure OnSetUsageFilterOnAfterSetFiltersByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Option)
    //ToDo
    begin
        /*        CASE ReportUsage2 OF
                    ReportUsage2::T5:
                        Rec.SETRANGE(Usage, Rec.Usage::T5);
                    ReportUsage2::TM:
                        Rec.SETRANGE(Usage, Rec.Usage::TM);
                    ReportUsage2::T1:
                        SETRANGE(Usage, Rec.Usage::T1);
                    ReportUsage2::TM:
                        SETRANGE(Usage, Rec.Usage::TM);
                    ReportUsage2::EX1:
                        SETRANGE(Usage, Rec.Usage::EX1);
                    ReportUsage2::EX9:
                        SETRANGE(Usage, Rec.Usage::EX9);
                    ReportUsage2::COM9:
                        SETRANGE(Usage, Rec.Usage::COM9);
                end;*/
    end;
    //--Page347--
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Purchase", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', false, false)]
    local procedure OnSetUsageFilterOnAfterSetFilterByReportUsage(var Rec: Record "Report Selections"; ReportUsage2: Enum "Report Selection Usage Purchase")
    begin
        CASE ReportUsage2 OF
            ReportUsage2::"Notice Investment":
                Rec.SETRANGE(Usage, Rec.Usage::"Notice Investment");
            ReportUsage2::COM7:
                Rec.SETRANGE(Usage, Rec.Usage::COM7);
        end;
    end;
    //--Page394--
    [EventSubscriber(ObjectType::Page, Page::"Entry/Exit Points", 'OnOpenPageEvent', '', false, false)]
    local procedure EntryExitPoints_OnOpenPageEvent(var Rec: Record "Entry/Exit Point")
    var
        EntryExitPoints: page "Entry/Exit Points";
    begin
        IF EntryExitPoints.LOOKUPMODE THEN EntryExitPoints.EDITABLE := FALSE;
    end;

    //--Page402--

    //--Page508--
    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterGetRecordEvent', '', false, false)]
    local procedure SalesOrderSubform_OnAfterGetRecordEvent(var Rec: Record "Sales Line")
    var
        PWDFunctionMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionMgt.UnitPriceOnFormat();
    end;
    //--Page6510--
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeClosePage', '', false, false)]
    local procedure OnBeforeClosePageEvent_ItemTrackingLines(var TrackingSpecification: Record "Tracking Specification"; var SkipWriteToDatabase: Boolean)
    var
        SalesLine2: record "Sales Line";
    begin
        IF TrackingSpecification."Source Type" = 37 THEN BEGIN
            SalesLine2.SETRANGE("Document Type", SalesLine2."Document Type"::Order);
            SalesLine2.SETRANGE("Document No.", TrackingSpecification."Source ID");
            SalesLine2.SETRANGE("Line No.", TrackingSpecification."Source Ref. No.");
            SalesLine2.SETRANGE(SalesLine2."No.", TrackingSpecification."Item No.");
            IF SalesLine2.FIND('-') THEN
                SalesLine2."PWD Origin Area" := TrackingSpecification."PWD Country Origin";
            SalesLine2."PWD Certificate Transit No." := TrackingSpecification."PWD Certificate Transit No.";
            SalesLine2.MODIFY();
        END;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeSetSourceSpec', '', false, false)]

    local procedure OnBeforeSetSourceSpec_ItemTrackingLines(var TrackingSpecification: Record "Tracking Specification"; var ReservationEntry: Record "Reservation Entry"; var ExcludePostedEntries: Boolean)
    begin
        ReservationEntry."PWD Country Origin" := TrackingSpecification."PWD Country Origin";
        ReservationEntry."PWD Certificate Transit No." := TrackingSpecification."PWD Certificate Transit No.";
        ReservationEntry."PWD Stocking Advice No." := TrackingSpecification."PWD Stocking Advice No.";
        ReservationEntry."PWD Lot No. Origin" := TrackingSpecification."PWD Origin Lot No.";
        ReservationEntry."Expiration Date" := TrackingSpecification."Expiration Date";
        ReservationEntry."Location Code" := TrackingSpecification."Location Code";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure OnAfterEntriesAreIdentical_ItemTrackingLines(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean)
    begin
        IdenticalArray[1] := (
        (ReservEntry1."Entry No." = ReservEntry2."Entry No.") AND
        (ReservEntry1."Item No." = ReservEntry2."Item No.") AND
        (ReservEntry1."Location Code" = ReservEntry2."Location Code") AND
        (ReservEntry1."Quantity (Base)" = ReservEntry2."Quantity (Base)") AND
        (ReservEntry1."Reservation Status" = ReservEntry2."Reservation Status") AND
        (ReservEntry1."Creation Date" = ReservEntry2."Creation Date") AND
        (ReservEntry1."Transferred from Entry No." = ReservEntry2."Transferred from Entry No.") AND
        (ReservEntry1."Source Type" = ReservEntry2."Source Type") AND
        (ReservEntry1."Source Subtype" = ReservEntry2."Source Subtype") AND
        (ReservEntry1."Source ID" = ReservEntry2."Source ID") AND
        (ReservEntry1."Source Batch Name" = ReservEntry2."Source Batch Name") AND
        (ReservEntry1."Source Prod. Order Line" = ReservEntry2."Source Prod. Order Line") AND
        (ReservEntry1."Source Ref. No." = ReservEntry2."Source Ref. No.") AND
        (ReservEntry1."Expected Receipt Date" = ReservEntry2."Expected Receipt Date") AND
        (ReservEntry1."Shipment Date" = ReservEntry2."Shipment Date") AND
        (ReservEntry1."Serial No." = ReservEntry2."Serial No.") AND
        (ReservEntry1."Created By" = ReservEntry2."Created By") AND
        (ReservEntry1."Changed By" = ReservEntry2."Changed By") AND
        (ReservEntry1.Positive = ReservEntry2.Positive) AND
        (ReservEntry1."Qty. per Unit of Measure" = ReservEntry2."Qty. per Unit of Measure") AND
        (ReservEntry1.Quantity = ReservEntry2.Quantity) AND
        (ReservEntry1."Action Message Adjustment" = ReservEntry2."Action Message Adjustment") AND
        (ReservEntry1.Binding = ReservEntry2.Binding) AND
        (ReservEntry1."Suppressed Action Msg." = ReservEntry2."Suppressed Action Msg.") AND
        (ReservEntry1."Planning Flexibility" = ReservEntry2."Planning Flexibility") AND
        (ReservEntry1."Lot No." = ReservEntry2."Lot No.") AND
        (ReservEntry1."Variant Code" = ReservEntry2."Variant Code") AND
        (ReservEntry1."Quantity Invoiced (Base)" = ReservEntry2."Quantity Invoiced (Base)") AND
        (ReservEntry1."PWD Country Origin" = ReservEntry2."PWD Country Origin") AND
        (ReservEntry1."PWD Certificate Transit No." = ReservEntry2."PWD Certificate Transit No.") AND
        (ReservEntry1."PWD Stocking Advice No." = ReservEntry2."PWD Stocking Advice No.") AND
        (ReservEntry1."PWD Lot No. Origin" = ReservEntry2."PWD Lot No. Origin") AND
        (ReservEntry1."Expiration Date" = ReservEntry2."Expiration Date"));
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCreateReservEntryFor', '', false, false)]
    local procedure OnAfterCreateReservEntryFor_ItemTrackingLines(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; var CreateReservEntry: Codeunit "Create Reserv. Entry")
    var
        PWDSetGetFunctions: codeunit "PWD Set/Get Functions";
    begin
        PWDSetGetFunctions.SetOriginArea(OldTrackingSpecification."PWD Country Origin");
        PWDSetGetFunctions.SetCertifTransit(OldTrackingSpecification."PWD Certificate Transit No.");
        PWDSetGetFunctions.SetStockingAdvice(OldTrackingSpecification."PWD Stocking Advice No.");
        PWDSetGetFunctions.SetLocationCode(OldTrackingSpecification."Location Code");
        PWDSetGetFunctions.SetButchery(OldTrackingSpecification."Expiration Date");
        PWDSetGetFunctions.SetButcheryOriginLot(OldTrackingSpecification."PWD Origin Lot No.");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields_ItemTrackingLines(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    begin
        ReservEntry."PWD Country Origin" := TrkgSpec."PWD Country Origin";
        ReservEntry."PWD Certificate Transit No." := TrkgSpec."PWD Certificate Transit No.";
        ReservEntry."PWD Stocking Advice No." := TrkgSpec."PWD Stocking Advice No.";
        ReservEntry."PWD Lot No. Origin" := TrkgSpec."PWD Origin Lot No.";
        ReservEntry."Expiration Date" := TrkgSpec."Expiration Date";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeCollectTempTrackingSpecificationInsert', '', false, false)]
    local procedure OnBeforeCollectTempTrackingSpecificationInsert_ItemTrackingLines(var TempTrackingSpecification: Record "Tracking Specification" temporary; ItemLedgerEntry: Record "Item Ledger Entry"; var TrackingSpecification: Record "Tracking Specification")
    begin
        TempTrackingSpecification."PWD Country Origin" := ItemLedgerEntry."PWD Origin";
        TempTrackingSpecification."PWD Country Origin" := ItemLedgerEntry."PWD Origin";
        TempTrackingSpecification."PWD Certificate Transit No." := ItemLedgerEntry."PWD Cetificate Transit No.";
        TempTrackingSpecification."PWD Stocking Advice No." := ItemLedgerEntry."PWD Notice Series No.";
        TempTrackingSpecification."PWD Origin Lot No." := ItemLedgerEntry."PWD Origin Lot No.";
        TrackingSpecification."Expiration Date" := ItemLedgerEntry."Expiration Date";
    end;
    //--Page9300--
    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeActionEvent', 'MakeOrder', false, false)]
    local procedure OnBeforeActionEvent_SalesQuote_Make_Order(var Rec: Record "Sales Header")
    var
        RecLSalesLines: Record "Sales Line";
        Gtext001: Label 'La ligne %1 pour l''article %2 ne possŠde pas de quantit‚.';
    begin
        RecLSalesLines.RESET();
        RecLSalesLines.SETRANGE("Document Type", Rec."Document Type");
        RecLSalesLines.SETRANGE("Document No.", Rec."No.");
        RecLSalesLines.SETRANGE(Type, RecLSalesLines.Type::Item);
        RecLSalesLines.SETFILTER(Quantity, '%1', 0);
        IF RecLSalesLines.FINDFIRST() THEN
            ERROR(Gtext001, RecLSalesLines."Line No.", RecLSalesLines."No.");
    end;
    //--Cdu90--
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertPostedHeaders', '', false, false)]
    local procedure OnAfterInsertPostedHeaders(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var PurchSetup: Record "Purchases & Payables Setup")
    var
        PWDSetGetFunctions: Codeunit "PWD Set/Get Functions";
    begin
        if PurchaseHeader.Invoice then
            if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice] then
                PWDSetGetFunctions.SetGenRef(PurchInvHeader."PWD Reference")
            else
                PWDSetGetFunctions.SetGenRef(PurchaseHeader."PWD Reference");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure CDU414_OnBeforeReleaseSalesDocEvent(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipCheckReleaseRestrictions: Boolean)
    var
        CduFunctiontMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontMgt.FCT_CDU414OnBeforeReleaseSalesDocEvent(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure CDU414_OnAfterReleaseSalesDocEvent(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        CduFunctiontMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontMgt.FCT_CDU414OnAfterReleaseSalesDocEvent(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseATOs', '', false, false)]
    local procedure CDU414_OnAfterReleaseATOsEvent(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; PreviewMode: Boolean)
    var
        CduFunctiontMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontMgt.TestDocumentAvita(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnReopenOnBeforeSalesHeaderModify', '', false, false)]
    local procedure CDU414_OnReopenOnBeforeSalesHeaderModifyEvent(var SalesHeader: Record "Sales Header")
    begin
        IF SalesHeader."PWD Preparation Status" = SalesHeader."PWD Preparation Status"::"Ready to prepare" THEN
            SalesHeader."PWD Preparation Status" := SalesHeader."PWD Preparation Status"::" ";
    end;
    //---CDU333---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertPurchOrderLineOnAfterTransferFromReqLineToPurchLine', '', false, false)]
    local procedure CDU333_OnInsertPurchOrderLineOnAfterTransferFromReqLineToPurchLine(var PurchOrderLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    var
        GPurchOrderLine: Record "Purchase Line";
    begin
        GPurchOrderLine."PWD Specific Cost" := PurchOrderLine."PWD Specific cost";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderLine', '', false, false)]
    local procedure CDU333_OnAfterInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; var NextLineNo: Integer; var RequisitionLine: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header")
    var
        CduFunctiontMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontMgt.FCT_CDU333OnAfterInsertPurchOrderLine(PurchOrderLine);
    end;
    //---CDU5703---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Catalog Item Management", 'OnCreateNewItemOnBeforeItemInsert', '', false, false)]
    local procedure CDU5703_OnCreateNewItemOnBeforeItemInsert(var Item: Record Item; NonstockItem: Record "Nonstock Item")
    var
        CduFunctiontMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontMgt.FCT_CDU5703OnCreateNewItemOnBeforeItemInsert(Item);
    end;
    //--cdu23--
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnBeforeCheckItemAvailabilityHandled', '', false, false)]
    local procedure OnBeforeCheckItemAvailabilityHandled(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    Var
        PWDFunctionMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionMgt.CtrlButchery(ItemJournalLine);
    end;
    //--CDU81--
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnConfirmPostOnBeforeSetSelection', '', false, false)]
    local procedure OnConfirmPostOnBeforeSetSelection(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Text1000000002: Label 'ENU=The order cannot be validated because the ordered quantity on Sales Line %1 doesn''t match the prepared quantity.';
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                begin
                    SalesLine.RESET();
                    SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                    SalesLine.SETFILTER(SalesLine."PWD Adjmt Prepared Qty", '<>%1', 0);
                    SalesLine.SETFILTER(SalesLine."PWD Butchery", '=%1', FALSE);
                    SalesLine.SETFILTER(SalesLine."PWD Trading Brand", '=%1', FALSE);
                    IF SalesLine.FIND('-') THEN
                        ERROR(Text1000000002, SalesLine."Line No.");
                end;
        end;
    end;
    //Table83
    [EventSubscriber(ObjectType::Table, DataBase::"Item Journal Line", 'OnAfterSetupNewLine', '', false, false)]
    local procedure OnAfterSetupNewLine(var ItemJournalLine: Record "Item Journal Line"; var LastItemJournalLine: Record "Item Journal Line"; ItemJournalTemplate: Record "Item Journal Template"; ItemJnlBatch: Record "Item Journal Batch")
    var
        InvSetup: Record "Inventory Setup";
        UserMgt: Codeunit "User Setup Management";
    begin
        InvSetup.GET;
        IF InvSetup."PWD Nom modele prestation" = ItemJournalLine."Journal Template Name" THEN BEGIN
            CASE ItemJournalLine."Entry Type" OF
                ItemJournalLine."Entry Type"::Purchase:
                    ItemJournalLine."Location Code" := UserMgt.GetLocation(1, '', UserMgt.GetPurchasesFilter);
                ItemJournalLine."Entry Type"::Sale:
                    ItemJournalLine."Location Code" := UserMgt.GetLocation(0, '', UserMgt.GetSalesFilter);
            end;
            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
            ItemJournalLine."PWD Code prestation" := ItemJnlBatch."PWD Code préstation";
            ItemJournalLine."PWD Code fournisseur" := ItemJnlBatch."PWD Code fournisseur";
            ItemJournalLine."PWD Code client" := ItemJnlBatch."PWD Code client";
        END;
    end;
}
