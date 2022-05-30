codeunit 50013 "PWD delete ligne anomalie"
{
    TableNo = "Sales Line";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        SalesHeader2: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ReleaseSales: Codeunit "Release Sales Document";
    begin
        SalesLine := Rec;
        SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
        IF SalesHeader.Status = SalesHeader.Status::Released THEN BEGIN
            CLEAR(ReleaseSales);
            ReleaseSales.Reopen(SalesHeader);
            SalesLine.DELETE();
            ReleaseSales.RUN(SalesHeader);
        END;
        CLEAR(ReleaseSales);
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        ReleaseSales.RUN(SalesHeader2);
    end;
}
