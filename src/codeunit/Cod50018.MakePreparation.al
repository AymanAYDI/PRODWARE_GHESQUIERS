codeunit 50018 "PWD MakePreparation"
{
    TableNo = "Sales Header";

    trigger OnRun()
    begin
        IF SalesHeader.COUNT > 1 THEN
            ERROR(Text1000000009);
        IF SalesHeader.COUNT = 0 THEN
            ERROR(Text1000000010);
        IF SalesHeader.FIND('-') THEN BEGIN
            IF SalesHeader."PWD Preparation in process" = FALSE THEN BEGIN
                CLEAR(ReleaseSalesDoc);
                ReleaseSalesDoc.Reopen(SalesHeader);
                SalesHeader.MODIFY();
                LastLineNo := 0;
                SalesLine.RESET();
                SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(SalesLine."PWD Preparation in Process", FALSE);
                IF SalesLine.FIND('+') THEN
                    LastLineNo := SalesLine."Line No.";
                SalesLine.RESET();
                SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                SalesLine.SETRANGE("Special Order", FALSE);
                SalesLine.SETRANGE("PWD Order Trading brand", FALSE);
                SalesLine.SETRANGE("PWD Trading Brand", FALSE);
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        IF ItemNo <> SalesLine."No." THEN BEGIN
                            SalesLineItem.SETCURRENTKEY("Document Type", "Document No.", "PWD Preparation in Process",
                            "Line No.", Type, "No.", "Special Order");
                            SalesLineItem.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                            SalesLineItem.SETRANGE("Document No.", SalesHeader."No.");
                            SalesLineItem.SETRANGE("PWD Preparation in Process", FALSE);
                            SalesLineItem.SETRANGE(Type, SalesLine.Type::Item);
                            SalesLineItem.SETRANGE("No.", SalesLine."No.");
                            SalesLineItem.CALCSUMS(Quantity);
                            SalesLine.VALIDATE(Quantity, SalesLineItem.Quantity);
                            SalesLine.VALIDATE("Unit Price", SalesLineItem."Unit Price");
                            SalesLine.MODIFY(TRUE);
                            ItemNo := SalesLine."No.";
                        END ELSE
                            SalesLine.DELETE(TRUE);
                    UNTIL SalesLine.NEXT() = 0;

                SalesLine.RESET();
                SalesLine.SETCURRENTKEY("Document Type", "Document No.", "PWD Preparation in Process",
                "Line No.", Type, "No.");
                SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(SalesLine."PWD Preparation in Process", FALSE);
                SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
                SalesLine.SETRANGE("PWD Trading Brand", FALSE);
                IF SalesLine.FIND('-') THEN BEGIN
                    REPEAT
                        Item.GET(SalesLine."No.");
                        IF (Item."PWD Trading Brand" = FALSE) AND (Item."PWD Butchery" = FALSE) AND (SalesLine."PWD Countermark Location" = FALSE) THEN BEGIN
                            QtytoSend := SalesLine."Quantity (Base)";
                            SalesLine.VALIDATE(Quantity, 0);
                            SalesLine.MODIFY();
                            BreakdownSalesLineQty(QtytoSend);
                            UpdateLinkedCommentLines();
                            SalesLine.DELETE(TRUE);
                        END;
                    UNTIL SalesLine.NEXT() = 0;
                    SalesHeader.VALIDATE(SalesHeader."PWD Preparation in process", TRUE);
                    SalesHeader."PWD Preparation Status" := SalesHeader."PWD Preparation Status"::"In process";
                END;
                SalesLine.RESET();
                SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
                SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(SalesLine."PWD Preparation in Process", TRUE);
                SalesLine.SETRANGE("PWD Trading Brand", FALSE);
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        Item.GET(SalesLine."No.");
                        IF (Item."PWD Trading Brand" = FALSE) AND (Item."PWD Butchery" = FALSE) AND (SalesLine."PWD Countermark Location" = FALSE) THEN
                            CheckTrackingLines(SalesLine);
                    UNTIL SalesLine.NEXT() = 0;
                SalesHeader.VALIDATE(SalesHeader.Status, SalesHeader.Status::Released);
                SalesHeader.MODIFY();
                COMMIT();
                REPORT.RUNMODAL(Report::"PWD Picking List", TRUE, TRUE, SalesHeader);
                MESSAGE(Text1000000011, SalesHeader."No.");
            END ELSE
                REPORT.RUNMODAL(Report::"PWD Picking List", TRUE, TRUE, SalesHeader);
            REPORT.RUNMODAL(Report::"PWD Fiche Anomalie", TRUE, TRUE, SalesHeader);
            REPORT.RUNMODAL(50065, TRUE, TRUE, SalesHeader);
        END;
    end;

    var
        Item: Record Item;
        Item2: Record Item;
        RecLocPriority: Record "PWD Location Priority";
        ReservEntry: Record "Reservation Entry";
        ReservEntryNo: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        CommentSalesLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        SalesLineItem: Record "Sales Line";
        ItemTrackingLines: Record "Tracking Specification";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        LastLineNo: BigInteger;
        ItemNo: Code[20];
        ItemNo2: Code[20];
        AvailableInventory: Decimal;
        CumulatedInventory: Decimal;
        QtytoSend: Decimal;
        RemainingDifference: Decimal;
        Text1000000009: Label 'You can''t select more than one line for picking';
        Text1000000010: Label 'You must select at least one line for picking';
        Text1000000011: Label 'The items corresponding to the order %1 have been picked successfully !';
        Commentaires: array[20] of Text[50];

    procedure BreakdownSalesLineQty(InputQuantity: Decimal)
    var
        InsertedSalesLineQty: Decimal;
        PositiveRemainingQty: Decimal;
        Qtyinserted: Decimal;
        TotalAvailableInventory: Decimal;
        UnavailableQty: Decimal;
    begin
        AvailableInventory := 0;
        TotalAvailableInventory := 0;
        InsertedSalesLineQty := 0;
        RemainingDifference := 0;
        Qtyinserted := 0;
        CumulatedInventory := 0;
        UnavailableQty := 0;
        RecLocPriority.RESET();
        RecLocPriority.SETCURRENTKEY("PWD Call Type Code", "PWD Location priority");
        RecLocPriority.SETRANGE(RecLocPriority."PWD Call Type Code", SalesHeader."PWD Call Type");
        IF RecLocPriority.FIND('-') THEN BEGIN
            REPEAT
                TotalAvailableInventory := CalculateNeed();
                IF TotalAvailableInventory > 0 THEN
                    PositiveRemainingQty += TotalAvailableInventory;
            UNTIL RecLocPriority.NEXT() = 0;
            IF TotalAvailableInventory < (InputQuantity / SalesLine."Qty. per Unit of Measure") THEN
                UnavailableQty := (InputQuantity / SalesLine."Qty. per Unit of Measure") - PositiveRemainingQty;
            RecLocPriority.FIND('-');
            REPEAT
                AvailableInventory := CalculateNeed();
                CumulatedInventory += CalculateNeed();
                IF AvailableInventory <> 0 THEN BEGIN
                    InsertedSalesLineQty += Qtyinserted;
                    RemainingDifference := InputQuantity - InsertedSalesLineQty;
                END;
                Item2.GET(SalesLine."No.");
                AvailableInventory := AvailableInventory / SalesLine."Qty. per Unit of Measure";
                IF (AvailableInventory > 0) AND (InsertedSalesLineQty <= InputQuantity) AND (RemainingDifference <> 0) THEN BEGIN
                    LastLineNo += 10000;
                    SalesLine2.INIT();
                    SalesLine2.VALIDATE(SalesLine2."Document Type", SalesLine2."Document Type"::Order);
                    SalesLine2.VALIDATE(SalesLine2."Document No.", SalesLine."Document No.");
                    SalesLine2.VALIDATE(SalesLine2."Line No.", LastLineNo);
                    SalesLine2.VALIDATE(SalesLine2.Type, SalesLine.Type);
                    SalesLine2.VALIDATE(SalesLine2."No.", SalesLine."No.");
                    SalesLine2.VALIDATE(SalesLine2."Location Code", RecLocPriority."PWD Location code");
                    IF CumulatedInventory <= InputQuantity THEN
                        SalesLine2.Quantity := AvailableInventory ELSE
                        SalesLine2.Quantity := RemainingDifference;
                    SalesLine2.VALIDATE(SalesLine2."Unit of Measure Code", SalesLine."Unit of Measure Code");
                    SalesLine2."PWD Preparation in Process" := TRUE;
                    SalesLine2."PWD Prepared Quantity" := SalesLine2.Quantity;
                    SalesLine2.VALIDATE("PWD Quantity to prepare", SalesLine2.Quantity);
                    SalesLine2."PWD Prepared Quantity (Base)" := SalesLine2.Quantity * SalesLine2."Qty. per Unit of Measure";
                    SalesLine2."PWD Adjmt Prepared Qty" := 0;
                    SalesLine2."PWD Previous Line No" := SalesLine."Line No.";
                    SalesLine2.INSERT(TRUE);
                    Qtyinserted := SalesLine2.Quantity;
                    ItemNo2 := SalesLine2."No.";
                END;
            UNTIL (RecLocPriority.NEXT() = 0) OR (InsertedSalesLineQty = InputQuantity);
            IF UnavailableQty > 0 THEN BEGIN
                LastLineNo += 10000;
                SalesLine2.INIT();
                SalesLine2.VALIDATE(SalesLine2."Document Type", SalesLine2."Document Type"::Order);
                SalesLine2.VALIDATE(SalesLine2."Document No.", SalesLine."Document No.");
                SalesLine2.VALIDATE(SalesLine2."Line No.", LastLineNo);
                SalesLine2.VALIDATE(SalesLine2.Type, SalesLine.Type);
                SalesLine2.VALIDATE(SalesLine2."No.", SalesLine."No.");
                SalesLine2.VALIDATE(SalesLine2."Location Code", '');
                SalesLine2.Quantity := UnavailableQty;
                SalesLine2.VALIDATE(SalesLine2."Unit of Measure Code", SalesLine."Unit of Measure Code");
                SalesLine2."PWD Preparation in Process" := TRUE;
                SalesLine2.VALIDATE("PWD Quantity to prepare", SalesLine2.Quantity);
                SalesLine2."PWD Previous Line No" := SalesLine."Line No.";
                SalesLine2.INSERT(TRUE);
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
        IF NOT ReservEntry.FIND('-') THEN
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
        IF ItemSalesLine.FIND('-') THEN
            ItemSalesLine.CALCFIELDS("Qty. on Sales Order");

        Item.RESET();
        Item.SETRANGE("No.", SalesLine."No.");
        Item.SETRANGE("Date Filter", 0D, SalesLine."Shipment Date");
        Item.SETRANGE(Item."Location Filter", RecLocPriority."PWD Location code");
        IF Item.FIND('-') THEN BEGIN
            Item.CALCFIELDS(
              "Qty. on Purch. Order",
              "Qty. on Sales Order",
              Inventory,
              "Purch. Req. Receipt (Qty.)",
              "Purch. Req. Release (Qty.)");

            GrossRequirement :=
              ItemSalesLine."Qty. on Sales Order";

            PlannedOrderReceipt :=
              Item."Purch. Req. Receipt (Qty.)";

            ScheduledReceipt :=
              Item."Qty. on Purch. Order";

            PlannedOrderReleases :=
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
        IF ItemLedgerEntry.FIND('-') THEN BEGIN
            ReservEntryNo.FIND('+');
            EntryNo := ReservEntryNo."Entry No.";
            REPEAT
                EntryNo += 1;
                CumulatedRemainingQty += ItemLedgerEntry."Remaining Quantity";
                Difference := -(ABS(SalesLine."PWD Prepared Quantity (Base)") - ABS((InsertedTrackingQty)));
                IF (Difference <> 0) THEN BEGIN
                    ReservEntry.INIT();
                    ReservEntry.VALIDATE("Entry No.", EntryNo);
                    ReservEntry.VALIDATE("Item No.", ItemLedgerEntry."Item No.");
                    ReservEntry.VALIDATE(ReservEntry."Reservation Status", ReservEntry."Reservation Status"::Surplus);
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
        IF NOT ItemTrackingLines.FIND('-') THEN
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
        ItemTrackingLines: Record "Tracking Specification";
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
        IF ItemLedgerEntry.FIND('-') THEN BEGIN
            ItemTrackingLines.FIND('+');
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

    procedure UpdateLinkedCommentLines()
    var
        CommentLineNumber: Integer;
        i: Integer;
        J: Integer;
    begin
        CommentSalesLine.RESET();
        CommentSalesLine.SETRANGE(CommentSalesLine."Document Type", CommentSalesLine."Document Type"::Order);
        CommentSalesLine.SETRANGE(CommentSalesLine."Document No.", SalesLine."Document No.");
        CommentSalesLine.SETRANGE(CommentSalesLine.Type, CommentSalesLine.Type::" ");
        CommentSalesLine.SETRANGE(CommentSalesLine."PWD Linked Sales Line", SalesLine."Line No.");
        IF CommentSalesLine.FIND('-') THEN BEGIN
            i := 0;
            REPEAT
                CommentSalesLine.MARK(TRUE);
                i += 1;
                Commentaires[i] := CommentSalesLine.Description;
            UNTIL CommentSalesLine.NEXT() = 0;
            CommentLineNumber := i;
            FOR J := 1 TO CommentLineNumber DO BEGIN
                LastLineNo += 10000;
                SalesLine2.INIT();
                SalesLine2."Document Type" := SalesLine."Document Type"::Order;
                SalesLine2."Document No." := SalesLine."Document No.";
                SalesLine2."Line No." := LastLineNo;
                SalesLine2.Description := Commentaires[J];
                SalesLine2."PWD Linked Sales Line" := SalesLine."Line No.";
                SalesLine2.INSERT(TRUE);
            END;
        END;
        CommentSalesLine.MARKEDONLY(TRUE);
        CommentSalesLine.DELETEALL();
    end;

    procedure MakePreparation()
    begin
    end;
}
