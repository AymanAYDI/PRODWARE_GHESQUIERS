page 50059 "PWD Sales Orders to prepare V2"
{
    Caption = 'Sales Orders to prepare';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = FILTER(Order), Status = FILTER(Released));
    ApplicationArea = all;
    UsageCategory = lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(KPI; Rec."PWD KPI")
                {
                    ApplicationArea = All;
                }
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
                field("Seafrance Order No."; Rec."PWD Seafrance Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Prepared"; Rec."PWD Order Prepared")
                {
                    ApplicationArea = All;
                }
                field("Call Type"; Rec."PWD Call Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Bon de préparation")
            {
                Caption = 'Bon de préparation';
                action("Calcul et édition BP")
                {
                    Caption = 'Calcul et édition BP';
                    ApplicationArea = All;
                    Image = Calculate;

                    trigger OnAction()
                    begin
                        MakePreparation();
                    end;
                }
                action("Ré-édition BP")
                {
                    Caption = 'Ré-édition BP';
                    ApplicationArea = All;
                    Image = PrintReport;

                    trigger OnAction()
                    var
                        LRecSalesLines: Record "Sales Line";
                    begin
                        IF Rec."PWD Preparation Status" = 1 THEN
                            MESSAGE(Text1000000012)
                        ELSE BEGIN
                            CurrPage.SETSELECTIONFILTER(SalesHeader);
                            REPORT.RUN(Report::"PWD Picking List", TRUE, TRUE, SalesHeader);
                            LRecSalesLines.SETRANGE("Document Type", SalesHeader."Document Type");
                            LRecSalesLines.SETRANGE("Document No.", SalesHeader."No.");
                            LRecSalesLines.SETFILTER(Type, '<>%1', 0);
                            LRecSalesLines.SETRANGE("PWD Trading Brand", FALSE);
                            LRecSalesLines.SETRANGE("Special Order", FALSE);
                            LRecSalesLines.SETRANGE("Location Code", '');
                            IF NOT LRecSalesLines.ISEMPTY THEN
                                REPORT.RUN(Report::"PWD Fiche Anomalie", TRUE, TRUE, SalesHeader);
                        END;
                    end;
                }
            }
        }
        area(processing)
        {
            action("Editer Bon de Préparation")
            {
                Caption = 'Print Preparation Receipt';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;
                Image = Print;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    MakePreparation();
                end;
            }
            action("Impression des étiquettes")
            {
                Caption = 'Print Lables';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = Print;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    IF Rec."PWD Preparation Status" = 1 THEN
                        MESSAGE(CstG001)
                    ELSE BEGIN
                        CurrPage.SETSELECTIONFILTER(SalesHeader);
                        REPORT.RUN(50121, TRUE, TRUE, SalesHeader);
                    END;
                end;
            }
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
                    IF SalesHeader.FindFirst() THEN
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
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateKPI();
    end;

    var
        Item: Record Item;
        RecLocPriority: Record "PWD Location Priority";
        ReservEntry: Record "Reservation Entry";
        ReservEntryNo: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        NewSalesLine: Record "Sales Line" temporary;
        SalesLine: Record "Sales Line";
        SalesLineCreated: Record "Sales Line";
        DimMgt: Codeunit DimensionManagement;
        PWDSetGetFunctions: codeunit "PWD Set/Get Functions";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        FormSalesLinetoPrepare: Page "PWD Sales Lines to Prepare";
        [InDataSet]
        "No.Emphasize": Boolean;
        MemLocationCode: Code[10];
        APreparer: Decimal;
        MemLineDiscount: Decimal;
        MemUnitPrice: Decimal;
        NewNeed: Decimal;
        LocationIsOK: Integer;
        LocationsToCheck: Integer;
        CstG001: Label 'The Labels list cannot be printed until the ordre has been prepared.';
        Text1000000009: Label 'You can''t select more than one line for picking';
        Text1000000010: Label 'You must select at least one line for picking';
        Text1000000011: Label 'The items corresponding to the order %1 have been picked successfully !';
        Text1000000012: Label 'The picking list cannot be printed until the ordre has been prepared';
        Text1000000013: Label 'The order %1 has not yet been prepared !';

    procedure MakePreparation()
    var
        LRecSalesLines: Record "Sales Line";
    begin
        NewSalesLine.DELETEALL();
        SalesHeader.RESET();
        CurrPage.SETSELECTIONFILTER(SalesHeader);
        IF SalesHeader.COUNT > 1 THEN
            ERROR(Text1000000009);
        IF SalesHeader.COUNT = 0 THEN
            ERROR(Text1000000010);

        IF SalesHeader.FindFirst() THEN BEGIN
            CLEAR(ReleaseSalesDoc);
            PWDSetGetFunctions.InitRelease(TRUE);
            ReleaseSalesDoc.Reopen(SalesHeader);
            SalesLine.RESET();
            SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
            SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            SalesLine.SETRANGE("PWD Preparation Recalculate", TRUE);
            IF SalesLine.FindSet() THEN
                REPEAT
                    SalesLine."PWD Preparation in Process" := FALSE;
                    SalesLine."Location Code" := MemLocationCode;
                    SalesLine.VALIDATE(Quantity);
                    SalesLine.MODIFY();
                UNTIL SalesLine.NEXT() = 0;
            SalesLine.RESET();
            SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
            SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            SalesLine.SETRANGE("Special Order", FALSE);
            SalesLine.SETRANGE("PWD Order Trading brand", FALSE);
            SalesLine.SETRANGE("PWD Trading Brand", FALSE);
            SalesLine.SETRANGE("PWD Preparation in Process", FALSE);
            IF SalesLine.FindFirst() THEN
                REPEAT
                    MemLocationCode := SalesLine."Location Code";
                    BreakdownSalesLineQty(SalesLine."Qty. to Ship (Base)");
                UNTIL SalesLine.NEXT() = 0;
            SalesLine.RESET();
            SalesLine.SETRANGE(SalesLine.Type, SalesLine.Type::Item);
            SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
            SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
            SalesLine.SETRANGE(SalesLine."PWD Preparation in Process", TRUE);
            SalesLine.SETRANGE("PWD Trading Brand", FALSE);
            IF SalesLine.FindFirst() THEN
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
            PWDSetGetFunctions.SkipLocationControl(TRUE);
            ReleaseSalesDoc.RUN(SalesHeader);
            MESSAGE(Text1000000011, SalesHeader."No.");

            //>-> GHE-RE.1.00
            //>>GHE-RE1.01
            //GRepPickingList.Fct_UpdateNewPage(SalesHeader);
            //<<GHE-RE1.01
            //<-< GHE-RE.1.00

            COMMIT();
            REPORT.RUN(Report::"PWD Picking List", TRUE, TRUE, SalesHeader);

            //>-> GHE-RE.1.00
            LRecSalesLines.SETRANGE("Document Type", SalesHeader."Document Type");
            LRecSalesLines.SETRANGE("Document No.", SalesHeader."No.");
            LRecSalesLines.SETFILTER(Type, '<>%1', 0);
            LRecSalesLines.SETRANGE("PWD Trading Brand", FALSE);
            LRecSalesLines.SETRANGE("Special Order", FALSE);
            LRecSalesLines.SETRANGE("Location Code", '');
            IF NOT LRecSalesLines.ISEMPTY THEN
                //<-< GHE-RE.1.00
                REPORT.RUN(Report::"PWD Fiche Anomalie", TRUE, TRUE, SalesHeader);
            //REPORT.RUN (50065,TRUE,TRUE,SalesHeader);
            //>-> GUE-RE.1.00
            //  REPORT.RUN (50052,TRUE,TRUE,SalesHeader); //Prix à 0
            //<-< GUE-RE.1.00


            //<-< GHE-RE.1.00
        END;
    end;

    procedure BreakdownSalesLineQty(InputQuantity: Decimal)
    var
        NextSalesLine: Record "Sales Line";
        IncremLine: Integer;
        NewSalesLineNo: Integer;
        NextSalesLineNo: Integer;
    begin
        NewSalesLine.DELETEALL();
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
                        NewSalesLineNo := SalesLine."Line No.";
                    IF APreparer >= NewNeed THEN
                        InsertNewLine(RecLocPriority."PWD Location code", NewNeed, NewSalesLineNo) ELSE
                        InsertNewLine(RecLocPriority."PWD Location code", APreparer, NewSalesLineNo);
                    NewNeed -= APreparer;
                    NewSalesLineNo := SalesLine."Line No." + (IncremLine * (LocationIsOK));
                END;
            UNTIL (RecLocPriority.NEXT() = 0) OR (NewNeed <= 0);
            IF NewNeed > 0 THEN BEGIN
                IF LocationIsOK = 0 THEN NewSalesLineNo := SalesLine."Line No." + ROUND((NextSalesLineNo - SalesLine."Line No.") / 2, 1);

                InsertNewLineNull('', NewNeed, NewSalesLineNo);
            END;
        END;
        SalesLine.DELETE(TRUE);
        NewSalesLine.RESET();
        IF NewSalesLine.FindFirst() THEN
            REPEAT
                SalesLineCreated.TRANSFERFIELDS(NewSalesLine);
                SalesLineCreated.INSERT();
            UNTIL NewSalesLine.NEXT() = 0;
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
        IF NOT ReservEntry.FindSet() THEN
            InsertTrackingLines()
        ELSE BEGIN
            REPEAT
                ReservEntry.DELETE();
            UNTIL ReservEntry.NEXT() = 0;
            InsertTrackingLines();
        END;
    end;

    local procedure CalculateNeed() Availalibilty: Decimal
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
              "Purch. Req. Release (Qty.)",
              "PWD Qty. on Sales Order Prep");
            GrossRequirement :=
              Item."PWD Qty. on Sales Order Prep";

            PlannedOrderReceipt :=
              Item."Purch. Req. Receipt (Qty.)";

            ScheduledReceipt :=
              Item."Qty. on Purch. Order";

            PlannedOrderReleases :=
              Item."Purch. Req. Release (Qty.)";
            Availalibilty := Item.Inventory - GrossRequirement;
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
        IF ItemLedgerEntry.FindFirst() THEN BEGIN
            IF ReservEntryNo.FindLast() THEN
                EntryNo := ReservEntryNo."Entry No."
            ELSE
                EntryNo := 0;
            REPEAT

                ItemLedgerEntry.CALCFIELDS("PWD Lot Reserved Qty");
                IF ItemLedgerEntry."Remaining Quantity" <> ItemLedgerEntry."PWD Lot Reserved Qty" THEN BEGIN

                    EntryNo += 1;
                    CumulatedRemainingQty += ItemLedgerEntry."Remaining Quantity" - ItemLedgerEntry."PWD Lot Reserved Qty";
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
                            ReservEntry.VALIDATE("Quantity (Base)", -(ItemLedgerEntry."Remaining Quantity" - ItemLedgerEntry."PWD Lot Reserved Qty")) ELSE
                            ReservEntry.VALIDATE("Quantity (Base)", Difference);
                        ReservEntry.VALIDATE("Creation Date", ItemLedgerEntry."Posting Date");
                        ReservEntry.VALIDATE(ReservEntry."PWD Certificate Transit No.", ItemLedgerEntry."PWD Cetificate Transit No.");
                        ReservEntry.VALIDATE("Expiration Date", ItemLedgerEntry."Expiration Date");
                        ReservEntry.INSERT(TRUE);
                        InsertedTrackingQty += ReservEntry."Quantity (Base)";
                    END;
                END;
            UNTIL (ItemLedgerEntry.NEXT() = 0) OR (ABS(InsertedTrackingQty) = SalesLine."PWD Prepared Quantity (Base)")
        END;
    end;

    procedure InsertNewLine(FromLocationCode: Code[20]; FromQty: Decimal; NewLineNo: Integer)
    begin
        CLEAR(NewSalesLine);
        NewSalesLine.TRANSFERFIELDS(SalesLine);
        NewSalesLine."Line No." := NewLineNo;
        MemLineDiscount := NewSalesLine."Line Discount %";
        MemUnitPrice := NewSalesLine."Unit Price";
        NewSalesLine.INSERT(TRUE);
        NewSalesLine.VALIDATE("Location Code", FromLocationCode);
        NewSalesLine.Description := SalesLine.Description;
        NewSalesLine."Description 2" := SalesLine."Description 2";
        NewSalesLine.VALIDATE("Shortcut Dimension 1 Code");
        NewSalesLine.VALIDATE("Shortcut Dimension 2 Code");
        NewSalesLine.VALIDATE("Quantity (Base)", FromQty);
        NewSalesLine.VALIDATE("PWD Prepared Quantity", NewSalesLine.Quantity);
        NewSalesLine.VALIDATE("PWD Prepared Quantity (Base)", NewSalesLine."Quantity (Base)");
        NewSalesLine."PWD Preparation in Process" := TRUE;
        NewSalesLine.MODIFY(TRUE);
        NewSalesLine.VALIDATE(NewSalesLine."Line Discount %", MemLineDiscount);
        NewSalesLine.VALIDATE(NewSalesLine."Unit Price", MemUnitPrice);
        NewSalesLine.MODIFY(TRUE);
        CLEAR(DimMgt);
        //TODO
        /* DimMgt.InsertDocDim(
           DATABASE::"Sales Line", NewSalesLine."Document Type", NewSalesLine."Document No.", NewSalesLine."Line No.",
           NewSalesLine."Shortcut Dimension 1 Code", NewSalesLine."Shortcut Dimension 2 Code");*/
    end;

    procedure InsertNewLineNull(FromLocationCode: Code[20]; FromQty: Decimal; NewLineNo: Integer)
    begin
        CLEAR(NewSalesLine);
        NewSalesLine.TRANSFERFIELDS(SalesLine);
        NewSalesLine."Line No." := NewLineNo;
        MemLineDiscount := NewSalesLine."Line Discount %";
        MemUnitPrice := NewSalesLine."Unit Price";
        NewSalesLine.INSERT(TRUE);
        NewSalesLine.VALIDATE("Location Code", FromLocationCode);
        NewSalesLine.VALIDATE("Quantity (Base)", FromQty);
        NewSalesLine.Description := SalesLine.Description;
        NewSalesLine."Description 2" := SalesLine."Description 2";
        NewSalesLine.VALIDATE("Shortcut Dimension 1 Code");
        NewSalesLine.VALIDATE("Shortcut Dimension 2 Code");
        NewSalesLine.VALIDATE("PWD Quantity to prepare", NewSalesLine.Quantity);
        NewSalesLine.VALIDATE("Qty. to Ship", 0);
        NewSalesLine."PWD Preparation in Process" := TRUE;
        NewSalesLine."PWD Preparation Recalculate" := TRUE;
        NewSalesLine."PWD loc. Code Prepa Recalc." := MemLocationCode;
        NewSalesLine.MODIFY(TRUE);
        NewSalesLine.VALIDATE(NewSalesLine."Line Discount %", MemLineDiscount);
        NewSalesLine.VALIDATE(NewSalesLine."Unit Price", MemUnitPrice);
        NewSalesLine.MODIFY(TRUE);
        CLEAR(DimMgt);
        //TODO
        /*DimMgt.InsertDocDim(
           DATABASE::"Sales Line", NewSalesLine."Document Type", NewSalesLine."Document No.", NewSalesLine."Line No.",
           NewSalesLine."Shortcut Dimension 1 Code", NewSalesLine."Shortcut Dimension 2 Code");*/
    end;

    local procedure NoOnFormat()
    begin
        IF Rec."PWD Preparation Status" = 1 THEN
            "No.Emphasize" := TRUE;
    end;

    procedure UpdateKPI()
    var
        RecLKPIRulesSetup: Record "PWD KPI Rules Setup";
    begin
        IF NOT RecLKPIRulesSetup.GET('', 1) THEN EXIT;
        RecLKPIRulesSetup.CALCFIELDS(RecLKPIRulesSetup.KPI);
        IF Rec."PWD Preparation Status" = 1 THEN BEGIN
            Rec."PWD KPI" := RecLKPIRulesSetup.KPI;
            Rec.CALCFIELDS(Rec."PWD KPI");
        END ELSE
            CLEAR(Rec."PWD KPI");
    end;
}
