page 50063 "PWD Sales AVOIR to prepare V2"
{
    Caption = 'Sales Orders to prepare';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Header";
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Delivery time"; Rec."PWD Delivery time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Preparation Status"; Rec."PWD Preparation Status")
                {
                    ApplicationArea = All;
                }
                field("Order Prepared"; Rec."PWD Order Prepared")
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
            action("Mettre à jour Qté (à preparer)")
            {
                Caption = 'Update Qties to prepare';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = UpdateUnitCost;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    SalesHeader.RESET();
                    CurrPage.SETSELECTIONFILTER(SalesHeader);
                    IF SalesHeader.COUNT > 1 THEN
                        ERROR(Text1000000009);
                    IF SalesHeader.COUNT = 0 THEN
                        ERROR(Text1000000010);
                    IF SalesHeader.FINDFirst() THEN
                        IF SalesHeader."PWD Preparation in process" = FALSE THEN
                            MESSAGE(Text1000000013, SalesHeader."No.") ELSE BEGIN
                            SalesLine.RESET();
                            SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                            SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                            SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
                            SalesLine.SETRANGE(SalesLine."PWD Butchery", FALSE);
                            SalesLine.SETRANGE(SalesLine."PWD Trading Brand", FALSE);
                            SalesLine.SETRANGE(SalesLine."PWD Countermark Location", FALSE);
                            CLEAR(FormSalesLinetoPrepare);
                            FormSalesLinetoPrepare.SETTABLEVIEW(SalesLine);
                            FormSalesLinetoPrepare.InitOrderNo(SalesHeader."No.");
                            FormSalesLinetoPrepare.RUNMODAL();
                        END;
                end;
            }
            action("Editer Bon de Préparation")
            {
                Caption = 'Print Preparation Receipt';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                begin
                    MakePreparation();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NoOnFormat();
    end;

    var
        Item: Record Item;
        RecLocPriority: Record "PWD Location Priority";
        ReservEntry: Record "Reservation Entry";
        ReservEntryNo: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesLineCreated: Record "Sales Line";
        TempNewSalesLine: Record "Sales Line" temporary;
        DimMgt: Codeunit DimensionManagement;
        PWDSetGetFunctions: codeunit "PWD Set/Get Functions";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        FormSalesLinetoPrepare: Page "PWD Sales Lines to Prepare";
        [InDataSet]
        "No.Emphasize": Boolean;
        APreparer: Decimal;
        NewNeed: Decimal;
        LocationIsOK: Integer;
        LocationsToCheck: Integer;
        Text1000000009: Label 'You can''t select more than one line for picking';
        Text1000000010: Label 'You must select at least one line for picking';
        Text1000000011: Label 'The items corresponding to the order %1 have been picked successfully !';
        Text1000000013: Label 'The order %1 has not yet been prepared !';

    procedure MakePreparation()
    begin
        TempNewSalesLine.DELETEALL();
        SalesHeader.RESET();
        CurrPage.SETSELECTIONFILTER(SalesHeader);
        IF SalesHeader.COUNT > 1 THEN
            ERROR(Text1000000009);
        IF SalesHeader.COUNT = 0 THEN
            ERROR(Text1000000010);

        IF SalesHeader.FindFirst() THEN BEGIN
            IF SalesHeader."PWD Preparation in process" = FALSE THEN BEGIN
                CLEAR(ReleaseSalesDoc);
                PWDSetGetFunctions.InitRelease(TRUE);
                ReleaseSalesDoc.Reopen(SalesHeader);
                SalesLine.RESET();
                SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                SalesLine.SETRANGE("Special Order", FALSE);
                SalesLine.SETRANGE("PWD Order Trading brand", FALSE);
                SalesLine.SETRANGE("PWD Trading Brand", FALSE);
                SalesLine.SETRANGE("PWD Preparation in Process", FALSE);
                IF SalesLine.FindSet() THEN
                    REPEAT
                        BreakdownSalesLineQty(SalesLine."Qty. to Ship (Base)");
                    UNTIL SalesLine.NEXT() = 0;
                SalesLine.RESET();
                SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
                SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                SalesLine.SETRANGE(SalesLine."PWD Preparation in Process", TRUE);
                SalesLine.SETRANGE("PWD Trading Brand", FALSE);
                IF SalesLine.FindSet() THEN
                    REPEAT
                        Item.GET(SalesLine."No.");
                        IF (Item."PWD Trading Brand" = FALSE) AND (Item."PWD Butchery" = FALSE) AND (SalesLine."PWD Countermark Location" = FALSE) THEN
                            CheckTrackingLines(SalesLine);
                    UNTIL SalesLine.NEXT() = 0;
                SalesHeader.VALIDATE(SalesHeader."PWD Preparation in process", TRUE);
                SalesHeader."PWD Preparation Status" := SalesHeader."PWD Preparation Status"::"In process";
                SalesHeader.MODIFY();
                CLEAR(ReleaseSalesDoc);
                PWDSetGetFunctions.InitRelease(TRUE);
                ReleaseSalesDoc.RUN(SalesHeader);

                MESSAGE(Text1000000011, SalesHeader."No.");
            END;
            REPORT.RUN(Report::"PWD Picking List", TRUE, TRUE, SalesHeader);
            REPORT.RUN(Report::"PWD Fiche Anomalie", TRUE, TRUE, SalesHeader);
            REPORT.RUN(50065, TRUE, TRUE, SalesHeader);
            REPORT.RUN(50052, TRUE, TRUE, SalesHeader);
        END;
    end;

    procedure BreakdownSalesLineQty(InputQuantity: Decimal)
    var
        NextSalesLine: Record "Sales Line";
        IncremLine: Integer;
        NewSalesLineNo: Integer;
        NextSalesLineNo: Integer;
    begin
        TempNewSalesLine.DELETEALL();
        CLEAR(NextSalesLineNo);
        CLEAR(NextSalesLine);
        CLEAR(IncremLine);
        CLEAR(LocationsToCheck);
        CLEAR(APreparer);
        CLEAR(NewSalesLineNo);
        CLEAR(LocationIsOK);
        NewNeed := InputQuantity;
        NextSalesLine.SETRANGE(NextSalesLine."Document Type", SalesLine."Document Type");
        NextSalesLine.SETRANGE("Document No.", SalesLine."Document No.");
        NextSalesLine.SETFILTER("Line No.", '>%1', SalesLine."Line No.");
        IF NextSalesLine.FindFirst() THEN
            NextSalesLineNo := NextSalesLine."Line No." ELSE
            NextSalesLineNo := SalesLine."Line No." + 10000;
        RecLocPriority.RESET();
        RecLocPriority.SETCURRENTKEY("PWD Call Type Code", "PWD Location priority");
        RecLocPriority.SETRANGE(RecLocPriority."PWD Call Type Code", SalesHeader."PWD Call Type");
        IF RecLocPriority.FindFirst() THEN BEGIN
            CLEAR(IncremLine);
            LocationsToCheck := RecLocPriority.COUNT + 1;
            IncremLine := ROUND(((NextSalesLineNo - SalesLine."Line No.") / LocationsToCheck), 1);
            REPEAT
                APreparer := CalculateNeed();
                IF APreparer > 0 THEN BEGIN
                    LocationIsOK += 1;
                    IF LocationIsOK = 1 THEN
                        NewSalesLineNo := SalesLine."Line No." + (IncremLine);
                    IF APreparer >= NewNeed THEN
                        InsertNewLine(RecLocPriority."PWD Location code", NewNeed, NewSalesLineNo) ELSE
                        InsertNewLine(RecLocPriority."PWD Location code", APreparer, NewSalesLineNo);
                    NewNeed -= APreparer;
                    NewSalesLineNo := SalesLine."Line No." + (IncremLine * (LocationIsOK + 1));
                END;
            UNTIL (RecLocPriority.NEXT() = 0) OR (NewNeed <= 0);
            IF NewNeed > 0 THEN BEGIN
                IF LocationIsOK = 0 THEN NewSalesLineNo := SalesLine."Line No." + ((NextSalesLineNo - SalesLine."Line No.") / 2);
                InsertNewLineNull('', NewNeed, NewSalesLineNo);
            END;
        END;
        TempNewSalesLine.RESET();
        IF TempNewSalesLine.FindFirst() THEN
            REPEAT
                SalesLineCreated.TRANSFERFIELDS(TempNewSalesLine);
                SalesLineCreated.INSERT();
            UNTIL TempNewSalesLine.NEXT() = 0;
        SalesLine.DELETE(TRUE);
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
        IF ItemSalesLine.FindFirst() THEN
            ItemSalesLine.CALCFIELDS("Qty. on Sales Order");
        Item.RESET();
        Item.SETRANGE("No.", SalesLine."No.");
        Item.SETRANGE("Date Filter", 0D, SalesLine."Shipment Date");
        Item.SETRANGE(Item."Location Filter", RecLocPriority."PWD Location code");
        IF Item.FindFirst() THEN BEGIN
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
            PlannedOrderReleases := Item."Purch. Req. Release (Qty.)";
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
        ItemLedgerEntry.SETCURRENTKEY("Expiration Date");
        ItemLedgerEntry.ASCENDING(TRUE);
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", SalesLine."Location Code");
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", SalesLine."No.");
        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Lot No.", '<>%1', '');
        ItemLedgerEntry.SETRANGE(ItemLedgerEntry.Positive, TRUE);
        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '<>%1', 0);
        IF ItemLedgerEntry.FIND() THEN BEGIN
            IF ReservEntryNo.FindLast() THEN
                EntryNo := ReservEntryNo."Entry No."
            ELSE
                EntryNo := 0;
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
                    ReservEntry.VALIDATE("Expiration Date", ItemLedgerEntry."Expiration Date");
                    ReservEntry.INSERT(TRUE);
                    InsertedTrackingQty += ReservEntry."Quantity (Base)";
                END;
            UNTIL (ItemLedgerEntry.NEXT() = 0) OR (ABS(InsertedTrackingQty) = SalesLine."PWD Prepared Quantity (Base)")
        END;
    end;

    procedure InsertNewLine(FromLocationCode: Code[20]; FromQty: Decimal; NewLineNo: Integer)
    begin
        CLEAR(TempNewSalesLine);
        TempNewSalesLine.TRANSFERFIELDS(SalesLine);
        TempNewSalesLine."Line No." := NewLineNo;
        TempNewSalesLine.INSERT(TRUE);

        TempNewSalesLine.VALIDATE("Location Code", FromLocationCode);
        TempNewSalesLine.Description := SalesLine.Description;
        TempNewSalesLine."Description 2" := SalesLine."Description 2";
        TempNewSalesLine.VALIDATE("Shortcut Dimension 1 Code");
        TempNewSalesLine.VALIDATE("Shortcut Dimension 2 Code");
        TempNewSalesLine.VALIDATE("Quantity (Base)", FromQty);
        TempNewSalesLine.VALIDATE("PWD Prepared Quantity", TempNewSalesLine.Quantity);

        TempNewSalesLine.VALIDATE("PWD Prepared Quantity (Base)", TempNewSalesLine."Quantity (Base)");
        TempNewSalesLine."PWD Preparation in Process" := TRUE;

        TempNewSalesLine.MODIFY(TRUE);

        CLEAR(DimMgt);
        //TODO
        /* DimMgt.InsertDocDim(
           DATABASE::"Sales Line", TempNewSalesLine."Document Type", TempNewSalesLine."Document No.", TempNewSalesLine."Line No.",
           TempNewSalesLine."Shortcut Dimension 1 Code", TempNewSalesLine."Shortcut Dimension 2 Code");*/
    end;

    procedure InsertNewLineNull(FromLocationCode: Code[20]; FromQty: Decimal; NewLineNo: Integer)
    begin
        CLEAR(TempNewSalesLine);
        TempNewSalesLine.TRANSFERFIELDS(SalesLine);
        TempNewSalesLine."Line No." := NewLineNo;
        TempNewSalesLine.INSERT(TRUE);

        TempNewSalesLine.VALIDATE("Location Code", FromLocationCode);
        TempNewSalesLine.VALIDATE("Quantity (Base)", FromQty);
        TempNewSalesLine.Description := SalesLine.Description;
        TempNewSalesLine."Description 2" := SalesLine."Description 2";
        TempNewSalesLine.VALIDATE("Shortcut Dimension 1 Code");
        TempNewSalesLine.VALIDATE("Shortcut Dimension 2 Code");

        TempNewSalesLine.VALIDATE("PWD Quantity to prepare", TempNewSalesLine.Quantity);
        TempNewSalesLine.VALIDATE("Qty. to Ship", 0);
        TempNewSalesLine."PWD Preparation in Process" := TRUE;
        TempNewSalesLine.MODIFY(TRUE);
        CLEAR(DimMgt);
        //ToDo
        // DimMgt.InsertDocDim(
        //   DATABASE::"Sales Line", TempNewSalesLine."Document Type", TempNewSalesLine."Document No.", TempNewSalesLine."Line No.",
        //   TempNewSalesLine."Shortcut Dimension 1 Code", TempNewSalesLine."Shortcut Dimension 2 Code");
    end;

    local procedure NoOnFormat()
    begin
        IF Rec."PWD Preparation Status" = 1 THEN
            "No.Emphasize" := TRUE;
    end;
}
