codeunit 50013 "PWD delete ligne anomalie"
{
    TableNo = "Sales Line";

    trigger OnRun()
    var
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        ReleaseSales: Codeunit "Release Sales Document";
        SalesHeader2: Record "Sales Header";
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
        SalesHeader.GET("Document Type", "Document No.");
        ReleaseSales.RUN(SalesHeader2);
    end;
}

