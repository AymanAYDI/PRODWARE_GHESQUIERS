report 50047 "Màj Certificate Transit No."
{
    Permissions = TableData "Purch. Rcpt. Line" = rm,
                  TableData "Purch. Inv. Line" = rm;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Tasks;
    dataset
    {
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF Recept <> '' THEN BEGIN
            RecRecept.SETFILTER(RecRecept."Document No.", Recept);
            IF RecRecept.FindSet() THEN
                REPEAT
                    RecRecept."PWD Cetificate Transit No." := NewCertif;
                    RecRecept.MODIFY();
                UNTIL RecRecept.NEXT() <= 0
            ELSE
                MESSAGE('Réception non trouvée');
        END;
        IF Facture <> '' THEN BEGIN
            RecFacture.SETFILTER(RecFacture."Document No.", Facture);
            IF RecFacture.FindSet() THEN
                REPEAT
                    RecFacture."PWD Cetificate Transit No." := NewCertif;
                    RecFacture.MODIFY();
                UNTIL RecFacture.NEXT() <= 0
            ELSE
                MESSAGE('Facture non trouvée');
        END;
    end;

    var
        RecFacture: Record "Purch. Inv. Line";
        RecRecept: Record "Purch. Rcpt. Line";
        Facture: Code[20];
        Recept: Code[20];
        NewCertif: Code[50];
}
