report 50126 "Validate And Print Sales Order"
{
    Caption = 'Validate and Print Sales Order';
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");

            trigger OnAfterGetRecord()
            begin
                Code();
            end;

            trigger OnPreDataItem()
            begin
                IF PostingDateV = 0D THEN
                    ERROR(Text1000000003);
                IF DocumentDateV = 0D THEN
                    ERROR(Text1000000004);
                SalesHeader.SETRANGE(SalesHeader."Document Type", DocType);
                SalesHeader.SETRANGE(SalesHeader."No.", NumDocument);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Invoice)
                {
                    field(PostingDate; PostingDateV)
                    {
                        Caption = 'Date de comptabilisation';
                        ApplicationArea = All;
                    }
                    field(DocumentDate; DocumentDateV)
                    {
                        Caption = 'Date de document';
                        ApplicationArea = All;
                    }
                    field(ToShip; ToShipV)
                    {
                        Caption = 'Livrer';
                        ApplicationArea = All;
                    }
                    field(ToInvoice; ToInvoiceV)
                    {
                        Caption = 'Facturer';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Location: Record Location;
        ReportSelection: Record "Report Selections";
        ReturnRcptHeader: Record "Return Receipt Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesLine: Record "Sales Line";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesPost: Codeunit "Sales-Post";
        ToInvoiceV: Boolean;
        ToShipV: Boolean;
        NumDocument: Code[20];
        DocumentDateV: Date;
        PostingDateV: Date;
        Text001: Label 'Do you want to post and print the %1?';
        Text1000000000: Label 'Profit (%1 %3) is inferior than Discount profit (%2 %3) \Would you like to post the document ?';
        Text1000000001: Label 'Profit (%1 %3) is inferior than Discount profit (%2 %3).';
        Text1000000003: Label 'Please enter a posting date !';
        Text1000000004: Label 'Please enter a document date !';
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";

    procedure ControlProfit()
    var
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        GenLedSetUp: Record "General Ledger Setup";
        //MemberOf: Record "Permission Set";
        AccessControl: Record "Access Control";
        LSalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        TotalSalesLine: Record "Sales Line";
        TotalSalesLineLCY: Record "Sales Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        UseDate: Date;
        CreditLimitLCYExpendedPct: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
    begin
        CLEAR(LSalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        CLEAR(SalesPost);

        SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 0);
        CLEAR(SalesPost);
        IF SalesHeader."Prices Including VAT" THEN BEGIN
            TotalAmount2 := TotalSalesLine.Amount;
            TotalAmount1 := TotalAmount2 + VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount1 := TotalSalesLine.Amount;
            TotalAmount2 := TotalSalesLine."Amount Including VAT";
        END;

        IF Cust.GET(SalesHeader."Bill-to Customer No.") THEN
            Cust.CALCFIELDS("Balance (LCY)")
        ELSE
            CLEAR(Cust);
        IF Cust."Credit Limit (LCY)" = 0 THEN
            CreditLimitLCYExpendedPct := 0
        ELSE
            IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 THEN
                CreditLimitLCYExpendedPct := 0
            ELSE
                IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 THEN
                    CreditLimitLCYExpendedPct := 10000
                ELSE
                    CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        LSalesLine.CalcVATAmountLines(1, SalesHeader, TempSalesLine, TempVATAmountLine);
        TempVATAmountLine.MODIFYALL(Modified, FALSE);

        TotalSalesLine."Inv. Discount Amount" := TempVATAmountLine.GetTotalInvDiscAmount();
        TotalAmount1 :=
          TotalSalesLine."Line Amount" - TotalSalesLine."Inv. Discount Amount";
        VATAmount := TempVATAmountLine.GetTotalVATAmount();

        IF SalesHeader."Prices Including VAT" THEN BEGIN
            TotalAmount1 := TempVATAmountLine.GetTotalAmountInclVAT();
            TotalAmount2 := TotalAmount1 - VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE
            TotalAmount2 := TotalAmount1 + VATAmount;

        IF SalesHeader."Prices Including VAT" THEN
            TotalSalesLineLCY.Amount := TotalAmount2
        ELSE
            TotalSalesLineLCY.Amount := TotalAmount1;
        IF SalesHeader."Currency Code" <> '' THEN BEGIN
            IF (SalesHeader."Document Type" IN [SalesHeader."Document Type"::"Blanket Order", SalesHeader."Document Type"::Quote]) AND
               (SalesHeader."Posting Date" = 0D)
            THEN
                UseDate := WORKDATE()
            ELSE
                UseDate := SalesHeader."Posting Date";

            TotalSalesLineLCY.Amount :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                UseDate, SalesHeader."Currency Code", TotalSalesLineLCY.Amount, SalesHeader."Currency Factor");
        END;
        ProfitLCY := TotalSalesLineLCY.Amount - TotalSalesLineLCY."Unit Cost (LCY)";
        IF TotalSalesLineLCY.Amount = 0 THEN
            ProfitPct := 0
        ELSE
            ProfitPct := ROUND(100 * ProfitLCY / TotalSalesLineLCY.Amount, 0.01);
        GenLedSetUp.GET();
        IF Cust."PWD Discount Profit %" > ProfitPct THEN begin
            //*** Recherche si userid appartient au role direction
            AccessControl.SETRANGE(AccessControl."User Security ID", UserSecurityId());
            AccessControl.SETRANGE(AccessControl."Role ID", GenLedSetUp."PWD Direction Role ID");
            IF AccessControl.FindFirst() THEN BEGIN
                IF CONFIRM(Text1000000000, TRUE, ProfitPct, Cust."PWD Discount Profit %", '%') = FALSE THEN
                    ERROR(Text1000000001, ProfitPct, Cust."PWD Discount Profit %", '%');
            END ELSE
                ERROR(Text1000000001, ProfitPct, Cust."PWD Discount Profit %", '%');
        end;
    end;

    local procedure "Code"()
    begin
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN
            ControlProfit();
        CtrlUnitPrice();
        SalesHeader.VALIDATE("Posting Date", PostingDateV);
        SalesHeader.VALIDATE("Document Date", DocumentDateV);
        SalesHeader.VALIDATE("Document Date");
        SalesHeader.Ship := ToShipV;
        SalesHeader.Invoice := ToInvoiceV;
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::Order:
                BEGIN
                    SalesLine.RESET();
                    SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
                    SalesLine.SETFILTER(SalesLine."PWD Adjmt Prepared Qty", '<>%1', 0);
                    SalesLine.SETFILTER(SalesLine."PWD Butchery", '=%1', FALSE);
                    SalesLine.SETFILTER(SalesLine."PWD Countermark Location", '=%1', FALSE);
                END;
            // SalesHeader."Document Type"::"Return Order":
            // Selection := STRMENU(Text002,3);
            // IF Selection = 0 THEN
            //  EXIT;
            // Receive := Selection IN [1,3];
            // Invoice := Selection IN [2,3];
            ELSE
                IF NOT
                   CONFIRM(
                     Text001, FALSE,
                     SalesHeader."Document Type")
                THEN
                    EXIT;
        END;
        SalesPost.RUN(SalesHeader);
        GetReport(SalesHeader);
        COMMIT();
    end;

    procedure InitRequete(SalesHeader1: Record "Sales Header")
    begin
        PostingDateV := WORKDATE();
        DocumentDateV := WORKDATE();
        DocType := SalesHeader1."Document Type".AsInteger();
        NumDocument := SalesHeader1."No.";
        ToInvoiceV := TRUE;
        ToShipV := TRUE;
    end;

    procedure CtrlUnitPrice()
    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Item: Record Item;
        SalesLineCtrl: Record "Sales Line";
        Avertissement: Boolean;
        BottomPrice: Decimal;
    begin
        SalesLineCtrl.RESET();
        SalesLineCtrl.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLineCtrl.SETRANGE("Document No.", SalesHeader."No.");
        SalesLineCtrl.SETRANGE(Type, SalesLineCtrl.Type::Item);
        IF SalesLineCtrl.FindSet() THEN
            REPEAT
                IF Item.GET(SalesLineCtrl."No.") THEN BEGIN
                    BottomPrice := Item."PWD Bottom Price";
                    IF SalesHeader."Currency Code" <> '' THEN BEGIN
                        Currency.GET(SalesHeader."Currency Code");
                        BottomPrice :=
                           ROUND(
                                 CurrExchRate.ExchangeAmtLCYToFCY(
                                 SalesLineCtrl.GetDate(), SalesHeader."Currency Code",
                                 BottomPrice, SalesHeader."Currency Factor"),
                                 Currency."Unit-Amount Rounding Precision")
                    END;
                    Location.GET(SalesLineCtrl."Location Code");
                    IF ((SalesLineCtrl."Unit Price" < BottomPrice) OR (SalesLineCtrl."Unit Price" = 0)) AND
                       (Location."PWD Controle du prix plancher") THEN
                        IF Avertissement = FALSE THEN
                            ERROR('Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5)',
                                   SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                   SalesLineCtrl."Unit Price", BottomPrice)
                        ELSE
                            IF CONFIRM(
                                  'Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5) \Continuer ',
                                  TRUE,
                                  SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                  SalesLineCtrl."Unit Price", BottomPrice) = FALSE THEN
                                ERROR('Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5)',
                                       SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                       SalesLineCtrl."Unit Price", BottomPrice);
                END;
            UNTIL SalesLineCtrl.NEXT() = 0;
    end;

    procedure GetReport(var SalesHeader: Record "Sales Header")
    begin
        CASE SalesHeader."Document Type" OF
            SalesHeader."Document Type"::Order:
                BEGIN
                    IF SalesHeader.Ship THEN BEGIN
                        SalesShptHeader."No." := SalesHeader."Last Shipping No.";
                        SalesShptHeader.SETRECFILTER();
                        PrintReport(ReportSelection.Usage::"S.Shipment".AsInteger());
                    END;
                    IF SalesHeader.Invoice THEN BEGIN
                        SalesInvHeader."No." := SalesHeader."Last Posting No.";
                        SalesInvHeader.SETRECFILTER();
                        PrintReport(ReportSelection.Usage::"S.Invoice".AsInteger());
                    END;
                END;
            SalesHeader."Document Type"::Invoice:
                BEGIN
                    IF SalesHeader."Last Posting No." = '' THEN
                        SalesInvHeader."No." := SalesHeader."No."
                    ELSE
                        SalesInvHeader."No." := SalesHeader."Last Posting No.";
                    SalesInvHeader.SETRECFILTER();
                    PrintReport(ReportSelection.Usage::"S.Invoice".AsInteger());
                END;
            SalesHeader."Document Type"::"Return Order":
                BEGIN
                    IF SalesHeader.Receive THEN BEGIN
                        ReturnRcptHeader."No." := SalesHeader."Last Return Receipt No.";
                        ReturnRcptHeader.SETRECFILTER();
                        PrintReport(ReportSelection.Usage::"S.Ret.Rcpt.".AsInteger());
                    END;
                    IF SalesHeader.Invoice THEN BEGIN
                        SalesCrMemoHeader."No." := SalesHeader."Last Posting No.";
                        SalesCrMemoHeader.SETRECFILTER();
                        PrintReport(ReportSelection.Usage::"S.Cr.Memo".AsInteger());
                    END;
                END;
            SalesHeader."Document Type"::"Credit Memo":
                BEGIN
                    IF SalesHeader."Last Posting No." = '' THEN
                        SalesCrMemoHeader."No." := SalesHeader."No."
                    ELSE
                        SalesCrMemoHeader."No." := SalesHeader."Last Posting No.";
                    SalesCrMemoHeader.SETRECFILTER();
                    PrintReport(ReportSelection.Usage::"S.Cr.Memo".AsInteger());
                END;
        END;
    end;

    local procedure PrintReport(ReportUsage: Integer)
    begin
        ReportSelection.RESET();
        ReportSelection.SETRANGE(Usage, ReportUsage);
        ReportSelection.FINDSET();
        REPEAT
            ReportSelection.TESTFIELD("Report ID");
            CASE ReportUsage OF
                ReportSelection.Usage::"SM.Invoice".AsInteger():
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, SalesInvHeader);
                ReportSelection.Usage::"SM.Credit Memo".AsInteger():
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, SalesCrMemoHeader);
                ReportSelection.Usage::"S.Invoice".AsInteger():
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, SalesInvHeader);
                ReportSelection.Usage::"S.Cr.Memo".AsInteger():
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, SalesCrMemoHeader);
                ReportSelection.Usage::"S.Shipment".AsInteger():
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, SalesShptHeader);
                ReportSelection.Usage::"S.Ret.Rcpt.".AsInteger():
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, ReturnRcptHeader);
            END;
        UNTIL ReportSelection.NEXT() = 0;
    end;
}
