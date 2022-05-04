page 50058 "PWD Check Availability Prep"
{
    Caption = 'Check Availability';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                label(Control2)
                {
                    CaptionClass = Text19051598;
                    MultiLine = true;
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(InventoryQty; InventoryQty)
                {
                    Caption = 'Inventory';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(GrossReq; GrossReq)
                {
                    Caption = 'Gross Requirement';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(SchedRcpt; SchedRcpt)
                {
                    Caption = 'Scheduled Receipt';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("-ItemNetChange"; -ItemNetChange)
                {
                    Caption = 'Current Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("InitialQtyAvailable+ItemNetChange"; InitialQtyAvailable + ItemNetChange)
                {
                    Caption = 'Total Quantity';
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    ApplicationArea = All;
                }
                field(EarliestAvailDate; EarliestAvailDate)
                {
                    Caption = 'Earliest Availability Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    ApplicationArea = All;
                }
            }
            group(Dimensions)
            {
                Caption = 'Dimensions';
                field("Variant Filter"; Rec."Variant Filter")
                {
                    Editable = false;
                    Lookup = false;
                    ApplicationArea = All;
                }
                field("Location Filter"; Rec."Location Filter")
                {
                    Editable = false;
                    Lookup = false;
                    ApplicationArea = All;
                }
                field(UnitOfMeasureCode; UnitOfMeasureCode)
                {
                    Caption = 'Unit of Measure Code';
                    Editable = false;
                    Lookup = false;
                    ApplicationArea = All;
                }
                field("Date Filter"; Rec."Date Filter")
                {
                    Editable = false;
                    Lookup = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.COPY(Item2);
    end;

    var
        CompanyInfo: Record "Company Information";
        Item2: Record Item;
        OldSalesLine: Record "Sales Line";
        AvailToPromise: Codeunit "Available to Promise";
        SetupDataIsPresent: Boolean;
        UseOrderPromise: Boolean;
        UnitOfMeasureCode: Code[10];
        ItemNo: Code[20];
        EarliestAvailDate: Date;
        OldItemShipmentDate: Date;
        AvailableQty: Decimal;
        GrossReq: Decimal;
        InitialQtyAvailable: Decimal;
        InventoryQty: Decimal;
        ItemNetChange: Decimal;
        NewItemNetChange: Decimal;
        OldItemNetChange: Decimal;
        QtyPerUnitOfMeasure: Decimal;
        SchedRcpt: Decimal;
        Text19051598: Label 'The quantity on inventory is not sufficient to cover the net change in inventory.';


    procedure SalesLineShowWarning(SalesLine: Record "Sales Line"): Boolean
    begin
        OldItemNetChange := 0;
        OldSalesLine := SalesLine;
        IF OldSalesLine.FIND() THEN
            IF (OldSalesLine."Document Type" = OldSalesLine."Document Type"::Order) AND
               (OldSalesLine."No." = SalesLine."No.") AND
               (OldSalesLine."Variant Code" = SalesLine."Variant Code") AND
               (OldSalesLine."Location Code" = SalesLine."Location Code") AND
               (OldSalesLine."Bin Code" = SalesLine."Bin Code") AND
               NOT OldSalesLine."Drop Shipment"
            THEN
                OldItemNetChange := -OldSalesLine."PWD Prepared Quantity (Base)";

        IF SalesLine."Document Type" = SalesLine."Document Type"::Order THEN
            UseOrderPromise := TRUE;
        EXIT(
          ShowWarning(
            SalesLine."No.",
            SalesLine."Variant Code",
            SalesLine."Location Code",
            SalesLine."Bin Code",
            SalesLine."Unit of Measure Code",
            SalesLine."Qty. per Unit of Measure",
            -SalesLine."PWD Prepared Quantity",
            OldItemNetChange,
            SalesLine."Shipment Date",
            OldSalesLine."Shipment Date",
            SalesLine."Qty. to Ship"));
    end;

    local procedure ShowWarning(ItemNo2: Code[20]; ItemVariantCode: Code[10]; ItemLocationCode: Code[10]; ItemBinCode: Code[20]; UnitOfMeasureCode2: Code[10]; QtyPerUnitOfMeasure2: Decimal; NewItemNetChange2: Decimal; OldItemNetChange2: Decimal; ShipmentDate: Date; OldShipmentDate: Date; QtyToShip: Decimal): Boolean
    begin
        ItemNo := ItemNo2;
        UnitOfMeasureCode := UnitOfMeasureCode2;
        QtyPerUnitOfMeasure := QtyPerUnitOfMeasure2;
        NewItemNetChange := NewItemNetChange2;
        OldItemNetChange := ConvertQty(OldItemNetChange2);
        OldItemShipmentDate := OldShipmentDate;

        IF NewItemNetChange >= 0 THEN
            EXIT(FALSE);

        Rec.GET(ItemNo);
        Rec.SETRANGE("No.", Rec."No.");
        Rec.SETRANGE("Variant Filter", ItemVariantCode);
        Rec.SETRANGE("Location Filter", ItemLocationCode);
        Rec.SETRANGE("Bin Filter", ItemBinCode);
        Rec.SETRANGE("Drop Shipment Filter", FALSE);

        IF UseOrderPromise THEN
            Rec.SETRANGE("Date Filter", 0D, ShipmentDate)
        ELSE
            Rec.SETRANGE("Date Filter", 0D, WORKDATE());

        Item2.COPY(Rec);

        Calculate(QtyToShip);
        EXIT(InitialQtyAvailable + ItemNetChange < 0);
    end;

    local procedure Calculate(QtyToShip: Decimal)
    Var
        PWDFunctionMgt: codeunit "PWD Function Mgt";
    begin
        IF NOT SetupDataIsPresent THEN
            GetSetupData();

        PWDFunctionMgt.PrepQtyAvailabletoPromise(
          Rec, GrossReq, SchedRcpt, Rec.GETRANGEMAX("Date Filter"),
          CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");

        EarliestAvailDate :=
          AvailToPromise.EarliestAvailabilityDate(
            Rec, -NewItemNetChange, Rec.GETRANGEMAX("Date Filter"), -OldItemNetChange, OldItemShipmentDate, AvailableQty,
            CompanyInfo."Check-Avail. Time Bucket", CompanyInfo."Check-Avail. Period Calc.");

        IF NOT UseOrderPromise THEN
            SchedRcpt := 0;

        Rec.CALCFIELDS(Inventory, "Reserved Qty. on Inventory");
        InventoryQty := ConvertQty(Rec.Inventory - Rec."Reserved Qty. on Inventory");
        GrossReq := ConvertQty(GrossReq);
        SchedRcpt := ConvertQty(SchedRcpt);

        ItemNetChange := 0;
        IF Rec."No." = ItemNo THEN BEGIN
            ItemNetChange := NewItemNetChange;
            GrossReq := GrossReq + OldItemNetChange;
        END;

        InitialQtyAvailable := InventoryQty + SchedRcpt - GrossReq;
    end;

    local procedure ConvertQty(Qty: Decimal): Decimal
    begin
        IF QtyPerUnitOfMeasure = 0 THEN
            QtyPerUnitOfMeasure := 1;
        EXIT(ROUND(Qty / QtyPerUnitOfMeasure, 0.00001));
    end;


    procedure GetSetupData()
    begin
        CompanyInfo.GET();
        SetupDataIsPresent := TRUE;
    end;
}

