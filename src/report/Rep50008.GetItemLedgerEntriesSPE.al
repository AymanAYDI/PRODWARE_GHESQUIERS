report 50008 "Get Item Ledger Entries SPE"
{
    Caption = 'Get Item Ledger Entries';
    Permissions = TableData "General Posting Setup" = imd;
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem("Country/Region"; "Country/Region")
        {
            DataItemTableView = SORTING("Intrastat Code") WHERE("Intrastat Code" = FILTER(<> ''));
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = SORTING("Country/Region Code", "Entry Type", "Posting Date");
                RequestFilterFields = "Document No.", "Item No.", "Entry Type";

                trigger OnAfterGetRecord()
                var
                    ItemLedgEntry: Record "Item Ledger Entry";
                    Location: Record Location;
                    Include: Boolean;
                begin
                    IntrastatJnlLine2.SETRANGE("Source Entry No.", "Entry No.");
                    IF IntrastatJnlLine2.FINDFIRST() THEN
                        CurrReport.SKIP();

                    CASE TRUE OF
                        "Drop Shipment":
                            BEGIN
                                IF ("Country/Region Code" = CompanyInfo."Country/Region Code") OR
                                   ("Country/Region Code" = '')
                                THEN
                                    CurrReport.SKIP();
                                IF "Applies-to Entry" = 0 THEN BEGIN
                                    ItemLedgEntry.SETCURRENTKEY("Item No.", "Posting Date");
                                    ItemLedgEntry.SETRANGE("Item No.", "Item No.");
                                    ItemLedgEntry.SETRANGE("Posting Date", "Posting Date");
                                    ItemLedgEntry.SETRANGE("Applies-to Entry", "Entry No.");
                                    ItemLedgEntry.FINDFIRST();
                                END ELSE
                                    ItemLedgEntry.GET("Applies-to Entry");
                                IF (ItemLedgEntry."Country/Region Code" <> CompanyInfo."Country/Region Code") AND
                                   (ItemLedgEntry."Country/Region Code" <> '')
                                THEN
                                    CurrReport.SKIP();
                            END;
                        "Entry Type" = "Entry Type"::Transfer:
                            BEGIN
                                IF ("Country/Region Code" = CompanyInfo."Country/Region Code") OR
                                   ("Country/Region Code" = '')
                                THEN
                                    CurrReport.SKIP();
                                //IF "Transfer Order No." = '' THEN BEGIN
                                //TODO Cde adapté selon nouveau std
                                if ("Order Type" <> "Order Type"::Transfer) or ("Order No." = '') then begin
                                    Location.GET("Location Code");
                                    IF (Location."Country/Region Code" <> '') AND
                                       (Location."Country/Region Code" <> CompanyInfo."Country/Region Code")
                                    THEN
                                        CurrReport.SKIP();
                                END ELSE BEGIN
                                    //ItemLedgEntry.SETRANGE("Transfer Order No.", "Transfer Order No.");
                                    //TODO Cde adapté selon nouveau std
                                    ItemLedgEntry.SetCurrentKey("Order Type", "Order No.");
                                    ItemLedgEntry.SetRange("Order Type", "Order Type"::Transfer);
                                    ItemLedgEntry.SetRange("Order No.", "Order No.");
                                    ItemLedgEntry.SetRange("Document Type", ItemLedgEntry."Document Type"::"Transfer Shipment");
                                    //
                                    ItemLedgEntry.SETFILTER("Country/Region Code", '%1 | %2', '', CompanyInfo."Country/Region Code");
                                    IF ItemLedgEntry.FINDSET() THEN
                                        REPEAT
                                            Location.GET(ItemLedgEntry."Location Code");
                                            IF Location."Use As In-Transit" THEN
                                                Include := TRUE;
                                        UNTIL Include OR (ItemLedgEntry.NEXT() = 0);
                                    IF NOT Include THEN
                                        CurrReport.SKIP();
                                END;
                            END;
                        "Location Code" <> '':
                            BEGIN
                                Location.GET("Location Code");
                                CheckILE(Location."Country/Region Code");
                            END
                        ELSE BEGIN
                                IF "Entry Type" = "Entry Type"::Purchase THEN
                                    CheckILE(CompanyInfo."Ship-to Country/Region Code");
                                IF "Entry Type" = "Entry Type"::Sale THEN
                                    CheckILE(CompanyInfo."Country/Region Code");
                            END;
                    END;
                    TotalInvoicedQty := 0;
                    TotalAmt := 0;
                    TotalAmtExpected := 0;
                    TotalCostAmt := 0;
                    TotalCostAmtExpected := 0;

                    ValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                    IF ValueEntry.FindSet() THEN
                        REPEAT
                            TotalInvoicedQty := TotalInvoicedQty + ValueEntry."Invoiced Quantity";
                            IF NOT IntrastatJnlBatch."Amounts in Add. Currency" THEN BEGIN
                                TotalAmt := TotalAmt + ValueEntry."Sales Amount (Actual)";
                                TotalCostAmt := TotalCostAmt + ValueEntry."Cost Amount (Actual)";
                                TotalAmtExpected := TotalAmtExpected + ValueEntry."Sales Amount (Expected)";
                                TotalCostAmtExpected := TotalCostAmtExpected + ValueEntry."Cost Amount (Expected)";
                            END ELSE BEGIN
                                TotalCostAmt := TotalCostAmt + ValueEntry."Cost Amount (Actual) (ACY)";
                                TotalCostAmtExpected := TotalCostAmtExpected + ValueEntry."Cost Amount (Expected) (ACY)";
                                IF ValueEntry."Cost per Unit" <> 0 THEN BEGIN
                                    TotalAmt :=
                                      TotalAmt +
                                      ValueEntry."Sales Amount (Actual)" * ValueEntry."Cost per Unit (ACY)" / ValueEntry."Cost per Unit";
                                    TotalAmtExpected :=
                                      TotalAmtExpected +
                                      ValueEntry."Sales Amount (Expected)" * ValueEntry."Cost per Unit (ACY)" / ValueEntry."Cost per Unit";
                                END ELSE BEGIN
                                    TotalAmt :=
                                      TotalAmt +
                                      CurrExchRate.ExchangeAmtLCYToFCY(
                                        ValueEntry."Posting Date", GLSetup."Additional Reporting Currency",
                                        ValueEntry."Sales Amount (Actual)", AddCurrencyFactor);
                                    TotalAmtExpected :=
                                      TotalAmtExpected +
                                      CurrExchRate.ExchangeAmtLCYToFCY(
                                        ValueEntry."Posting Date", GLSetup."Additional Reporting Currency",
                                        ValueEntry."Sales Amount (Expected)", AddCurrencyFactor);
                                END;
                            END;
                        UNTIL ValueEntry.NEXT() = 0;

                    IF Quantity <> TotalInvoicedQty THEN BEGIN
                        TotalAmt := TotalAmt + TotalAmtExpected;
                        TotalCostAmt := TotalCostAmt + TotalCostAmtExpected;
                    END;

                    IF "Entry Type" IN ["Entry Type"::Purchase, "Entry Type"::Transfer] THEN BEGIN
                        IF TotalCostAmt = 0 THEN BEGIN
                            CalculateAverageCost(AverageCost, AverageCostACY);
                            IF IntrastatJnlBatch."Amounts in Add. Currency" THEN
                                TotalCostAmt :=
                                  TotalCostAmt + Quantity * AverageCostACY
                            ELSE
                                TotalCostAmt :=
                                  TotalCostAmt + Quantity * AverageCost;
                        END;
                        TotalAmt := TotalCostAmt;
                    END;

                    IF (TotalAmt = 0) AND ("Entry Type" = "Entry Type"::Sale) THEN BEGIN
                        IF Item."No." <> "Item No." THEN
                            Item.GET("Item No.");
                        IF IntrastatJnlBatch."Amounts in Add. Currency" THEN
                            Item."Unit Price" :=
                              CurrExchRate.ExchangeAmtLCYToFCY(
                                EndDate, GLSetup."Additional Reporting Currency",
                                Item."Unit Price", AddCurrencyFactor);
                        IF Item."Price Includes VAT" THEN BEGIN
                            VATPostingSetup.GET(Item."VAT Bus. Posting Gr. (Price)", Item."VAT Prod. Posting Group");
                            CASE VATPostingSetup."VAT Calculation Type" OF
                                VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                                    VATPostingSetup."VAT %" := 0;
                                VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                                    ERROR(
                                      Text000,
                                      VATPostingSetup.FIELDCAPTION("VAT Calculation Type"),
                                      VATPostingSetup."VAT Calculation Type");
                            END;
                            TotalAmt :=
                              TotalAmt + Quantity *
                              (Item."Unit Price" / (1 + (VATPostingSetup."VAT %" / 100)));
                        END ELSE
                            TotalAmt := TotalAmt + Quantity * Item."Unit Price";
                    END;

                    InsertItemJnlLine();
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", StartDate, EndDate);

                    IF "Country/Region".Code = CompanyInfo."Country/Region Code" THEN
                        SETFILTER("Country/Region Code", '%1|%2', "Country/Region".Code, '')
                    ELSE
                        SETRANGE("Country/Region Code", "Country/Region".Code);
                    IF (CompanyInfo."Country/Region Code" = '') AND NOT ShowBlank THEN BEGIN
                        ShowBlank := TRUE;
                        SETRANGE("Country/Region Code", '');
                    END;

                    IntrastatJnlLine2.SETCURRENTKEY("Source Type", "Source Entry No.");
                    IntrastatJnlLine2.SETRANGE("Source Type", IntrastatJnlLine2."Source Type"::"Item entry");

                    ValueEntry.SETCURRENTKEY("Item Ledger Entry No.");
                    ValueEntry.SETRANGE("Valuation Date", StartDate, EndDate);
                    ValueEntry.SETRANGE("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
                    ValueEntry.SETFILTER(
                      "Item Ledger Entry Type", '%1|%2|%3',
                      ValueEntry."Item Ledger Entry Type"::Sale,
                      ValueEntry."Item Ledger Entry Type"::Purchase,
                      ValueEntry."Item Ledger Entry Type"::Transfer);
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Field_StartDate"; StartDate)
                    {
                        Caption = 'Starting Date';
                        ApplicationArea = All;
                    }
                    field("Field_EndDate"; EndDate)
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = All;
                    }
                    field("Field_IndirectCostPctReq"; IndirectCostPctReq)
                    {
                        Caption = 'Cost Regulation %';
                        DecimalPlaces = 0 : 5;
                        ApplicationArea = All;
                    }
                    field("Field_GroupEntries"; GroupEntries)
                    {
                        Caption = 'Group Entries';
                        ToolTip = 'This option will group entries with the same Tariff No, Country/Region Code, Item No, Cust.VAT Registration No. This feature substract items returns from shipments. This is required in the French Intrastat reporting.';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IntraJnlTemplate.GET(IntrastatJnlLine."Journal Template Name");
            IntrastatJnlBatch.GET(IntrastatJnlLine."Journal Template Name", IntrastatJnlLine."Journal Batch Name");
            IntrastatJnlBatch.TESTFIELD("Statistics Period");
            Century := DATE2DMY(WORKDATE(), 3) DIV 100;
            EVALUATE(Year, COPYSTR(IntrastatJnlBatch."Statistics Period", 1, 2));
            Year := Year + Century * 100;
            EVALUATE(Month, COPYSTR(IntrastatJnlBatch."Statistics Period", 3, 2));
            StartDate := DMY2DATE(1, Month, Year);
            EndDate := CALCDATE('<+1M-1D>', StartDate);
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.FIND('-');
        CLEAR("Item Ledger Entry");
    end;

    trigger OnPostReport()
    var
        FirstLine: Boolean;
        Amount: Decimal;
        IndirectCost: Decimal;
        Quantity: Decimal;
        StatisticalValue: Decimal;
        TotalWeight: Decimal;
    begin
        IF GroupEntries THEN BEGIN
            IntrastatJnlLine.RESET();
            IntrastatJnlLine2.RESET();
            IF IntrastatJnlLine.FIND('-') THEN
                REPEAT
                    IntrastatJnlLine2.SETRANGE("Item No.", IntrastatJnlLine."Item No.");
                    IntrastatJnlLine2.SETRANGE("Country/Region Code", IntrastatJnlLine."Country/Region Code");
                    IntrastatJnlLine2.SETRANGE("Tariff No.", IntrastatJnlLine."Tariff No.");
                    IntrastatJnlLine2.SETRANGE("Partner VAT ID", IntrastatJnlLine."Partner VAT ID");
                    Quantity := 0;
                    IndirectCost := 0;
                    TotalWeight := 0;
                    Amount := 0;
                    StatisticalValue := 0;
                    FirstLine := TRUE;

                    IF IntrastatJnlLine2.FIND('-') THEN
                        REPEAT
                            IF IntrastatJnlLine2.Type = IntrastatJnlLine2.Type::Shipment THEN BEGIN
                                Amount := Amount + IntrastatJnlLine2.Amount;
                                Quantity := Quantity + IntrastatJnlLine2.Quantity;
                                IndirectCost := IndirectCost + IntrastatJnlLine2."Indirect Cost";
                                StatisticalValue := StatisticalValue + IntrastatJnlLine2."Statistical Value";
                                TotalWeight := TotalWeight + IntrastatJnlLine2."Total Weight";
                            END ELSE
                                IF IntrastatJnlLine2.Type = IntrastatJnlLine2.Type::Receipt THEN BEGIN
                                    Amount := Amount - IntrastatJnlLine2.Amount;
                                    Quantity := Quantity - IntrastatJnlLine2.Quantity;
                                    IndirectCost := IndirectCost - IntrastatJnlLine2."Indirect Cost";
                                    StatisticalValue := StatisticalValue - IntrastatJnlLine2."Statistical Value";
                                    TotalWeight := TotalWeight - IntrastatJnlLine2."Total Weight";
                                END;
                            IF NOT FirstLine THEN
                                IntrastatJnlLine2.DELETE();
                            FirstLine := FALSE;
                        UNTIL IntrastatJnlLine2.NEXT() = 0;

                    IF Quantity > 0 THEN
                        IntrastatJnlLine.Type := IntrastatJnlLine.Type::Shipment
                    ELSE
                        IntrastatJnlLine.Type := IntrastatJnlLine.Type::Receipt;
                    IntrastatJnlLine.Amount := ABS(Amount);
                    IntrastatJnlLine.Quantity := ABS(Quantity);
                    IntrastatJnlLine."Indirect Cost" := ABS(IndirectCost);
                    IntrastatJnlLine."Statistical Value" := ABS(StatisticalValue);
                    IntrastatJnlLine."Total Weight" := ABS(TotalWeight);
                    IntrastatJnlLine.Date := 0D;
                    IntrastatJnlLine."Document No." := '';
                    IntrastatJnlLine.MODIFY();
                UNTIL IntrastatJnlLine.NEXT() = 0;
        END;
    end;

    trigger OnPreReport()
    begin
        IntrastatJnlLine.DELETEALL();
        IntrastatJnlLine.SETRANGE("Journal Template Name", IntrastatJnlLine."Journal Template Name");
        IntrastatJnlLine.SETRANGE("Journal Batch Name", IntrastatJnlLine."Journal Batch Name");
        IntrastatJnlLine.LOCKTABLE();
        IF IntrastatJnlLine.FIND('+') THEN;

        GetGLSetup();
        IF IntrastatJnlBatch."Amounts in Add. Currency" THEN BEGIN
            GLSetup.TESTFIELD("Additional Reporting Currency");
            AddCurrencyFactor :=
              CurrExchRate.ExchangeRate(EndDate, GLSetup."Additional Reporting Currency");
        END;
    end;

    var
        CompanyInfo: Record "Company Information";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Customer: Record Customer;
        GLSetup: Record "General Ledger Setup";
        IntrastatJnlBatch: Record "Intrastat Jnl. Batch";
        IntrastatJnlLine: Record "Intrastat Jnl. Line";
        IntrastatJnlLine2: Record "Intrastat Jnl. Line";
        IntraJnlTemplate: Record "Intrastat Jnl. Template";
        Item: Record Item;
        ValueEntry: Record "Value Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        GLSetupRead: Boolean;
        GroupEntries: Boolean;
        ShowBlank: Boolean;
        EndDate: Date;
        StartDate: Date;
        AddCurrencyFactor: Decimal;
        AverageCost: Decimal;
        AverageCostACY: Decimal;
        IndirectCostPctReq: Decimal;
        TotalAmt: Decimal;
        TotalAmtExpected: Decimal;
        TotalCostAmt: Decimal;
        TotalCostAmtExpected: Decimal;
        TotalInvoicedQty: Decimal;
        Century: Integer;
        Month: Integer;
        Year: Integer;
        Text000: Label 'Prices including VAT cannot be calculated when %1 is %2.';

    procedure SetIntrastatJnlLine(NewIntrastatJnlLine: Record "Intrastat Jnl. Line")
    begin
        IntrastatJnlLine := NewIntrastatJnlLine;
    end;

    local procedure InsertItemJnlLine()
    var
        RecLItem: Record Item;
    begin
        GetGLSetup();
        IntrastatJnlLine.INIT();
        IntrastatJnlLine."Line No." := IntrastatJnlLine."Line No." + 10000;
        IntrastatJnlLine.Date := "Item Ledger Entry"."Posting Date";
        IF RecLItem.GET("Item Ledger Entry"."Item No.") THEN
            IntrastatJnlLine."Country/Region Code" := RecLItem."Country/Region of Origin Code";
        IntrastatJnlLine."Transaction Type" := "Item Ledger Entry"."Transaction Type";
        IntrastatJnlLine."Transport Method" := "Item Ledger Entry"."Transport Method";
        IntrastatJnlLine."Source Entry No." := "Item Ledger Entry"."Entry No.";
        IntrastatJnlLine.Quantity := "Item Ledger Entry".Quantity;
        IntrastatJnlLine."Document No." := "Item Ledger Entry"."Document No.";
        IntrastatJnlLine."Item No." := "Item Ledger Entry"."Item No.";
        IntrastatJnlLine."Entry/Exit Point" := "Item Ledger Entry"."Entry/Exit Point";
        IntrastatJnlLine.Area := "Item Ledger Entry".Area;
        IntrastatJnlLine."Transaction Specification" := "Item Ledger Entry"."Transaction Specification";
        IntrastatJnlLine."Shpt. Method Code" := "Item Ledger Entry"."Shpt. Method Code";
        IntrastatJnlLine.Amount := ROUND(ABS(TotalAmt), 1);

        IF IntrastatJnlLine.Quantity < 0 THEN BEGIN
            IntrastatJnlLine.Type := IntrastatJnlLine.Type::Shipment;
            IF ("Item Ledger Entry"."Source Type" = "Item Ledger Entry"."Source Type"::Customer) THEN
                IF Customer.GET("Item Ledger Entry"."Source No.") THEN
                    IntrastatJnlLine."Partner VAT ID" := Customer."VAT Registration No.";
            IntrastatJnlLine.Amount := ROUND(ABS(TotalAmt), 1);
        END ELSE BEGIN
            IntrastatJnlLine.Type := IntrastatJnlLine.Type::Receipt;
            IF ("Item Ledger Entry"."Source Type" = "Item Ledger Entry"."Source Type"::Customer) THEN
                IF Customer.GET("Item Ledger Entry"."Source No.") THEN
                    IntrastatJnlLine."Partner VAT ID" := Customer."VAT Registration No.";
            IntrastatJnlLine.Amount := ROUND(ABS(TotalCostAmt), 1);
        END;
        IntrastatJnlLine.VALIDATE("Item No.");
        IntrastatJnlLine."Source Type" := IntrastatJnlLine."Source Type"::"Item entry";
        IntrastatJnlLine.VALIDATE(Quantity, ROUND(ABS(IntrastatJnlLine.Quantity), 0.00001));
        IntrastatJnlLine.VALIDATE("Cost Regulation %", IndirectCostPctReq);
        IF IntrastatJnlLine.Quantity >= 0 THEN
            IntrastatJnlLine.INSERT();
    end;

    local procedure GetGLSetup()
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.GET();
            IF GLSetup."Additional Reporting Currency" <> '' THEN
                Currency.GET(GLSetup."Additional Reporting Currency");
        END;
        GLSetupRead := TRUE;
    end;

    local procedure CalculateAverageCost(var AverageCost: Decimal; var AverageCostACY: Decimal): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        AverageQty: Decimal;
    begin
        ItemLedgEntry.SETCURRENTKEY("Item No.", "Entry Type");
        ItemLedgEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
        ItemLedgEntry.SETRANGE("Entry Type", "Item Ledger Entry"."Entry Type");
        ItemLedgEntry.CALCSUMS(Quantity);

        ValueEntry.SETCURRENTKEY("Item No.", "Posting Date", "Item Ledger Entry Type");
        ValueEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
        ValueEntry.SETRANGE("Item Ledger Entry Type", "Item Ledger Entry"."Entry Type");
        ValueEntry.CALCSUMS(
          "Cost Amount (Actual)",
          "Cost Amount (Expected)");
        ValueEntry."Cost Amount (Actual) (ACY)" :=
          CurrExchRate.ExchangeAmtLCYToFCY(
            EndDate, GLSetup."Additional Reporting Currency", ValueEntry."Cost Amount (Actual)", AddCurrencyFactor);
        ValueEntry."Cost Amount (Expected) (ACY)" :=
          CurrExchRate.ExchangeAmtLCYToFCY(
            EndDate, GLSetup."Additional Reporting Currency", ValueEntry."Cost Amount (Expected)", AddCurrencyFactor);
        AverageQty := ItemLedgEntry.Quantity;
        AverageCost := ValueEntry."Cost Amount (Actual)" + ValueEntry."Cost Amount (Expected)";
        AverageCostACY := ValueEntry."Cost Amount (Actual) (ACY)" + ValueEntry."Cost Amount (Expected) (ACY)";
        IF AverageQty <> 0 THEN BEGIN
            AverageCost := AverageCost / AverageQty;
            AverageCostACY := AverageCostACY / AverageQty;
            IF (AverageCost < 0) OR (AverageCostACY < 0) THEN BEGIN
                AverageCost := 0;
                AverageCostACY := 0;
            END;
        END ELSE BEGIN
            AverageCost := 0;
            AverageCostACY := 0;
        END;

        EXIT(AverageQty >= 0);
    end;

    local procedure CheckILE(CountryRegionCode: Code[20])
    var
        CountryRegion: Record "Country/Region";
    begin
        IF ("Item Ledger Entry"."Country/Region Code" IN [CompanyInfo."Country/Region Code", '']) =
           (CountryRegionCode IN [CompanyInfo."Country/Region Code", ''])
        THEN
            CurrReport.SKIP();
        IF CountryRegionCode <> '' THEN BEGIN
            CountryRegion.GET(CountryRegionCode);
            IF CountryRegion."Intrastat Code" = '' THEN
                CurrReport.SKIP();
        END;
    end;
}
