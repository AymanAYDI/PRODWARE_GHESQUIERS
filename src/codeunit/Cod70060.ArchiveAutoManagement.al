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
        Text001: Label 'Document %1 has been archived.';
        Text002: Label 'Do you want to Restore %1 %2 Version %3?';
        Text003: Label '%1 %2 has been restored.';
        Text004: Label 'Document restored from Version %1.';
        Text005: Label '%1 %2 has been partly posted.\Restore not possible.';
        Text006: Label 'Entries exist for on or more of the following:\  - %1\  - %2\  - %3.\Restoration of document will delete these entries.\Continue with restore?';
        Text007: Label 'Archive %1 no.: %2?';
        Text008: Label 'Item Tracking Line';
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        Ok: Boolean;


    procedure StoreSalesDocument(SalesHeader: Record "Sales Header")
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line";
        SalesHeaderArchive: Record "PWD Archived Sales Header";
        SalesLineArchive: Record "PWD Archived Sales Line";
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
          DATABASE::"Sales Header", SalesHeader."Document Type", SalesHeader."No.", SalesHeader."Doc. No. Occurrence");
        SalesHeaderArchive."Last Version" := TRUE;
        SalesHeaderArchive.INSERT();

        StoreDocDim(
          DATABASE::"Sales Header", SalesHeader."Document Type",
          SalesHeader."No.", 0, SalesHeader."Doc. No. Occurrence", SalesHeaderArchive."Version No.");

        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.FIND('-') THEN
            REPEAT
                SalesLineArchive.INIT();
                SalesLineArchive.TRANSFERFIELDS(SalesLine);
                SalesLineArchive."Doc. No. Occurrence" := SalesHeader."Doc. No. Occurrence";
                SalesLineArchive."Version No." := SalesHeaderArchive."Version No.";
                SalesLineArchive."Last Version" := TRUE;
                SalesLineArchive.INSERT();
                StoreDocDim(
                  DATABASE::"Sales Line", SalesLine."Document Type", SalesLine."Document No.",
                  SalesLine."Line No.", SalesHeader."Doc. No. Occurrence", SalesLineArchive."Version No.");
            UNTIL SalesLine.NEXT() = 0;
    end;


    procedure StorePurchDocument(PurchHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchLine: Record "Purchase Line";
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
          DATABASE::"Purchase Header", PurchHeader."Document Type", PurchHeader."No.", PurchHeader."Doc. No. Occurrence");
        PurchHeaderArchive."Last Version" := TRUE;
        PurchHeaderArchive.INSERT();

        StoreDocDim(
          DATABASE::"Purchase Header", PurchHeader."Document Type",
          PurchHeader."No.", 0, PurchHeader."Doc. No. Occurrence", PurchHeaderArchive."Version No.");

        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FIND('-') THEN
            REPEAT
                PurchLineArchive.INIT();
                PurchLineArchive.TRANSFERFIELDS(PurchLine);
                PurchLineArchive."Doc. No. Occurrence" := PurchHeader."Doc. No. Occurrence";
                PurchLineArchive."Version No." := PurchHeaderArchive."Version No.";
                PurchLineArchive."Last Version" := TRUE;
                PurchLineArchive.INSERT();
                StoreDocDim(
                  DATABASE::"Purchase Line", PurchLine."Document Type", PurchLine."Document No.",
                  PurchLine."Line No.", PurchHeader."Doc. No. Occurrence", PurchLineArchive."Version No.");
            UNTIL PurchLine.NEXT() = 0;
    end;


    procedure GetNextOccurrenceNo(TableId: Integer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Integer
    var
        SalesHeaderArchive: Record "PWD Archived Sales Header";
        PurchHeaderArchive: Record "PWD Archived Purchase Header";
    begin
        CASE TableId OF
            DATABASE::"Sales Header":
                BEGIN
                    SalesHeaderArchive.LOCKTABLE();
                    SalesHeaderArchive.SETRANGE("Document Type", DocType);
                    SalesHeaderArchive.SETRANGE("No.", DocNo);
                    IF SalesHeaderArchive.FIND('+') THEN
                        EXIT(SalesHeaderArchive."Doc. No. Occurrence" + 1)
                    ELSE
                        EXIT(1);
                END;
            DATABASE::"Purchase Header":
                BEGIN
                    PurchHeaderArchive.LOCKTABLE();
                    PurchHeaderArchive.SETRANGE("Document Type", DocType);
                    PurchHeaderArchive.SETRANGE("No.", DocNo);
                    IF PurchHeaderArchive.FIND('+') THEN
                        EXIT(PurchHeaderArchive."Doc. No. Occurrence" + 1)
                    ELSE
                        EXIT(1);
                END;
        END;
    end;


    procedure GetNextVersionNo(TableId: Integer; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]; DocNoOccurrence: Integer): Integer
    var
        SalesHeaderArchive: Record "PWD Archived Sales Header";
        PurchHeaderArchive: Record "PWD Archived Purchase Header";
    begin
        CASE TableId OF
            DATABASE::"Sales Header":
                BEGIN
                    SalesHeaderArchive.LOCKTABLE();
                    SalesHeaderArchive.SETRANGE("Document Type", DocType);
                    SalesHeaderArchive.SETRANGE("No.", DocNo);
                    SalesHeaderArchive.SETRANGE("Doc. No. Occurrence", DocNoOccurrence);
                    IF SalesHeaderArchive.FIND('+') THEN
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
                    IF PurchHeaderArchive.FIND('+') THEN
                        EXIT(PurchHeaderArchive."Version No." + 1)
                    ELSE
                        EXIT(1);
                END;
        END;
    end;


    procedure StoreDocDim(TableId: Integer; DocType: Option; DocNo: Code[20]; LineNo: Integer; DocNoOccurrence: Integer; VersionNo: Integer)
    var
    // DocDim: Record "PWD Document Dimension";
    //  DocDimArchive: Record "PWD Document Dimension Archive";
    begin
        //MISE EN COMMENTAIRE GTE CAR PAS AUTORISATION AVITA SUR LA TABLE

        /*
        DocDim.SETRANGE("Table ID",TableId);
        DocDim.SETRANGE("Document Type",DocType);
        DocDim.SETRANGE("Document No.",DocNo);
        DocDim.SETRANGE("Line No.",LineNo);
        IF DocDim.FIND('-') THEN
          REPEAT
            DocDimArchive.INIT;
            DocDimArchive.TRANSFERFIELDS(DocDim);
            DocDimArchive."Version No." := VersionNo;
            DocDimArchive."Doc. No. Occurrence" := DocNoOccurrence;
            DocDimArchive.INSERT;
          UNTIL DocDim.NEXT = 0;
        */

    end;
}

