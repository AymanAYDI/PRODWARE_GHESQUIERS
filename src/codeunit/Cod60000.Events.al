codeunit 60000 "PWD Events"
{
    trigger OnRun()
    begin

    end;

    //---TAB27---
    [EventSubscriber(ObjectType::Table, DataBase::Item, 'OnAfterValidateEvent', 'Country/Region of Origin Code', false, false)]
    local procedure OnAfterValidateEvent_CountryRegionofOriginCode_Item(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    var
        CountryCode: Record "Country/Region";
    begin
        IF CountryCode.GET(Rec."Country/Region of Origin Code") THEN
            Rec."PWD Continental Code" := CountryCode."PWD Continental Code";
    end;

    //---TAB30---
    [EventSubscriber(ObjectType::Table, DataBase::"Item Translation", 'OnAfterValidateEvent', 'Description', false, false)]
    local procedure OnAfterValidateEvent_Description_ItemTranslation(var Rec: Record "Item Translation"; var xRec: Record "Item Translation"; CurrFieldNo: Integer)
    begin
        Rec.ChangeItemTranslation();
    end;

    //---TAB36---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeUpdateShipToAddressFromSellToAddress', 'Description', false, false)]
    local procedure OnBeforeUpdateShipToAddressFromSellToAddress(var SalesHeader: Record "Sales Header"; FieldNumber: Integer; var IsHandled: Boolean)
    begin
        IsHandled := false;
    end;

    //---TAB38---
    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnAfterValidateEvent', 'Buy-from Vendor No.', false, false)]
    local procedure OnAfterValidateEvent_BuyfromVendorNo_PurchaseHeader(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    var
        Vend: Record Vendor;
    begin
        Vend.Get(Rec."Buy-from Vendor No.");
        Rec."Transaction Type" := '11';
        Rec."Transaction Specification" := '11';
        Rec."Transport Method" := '3';
        Rec."Entry Point" := Vend."Country/Region Code";
        Rec.Area := '62';
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord_PurchaseHeader(var PurchHeader: Record "Purchase Header")
    begin
        PurchHeader."Posting Description" := PurchHeader."Buy-from Vendor Name" + ' ' + COPYSTR(PurchHeader."Buy-from City", 1, 15);
    end;

    //---TAB39---
    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEvent_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeUpdateSpecialSalesOrderLineFromOnDelete', '', false, false)]
    local procedure OnBeforeUpdateSpecialSalesOrderLineFromOnDelete_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        CduFunctiontsMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontsMgt.FctOnBeforeUpdateSpecialSalesOrderLineFromOnDeleteT39(PurchaseLine, SalesOrderLine);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Buy-from Vendor No.', false, false)]
    local procedure OnAfterValidateEvent_BuyfromVendorNo_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        Rec.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeValidateType', '', false, false)]
    local procedure OnBeforeValidateType_PurchaseLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        PurchaseLine.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeValidateNo', '', false, false)]
    local procedure OnBeforeValidateNo_PurchaseLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        PurchaseLine.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterInitHeaderDefaults', '', false, false)]
    local procedure OnAfterInitHeaderDefaults_PurchaseLine(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"; var TempPurchLine: record "Purchase Line" temporary)
    begin
        PurchLine."PWD Purchaser code" := PurchHeader."Purchaser Code";
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure OnCopyFromItemOnAfterCheck_PurchaseLine(PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    var
        VendorRec: Record Vendor;
    begin
        PurchaseLine."PWD Family" := Item."PWD Family";
        PurchaseLine."PWD Cle (restitution)" := Item."PWD Restitution Key";

        IF VendorRec.GET("PWD Buy-from Vendor No.") THEN
            PurchaseLine."PWD Origin" := VendorRec."Country/Region Code";
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure OnAfterValidateEvent_LocationCode_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        CduFunctiontsMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontsMgt.FctOnAfterValidateLocationCodeT39(Rec);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnValidateQuantityOnBeforeDropShptCheck', '', false, false)]
    local procedure OnValidateQuantityOnBeforeDropShptCheck_PurchaseLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        CduFunctiontsMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontsMgt.FctOnValidateQuantityOnBeforeDropShptCheckT39(PurchaseLine);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Qty. to Invoice', false, false)]
    local procedure OnAfterValidateEvent_QtytoInvoice_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        CduFunctiontsMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontsMgt.FctOnAfterValidateQtytoInvoiceT39(Rec);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    local procedure OnAfterValidateEvent_DirectUnitCost_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        Rec.VerifUnitCost();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Gross Weight', false, false)]
    local procedure OnAfterValidateEvent_GrossWeight_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        IF xRec."Gross Weight" <> Rec."Gross Weight" THEN
            Rec.MAJSalesDoc('G', Rec."Gross Weight");
        ;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Net Weight', false, false)]
    local procedure OnAfterValidateEvent_NetWeight_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        IF xRec."Net Weight" <> Rec."Net Weight" THEN
            Rec.MAJSalesDoc('N', Rec."Net Weight");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnValidateUnitOfMeasureCodeOnBeforeDropShipmentError', '', false, false)]
    local procedure OnValidateUnitOfMeasureCodeOnBeforeDropShipmentError_PurchaseLine(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer)
    begin
        PurchaseLine.VerifChange();
    end;

    //--TAB111---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Shipment Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEvent_SalesShipmentLine(var Rec: Record "Sales Shipment Line"; RunTrigger: Boolean)
    var
        RecGCustomer: Record Customer;
        RecGCountry: Record "Country/Region";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF RecGCustomer.GET(Rec."Sell-to Customer No.") THEN BEGIN
            RecGCountry.RESET();
            RecGCountry.SETFILTER("PWD Flag", RecGCustomer."PWD Flag");
            IF RecGCountry.FIND('-') THEN
                Rec.VALIDATE("PWD Monthly Code", RecGCountry."PWD Monthly Code");
        END;
    end;

    //--TAB112---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Invoice Header", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteEvent_SalesInvoiceHeader(var Rec: Record "Sales Invoice Header"; RunTrigger: Boolean)
    var
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec.TESTFIELD("No. Printed");
    end;

    //---TAB115---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Cr.Memo Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEvent_SalesCrMemoLine(var Rec: Record "Sales Cr.Memo Line"; RunTrigger: Boolean)
    var
        RecGCustomer: Record Customer;
        RecGCountry: Record "Country/Region";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF RecGCustomer.GET(Rec."Sell-to Customer No.") THEN BEGIN
            RecGCountry.RESET();
            RecGCountry.SETFILTER("PWD Flag", RecGCustomer."PWD Flag");
            IF RecGCountry.FIND('-') THEN
                Rec.VALIDATE(Rec."PWD Monthly Code", RecGCountry."PWD Monthly Code");
        END;
    end;

    //---TAB7001---
    [EventSubscriber(ObjectType::Table, DataBase::"Price List Line", 'OnAfterValidateEvent', 'Unit Price', false, false)]
    local procedure OnAfterValidateEvent_UnitPrice_PriceListLine(var Rec: Record "Price List Line"; var xRec: Record "Price List Line"; CurrFieldNo: Integer)
    begin
        IF (Rec."PWD Percentage Profit" <> 0) AND (Rec."PWD Percentage Profit" <> 100) THEN
            Rec."PWD Purch. Cost" := ROUND(Rec."Unit Price" * (1 - Rec."PWD Percentage Profit" / 100), 0.01, '<')
        ELSE
            Rec."PWD Purch. Cost" := ROUND(Rec."Unit Price", 0.01, '<');
    end;

    var
        myInt: Integer;
}