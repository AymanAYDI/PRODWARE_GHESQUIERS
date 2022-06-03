codeunit 70060 "PWD ArchiveAutoManagement"
{
    Permissions = TableData "Pwd Archived Sales Header" = i,
                  TableData "PWD Archived Sales Line" = i,
                  TableData "PWD Archived Purchase Header" = i,
                  TableData "PWD Archived Purchase Line" = i;

    trigger OnRun()
    begin
    end;

    var
        Ok: Boolean;

    procedure StoreSalesDocument(SalesHeader: Record "Sales Header")
    var
        SalesHeaderArchive: Record "PWD Archived Sales Header";
        SalesLineArchive: Record "PWD Archived Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
    begin
        SalesSetup.GET();
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::Order:
                Ok := SalesSetup."Archive Orders";
            SalesHeader."Document Type"::Quote:
                Ok := SalesSetup."PWD Archive Quotes";
        END;
        IF NOT Ok THEN
            EXIT;

        SalesHeaderArchive.INIT();
        SalesHeaderArchive.TRANSFERFIELDS(SalesHeader);
        SalesHeaderArchive."Archived By" := USERID;
        SalesHeaderArchive."Date Archived" := WORKDATE();
        SalesHeaderArchive."Time Archived" := TIME;
        SalesHeaderArchive."Version No." := GetNextVersionNo(
          DATABASE::"Sales Header", SalesHeader."Document Type".AsInteger(), SalesHeader."No.", SalesHeader."Doc. No. Occurrence");
        SalesHeaderArchive."Last Version" := TRUE;
        SalesHeaderArchive.INSERT();
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.FindSet() THEN
            REPEAT
                SalesLineArchive.INIT();
                SalesLineArchive.TRANSFERFIELDS(SalesLine);
                SalesLineArchive."Doc. No. Occurrence" := SalesHeader."Doc. No. Occurrence";
                SalesLineArchive."Version No." := SalesHeaderArchive."Version No.";
                SalesLineArchive."Last Version" := TRUE;
                SalesLineArchive.INSERT();
            UNTIL SalesLine.NEXT() = 0;
    end;

    procedure StorePurchDocument(PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchHeaderArchive: Record "PWD Archived Purchase Header";
        PurchLineArchive: Record "PWD Archived Purchase Line";
    begin
        PurchSetup.GET();
        CASE PurchHeader."Document Type" OF
            PurchHeader."Document Type"::Order:
                Ok := PurchSetup."Archive Orders";
            PurchHeader."Document Type"::Quote:
                Ok := PurchSetup."PWD Archive Quotes";
        END;
        IF NOT Ok THEN
            EXIT;
        PurchHeaderArchive.INIT();
        PurchHeaderArchive.TRANSFERFIELDS(PurchHeader);
        PurchHeaderArchive."Archived By" := USERID;
        PurchHeaderArchive."Date Archived" := WORKDATE();
        PurchHeaderArchive."Time Archived" := TIME;
        PurchHeaderArchive."Version No." := GetNextVersionNo(
          DATABASE::"Purchase Header", PurchHeader."Document Type".AsInteger(), PurchHeader."No.", PurchHeader."Doc. No. Occurrence");
        PurchHeaderArchive."Last Version" := TRUE;
        PurchHeaderArchive.INSERT();
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FindSet() THEN
            REPEAT
                PurchLineArchive.INIT();
                PurchLineArchive.TRANSFERFIELDS(PurchLine);
                PurchLineArchive."Doc. No. Occurrence" := PurchHeader."Doc. No. Occurrence";
                PurchLineArchive."Version No." := PurchHeaderArchive."Version No.";
                PurchLineArchive."Last Version" := TRUE;
                PurchLineArchive.INSERT();
            UNTIL PurchLine.NEXT() = 0;
    end;

    procedure GetNextOccurrenceNo(TableId: Integer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Integer
    var
        PurchHeaderArchive: Record "PWD Archived Purchase Header";
        SalesHeaderArchive: Record "PWD Archived Sales Header";
    begin
        CASE TableId OF
            DATABASE::"Sales Header":
                BEGIN
                    SalesHeaderArchive.LOCKTABLE();
                    SalesHeaderArchive.SETRANGE("Document Type", DocType);
                    SalesHeaderArchive.SETRANGE("No.", DocNo);
                    IF SalesHeaderArchive.FindLast() THEN
                        EXIT(SalesHeaderArchive."Doc. No. Occurrence" + 1)
                    ELSE
                        EXIT(1);
                END;
            DATABASE::"Purchase Header":
                BEGIN
                    PurchHeaderArchive.LOCKTABLE();
                    PurchHeaderArchive.SETRANGE("Document Type", DocType);
                    PurchHeaderArchive.SETRANGE("No.", DocNo);
                    IF PurchHeaderArchive.FindLast() THEN
                        EXIT(PurchHeaderArchive."Doc. No. Occurrence" + 1)
                    ELSE
                        EXIT(1);
                END;
        END;
    end;

    procedure GetNextVersionNo(TableId: Integer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]; DocNoOccurrence: Integer): Integer
    var
        PurchHeaderArchive: Record "PWD Archived Purchase Header";
        SalesHeaderArchive: Record "PWD Archived Sales Header";
    begin
        CASE TableId OF
            DATABASE::"Sales Header":
                BEGIN
                    SalesHeaderArchive.LOCKTABLE();
                    SalesHeaderArchive.SETRANGE("Document Type", DocType);
                    SalesHeaderArchive.SETRANGE("No.", DocNo);
                    SalesHeaderArchive.SETRANGE("Doc. No. Occurrence", DocNoOccurrence);
                    IF SalesHeaderArchive.FindLast() THEN
                        EXIT(SalesHeaderArchive."Version No." + 1)
                    ELSE
                        EXIT(1);
                END;
            DATABASE::"Purchase Header":
                BEGIN
                    PurchHeaderArchive.LOCKTABLE();
                    PurchHeaderArchive.SETRANGE("Document Type", DocType);
                    PurchHeaderArchive.SETRANGE("No.", DocNo);
                    PurchHeaderArchive.SETRANGE("Doc. No. Occurrence", DocNoOccurrence);
                    IF PurchHeaderArchive.FindLast() THEN
                        EXIT(PurchHeaderArchive."Version No." + 1)
                    ELSE
                        EXIT(1);
                END;
        END;
    end;
}
