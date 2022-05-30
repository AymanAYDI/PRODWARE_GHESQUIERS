report 50006 "Accept selected offers -TrB"
{
    // *** Contremarque - C2A
    // Accepter les offres fournisseurs

    Caption = 'Accept selected offers';
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = WHERE("PWD Trading Brand" = CONST(true));

                trigger OnAfterGetRecord()
                var
                    CurrExRate: Record "Currency Exchange Rate";
                    PuchQuoteHeader: Record "Purchase Header";
                    UnitCost: Decimal;
                begin
                    PurchQuoteLine.SETRANGE("PWD Sales Type Doc Appeal tenders", "Sales Line"."Document Type".AsInteger());
                    PurchQuoteLine.SETRANGE("PWD Sales No. Appeal Tenders", "Sales Line"."Document No.");

                    PurchQuoteLine.SETRANGE("PWD Sales Line No. Appeal Tenders", "Sales Line"."Line No.");
                    PurchQuoteLine.SETRANGE("PWD Selected Quote", TRUE);
                    NbRecord := PurchQuoteLine.COUNT;

                    IF NbRecord <> 1 THEN BEGIN
                        IF NbRecord = 0 THEN
                            MESSAGE(Text1000000002, "Sales Line"."Document Type", "Sales Line"."Document No.", "Sales Line"."Line No.", "Sales Line"."No.")
                        ELSE
                            ERROR(Text1000000003, "Sales Line"."Document Type",
                                 "Sales Line"."Document No.", "Sales Line"."Line No.", "Sales Line"."No.");
                    END ELSE BEGIN
                        PurchQuoteLine.FIND('-');
                        // C2A GTE
                        IF PurchQuoteLine."Currency Code" = '' THEN BEGIN
                            "Sales Line".VALIDATE("Unit Cost (LCY)", PurchQuoteLine."Direct Unit Cost");
                            "Sales Line".MODIFY();
                        END ELSE BEGIN
                            PuchQuoteHeader.GET(PurchQuoteLine."Document Type", PurchQuoteLine."Document No.");
                            UnitCost := CurrExRate.ExchangeAmtFCYToLCY(PurchQuoteLine.GetDate(),
                              PuchQuoteHeader."Currency Code", PurchQuoteLine."Direct Unit Cost", PuchQuoteHeader."Currency Factor");
                            "Sales Line".VALIDATE("Unit Cost (LCY)", UnitCost);
                            "Sales Line".MODIFY();
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnPreReport()
    begin
        IF NOT CONFIRM(Text1000000004, TRUE) = TRUE THEN
            CurrReport.QUIT();

        PurchQuoteLine.SETCURRENTKEY("PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders");
    end;

    var
        PurchQuoteLine: Record "Purchase Line";
        NbRecord: Integer;
        Text1000000002: Label 'Any vendor reply selected %1 %2 %3 \Item %4';
        Text1000000003: Label 'To many vendor reply selected %1 %2 %3 \Item %4';
        Text1000000004: Label 'Accept vendors offers ?';
}
