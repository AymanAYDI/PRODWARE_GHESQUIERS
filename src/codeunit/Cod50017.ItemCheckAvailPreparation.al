codeunit 50017 "Item-Check Avail. Preparation"
{
    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'The update has been interrupted to respect the warning.';

    procedure SalesLineCheck(SalesLine: Record "Sales Line")
    var
        CheckItemAvail: page "PWD Check Availability Prep";
    begin
        IF CheckItemAvail.SalesLineShowWarning(SalesLine) THEN BEGIN
            CheckItemAvail.LOOKUPMODE(TRUE);
            CheckItemAvail.RUNMODAL();
            CLEAR(CheckItemAvail);
            ERROR(Text000);
        END;
    end;

    procedure CalculateNeed(SalesLine: Record "Sales Line"; LocationCode: Code[10]): Decimal
    var
        Item: Record Item;
        ItemSalesLine: Record Item;
        GrossRequirement: Decimal;
        PlannedOrderReceipt: Decimal;
        //TODO Var not used
        //PlannedOrderReleases: Decimal;
        ScheduledReceipt: Decimal;
    begin
        ItemSalesLine.RESET();
        ItemSalesLine.SETRANGE("No.", SalesLine."No.");
        ItemSalesLine.SETRANGE("Date Filter", 0D, SalesLine."Shipment Date");
        ItemSalesLine.SETRANGE("Location Filter", LocationCode);
        ItemSalesLine.SETRANGE("PWD Preparation Filter", SalesLine."PWD Preparation in Process");
        IF ItemSalesLine.FindFirst() THEN
            ItemSalesLine.CALCFIELDS("Qty. on Sales Order");

        Item.SETRANGE("No.", SalesLine."No.");
        Item.SETRANGE("Date Filter", 0D, SalesLine."Shipment Date");
        Item.SETRANGE(Item."Location Filter", LocationCode);
        IF Item.FindFirst() THEN BEGIN
            Item.CALCFIELDS(
              "Qty. on Purch. Order",
              "Qty. on Service Order",
              Inventory,
              "Scheduled Receipt (Qty.)",
              "Qty. on Component Lines",
              "Planning Issues (Qty.)",
              "Planned Order Receipt (Qty.)",
              "FP Order Receipt (Qty.)",
              "Rel. Order Receipt (Qty.)",
              "Planned Order Release (Qty.)",
              "Purch. Req. Receipt (Qty.)",
              "Purch. Req. Release (Qty.)",
              "Qty. in Transit",
              "Trans. Ord. Shipment (Qty.)",
              "Trans. Ord. Receipt (Qty.)");
            GrossRequirement :=
              ItemSalesLine."Qty. on Sales Order" +
              Item."Qty. on Service Order" +
              Item."Qty. on Component Lines" +
              Item."Trans. Ord. Shipment (Qty.)" +
              Item."Planning Issues (Qty.)";
            PlannedOrderReceipt :=
              Item."Planned Order Receipt (Qty.)" +
              Item."Purch. Req. Receipt (Qty.)";
            ScheduledReceipt :=
              Item."FP Order Receipt (Qty.)" +
              Item."Rel. Order Receipt (Qty.)" +
              Item."Qty. on Purch. Order" +
              Item."Qty. in Transit" +
              Item."Trans. Ord. Receipt (Qty.)";
            //TODO var not used
            /*PlannedOrderReleases :=
              Item."Planned Order Release (Qty.)" +
              Item."Purch. Req. Release (Qty.)";*/

            EXIT(Item.Inventory + PlannedOrderReceipt + ScheduledReceipt - GrossRequirement);
        END;
    end;

    procedure CheckItemAvailability(SalesLine: Record "Sales Line") OldItemNetChange: Boolean
    var
        OldsalesLine: Record "Sales Line";
    begin
        OldItemNetChange := FALSE;
        OldsalesLine := SalesLine;
        IF OldsalesLine.findFirst() THEN
            IF (OldsalesLine."Document Type" = OldsalesLine."Document Type"::Order) AND
               (OldsalesLine."No." = SalesLine."No.") AND
               (OldsalesLine."Variant Code" = SalesLine."Variant Code") AND
               (OldsalesLine."Location Code" = SalesLine."Location Code") AND
               (OldsalesLine."Bin Code" = SalesLine."Bin Code") AND
               NOT OldsalesLine."Drop Shipment"
            THEN
                IF SalesLine.Quantity <> 0 THEN
                    OldItemNetChange := TRUE;

        EXIT(OldItemNetChange);
    end;
}
