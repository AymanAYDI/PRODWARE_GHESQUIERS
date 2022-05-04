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
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter', '', false, false)]
    local procedure T36_OnCopySelltoCustomerAddressFieldsFromCustomerOnAfterAssignRespCenter_SalesHeader(var SalesHeader: Record "Sales Header"; Customer: Record Customer; CallingFieldNo: Integer)
    begin
        SalesHeader."PWD Discount Profit %" := Customer."Discount Profit %";
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

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnBeforeRecreateSalesLines', '', false, false)]
    local procedure T36_OnBeforeRecreateSalesLines_SalesHeader(var SalesHeader: Record "Sales Header")
    var
        PWDSetGetFunctions: Codeunit "PWD Set/Get Functions";
        vconf: Boolean;
        CstG004: Label 'Voulez vous garder les valeurs actuelles des lignes';

    begin
        vconf := CONFIRM(CstG004, TRUE);
        PWDSetGetFunctions.Setconf(vconf);
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
        Rec.GetSalesHeader();
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
        //SalesLine.GetCallCust;  //TODO à vérifier "GetCallCust" est spec local
        IF SalesLine."PWD Call No." <> '' THEN
            RecCall.GET(SalesLine."PWD Call No.");
        SalesLine."PWD Monthly Code" := RecCall."Monthly Code";
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
                IF SalesLine.GetSKU(SKU) THEN //TODO à vérifier
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
        MemLineDiscount: Decimal;  //TODO Vérifier Variable Globale
        MemUnitPrice: Decimal;  //TODO Vérifier Variable Globale
    begin
        MemLineDiscount := SalesLine."Line Discount %";
        MemUnitPrice := SalesLine."Unit Price";
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
        Currency: Record Currency;
        SalesHeader: Record "Sales Header";
        HeaderWasReleased: Boolean;

    begin
        IF CurrFieldNo = Rec.FIELDNO("Unit Price") THEN BEGIN
            Rec.GetSalesHeader(SalesHeader, Currency);//TODO A vérifier GetSalesHeader
            //Rec.GetSalesHeader;
            IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
                HeaderWasReleased := TRUE;
                Rec.SuspendStatusCheck(TRUE);
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Line", 'OnAfterValidateEvent', 'Unit Price', false, false)]

    local procedure T37_OnAfterValidateEvent_SalesLine_UnitPrice(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        HeaderWasReleased: Boolean;//TODO à vérifier
    begin
        IF Rec.Quantity <> 0 THEN
            Rec.CtrlUnitPrice();
        IF HeaderWasReleased THEN BEGIN
            HeaderWasReleased := FALSE;
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

    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure TAB39_OnCopyFromItemOnAfterCheck_PurchaseLine(PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    var
        VendorRec: Record Vendor;
    begin
        PurchaseLine."PWD Family" := Item."PWD Family";
        PurchaseLine."PWD Cle (restitution)" := Item."PWD Restitution Key";

        IF VendorRec.GET(PurchaseLine."Buy-from Vendor No.") THEN
            PurchaseLine."PWD Origin" := VendorRec."Country/Region Code";

        PurchaseLine.Modify();
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

    //---CDU21---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnBeforeCheckEmptyQuantity', '', false, false)]
    local procedure OnBeforeCheckEmptyQuantity_ItemJnlCheckLine(ItemJnlLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
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
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertPostedHeaders', '', false, false)]
    local procedure CDU90_OnAfterInsertPostedHeaders_PurchPost(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var PurchSetup: Record "Purchases & Payables Setup")
    begin
        if PurchaseHeader.Invoice then
            if PurchaseHeader."Document Type" in [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice] then
                GenRef := PurchInvHeader."PWD Reference" //TODO var globale
            else
                GenRef := PurchaseHeader."PWD Reference";
    end;

    //---CDU92---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforePrintReceive', '', false, false)]
    local procedure CDU92_OnBeforePrintReceive_PurchPostPrint(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        ReportSelection: Record "Report Selections";
        ReturnShptHeader: Record "Return Shipment Header";
    begin
        ReportSelection.PrintWithDialogForVend(
              ReportSelection.Usage::"Notice Investment", ReturnShptHeader, false, ReturnShptHeader.FieldNo("Buy-from Vendor No."));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforePrintInvoice', '', false, false)]
    local procedure CDU92_OnBeforePrintInvoice_PurchPostPrint(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        if PurchaseHeader."Last Posting No." = '' then
            PurchInvHeader."No." := PurchaseHeader."No."
        else
            PurchInvHeader."No." := PurchaseHeader."Last Posting No.";
        PurchInvHeader.SetRecFilter();
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
            EXIT;
            IsHandled := true;
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

}
