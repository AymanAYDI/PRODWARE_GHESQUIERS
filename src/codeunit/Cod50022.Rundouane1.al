codeunit 50022 "PWD Run douane1"
{
    trigger OnRun()
    var
        SalesShipHeader: Record "Sales Shipment Header";
    begin
        CLEAR(SalesShipHeader);
        SalesShipHeader.SETFILTER("PWD Location Filter", '3');
        REPORT.RUNMODAL(REPORT::"Relevé des Sorties Export", TRUE, TRUE, SalesShipHeader);
    end;
}

