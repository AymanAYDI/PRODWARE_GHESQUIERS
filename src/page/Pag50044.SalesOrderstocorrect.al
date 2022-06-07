page 50044 "PWD Sales Orders to correct"
{
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Requested Delivery Date", "PWD Delivery time") ORDER(Ascending) WHERE("Document Type" = FILTER(Order));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Delivery time"; Rec."PWD Delivery time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Correction)
            {
                Caption = 'Quantities to correct';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = UntrackedQuantity;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    SalesHeader.RESET();
                    CurrPage.SETSELECTIONFILTER(SalesHeader);
                    IF SalesHeader.COUNT > 1 THEN
                        ERROR(Text1000000009);
                    IF SalesHeader.COUNT = 0 THEN
                        ERROR(Text1000000010);
                    IF SalesHeader.FIND() THEN
                        IF SalesHeader."PWD Preparation in process" = FALSE THEN
                            MESSAGE(Text1000000013, SalesHeader."No.") ELSE BEGIN
                            CLEAR(FormSalesLinetoCorrect);
                            SalesLine.RESET();
                            SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
                            SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                            SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
                            SalesLine.SETRANGE(SalesLine."PWD Butchery", FALSE);
                            SalesLine.SETRANGE(SalesLine."PWD Trading Brand", FALSE);
                            SalesLine.SETFILTER(SalesLine."PWD Adjmt Prepared Qty", '<>%1', 0);
                            IF SalesLine.COUNT = 0 THEN
                                MESSAGE(Text1000000014, SalesHeader."No.") ELSE BEGIN
                                FormSalesLinetoCorrect.SETTABLEVIEW(SalesLine);
                                FormSalesLinetoCorrect.RUNMODAL();
                            END;
                        END;
                end;
            }
        }
    }

    var
        Item: Record Item;
        Item2: Record Item;
        RecLocPriority: Record "PWD Location Priority";
        ReservEntry: Record "Reservation Entry";
        ReservEntryNo: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        ItemTrackingLines: Record "Tracking Specification";
        PWDFunctionMgt: codeunit "PWD Function Mgt";
        FormSalesLinetoCorrect: Page "PWD Sales Line to Correct";
        LastLineNo: BigInteger;
        AvailableInventory: Decimal;
        CumulatedInventory: Decimal;
        QtytoSend: Decimal;
        RemainingDifference: Decimal;
        Text1000000009: Label 'You can''t select more than one line for picking';
        Text1000000010: Label 'You must select at least one line for picking';
        Text1000000013: Label 'The order %1 has not yet been prepared !';
        Text1000000014: Label 'No prepared quantity has been changed in the order %1';

    procedure BreakdownSalesLineQty(InputQuantity: Decimal)
    var
        InsertedSalesLineQty: Decimal;
    begin
        AvailableInventory := 0;
        InsertedSalesLineQty := 0;
        CumulatedInventory := 0;
        RecLocPriority.RESET();
        RecLocPriority.SETRANGE(RecLocPriority."PWD Call Type Code", SalesHeader."PWD Call Type");
        IF RecLocPriority.FindSet() THEN BEGIN
            REPEAT
                AvailableInventory := PWDFunctionMgt.CalculateNeed(SalesLine, RecLocPriority."PWD Location code");
                CumulatedInventory += PWDFunctionMgt.CalculateNeed(SalesLine, RecLocPriority."PWD Location code");
                IF AvailableInventory <> 0 THEN BEGIN
                    InsertedSalesLineQty += SalesLine2.Quantity;
                    RemainingDifference := InputQuantity - InsertedSalesLineQty;
                END;
                Item2.GET(SalesLine."No.");
                AvailableInventory := AvailableInventory / SalesLine."Qty. per Unit of Measure";
                IF (AvailableInventory <> 0) AND (InsertedSalesLineQty < InputQuantity) AND (RemainingDifference <> 0) THEN BEGIN
                    LastLineNo += 10000;
                    SalesLine2.INIT();
                    SalesLine2.VALIDATE(SalesLine2."Document Type", SalesLine2."Document Type"::Order);
                    SalesLine2.VALIDATE(SalesLine2."Document No.", SalesLine."Document No.");
                    SalesLine2.VALIDATE(SalesLine2."Line No.", LastLineNo);
                    SalesLine2.VALIDATE(SalesLine2.Type, SalesLine.Type);
                    SalesLine2.VALIDATE(SalesLine2."No.", SalesLine."No.");
                    SalesLine2.VALIDATE(SalesLine2."Location Code", RecLocPriority."PWD Location code");
                    IF CumulatedInventory <= InputQuantity THEN
                        SalesLine2.VALIDATE(SalesLine2.Quantity, AvailableInventory) ELSE
                        SalesLine2.VALIDATE(SalesLine2.Quantity, RemainingDifference);
                    SalesLine2.VALIDATE(SalesLine2."Unit of Measure Code", SalesLine."Unit of Measure Code");
                    SalesLine2."PWD Preparation in Process" := TRUE;
                    SalesLine2."PWD Prepared Quantity" := InputQuantity;
                    SalesLine2."PWD Prepared Quantity (Base)" := QtytoSend * SalesLine."Qty. per Unit of Measure";
                    SalesLine2.INSERT(TRUE);
                END;
            UNTIL (RecLocPriority.NEXT() = 0) OR (InsertedSalesLineQty = InputQuantity);
            IF AvailableInventory <> 0 THEN BEGIN
                SalesHeader.VALIDATE("PWD Preparation in process", TRUE);
                SalesHeader.MODIFY();
            END;
        END;
    end;

    procedure CheckTrackingLines(SalesLine: Record "Sales Line")
    begin
        ReservEntry.RESET();
        ReservEntry.SETRANGE("Item No.", SalesLine."No.");
        ReservEntry.SETRANGE("Location Code", SalesLine."Location Code");
        ReservEntry.SETRANGE("Source Type", DATABASE::"Sales Line");
        ReservEntry.SETRANGE("Source Subtype", SalesLine."Document Type");
        ReservEntry.SETRANGE("Source ID", SalesLine."Document No.");
        ReservEntry.SETRANGE("Source Ref. No.", SalesLine."Line No.");
        IF NOT ReservEntry.FindFirst() THEN
            InsertTrackingLines()
        ELSE BEGIN
            REPEAT
                ReservEntry.DELETE();
            UNTIL ReservEntry.NEXT() = 0;
            InsertTrackingLines();
        END;
    end;

    local procedure CalculateNeed(): Decimal
    var
        ItemSalesLine: Record Item;
        GrossRequirement: Decimal;
        PlannedOrderReceipt: Decimal;
        PlannedOrderReleases: Decimal;
        ScheduledReceipt: Decimal;
    begin
        ItemSalesLine.RESET();
        ItemSalesLine.SETRANGE("No.", SalesLine."No.");
        ItemSalesLine.SETRANGE("Date Filter", 0D, SalesLine."Shipment Date");
        ItemSalesLine.SETRANGE("Location Filter", RecLocPriority."PWD Location code");
        ItemSalesLine.SETRANGE("PWD Preparation Filter", SalesLine."PWD Preparation in Process");
        IF ItemSalesLine.FindFirst() THEN
            ItemSalesLine.CALCFIELDS("Qty. on Sales Order");

        Item.RESET();
        Item.SETRANGE("No.", SalesLine."No.");
        Item.SETRANGE("Date Filter", 0D, SalesLine."Shipment Date");
        Item.SETRANGE(Item."Location Filter", RecLocPriority."PWD Location code");
        IF Item.FindFirst() THEN BEGIN
            Item.CALCFIELDS(
              "Qty. on Purch. Order",
              "Qty. on Service Order",
              Inventory,
              "Scheduled Receipt (Qty.)",
              "Scheduled Need (Qty.)",
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
              Item."Scheduled Need (Qty.)" +
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
            PlannedOrderReleases :=
              Item."Planned Order Release (Qty.)" +
              Item."Purch. Req. Release (Qty.)";

            EXIT(Item.Inventory + PlannedOrderReceipt + ScheduledReceipt - GrossRequirement);
        END;
    end;

    procedure InsertTrackingLines()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        CumulatedRemainingQty: Decimal;
        Difference: Decimal;
        InsertedTrackingQty: Decimal;
        EntryNo: Integer;
    begin
        CumulatedRemainingQty := 0;
        Difference := 0;
        InsertedTrackingQty := 0;
        ItemLedgerEntry.RESET();
        ItemLedgerEntry.SETCURRENTKEY("Posting Date");
        ItemLedgerEntry.ASCENDING(TRUE);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", SalesLine."No.");
        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Lot No.", '<>%1', '');
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry.Positive, TRUE);
        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '<>%1', 0);
        IF ItemLedgerEntry.FIND() THEN BEGIN
            ReservEntryNo.FIND();
            EntryNo := ReservEntryNo."Entry No.";
            REPEAT
                EntryNo += 1;
                CumulatedRemainingQty += ItemLedgerEntry."Remaining Quantity";
                Difference := -(ABS(SalesLine."PWD Prepared Quantity (Base)") - ABS((InsertedTrackingQty)));
                IF (Difference <> 0) THEN BEGIN
                    ReservEntry.INIT();
                    ReservEntry.VALIDATE("Entry No.", EntryNo);
                    ReservEntry.VALIDATE("Item No.", ItemLedgerEntry."Item No.");
                    ReservEntry.VALIDATE("Location Code", SalesLine."Location Code");
                    ReservEntry.VALIDATE("Source Type", DATABASE::"Sales Line");
                    ReservEntry.VALIDATE("Source Subtype", SalesLine."Document Type");
                    ReservEntry.VALIDATE("Source ID", SalesLine."Document No.");
                    ReservEntry.VALIDATE("Source Ref. No.", SalesLine."Line No.");
                    ReservEntry.VALIDATE("Lot No.", ItemLedgerEntry."Lot No.");
                    IF CumulatedRemainingQty <= SalesLine."PWD Prepared Quantity (Base)" THEN
                        ReservEntry.VALIDATE("Quantity (Base)", -(ItemLedgerEntry."Remaining Quantity")) ELSE
                        ReservEntry.VALIDATE("Quantity (Base)", Difference);
                    ReservEntry.VALIDATE("Creation Date", ItemLedgerEntry."Posting Date");
                    ReservEntry.VALIDATE(ReservEntry."PWD Certificate Transit No.", ItemLedgerEntry."PWD Cetificate Transit No.");
                    ReservEntry.INSERT(TRUE);
                    InsertedTrackingQty += ReservEntry."Quantity (Base)";
                END;
            UNTIL (ItemLedgerEntry.NEXT() = 0) OR (ABS(InsertedTrackingQty) = SalesLine."PWD Prepared Quantity (Base)")
        END;
    end;

    procedure CheckTrackingLines2(SalesLine: Record "Sales Line")
    begin
        ItemTrackingLines.RESET();
        ItemTrackingLines.SETRANGE(ItemTrackingLines."Item No.", SalesLine."No.");
        ItemTrackingLines.SETRANGE(ItemTrackingLines."Location Code", SalesLine."Location Code");
        ItemTrackingLines.SETRANGE(ItemTrackingLines."Source Type", DATABASE::"Sales Line");
        ItemTrackingLines.SETRANGE(ItemTrackingLines."Source Subtype", SalesLine."Document Type");
        ItemTrackingLines.SETRANGE(ItemTrackingLines."Source ID", SalesLine."Document No.");
        ItemTrackingLines.SETRANGE(ItemTrackingLines."Source Ref. No.", SalesLine."Line No.");
        IF NOT ItemTrackingLines.FindSet() THEN
            InsertTrackingLines()
        ELSE BEGIN
            REPEAT
                ItemTrackingLines.DELETE();
            UNTIL ItemTrackingLines.NEXT() = 0;
            InsertTrackingLines();
        END;
    end;

    procedure InsertTrackingLines2()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        CumulatedRemainingQty: Decimal;
        Difference: Decimal;
        InsertedTrackingQty: Decimal;
        EntryNo: Integer;
    begin
        CumulatedRemainingQty := 0;
        Difference := 0;
        InsertedTrackingQty := 0;
        ItemLedgerEntry.RESET();
        ItemLedgerEntry.SETCURRENTKEY("Posting Date");
        ItemLedgerEntry.ASCENDING(TRUE);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", SalesLine."No.");
        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Lot No.", '<>%1', '');
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry.Positive, TRUE);
        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '<>%1', 0);
        IF ItemLedgerEntry.FindSet() THEN BEGIN
            ItemTrackingLines.FIND();
            EntryNo := ItemTrackingLines."Entry No.";
            REPEAT
                EntryNo += 1;
                CumulatedRemainingQty += ItemLedgerEntry."Remaining Quantity";
                Difference := SalesLine."PWD Prepared Quantity (Base)" - InsertedTrackingQty;
                IF (Difference <> 0) THEN BEGIN
                    ItemTrackingLines.INIT();
                    ItemTrackingLines.VALIDATE("Entry No.", EntryNo);
                    ItemTrackingLines.VALIDATE("Item No.", ItemLedgerEntry."Item No.");
                    ItemTrackingLines.VALIDATE(ItemTrackingLines."Location Code", SalesLine."Location Code");
                    ItemTrackingLines.VALIDATE(ItemTrackingLines."Source Type", DATABASE::"Sales Line");
                    ItemTrackingLines.VALIDATE(ItemTrackingLines."Source Subtype", SalesLine."Document Type");
                    ItemTrackingLines.VALIDATE(ItemTrackingLines."Source ID", SalesLine."Document No.");
                    ItemTrackingLines.VALIDATE(ItemTrackingLines."Source Ref. No.", SalesLine."Line No.");
                    ItemTrackingLines.VALIDATE(ItemTrackingLines."Lot No.", ItemLedgerEntry."Lot No.");
                    IF CumulatedRemainingQty <= SalesLine."PWD Prepared Quantity (Base)" THEN
                        ItemTrackingLines.VALIDATE(ItemTrackingLines."Quantity (Base)", ItemLedgerEntry."Remaining Quantity") ELSE
                        ItemTrackingLines.VALIDATE(ItemTrackingLines."Quantity (Base)", Difference);
                    ItemTrackingLines.VALIDATE(ItemTrackingLines."Creation Date", ItemLedgerEntry."Posting Date");
                    ItemTrackingLines.VALIDATE(ItemTrackingLines."PWD Certificate Transit No.", ItemLedgerEntry."PWD Cetificate Transit No.");
                    ItemTrackingLines.INSERT(TRUE);
                    InsertedTrackingQty += ItemTrackingLines."Quantity (Base)";
                END;
            UNTIL (ItemLedgerEntry.NEXT() = 0) OR (InsertedTrackingQty = SalesLine."PWD Prepared Quantity (Base)")
        END;
    end;
}
