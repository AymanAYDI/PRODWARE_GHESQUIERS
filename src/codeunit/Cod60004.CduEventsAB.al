codeunit 60004 "PWD CduEvents AB"
{/*
    //---CDU414---
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReopenSalesDoc', '', false, false)]
    local procedure CDU414_OnBeforeReopenSalesDocEvent(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        CduFunctiontMgt: Codeunit "PWD Function Mgt";
    begin
        CduFunctiontMgt.GetPassWord();
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

    var

*/
}
