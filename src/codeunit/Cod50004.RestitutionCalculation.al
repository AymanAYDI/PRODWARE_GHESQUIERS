codeunit 50004 "PWD Restitution Calculation"
{

    trigger OnRun()
    begin
    end;

    var
        RecItem: Record Item;
        RecItem2: Record Item;
        RecUnitItem: Record "Item Unit of Measure";
        RecLocation: Record Location;
        RecRestCalc: Record "PWD RateRestitutionCalculation";
        RecResRestCalc: Record "Result Restitution Calculation";
        SalesShipmentLine: Record "Sales Shipment Line";


    procedure CallShipmentHeader(SalesShipmentHeader: Record "Sales Shipment Header"; Datefilter1: Date; Datefilter2: Date)
    var
        PWDFunctionMgt: Codeunit "PWD Function Mgt";
        QtyPer: Decimal;
        QtyPerSpecif: Decimal;
    begin
        SalesShipmentLine.SETRANGE(SalesShipmentLine."Document No.", SalesShipmentHeader."No.");
        IF SalesShipmentLine.FIND('-') THEN
            IF NOT RecResRestCalc.GET(SalesShipmentLine."Line No.", SalesShipmentLine."Document No.", SalesShipmentLine."No.") THEN
                REPEAT
                    IF SalesShipmentLine."PWD DSA No." <> '0' THEN
                        IF RecLocation.GET(SalesShipmentLine."Location Code") THEN
                            IF RecLocation."PWD Restitution Location" = TRUE THEN
                                IF RecItem.GET(SalesShipmentLine."No.") THEN
                                    IF RecItem."PWD Restitution Key" <> '' THEN BEGIN
                                        RecResRestCalc."Shipment No." := SalesShipmentHeader."No.";
                                        RecResRestCalc."Line No." := SalesShipmentLine."Line No.";
                                        RecResRestCalc."Shipment Date" := SalesShipmentLine."Shipment Date";
                                        RecResRestCalc."Item No." := SalesShipmentLine."No.";
                                        IF RecItem2.GET(RecResRestCalc."Item No.") THEN
                                            RecResRestCalc."NDP 13" := RecItem2."PWD National Add. Code";
                                        IF RecUnitItem.GET(SalesShipmentLine."No.", RecItem."Base Unit of Measure") THEN BEGIN
                                            RecResRestCalc."Unit (Base)" := RecUnitItem.Code;
                                            RecResRestCalc."Quantity (Base)" := RecUnitItem."Qty. per Unit of Measure";
                                        END;
                                        RecRestCalc.SETCURRENTKEY("Restitution Code", "Valid Until");
                                        RecRestCalc.SETRANGE(RecRestCalc."Restitution Code", RecItem."PWD Restitution Key");
                                        RecRestCalc.SETFILTER(RecRestCalc."Valid Until", '%1..%2', Datefilter1, Datefilter2);
                                        QtyPer := PWDFunctionMgt.GetQtyPerFromUnitToUnit(RecItem,
                                        SalesShipmentLine."Unit of Measure Code", RecItem."Base Unit of Measure");
                                        IF RecRestCalc.FIND('+') THEN BEGIN
                                            QtyPerSpecif := QtyPer * SalesShipmentLine.Quantity;
                                            RecResRestCalc."Restitution Quantity" := QtyPerSpecif / RecRestCalc.Quantity;
                                            RecResRestCalc."Restitution Unit" := RecRestCalc."Unit Code";
                                            RecResRestCalc."Rate (%)" := RecRestCalc."Rate (%)";
                                            RecResRestCalc."Restitution Amount" := RecResRestCalc."Restitution Quantity" / RecRestCalc."Rate (%)";
                                        END;
                                        RecResRestCalc.INSERT(TRUE);
                                    END;
                UNTIL SalesShipmentLine.NEXT() = 0;
    end;

    procedure FindSalesHeaderNo(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
    end;
}

