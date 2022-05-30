codeunit 50023 "PWD Run douane2"
{
    trigger OnRun()
    var
        SalesShipHeader: Record "Sales Shipment Header";
    begin
        CLEAR(SalesShipHeader);
        SalesShipHeader.SETFILTER("PWD Location Filter", 'CML|1|5|6|7|8|9|9HCEE');
        REPORT.RUNMODAL(REPORT::"Relevé des Sorties Export 2", TRUE, TRUE, SalesShipHeader);
    end;
}
