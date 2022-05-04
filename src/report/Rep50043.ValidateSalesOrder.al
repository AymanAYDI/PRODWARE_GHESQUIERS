report 50043 "PWD Validate Sales Order"
{
    Caption = 'Validate Sales Order';
    ProcessingOnly = true;

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
                IF PostingDate = 0D THEN
                    ERROR(Text1000000003);
                IF DocumentDate = 0D THEN
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
                group(SalesInformation)
                {
                    field(PostingDate; PostingDate)
                    {
                        Applicationarea = all;
                        Caption = 'Date de comptabilisation';
                    }
                    field(DocumentDate; DocumentDate)
                    {
                        Applicationarea = all;
                        Caption = 'Date de document';
                    }
                    field(ToShip; ToShip)
                    {
                        Applicationarea = all;
                        Caption = 'Livrer';
                    }
                    field(ToInvoice; ToInvoice)
                    {
                        Applicationarea = all;
                        Caption = 'Facturer';
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
        SalesLine: Record "Sales Line";
        SalesPost: Codeunit "Sales-Post";
        ToInvoice: Boolean;
        ToShip: Boolean;
        NumDocument: Code[20];
        DocumentDate: Date;
        PostingDate: Date;
        Text001: Label 'Do you want to post the %1?';
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
        MemberOf: Record "Permission Set";
        SalesLine: Record "Sales Line";
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
        CLEAR(SalesLine);
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

        SalesLine.CalcVATAmountLines(1, SalesHeader, TempSalesLine, TempVATAmountLine);
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
        IF Cust."Discount Profit %" > ProfitPct THEN BEGIN
            //*** Recherche si userid appartient au role direction
            //TODO MemberOf.SETRANGE("User ID",USERID);
            MemberOf.SETRANGE("Role ID", GenLedSetUp."PWD Direction Role ID");
            IF MemberOf.FIND('-') THEN BEGIN
                IF CONFIRM(Text1000000000, TRUE, ProfitPct, Cust."Discount Profit %", '%') = FALSE THEN
                    ERROR(Text1000000001, ProfitPct, Cust."Discount Profit %", '%');
            END ELSE BEGIN
                ERROR(Text1000000001, ProfitPct, Cust."Discount Profit %", '%');
            END;
        END;
    end;

    local procedure "Code"()
    begin
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) OR (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) THEN
            ControlProfit();
        CtrlUnitPrice();
        SalesHeader.VALIDATE("Posting Date", PostingDate);
        SalesHeader.VALIDATE("Document Date", DocumentDate);
        SalesHeader.VALIDATE("Document Date");
        SalesHeader.Ship := ToShip;
        SalesHeader.Invoice := ToInvoice;
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
            SalesHeader."Document Type"::"Return Order":
                BEGIN
                    //Selection := STRMENU(Text002,3);
                    //IF Selection = 0 THEN
                    //  EXIT;
                    //Receive := Selection IN [1,3];
                    //Invoice := Selection IN [2,3];
                END ELSE
                        IF NOT
                           CONFIRM(
                             Text001, FALSE,
                             SalesHeader."Document Type")
                        THEN
                            EXIT;
        END;
        SalesPost.RUN(SalesHeader);
        COMMIT();

    end;

    procedure InitRequete(SalesHeader1: Record "Sales Header")
    begin
        PostingDate := WORKDATE();
        DocumentDate := WORKDATE();
        DocType := SalesHeader1."Document Type";
        NumDocument := SalesHeader1."No.";
        ToInvoice := TRUE;
        ToShip := TRUE;
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
        IF SalesLineCtrl.FIND('-') THEN BEGIN
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
                       (Location."PWD Controle du prix plancher") THEN BEGIN
                        IF Avertissement = FALSE THEN BEGIN
                            ERROR('Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5)',
                                   SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                   SalesLineCtrl."Unit Price", BottomPrice);
                        END ELSE BEGIN
                            IF CONFIRM(
                                  'Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5) \Continuer ',
                                  TRUE,
                                  SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                  SalesLineCtrl."Unit Price", BottomPrice) = FALSE THEN
                                ERROR('Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5)',
                                       SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                       SalesLineCtrl."Unit Price", BottomPrice);
                        END
                    END;
                END;
            UNTIL SalesLineCtrl.NEXT() = 0;
        END;
    end;
}