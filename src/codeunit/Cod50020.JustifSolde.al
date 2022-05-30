codeunit 50020 "PWD Justif Solde"
{
    trigger OnRun()
    begin
    end;

    var
        CltEcritures_Lues: Record "Cust. Ledger Entry";
        FrsEcritures_Lues: Record "Vendor Ledger Entry";

    procedure "CltEcritureNonSoldée"(var CltEcriture: Record "Cust. Ledger Entry"; Date_Arrete: Date) RET: Boolean
    begin

        IF CltEcritures_Lues.GET(CltEcriture."Entry No.") THEN
            CltEcritures_Lues.MARK := TRUE;

        // Si l'écriture est postérieure à la date d'arrete alors elle ne l'était pas
        // lors de la date d'arrete
        IF CltEcriture."Posting Date" > Date_Arrete THEN EXIT(TRUE);
        // Si l'ecriture est ouverte aujourd'hui alors elle l'est en date de Date_Arrete
        IF CltEcriture.Open THEN EXIT(TRUE);

        // Si l'écriture a été soldée par une écriture qui n'était pas soldée alors elle n'était
        // elle même pas soldée
        IF (CltEcritures_Lues.GET(CltEcriture."Closed by Entry No.")) THEN
            IF (NOT CltEcritures_Lues.MARK()) THEN
                IF (CltEcritureNonSoldée(CltEcritures_Lues, Date_Arrete)) THEN EXIT(TRUE);

        // Si l'écriture solde une écriture qui n'était pas soldée alors elle n'était
        // elle même pas soldée
        CltEcritures_Lues.SETCURRENTKEY("Closed by Entry No.");
        CltEcritures_Lues.SETRANGE("Closed by Entry No.", CltEcriture."Entry No.", CltEcriture."Entry No.");
        IF CltEcritures_Lues.FIND('-') THEN
            REPEAT
                IF (NOT CltEcritures_Lues.MARK()) THEN
                    IF (CltEcritureNonSoldée(CltEcritures_Lues, Date_Arrete)) THEN EXIT(TRUE);
            UNTIL CltEcritures_Lues.NEXT() = 0;

        EXIT(FALSE);
    end;

    procedure "FrsEcritureNonSoldée"(var FrsEcriture: Record "Vendor Ledger Entry"; Date_Arrete: Date) RET: Boolean
    begin

        IF FrsEcritures_Lues.GET(FrsEcriture."Entry No.") THEN
            FrsEcritures_Lues.MARK := TRUE;

        // Si l'écriture est postérieure à la date d'arrete alors elle ne l'était pas
        // lors de la date d'arrete
        IF FrsEcriture."Posting Date" > Date_Arrete THEN EXIT(TRUE);
        // Si l'ecriture est ouverte aujourd'hui alors elle l'est en date de Date_Arrete
        IF FrsEcriture.Open THEN EXIT(TRUE);

        // Si l'écriture a été soldée par une écriture qui n'était pas soldée alors elle n'était
        // elle même pas soldée
        IF (FrsEcritures_Lues.GET(FrsEcriture."Closed by Entry No.")) THEN
            IF (NOT FrsEcritures_Lues.MARK()) THEN
                IF (FrsEcritureNonSoldée(FrsEcritures_Lues, Date_Arrete)) THEN EXIT(TRUE);

        // Si l'écriture solde une écriture qui n'était pas soldée alors elle n'était
        // elle même pas soldée
        FrsEcritures_Lues.SETCURRENTKEY("Closed by Entry No.");
        FrsEcritures_Lues.SETRANGE("Closed by Entry No.", FrsEcriture."Entry No.", FrsEcriture."Entry No.");
        IF FrsEcritures_Lues.FIND('-') THEN
            REPEAT
                IF (NOT FrsEcritures_Lues.MARK()) THEN
                    IF (FrsEcritureNonSoldée(FrsEcritures_Lues, Date_Arrete)) THEN EXIT(TRUE);
            UNTIL FrsEcritures_Lues.NEXT() = 0;

        EXIT(FALSE);
    end;
}
