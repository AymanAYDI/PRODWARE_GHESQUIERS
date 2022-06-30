codeunit 60000 "PWD Events"
{
    trigger OnRun()
    begin

    end;

    //----TAB21---
    [EventSubscriber(ObjectType::Table, DataBase::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine_CustLedgerEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry."PWD Reference" := GenJournalLine."PWD Reference";
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
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeUpdateShipToAddressFromSellToAddress', '', false, false)]
    local procedure T36_OnBeforeUpdateShipToAddressFromSellToAddress_SalesHeader(var SalesHeader: Record "Sales Header"; FieldNumber: Integer; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnAfterOnInsert', '', false, false)]
    local procedure T36_OnAfterOnInsert_SalesHeader(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."PWD User Id" := USERID;

        SalesHeader."Doc. No. Occurrence" := 0;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter', '', false, false)]
    local procedure T36_OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter_SalesHeader(var SalesHeader: Record "Sales Header"; Customer: Record Customer; CallingFieldNo: Integer)
    begin
        SalesHeader."PWD Discount Profit %" := Customer."PWD Discount Profit %";
    end;


    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeUpdateLocationCode', '', false, false)]
    local procedure T36_OnBeforeUpdateLocationCode_SalesHeader(var SalesHeader: Record "Sales Header"; LocationCode: Code[10]; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeSetBillToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure T36_OnBeforeSetBillToCustomerAddressFieldsFromCustomer_SalesHeader(var SalesHeader: Record "Sales Header"; var BillToCustomer: Record Customer; var SkipBillToContact: Boolean; var IsHandled: Boolean; xSalesHeader: Record "Sales Header"; var GLSetup: Record "General Ledger Setup")
    begin
        SalesHeader."PWD Bill-to C/O" := BillToCustomer."PWD C/O";
        SalesHeader."PWD Bill-to Additional name" := BillToCustomer."PWD Additional name";
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnAfterSetFieldsBilltoCustomer', '', false, false)]
    local procedure T36_OnAfterSetFieldsBilltoCustomer_SalesHeader(var SalesHeader: Record "Sales Header"; Customer: Record Customer; xSalesHeader: Record "Sales Header")
    begin
        SalesHeader."Payment Method Code" := Customer."Payment Method Code";
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnValidateShipToCodeOnBeforeCopyShipToAddress', '', false, false)]
    local procedure T36_OnValidateShipToCodeOnBeforeCopyShipToAddress_SalesHeader(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header"; var CopyShipToAddress: Boolean)
    begin
        CopyShipToAddress := true;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeSetCustomerLocationCode', '', false, false)]
    local procedure T36_OnBeforeSetCustomerLocationCode_SalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr', '', false, false)]
    local procedure T36_OnBeforeCopyShipToCustomerAddressFieldsFromShipToAddr_SalesHeader(var SalesHeader: Record "Sales Header"; var ShipToAddress: Record "Ship-to Address"; var IsHandled: Boolean)
    begin
        SalesHeader."Ship-to Name" := ShipToAddress.Name;
        SalesHeader."Ship-to Name 2" := ShipToAddress."Name 2";
        SalesHeader."Ship-to Address" := ShipToAddress.Address;
        SalesHeader."Ship-to Address 2" := ShipToAddress."Address 2";
        SalesHeader."Ship-to City" := ShipToAddress.City;
        SalesHeader."Ship-to Post Code" := ShipToAddress."Post Code";
        SalesHeader."Ship-to County" := ShipToAddress.County;
        SalesHeader.Validate("Ship-to Country/Region Code", ShipToAddress."Country/Region Code");
        SalesHeader."Ship-to Contact" := ShipToAddress.Contact;
        SalesHeader."Shipping Agent Code" := ShipToAddress."Shipping Agent Code";
        SalesHeader."Shipping Agent Service Code" := ShipToAddress."Shipping Agent Service Code";
        if ShipToAddress."Tax Area Code" <> '' then
            SalesHeader."Tax Area Code" := ShipToAddress."Tax Area Code";
        SalesHeader."Tax Liable" := ShipToAddress."Tax Liable";

        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure T36_OnAfterValidateEvent_SalesHeader_PostingDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        Rec.UpdateSalesLines(Rec.FIELDCAPTION("Posting Date"), FALSE);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeValidateShippingAgentCode', '', false, false)]
    local procedure T36_OnBeforeValidateShippingAgentCode_SalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var xSalesHeader: Record "Sales Header"; CurrentFieldNo: Integer)
    begin
        IsHandled := true;

        if xSalesHeader."Shipping Agent Code" = SalesHeader."Shipping Agent Code" then
            exit;

        SalesHeader."Shipping Agent Service Code" := '';
        SalesHeader.GetShippingTime(SalesHeader.FieldNo("Shipping Agent Code"));

        SalesHeader.UpdateSalesLinesByFieldNo(SalesHeader.FieldNo("Shipping Agent Code"), CurrentFieldNo <> 0);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeValidateShippingNoSeries', '', false, false)]
    local procedure T36_OnBeforeValidateShippingNoSeries_SalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        IsHandled := true;
        if (SalesHeader."Shipping No. Series" <> '') AND (SalesHeader."PWD Call Type" = '') then begin
            SalesSetup.Get();
            SalesSetup.TestField("Posted Shipment Nos.");
            NoSeriesMgt.TestSeries(SalesSetup."Posted Shipment Nos.", SalesHeader."Shipping No. Series");
        end;
        SalesHeader.TestField("Shipping No.", '');
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeSalesLineInsert', '', false, false)]
    local procedure T36_OnBeforeSalesLineInsert_SalesHeader(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; SalesHeader: Record "Sales Header")
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctT36_OnBeforeSalesLineInsert_SalesHeader(SalesLine, TempSalesLine, SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnUpdateSalesLineByChangedFieldName', '', false, false)]
    local procedure T36_OnUpdateSalesLineByChangedFieldName_SalesHeader(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctT36_OnUpdateSalesLineByChangedFieldName_SalesHeader(SalesHeader, SalesLine, ChangedFieldName, ChangedFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeUpdateShipToAddress', '', false, false)]
    local procedure T36_OnBeforeUpdateShipToAddress_SalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; CurrFieldNo: Integer)
    begin
        IsHandled := true;
    end;

    //---TAB37---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T37_OnAfterInsertEvent_SalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesHeader: Record "Sales Header";
        Text1000000006: label 'No lines can be inserted or deleted if the order has already been prepared';
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        IF SalesHeader."PWD Order Prepared" = TRUE THEN
            ERROR(Text1000000006);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeModifyEvent', '', false, false)]
    local procedure T37_OnBeforeModifyEvent_SalesLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        PWDFunctionsMgt.FctT37_OnBeforeModifyEvent_SalesLine(Rec, xRec, RunTrigger);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure T37_OnAfterModifyEvent_SalesLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean)
    var
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        ReserveSalesLine.VerifyChange(Rec, xRec);

        Rec.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnDeleteOnBeforeTestStatusOpen', '', false, false)]
    local procedure T37_OnDeleteOnBeforeTestStatusOpen_SalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        Text1000000006: Label 'No lines can be inserted or deleted if the order has already been prepared';
    begin
        IF SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
            IF (SalesHeader."PWD Order Prepared" = TRUE) THEN
                IF SalesLine."Location Code" <> '' THEN
                    ERROR(Text1000000006);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure T37_OnAfterDeleteEvent_SalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        //*** ajout sca - Contremarque - c2a - suppression appel d'offre et demande de prix.
        IF Rec."Document Type" = Rec."Document Type"::Quote THEN
            Rec.Delete_Purchquote(Rec)
        ELSE
            Rec.DeleteAppTenders_quote();
        Rec.CheckavailforPriorityLocation(0, Rec, TRUE);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnValidateTypeOnAfterCheckItem', '', false, false)]
    local procedure T37_OnValidateTypeOnAfterCheckItem_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    begin
        SalesLine.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeValidateNo', '', false, false)]
    local procedure T37_OnBeforeValidateNo_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        SalesLine.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnValidateNoOnBeforeInitHeaderDefaults', '', false, false)]
    local procedure T37_OnValidateNoOnBeforeInitHeaderDefaults_SalesLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        RecCall: Record "PWD Call";
    begin
        SalesLine."PWD Call No." := SalesHeader."PWD Call No.";
        SalesLine.VALIDATE("PWD Call No.");
        SalesLine.VALIDATE("PWD Call Type", SalesHeader."PWD Call Type");
        SalesLine."PWD User Id" := SalesHeader."PWD User Id";
        SalesLine."PWD Document Date" := SalesHeader."Document Date";
        SalesLine."Posting Date" := SalesHeader."Posting Date";
        IF SalesLine."PWD Call No." <> '' THEN begin
            RecCall.GET(SalesLine."PWD Call No.");
            SalesLine."PWD Monthly Code" := RecCall."Monthly Code";
        end;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterInitHeaderDefaults', '', false, false)]
    local procedure T37_OnAfterInitHeaderDefaults_SalesLine(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; xSalesLine: Record "Sales Line")
    var
        Item: record Item;
        SKU: Record "Stockkeeping Unit";
    begin
        IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
            SalesLine.GetItem(Item);
            IF (Item."PWD Trading Brand" = TRUE) OR (Item."PWD Butchery" = TRUE) OR (SalesLine."Special Order Purchase No." <> '') THEN BEGIN
                SalesLine.VALIDATE("Location Code", SalesHeader."Location Code");
                IF SalesLine.GetSKU(SKU) THEN
                    SalesLine.VALIDATE("Unit Cost (LCY)", SKU."Unit Cost");
            END;
        END;
        IF SalesLine."PWD Call Type" = '' THEN
            SalesLine."Location Code" := SalesHeader."Location Code";

        SalesLine."PWD Sell-to Country Code" := SalesHeader."Sell-to Country/Region Code";
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure T37_OnCopyFromItemOnAfterCheck_SalesLine(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctT37_OnCopyFromItemOnAfterCheck_SalesLine(SalesLine, Item);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]

    local procedure T37_OnAfterCopyFromItem_SalesLine(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctT37_OnAfterCopyFromItem_SalesLine(SalesLine, Item, CurrentFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnValidateNoOnAfterUpdateUnitPrice', '', false, false)]

    local procedure T37_OnValidateNoOnAfterUpdateUnitPrice_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctT37_OnValidateNoOnAfterUpdateUnitPrice_SalesLine(SalesLine, xSalesLine, TempSalesLine);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeValidateEvent', 'Location Code', false, false)]

    local procedure T37_OnBeforeValidateEvent_SalesLine_LocationCode(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctT37_OnBeforeValidateEvent_SalesLine_LocationCode(Rec, xRec, CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnValidateQuantityOnBeforeCheckAssocPurchOrder', '', false, false)]
    local procedure T37_OnValidateQuantityOnBeforeCheckAssocPurchOrder_SalesLine(var SalesLine: Record "Sales Line")
    var
        SetGetFunctions: codeunit "PWD Set/Get Functions";
        MemLineDiscount: Decimal;
        MemUnitPrice: Decimal;
    begin
        MemLineDiscount := SalesLine."Line Discount %";
        SetGetFunctions.SetMemLineDiscount(MemLineDiscount);
        MemUnitPrice := SalesLine."Unit Price";
        SetGetFunctions.SetMemUnitPrice(MemUnitPrice);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnValidateQuantityOnBeforeCheckReceiptOrderStatus', '', false, false)]
    local procedure T37_OnValidateQuantityOnBeforeCheckReceiptOrderStatus_SalesLine(var SalesLine: Record "Sales Line"; StatusCheckSuspended: Boolean; var IsHandled: Boolean)
    var
        Text002: Label 'You cannot change %1 because the order line is associated with purchase order %2 line %3.';
    begin
        IF NOT StatusCheckSuspended THEN
            IF (SalesLine."Special Order Purch. Line No." <> 0)
             THEN
                ERROR(
                  Text002,
                   SalesLine.FIELDCAPTION(Quantity), SalesLine."Purchase Order No.");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnValidateQuantityOnBeforeSalesLineVerifyChange', '', false, false)]
    local procedure T37_OnValidateQuantityOnBeforeSalesLineVerifyChange_SalesLine(var SalesLine: Record "Sales Line"; StatusCheckSuspended: Boolean; var IsHandled: Boolean)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctT37_OnValidateQuantityOnBeforeSalesLineVerifyChange_SalesLine(SalesLine, StatusCheckSuspended, IsHandled);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeValidateEvent', 'Unit Price', false, false)]
    local procedure T37_OnBeforeValidateEvent_SalesLine_UnitPrice(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        SetGetFunctions: Codeunit "PWD Set/Get Functions";
        SalesHeader: Record "Sales Header";
    //HeaderWasReleased: Boolean;
    begin
        IF CurrFieldNo = Rec.FIELDNO("Unit Price") THEN BEGIN
            //Rec.GetSalesHeader;
            SalesHeader.GET(Rec."Document Type", Rec."Document No.");
            IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                SetGetFunctions.SetHeaderWasReleased(TRUE);
                Rec.SuspendStatusCheck(TRUE);
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterValidateEvent', 'Unit Price', false, false)]

    local procedure T37_OnAfterValidateEvent_SalesLine_UnitPrice(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        SetGetFunctions: Codeunit "PWD Set/Get Functions";
    //HeaderWasReleased: Boolean;//TODO Reste a tester
    begin
        IF Rec.Quantity <> 0 THEN
            Rec.CtrlUnitPrice();
        IF SetGetFunctions.GetHeaderWasReleased() THEN BEGIN
            SetGetFunctions.SetHeaderWasReleased(FALSE);
            Rec.SuspendStatusCheck(FALSE);
        END;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterValidateEvent', 'Unit Cost (LCY)', false, false)]

    local procedure T37_OnAfterValidateEvent_SalesLine_UnitCostLCY(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        Rec.CalcRealisedProfit();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterValidateEvent', 'Drop Shipment', false, false)]

    local procedure T37_OnAfterValidateEvent_SalesLine_DropShipment(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        Rec.VALIDATE("PWD Trading Brand");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterValidateEvent', 'Line Amount', false, false)]

    local procedure T37_OnAfterValidateEvent_SalesLine_LineAmount(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        Rec.CalcRealisedProfit();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeValidateEvent', 'Unit of Measure Code', false, false)]
    local procedure T37_OnBeforeValidateEvent_SalesLine_UnitofMeasureCode(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
    begin
        Rec.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnValidatePurchasingCodeOnAfterAssignPurchasingFields', '', false, false)]
    local procedure T37_OnValidatePurchasingCodeOnAfterAssignPurchasingFields_SalesLine(var SalesLine: Record "Sales Line"; PurchasingCode: Record Purchasing; var IsHandled: Boolean)
    var
    begin
        SalesLine.VALIDATE("Location Code", PurchasingCode."PWD Location Code");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnValidatePurchasingCodeOnAfterSetReserveWithoutPurchasingCode', '', false, false)]
    local procedure T37_OnValidatePurchasingCodeOnAfterSetReserveWithoutPurchasingCode_SalesLine(var SalesLine: Record "Sales Line")
    var
    begin
        SalesLine.VALIDATE("PWD Trading Brand");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterValidateEvent', 'Special Order', false, false)]

    local procedure T37_OnAfterValidateEvent_SalesLine_SpecialOrder(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        Rec.VALIDATE("PWD Trading Brand");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterUpdateAmountsDone', '', false, false)]
    local procedure T37_OnAfterUpdateAmountsDone_SalesLine(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
    begin
        SalesLine.CalcRealisedProfit();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeGetUnitCost', '', false, false)]
    local procedure T37_OnBeforeGetUnitCost_SalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctT37_OnBeforeGetUnitCost_SalesLine(SalesLine, IsHandled);
    end;


    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnBeforeGetItemTranslation', '', false, false)]
    local procedure T37_OnBeforeGetItemTranslation_SalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        IsHandled := true;
        SalesLine.GetItem(Item);
        SalesLine.Description := Item.Description;
        SalesLine."Description 2" := Item."Description 2";
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
    local procedure TAB39_OnAfterModifyEvent_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeUpdateSpecialSalesOrderLineFromOnDelete', '', false, false)]
    local procedure TAB39_OnBeforeUpdateSpecialSalesOrderLineFromOnDelete_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctOnBeforeUpdateSpecialSalesOrderLineFromOnDeleteT39(PurchaseLine, SalesOrderLine);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Buy-from Vendor No.', false, false)]
    local procedure TAB39_OnAfterValidateEvent_BuyfromVendorNo_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        Rec.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeValidateType', '', false, false)]
    local procedure TAB39_OnBeforeValidateType_PurchaseLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        PurchaseLine.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeValidateNo', '', false, false)]
    local procedure TAB39_OnBeforeValidateNo_PurchaseLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        PurchaseLine.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterInitHeaderDefaults', '', false, false)]
    local procedure TAB39_OnAfterInitHeaderDefaults_PurchaseLine(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"; var TempPurchLine: record "Purchase Line" temporary)
    begin
        PurchLine."PWD Purchaser code" := PurchHeader."Purchaser Code";
    end;

    //[EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    //local procedure TAB39_OnCopyFromItemOnAfterCheck_PurchaseLine(PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterAssignItemValues', '', false, false)]
    local procedure TAB39_OnAfterAssignItemValues_PurchaseLine(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer; PurchHeader: Record "Purchase Header")
    var
        VendorRec: Record Vendor;
    begin
        PurchLine."PWD Family" := Item."PWD Family";
        PurchLine."PWD Cle (restitution)" := Item."PWD Restitution Key";

        IF VendorRec.GET(PurchLine."Buy-from Vendor No.") THEN
            PurchLine."PWD Origin" := VendorRec."Country/Region Code";

        //PurchLine.Modify();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Location Code', false, false)]
    local procedure TAB39_OnAfterValidateEvent_LocationCode_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctOnAfterValidateLocationCodeT39(Rec);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnValidateQuantityOnBeforeDropShptCheck', '', false, false)]
    local procedure TAB39_OnValidateQuantityOnBeforeDropShptCheck_PurchaseLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctOnValidateQuantityOnBeforeDropShptCheckT39(PurchaseLine);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Qty. to Invoice', false, false)]
    local procedure TAB39_OnAfterValidateEvent_QtytoInvoice_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt.FctOnAfterValidateQtytoInvoiceT39(Rec);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Direct Unit Cost', false, false)]
    local procedure TAB39_OnAfterValidateEvent_DirectUnitCost_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        Rec.VerifUnitCost();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Gross Weight', false, false)]
    local procedure TAB39_OnAfterValidateEvent_GrossWeight_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        IF xRec."Gross Weight" <> Rec."Gross Weight" THEN
            Rec.MAJSalesDoc('G', Rec."Gross Weight");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterValidateEvent', 'Net Weight', false, false)]
    local procedure TAB39_OnAfterValidateEvent_NetWeight_PurchaseLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        IF xRec."Net Weight" <> Rec."Net Weight" THEN
            Rec.MAJSalesDoc('N', Rec."Net Weight");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnValidateUnitOfMeasureCodeOnBeforeDropShipmentError', '', false, false)]
    local procedure TAB39_OnValidateUnitOfMeasureCodeOnBeforeDropShipmentError_PurchaseLine(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer)
    begin
        PurchaseLine.VerifChange();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnBeforeUpdateUnitCost', '', false, false)]
    local procedure TAB39_OnBeforeUpdateUnitCost_PurchaseLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF PurchaseLine."PWD Specific Cost" THEN
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterUpdateAmountsDone', '', false, false)]
    local procedure TAB39_OnAfterUpdateAmountsDone_PurchaseLine(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        PurchLine.VerifUnitCost();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnAfterGetItemTranslation', '', false, false)]
    local procedure TAB39_OnAfterGetItemTranslation_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; ItemTranslation: Record "Item Translation")
    var
        Item: Record Item;
    begin
        Item.GET(PurchaseLine."No.");
        PurchaseLine."PWD Designation FR" := Item.Description;
    end;


    //--TAB111---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Shipment Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEvent_SalesShipmentLine(var Rec: Record "Sales Shipment Line"; RunTrigger: Boolean)
    var
        RecGCountry: Record "Country/Region";
        RecGCustomer: Record Customer;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF RecGCustomer.GET(Rec."Sell-to Customer No.") THEN BEGIN
            RecGCountry.RESET();
            RecGCountry.SETFILTER("PWD Flag", RecGCustomer."PWD Flag");
            IF RecGCountry.FindFirst() THEN
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
        RecGCountry: Record "Country/Region";
        RecGCustomer: Record Customer;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF RecGCustomer.GET(Rec."Sell-to Customer No.") THEN BEGIN
            RecGCountry.RESET();
            RecGCountry.SETFILTER("PWD Flag", RecGCustomer."PWD Flag");
            IF RecGCountry.FindFirst() THEN
                Rec.VALIDATE(Rec."PWD Monthly Code", RecGCountry."PWD Monthly Code");
        END;
    end;

    //---TAB7001---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Price", 'OnAfterValidateEvent', 'Unit Price', false, false)]
    local procedure OnAfterValidateEvent_UnitPrice_PriceListLine(var Rec: Record "Sales Price"; var xRec: Record "Sales Price"; CurrFieldNo: Integer)
    begin
        IF (Rec."PWD Percentage Profit" <> 0) AND (Rec."PWD Percentage Profit" <> 100) THEN
            Rec."PWD Purch. Cost" := ROUND(Rec."Unit Price" * (1 - Rec."PWD Percentage Profit" / 100), 0.01, '<')
        ELSE
            Rec."PWD Purch. Cost" := ROUND(Rec."Unit Price", 0.01, '<');
    end;

    //---CDU21---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckEmptyQuantity', '', false, false)]
    local procedure CDU21_OnBeforeCheckEmptyQuantity_ItemJnlCheckLine(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //---CDU22---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeRunWithCheck', '', false, false)]
    local procedure CDU22_OnBeforeRunWithCheck_ItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; CalledFromApplicationWorksheet: Boolean; PostponeReservationHandling: Boolean; var IsHandled: Boolean)
    var
        FunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        FunctionsMgt.InsertInventoryPerLocation(ItemJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnCodeOnBeforeCheckItemTracking', '', false, false)]
    local procedure CDU22_OnCodeOnBeforeCheckItemTracking_ItemJnlPostLine(var ItemJnlLine: Record "Item Journal Line"; DisableItemTracking: Boolean; var IsHandled: Boolean; var TempTrackingSpecification: Record "Tracking Specification"; var ItemTrackingSetup: Record "Item Tracking Setup")
    var
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        FunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        IsHandled := true;
        if ItemTrackingSetup.TrackingRequired() and (ItemJnlLine."Quantity (Base)" <> 0) and
            (ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::"Direct Cost") and
            not DisableItemTracking and not ItemJnlLine.Adjustment and
            not ItemJnlLine.Subcontracting and not ItemJnlLine.IsAssemblyResourceConsumpLine()
        then begin
            ItemJnlPostLine.CheckItemTracking();
            FunctionsMgt.TestExpirationDate(ItemJnlLine);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeCheckRunItemValuePosting', '', false, false)]
    local procedure CDU22_OnBeforeCheckRunItemValuePosting_ItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        RecLInventorySetup: Record "Inventory Setup";
        ItemJnlPostLine: codeunit "Item Jnl.-Post Line";
    begin
        RecLInventorySetup.GET();
        IF RecLInventorySetup."PWD Nom modele prestation" = ItemJournalLine."Journal Template Name" THEN begin
            ItemJnlPostLine.ItemValuePosting();
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnItemQtyPostingOnAfterCalcInsertItemLedgEntryNeeded', '', false, false)]
    local procedure CDU22_OnItemQtyPostingOnAfterCalcInsertItemLedgEntryNeeded_ItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; var InsertItemLedgEntryNeeded: Boolean)
    var
        RecLInventorySetup: Record "Inventory Setup";
    begin
        RecLInventorySetup.GET();
        InsertItemLedgEntryNeeded := ((RecLInventorySetup."PWD Nom modele prestation" = ItemJournalLine."Journal Template Name") AND (NOT ItemJournalLine."Phys. Inventory")) OR ((NOT ItemJournalLine."Phys. Inventory") OR (ItemJournalLine.Quantity <> 0));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure CDU22_OnAfterInitItemLedgEntry_ItemJnlPostLine(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    var
        FunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        FunctionsMgt.FctCDU22_OnAfterInitItemLedgEntry_ItemJnlPostLine(NewItemLedgEntry, ItemJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertItemRegOnBeforeItemRegInsert', '', false, false)]
    local procedure CDU22_OnInsertItemRegOnBeforeItemRegInsert_ItemJnlPostLine(var ItemRegister: Record "Item Register"; var ItemJournalLine: Record "Item Journal Line")
    var
        RecLInventorySetup: Record "Inventory Setup";
    begin
        RecLInventorySetup.GET();
        IF ItemJournalLine."Journal Template Name" = RecLInventorySetup."PWD Nom modele prestation" THEN
            ItemRegister."PWD Generate Export File" := TRUE;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInitValueEntryOnAfterAssignFields', '', false, false)]
    local procedure CDU22_OnInitValueEntryOnAfterAssignFields_ItemJnlPostLine(var ValueEntry: Record "Value Entry"; ItemLedgEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line")
    begin
        ValueEntry."PWD Code prestation" := ItemJnlLine."PWD Code prestation";
        ValueEntry."PWD Code fournisseur" := ItemJnlLine."PWD Code fournisseur";
        ValueEntry."PWD Code client" := ItemJnlLine."PWD Code client";
        ValueEntry."PWD Family Code" := ItemJnlLine."PWD Family Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure CDU22_OnBeforeInsertSetupTempSplitItemJnlLine_ItemJnlPostLine(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempItemJournalLine: Record "Item Journal Line" temporary; var PostItemJnlLine: Boolean; var ItemJournalLine2: Record "Item Journal Line"; SignFactor: Integer; FloatingFactor: Decimal)
    begin
        TempItemJournalLine."PWD Notice Series No." := TempTrackingSpecification."PWD Stocking Advice No.";
        TempItemJournalLine."PWD Origin" := TempTrackingSpecification."PWD Country Origin";
        TempItemJournalLine."PWD Cetificate Transit No." := TempTrackingSpecification."PWD Certificate Transit No.";
        TempItemJournalLine."PWD Origin Lot No." := TempTrackingSpecification."PWD Origin Lot No.";
        TempItemJournalLine."PWD Meat Family" := TempTrackingSpecification."PWD Meat Family";
        TempItemJournalLine."PWD Meat Type" := TempTrackingSpecification."PWD Meat Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeIsInterimRevaluation', '', false, false)]
    local procedure CDU22_OnBeforeIsInterimRevaluation_ItemJnlPostLine(ItemJnlLine: Record "Item Journal Line"; var Result: Boolean; var IsHandled: Boolean)
    var
        RecLInventorySetup: Record "Inventory Setup";
    begin
        RecLInventorySetup.GET();
        IsHandled := true;
        IF RecLInventorySetup."PWD Nom modele prestation" = ItemJnlLine."Journal Template Name" then
            Result := false
        else
            if (ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::Revaluation) and (ItemJnlLine.Quantity <> 0) then
                Result := true
            else
                Result := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnPostItemOnBeforeTransferReservFromJobPlanningLine', '', false, false)]
    local procedure CDU22_OnPostItemOnBeforeTransferReservFromJobPlanningLine_ItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        RecLInventorySetup: Record "Inventory Setup";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
    begin
        RecLInventorySetup.GET();
        IF RecLInventorySetup."PWD Nom modele prestation" = ItemJournalLine."Journal Template Name" then
            if (ItemJournalLine.Quantity = 0) and
               (ItemJournalLine."Item Charge No." = '') and
               not (ItemJournalLine."Value Entry Type" in [ItemJournalLine."Value Entry Type"::Revaluation, ItemJournalLine."Value Entry Type"::Rounding]) and
               not ItemJournalLine.Adjustment
            then
                ItemJnlPostLine.ItemQtyPosting();
    end;
    //---CDU80---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCheckMandatoryHeaderFields', '', false, false)]
    local procedure CDU80_OnBeforeCheckMandatoryHeaderFields_SalesPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        FunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        FunctionsMgt.CalcAvailability(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterCheckMandatoryFields', '', false, false)]
    local procedure CDU80_OnAfterCheckMandatoryFields_SalesPost(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            SalesHeader.TESTFIELD("PWD Preparation Status", SalesHeader."PWD Preparation Status"::"Ready to ship");


        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            SalesHeader.TESTFIELD("PWD Preparation in process", TRUE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeCalcInvoice', '', false, false)]
    local procedure CDU80_OnBeforeCalcInvoice_SalesPost(SalesHeader: Record "Sales Header"; TempSalesLineGlobal: Record "Sales Line" temporary; var NewInvoice: Boolean; var IsHandled: Boolean)
    var
        FunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        FunctionsMgt.FctCDU80_OnBeforeCalcInvoice_SalesPost(SalesHeader, TempSalesLineGlobal, NewInvoice, IsHandled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    local procedure CDU80_OnBeforeSalesShptHeaderInsert_SalesPost(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; WhseShip: Boolean; InvtPickPutaway: Boolean)
    begin
        IF SalesShptHeader."PWD Seafrance Order No." <> '' THEN
            SalesShptHeader."PWD Generate Export File" := TRUE;
    end;

    //TODO Vérifier l'event utilisé
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeTestUnitOfMeasureCode', '', false, false)]
    local procedure CDU80_OnBeforeSalesShptHeaderInsertOnPostSalesLineOnBeforeTestUnitOfMeasureCode_SalesPost(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var TempSalesLineGlobal: Record "Sales Line" temporary)
    var
        Item: Record Item;
        Location: Record Location;
        Text1000000005: Label 'Le prix de l''article %1 (ligne %2) est inférieur au prix plancher (%3).';
        Text1000000006: Label 'Le prix de l''article %1 (ligne %2) ne pas être nul.';
        Error1: text;
        Error2: text;
    begin
        IF Item.GET(SalesLine."No.") AND Location.GET(SalesLine."Location Code") THEN
            IF (Location."PWD Controle du prix plancher" = TRUE) THEN BEGIN
                IF (Item."PWD Bottom Price" <> 0) AND (SalesLine."Unit Price" < Item."PWD Bottom Price") THEN BEGIN
                    Error1 := STRSUBSTNO(Text1000000005, SalesLine."No.", SalesLine."Line No.", Item."PWD Bottom Price");
                    //ERROR(STRSUBSTNO(Text1000000005, SalesLine."No.", SalesLine."Line No.", Item."PWD Bottom Price"));
                    ERROR(Error1);
                END;
                IF (SalesLine."Unit Price" = 0) THEN BEGIN
                    Error2 := STRSUBSTNO(Text1000000006, SalesLine."No.", SalesLine."Line No.");
                    //ERROR(STRSUBSTNO(Text1000000006, SalesLine."No.", SalesLine."Line No."));
                    ERROR(Error2);
                END;
            END;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Res. Journal Line", 'OnAfterCopyResJnlLineFromSalesLine', '', false, false)]
    local procedure TAB207_OnAfterCopyResJnlLineFromSalesLine_ResJournalLine(var SalesLine: Record "Sales Line"; var ResJnlLine: Record "Res. Journal Line")
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        ResJnlLine."PWD Reference" := SalesHeader."PWD Reference";
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Shipment Line", 'OnAfterInitFromSalesLine', '', false, false)]
    local procedure TAB111_OnAfterInitFromSalesLine_SalesShipmentLine(SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        IF SalesShptLine.Quantity = 0 THEN
            SalesShptLine."PWD Quantity Seafrance" := 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', false, false)]
    local procedure CDU80_OnBeforeSalesShptLineInsert_SalesPost(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; ItemLedgShptEntryNo: Integer; xSalesLine: record "Sales Line"; var TempSalesLineGlobal: record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        IF SalesShptLine."Line Discount %" <> 0 THEN
            SalesShptLine."PWD Line Amount" := (SalesShptLine.Quantity * SalesShptLine."Unit Price") * (1 - (SalesShptLine."Line Discount %") / 100)
        ELSE
            SalesShptLine."PWD Line Amount" := (SalesShptLine.Quantity * SalesShptLine."Unit Price");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure TAB81_OnAfterCopyGenJnlLineFromSalesHeader_GenJournalLine(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."PWD Reference" := SalesHeader."PWD Reference";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeUpdateWhseDocuments', '', false, false)]
    local procedure CDU80_OnBeforeUpdateWhseDocuments_SalesPost(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; WhseReceive: Boolean; WhseShip: Boolean; WhseRcptHeader: Record "Warehouse Receipt Header"; WhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary)
    var
        AutoArchiveManagement: Codeunit "PWD ArchiveAutoManagement";
    begin
        AutoArchiveManagement.StoreSalesDocument(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLineOnBeforeCopyTrackingFromSpec', '', false, false)]
    local procedure CDU80_OnPostItemJnlLineOnBeforeCopyTrackingFromSpec_SalesPost(TrackingSpecification: Record "Tracking Specification"; var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        ItemJnlLine."Expiration Date" := TrackingSpecification."Expiration Date";
        ItemJnlLine."PWD Seafrance Order No." := SalesHeader."PWD Seafrance Order No.";
        ItemJnlLine."PWD Seafrance Order Line No." := SalesLine."PWD Seafrance Order Line No.";

        IF SalesInvHeader."PWD Reference" <> '' THEN
            ItemJnlLine."PWD Reference" := SalesInvHeader."PWD Reference"
        else
            if SalesCrMemoHeader."PWD Reference" <> '' THEN
                ItemJnlLine."PWD Reference" := SalesCrMemoHeader."PWD Reference";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLineOnAfterCopyDocumentFields', '', false, false)]
    local procedure CDU80_OnPostItemJnlLineOnAfterCopyDocumentFields_SalesPost(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        SalesHeader: Record "Sales Header";
    begin
        IF ItemJournalLine."PWD Reference" = '' THEN BEGIN
            SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
            ItemJournalLine."PWD Reference" := SalesHeader."PWD Reference";
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLineOnBeforeIsJobContactLineCheck', '', false, false)]
    local procedure CDU80_OnPostItemJnlLineOnBeforeIsJobContactLineCheck_SalesPost(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var ShouldPostItemJnlLine: Boolean)
    begin
        ItemJnlLine."PWD Family Code" := SalesLine."PWD Family";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostItemChargePerOrder', '', false, false)]
    local procedure CDU80_OnBeforePostItemChargePerOrder_SalesPost(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var ItemJnlLine2: Record "Item Journal Line"; var ItemChargeSalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean)
    begin
        ItemJnlLine2."PWD Reference" := SalesHeader."PWD Reference";
    end;


    //---CDU81---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
    local procedure CDU81_OnBeforeConfirmSalesPost_SalesPostYesNo(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN
            PWDFunctionsMgt.ControlProfit(SalesHeader);
        PWDFunctionsMgt.CtrlUnitPrice(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnConfirmPostOnBeforeSetSelection', '', false, false)]
    local procedure CDU81_OnConfirmPostOnBeforeSetSelection_SalesPostYesNo(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Text1000000002: Label 'The order cannot be validated because the ordered quantity on Sales Line %1 doesn''t match the prepared quantity.';
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
                    IF SalesLine.FindFirst() THEN
                        ERROR(Text1000000002, SalesLine."Line No.");
                end;
        end;
    end;

    //---CDU82---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPost', '', false, false)]
    local procedure CDU82_OnBeforeConfirmPost_SalesPostPrint(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var SendReportAsEmail: Boolean; var DefaultOption: Integer)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN
            PWDFunctionsMgt.ControlProfit(SalesHeader);
        PWDFunctionsMgt.CtrlUnitPrice(SalesHeader);
    end;

    //---CDU86---
    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeInitFromSalesHeader', '', false, false)]
    local procedure TAB36_OnBeforeInitFromSalesHeader_SalesHeader(var SalesHeader: Record "Sales Header"; SourceSalesHeader: Record "Sales Header")
    begin
        SalesHeader."Posting No. Series" := SourceSalesHeader."Posting No. Series";
        SalesHeader."Shipping No. Series" := SourceSalesHeader."Shipping No. Series";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeModifySalesOrderHeader', '', false, false)]
    local procedure CDU86_OnBeforeModifySalesOrderHeader_SalesQuotetoOrder(var SalesOrderHeader: Record "Sales Header"; SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderHeader."Document Date" := SalesOrderHeader."Posting Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure CDU86_OnBeforeInsertSalesOrderLine_SalesQuotetoOrder(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt."Fct_OnBeforeInsertSalesOrderLine_SalesQuotetoOrder"(SalesOrderLine, SalesOrderHeader, SalesQuoteLine, SalesQuoteHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeDeleteSalesQuote', '', false, false)]
    local procedure CDU86_OnBeforeDeleteSalesQuote_SalesQuotetoOrder(var QuoteSalesHeader: Record "Sales Header"; var OrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SalesQuoteLine: Record "Sales Line")
    var
        AutoArchiveManagement: Codeunit "PWD ArchiveAutoManagement";
    begin
        AutoArchiveManagement.StoreSalesDocument(QuoteSalesHeader);
    end;

    //---CDU90---
    [EventSubscriber(ObjectType::Table, DataBase::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', false, false)]
    local procedure TAB81_OnAfterCopyGenJnlLineFromPurchHeader_GenJournalLine(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."PWD Reference" := PurchaseHeader."PWD Reference";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeDeleteApprovalEntries', '', false, false)]
    local procedure CDU90_OnBeforeDeleteApprovalEntries_PurchPost(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        AutoArchiveManagement: Codeunit "PWD ArchiveAutoManagement";
    begin
        AutoArchiveManagement.StorePurchDocument(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure CDU90_OnAfterFinalizePosting_PurchPost(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        FunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        IF (PurchHeader."Document Type" IN [PurchHeader."Document Type"::Order]) AND (NOT PurchHeader.Invoice) THEN BEGIN
            PurchHeader."PWD Reception OK" := FunctionsMgt.AllReceive(PurchHeader);
            PurchHeader.MODIFY();
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeInsertInvoiceHeader', '', false, false)]
    local procedure CDU90_OnBeforeInsertInvoiceHeader_PurchPost(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var IsHandled: Boolean; var Window: Dialog; var HideProgressWindow: Boolean; var SrcCode: Code[10]; var PurchCommentLine: Record "Purch. Comment Line"; var RecordLinkManagement: Codeunit "Record Link Management")
    var
        SetGetFunctions: codeunit "PWD Set/Get Functions";
    begin
        SetGetFunctions.SetGenRef(PurchInvHeader."PWD Reference");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeInserCrMemoHeader', '', false, false)]
    local procedure CDU90_OnBeforeInserCrMemoHeader_PurchPost(var PurchHeader: Record "Purchase Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var HideProgressWindow: Boolean; var Window: Dialog; var IsHandled: Boolean; SrcCode: Code[10]; PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; var PurchCommentLine: Record "Purch. Comment Line")
    var
        SetGetFunctions: codeunit "PWD Set/Get Functions";
    begin
        SetGetFunctions.SetGenRef(PurchHeader."PWD Reference");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostInvoicePostBufferLineOnAfterCopyFromInvoicePostBuffer', '', false, false)]
    local procedure CDU90_OnPostInvoicePostBufferLineOnAfterCopyFromInvoicePostBuffer_PurchPost(var GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Purchase Header"; var TempPurchLineGlobal: Record "Purchase Line")
    var
        SetGetFunctions: codeunit "PWD Set/Get Functions";
    begin
        GenJnlLine."PWD Reference" := SetGetFunctions.GetGenRef();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemJnlLineOnAfterPrepareItemJnlLine', '', false, false)]
    local procedure CDU90_OnPostItemJnlLineOnAfterPrepareItemJnlLine_PurchPost(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var GenJnlLineDocNo: code[20]; TrackingSpecification: Record "Tracking Specification"; QtyToBeReceived: Decimal)
    var
        SetGetFunctions: codeunit "PWD Set/Get Functions";
    begin
        if QtyToBeReceived = 0 then
            ItemJournalLine."PWD Reference" := SetGetFunctions.GetGenRef();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostItemJnlLineJobConsumption', '', false, false)]
    local procedure CDU90_OnBeforePostItemJnlLineJobConsumption_PurchPost(var ItemJournalLine: Record "Item Journal Line"; var PurchaseLine: Record "Purchase Line"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; QtyToBeInvoiced: Decimal; QtyToBeInvoicedBase: Decimal; SourceCode: Code[10])
    var
        SetGetFunctions: codeunit "PWD Set/Get Functions";
    begin
        if QtyToBeInvoiced <> 0 then
            ItemJournalLine."PWD Reference" := SetGetFunctions.GetGenRef();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemChargePerOrderOnAfterCopyToItemJnlLine', '', false, false)]
    local procedure CDU90_OnPostItemChargePerOrderOnAfterCopyToItemJnlLine_PurchPost(var ItemJournalLine: Record "Item Journal Line"; var PurchaseLine: Record "Purchase Line"; GeneralLedgerSetup: Record "General Ledger Setup"; QtyToInvoice: Decimal; var TempItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)" temporary)
    var
        SetGetFunctions: codeunit "PWD Set/Get Functions";
    begin
        ItemJournalLine."PWD Reference" := SetGetFunctions.GetGenRef();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    local procedure TAB83_OnAfterCopyItemJnlLineFromPurchLine_ItemJournalLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    var
        PurchaseHeader: record "Purchase Header";
    begin
        PurchaseHeader.Get(PurchLine."Document Type", PurchLine."Document No.");
        ItemJnlLine."PWD Reference" := PurchaseHeader."PWD Reference";

        ItemJnlLine."PWD Notice Series No." := PurchaseHeader."PWD Notice Series No.";  //TODO à vérifier
        ItemJnlLine."PWD Origin" := PurchLine."PWD Origin";
        ItemJnlLine."PWD Cetificate Transit No." := PurchLine."PWD Cetificate Transit No.";
    end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostItemChargePerOrder', '', false, false)]
    // local procedure CDU90_OnBeforePostItemChargePerOrder_PurchPost(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var ItemJnlLine2: Record "Item Journal Line"; var ItemChargePurchLine: Record "Purchase Line"; var TempTrackingSpecificationChargeAssmt: Record "Tracking Specification" temporary; CommitIsSupressed: Boolean; var TempItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)" temporary)
    // begin
    //     ItemJnlLine2."PWD Reference" := PurchHeader."PWD Reference";
    // end;

    //---CDU92---
    //TODO Fct "PrintDocumentsWithCheckDialogCommon" copie du std car elle est locale ds Tab 77 "Report Selections"
    // [EventSubscriber(ObjectType::Table, DataBase::"Report Selections", 'OnBeforePrintWithGUIYesNoVendor', '', false, false)]
    // local procedure TAB77_OnBeforePrintWithGUIYesNoVendor_ReportSelections(ReportUsage: Integer; RecordVariant: Variant; IsGUI: Boolean; VendorNoFieldNo: Integer; var Handled: Boolean)
    // var
    //     ReportSelection: Record "Report Selections";
    //     FunctionsMgt: Codeunit "PWD Function Mgt";
    // begin 
    //     FunctionsMgt.PrintDocumentsWithCheckDialogCommon(
    //      ReportSelection.Usage::"Notice Investment", RecordVariant, IsGUI, VendorNoFieldNo, false, DATABASE::Vendor);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeGetReport', '', false, false)]
    local procedure CDU92_OnBeforeGetReport_PurchPostPrint(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchPostPrint: codeunit "Purch.-Post + Print";
    begin
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Order:
                if PurchaseHeader.Receive then begin
                    PurchRcptHeader."No." := PurchaseHeader."Last Receiving No.";
                    PurchRcptHeader.SetRecFilter();
                    PurchRcptHeader.PrintRecordsSpec(false);
                    PurchRcptHeader.PrintRecords(false);
                end;
            PurchaseHeader."Document Type"::Invoice:
                PurchPostPrint.PrintInvoice(PurchaseHeader);
            PurchaseHeader."Document Type"::"Return Order":
                begin
                    if PurchaseHeader.Ship then
                        PurchPostPrint.PrintShip(PurchaseHeader);
                    if PurchaseHeader.Invoice then
                        PurchPostPrint.PrintCrMemo(PurchaseHeader);
                end;
            PurchaseHeader."Document Type"::"Credit Memo":
                PurchPostPrint.PrintCrMemo(PurchaseHeader);
        end;
        IsHandled := true;
    end;

    //---CDU96---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeDeletePurchQuote', '', false, false)]
    local procedure OnBeforeDeletePurchQuote_PurchQuotetoOrder(var QuotePurchHeader: Record "Purchase Header"; var OrderPurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        AutoArchiveManagement: Codeunit "PWD ArchiveAutoManagement";

    begin
        AutoArchiveManagement.StorePurchDocument(QuotePurchHeader);
    end;

    //---CDU5063---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeRestoreSalesDocument', '', false, false)]
    local procedure CDU5063_OnBeforeRestoreSalesDocument_ArchiveManagement(var SalesHeaderArchive: Record "Sales Header Archive"; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        if not SalesHeader.Get(SalesHeaderArchive."Document Type", SalesHeaderArchive."No.") then begin
            PWDFunctionsMgt.FctRestoreSalesQuoteDeleted(SalesHeaderArchive);
            IsHandled := true;
            EXIT;

        end;
    end;

    //---CDU99000830---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnCreateEntryOnBeforeSurplusCondition', '', false, false)]
    local procedure CDU99O00830_OnCreateEntryOnBeforeSurplusCondition_CreateReservEntry(var ReservEntry: Record "Reservation Entry"; QtyToHandleAndInvoiceIsSet: Boolean)
    var
        PWDFunctionsMgt: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionsMgt."FctOnCreateEntryOnBeforeSurplusCondition_CDU99000830"(ReservEntry, QtyToHandleAndInvoiceIsSet);
    end;

    //---REP698---
    [EventSubscriber(ObjectType::Report, report::"Get Sales Orders", 'OnInsertReqWkshLineOnBeforeValidateUoM', '', false, false)]
    local procedure REP698_OnInsertReqWkshLineOnBeforeValidateUoM_GetSalesOrders(var ReqLine: Record "Requisition Line"; SalesLine: Record "Sales Line"; SpecOrder: Integer)
    begin
        ReqLine.VALIDATE(Description, SalesLine.Description);
        ReqLine.VALIDATE("Description 2", SalesLine."Description 2");
    end;

    [EventSubscriber(ObjectType::Report, report::"Get Sales Orders", 'OnBeforeInsertReqWkshLine', '', false, false)]
    local procedure REP698_OnBeforeInsertReqWkshLine_GetSalesOrders(var ReqLine: Record "Requisition Line"; SalesLine: Record "Sales Line"; SpecOrder: Integer)
    begin
        ReqLine.Description := SalesLine.Description;
        IF SalesLine."PWD Specific Cost" OR SalesLine."Special Order" THEN BEGIN
            ReqLine."Direct Unit Cost" := SalesLine."Unit Cost";
            ReqLine."PWD Specific cost" := TRUE;
        END;
    end;
}
