codeunit 60001 "PWD Function Mgt"
{
    var
        TempPurchPrice: Record "Purchase Price";

    //---TAB39---
    procedure FctOnBeforeUpdateSpecialSalesOrderLineFromOnDeleteT39(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line")
    var
        AppTenders: Record "PWD Appeal for Tenders";
    begin
        IF (PurchaseLine."PWD Sales Line No. Appeal Tenders" <> 0) THEN BEGIN
            PurchaseLine.LOCKTABLE();
            SalesOrderLine.LOCKTABLE();
            SalesOrderLine.GET(
              PurchaseLine."PWD Sales Type Doc Appeal tenders", PurchaseLine."PWD Sales No. Appeal Tenders", PurchaseLine."PWD Sales Line No. Appeal Tenders");

            SalesOrderLine.CALCFIELDS(PurchaseLine."PWD Nb Purchase Quote");
            IF SalesOrderLine."PWD Nb Purchase Quote" = 1 THEN BEGIN

                SalesOrderLine."PWD Order Trading brand" := FALSE;
                SalesOrderLine.MODIFY();

                AppTenders.SETRANGE("Document Type", PurchaseLine."Sales Type Doc Appeal tenders");
                AppTenders.SETRANGE("Document No.", PurchaseLine."Sales No. Appeal Tenders");
                AppTenders.SETRANGE("Line No. document", PurchaseLine."Sales Line No. Appeal Tenders");
                IF AppTenders.FIND('-') THEN
                    AppTenders.DELETEALL();
            END;

            IF SalesOrderLine."PWD Order Trading brand" = TRUE THEN BEGIN
                PurchaseLine."PWD Sales Type Doc Appeal tenders" := 0;
                SalesOrderLine."PWD Trad. Brand Order Purch No." := '';
                SalesOrderLine."PWD Trad. Br Order Purch. Line No." := 0;
                SalesOrderLine."PWD Trading Brand" := FALSE;
                SalesOrderLine.MODIFY();

                AppTenders.SETRANGE("Document Type", PurchaseLine."PWD Sales Type Doc Appeal tenders");
                AppTenders.SETRANGE("Document No.", PurchaseLine."PWD Sales No. Appeal Tenders");
                AppTenders.SETRANGE("Line No. document", PurchaseLine."PWD Sales Line No. Appeal Tenders");
                IF AppTenders.FIND('-') THEN
                    AppTenders.DELETEALL();
            END;


        END;
    end;

    procedure FctOnAfterValidateLocationCodeT39(var Rec: Record "Purchase Line")
    var
        Location: Record Location;
        PurchHeader: Record "Purchase Header";
    begin
        IF Location.GET(Rec."Location Code") THEN BEGIN
            IF Location."PWD Shortcut Dimension 1 Code" <> '' THEN
                Rec.VALIDATE("Shortcut Dimension 1 Code", Location."PWD Shortcut Dimension 1 Code");
            IF Location."PWD Shortcut Dimension 2 Code" <> '' THEN
                Rec.VALIDATE("Shortcut Dimension 2 Code", Location."PWD Shortcut Dimension 2 Code");
        END;

        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        IF Location.GET(Rec."Location Code") THEN BEGIN
            IF Location."PWD Purch. Gen. Bus. Posting Group" <> '' THEN
                Rec.VALIDATE("Gen. Bus. Posting Group", Location."PWD Purch. Gen. Bus. Posting Group")
            ELSE BEGIN
                Rec.GetPurchHeader();
                Rec.VALIDATE("Gen. Bus. Posting Group", PurchHeader."Gen. Bus. Posting Group");
            END;
        END ELSE BEGIN
            Rec.GetPurchHeader();
            Rec.VALIDATE("Gen. Bus. Posting Group", PurchHeader."Gen. Bus. Posting Group");
        END;
    end;

    procedure FctOnValidateQuantityOnBeforeDropShptCheckT39(var PurchaseLine: Record "Purchase Line")
    var
        SalesLineSpeciale: Record "Sales Line";
    begin
        IF PurchaseLine."Special Order" = TRUE THEN BEGIN
            SalesLineSpeciale.RESET();
            SalesLineSpeciale.SETRANGE("Document No.", PurchaseLine."Special Order Sales No.");
            SalesLineSpeciale.SETRANGE("Line No.", PurchaseLine."Special Order Sales Line No.");
            IF SalesLineSpeciale.FIND('-') THEN BEGIN
                SalesLineSpeciale.SuspendStatusCheck(TRUE);
                SalesLineSpeciale.VALIDATE(Quantity, PurchaseLine.Quantity);
                SalesLineSpeciale.SuspendStatusCheck(FALSE);
                SalesLineSpeciale.MODIFY();
            END;
        END;
        IF PurchaseLine."PWD Sales No. Appeal Tenders" <> '' THEN BEGIN
            SalesLineSpeciale.RESET();
            SalesLineSpeciale.SETRANGE("Document Type", PurchaseLine."PWD Sales Type Doc Appeal tenders");
            SalesLineSpeciale.SETRANGE("Document No.", PurchaseLine."PWD Sales No. Appeal Tenders");
            SalesLineSpeciale.SETRANGE("Line No.", PurchaseLine."PWD Sales Line No. Appeal Tenders");
            IF SalesLineSpeciale.FIND('-') THEN BEGIN
                SalesLineSpeciale.SuspendStatusCheck(TRUE);
                SalesLineSpeciale.VALIDATE(Quantity, PurchaseLine.Quantity);
                SalesLineSpeciale.SuspendStatusCheck(FALSE);
                SalesLineSpeciale.MODIFY();
            END;
        END;
    end;

    procedure FctOnAfterValidateQtytoInvoiceT39(var PurchaseLine: Record "Purchase Line")
    var
        SalesLineSpeciale: Record "Sales Line";
    begin
        IF PurchaseLine."Special Order" = TRUE THEN BEGIN
            SalesLineSpeciale.RESET();
            SalesLineSpeciale.SETRANGE("Document No.", PurchaseLine."Special Order Sales No.");
            SalesLineSpeciale.SETRANGE("Line No.", PurchaseLine."Special Order Sales Line No.");
            IF SalesLineSpeciale.FIND('-') THEN BEGIN
                SalesLineSpeciale.SuspendStatusCheck(TRUE);
                SalesLineSpeciale.VALIDATE("Qty. to Ship", PurchaseLine."Qty. to Receive");
                SalesLineSpeciale.SuspendStatusCheck(FALSE);
                SalesLineSpeciale.MODIFY();
            END;
        END;
        IF PurchaseLine."PWD Sales No. Appeal Tenders" <> '' THEN BEGIN
            SalesLineSpeciale.RESET();
            SalesLineSpeciale.SETRANGE("Document Type", PurchaseLine."PWD Sales Type Doc Appeal tenders");
            SalesLineSpeciale.SETRANGE("Document No.", PurchaseLine."PWD Sales No. Appeal Tenders");
            SalesLineSpeciale.SETRANGE("Line No.", PurchaseLine."PWD Sales Line No. Appeal Tenders");
            IF SalesLineSpeciale.FIND('-') THEN BEGIN
                SalesLineSpeciale.SuspendStatusCheck(TRUE);
                SalesLineSpeciale.VALIDATE("Qty. to Ship", PurchaseLine."Qty. to Receive");
                SalesLineSpeciale.SuspendStatusCheck(FALSE);
                SalesLineSpeciale.MODIFY();
            END;
        END;
    end;

    //CDU 7010
    procedure FindItemPurchPrice(VAR ToPurchPrice: Record "Purchase Price"; ItemNo: Code[20]; StartingDate: Date; ShowAll: Boolean)
    var
        FromPurchPrice: Record "Purchase Price";
    begin

        FromPurchPrice.SETRANGE("Item No.", ItemNo);
        FromPurchPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
        IF NOT ShowAll THEN
            FromPurchPrice.SETRANGE("Starting Date", 0D, StartingDate);

        ToPurchPrice.RESET();
        ToPurchPrice.DELETEALL();
        IF FromPurchPrice.FIND('-') THEN
            REPEAT
                IF FromPurchPrice."Direct Unit Cost" <> 0 THEN BEGIN
                    ToPurchPrice := FromPurchPrice;
                    ToPurchPrice.INSERT();
                END;
            UNTIL FromPurchPrice.NEXT() = 0;
    end;

    procedure ItemPurchLinePriceExists(ItemNo: Code[20]; OrderDate: date; ShowAll: Boolean): Boolean
    var
        Item: Record Item;
    begin
        IF ItemNo <> '' THEN
            IF Item.GET(ItemNo) THEN BEGIN
                FindItemPurchPrice(
                  TempPurchPrice, ItemNo, OrderDate, ShowAll);
                EXIT(TempPurchPrice.FIND('-'));
            END;
        EXIT(FALSE);
    end;

    procedure GetItemPurchLinePrice(ItemNo: Code[20]; OrderDate: Date)
    var
    begin
        ItemPurchLinePriceExists(ItemNo, OrderDate, TRUE);
        IF Page.RUNMODAL(Page::"Get Purchase Price", TempPurchPrice) = ACTION::OK THEN;
    end;

    procedure CalcNoOfPurchPricesFromPurchLi(RecPPurchaseLine: Record "Purchase Line"): Integer
    var
        SalesLine: Record "Sales Line";
        RecLSalesHeader: Record "Sales Header";
        Item: Record Item;
    begin
        IF (SalesLine.Type = SalesLine.Type::Item) AND Item.GET(SalesLine."No.") THEN
            IF RecLSalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
                EXIT(NoOfItemPurchLinePrice(SalesLine."No.", RecLSalesHeader."Order Date", TRUE));
        EXIT(0);
    end;

    procedure NoOfItemPurchLinePrice(ItemNo: Code[20]; OrderDate: Date; ShowAll: Boolean): Integer
    var
    begin
        IF ItemPurchLinePriceExists(ItemNo, OrderDate, ShowAll) THEN
            EXIT(TempPurchPrice.COUNT);
    end;
}
