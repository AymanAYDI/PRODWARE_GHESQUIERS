page 50060 "PWD Check Credit Limit Release"
{
    Caption = 'Navision Attain';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Customer;
    UsageCategory = None;
    layout
    {
        area(content)
        {
            label(Control2)
            {
                CaptionClass = FORMAT(TextHeader);
                MultiLine = true;
                ShowCaption = false;
                ApplicationArea = All;
            }
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field(OrderAmountTotalLCY; OrderAmountTotalLCY)
                {
                    AutoFormatType = 1;
                    Caption = 'Outstanding Amt. (LCY)';
                    ApplicationArea = All;
                }
                field(ShippedRetRcdNotIndLCY; ShippedRetRcdNotIndLCY)
                {
                    Caption = 'Shipped/Ret. Rcd. Not Invd. (LCY)';
                    ApplicationArea = All;
                }
                field(OrderAmountThisOrderLCY; OrderAmountThisOrderLCY)
                {
                    AutoFormatType = 1;
                    Caption = 'Current Amount (LCY)';
                    ApplicationArea = All;
                }
                field(CustCreditAmountLCY; CustCreditAmountLCY)
                {
                    AutoFormatType = 1;
                    Caption = 'Total Amount (LCY)';
                    ApplicationArea = All;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Balance Due (LCY)"; Rec."Balance Due (LCY)")
                {
                    CaptionClass = FORMAT(STRSUBSTNO(Text001, FORMAT(Rec.GETRANGEMAX("Date Filter"))));
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(CUST)
            {
                Caption = '&Customer';
                Visible = CUSTVisible;
                action(Fiche)
                {
                    Caption = 'Card';
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action(Statistiques)
                {
                    Caption = 'Statistics';
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcCreditLimitLCY();
        CalcOverdueBalanceLCY();
    end;

    trigger OnInit()
    begin
        CUSTVisible := TRUE;
        NoVisible := TRUE;
        YESVisible := TRUE;
    end;

    trigger OnOpenPage()
    begin
        Rec.COPY(Cust2);

        IF CurrPage.LOOKUPMODE THEN BEGIN
            YESVisible := FALSE;
            NoVisible := FALSE;
            CUSTVisible := FALSE;
            TextHeader := STRSUBSTNO(Text000, Heading);
        END ELSE
            TextHeader := STRSUBSTNO(Text004, Heading);
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        Cust2: Record Customer;
        SalesLine: Record "Sales Line";
        [InDataSet]
        CUSTVisible: Boolean;
        [InDataSet]
        NoVisible: Boolean;
        [InDataSet]
        YESVisible: Boolean;
        CustNo: Code[20];
        CustCreditAmountLCY: Decimal;
        NewOrderAmountLCY: Decimal;
        OldOrderAmountLCY: Decimal;
        OrderAmountThisOrderLCY: Decimal;
        OrderAmountTotalLCY: Decimal;
        OutstandingRetOrdersLCY: Decimal;
        RcdNotInvdRetOrdersLCY: Decimal;
        ShippedRetRcdNotIndLCY: Decimal;
        Text000: Label '%1 Do you still want to record the amount?';
        Text001: Label 'Overdue Amounts (LCY) as of %1';
        Text002: Label 'The customer''s credit limit has been exceeded.';
        Text004: Label '%1 Voulez vous lancer la commande ?';
        Heading: Text[80];
        TextHeader: Text[100];

    procedure SalesHeaderShowWarning(SalesHeader: Record "Sales Header"): Boolean
    begin
        // Used when additional lines are inserted

        IF SalesHeader."Currency Code" = '' THEN
            NewOrderAmountLCY := SalesHeader."Amount Including VAT"
        ELSE
            NewOrderAmountLCY :=
              ROUND(
                CurrExchRate.ExchangeAmtFCYToLCY(
                  WORKDATE(), SalesHeader."Currency Code",
                  SalesHeader."Amount Including VAT", SalesHeader."Currency Factor"));

        IF NOT (SalesHeader."Document Type" IN
                [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Return Order"])
        THEN
            NewOrderAmountLCY := NewOrderAmountLCY + SalesLineAmount(SalesHeader."Document Type", SalesHeader."No.");
        EXIT(ShowWarning(SalesHeader."Bill-to Customer No.", NewOrderAmountLCY, 0, TRUE));
    end;

    local procedure SalesLineAmount(DocType: Integer; DocNo: Code[20]): Decimal
    begin
        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", DocType);
        SalesLine.SETRANGE("Document No.", DocNo);
        SalesLine.CALCSUMS("Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)");
        EXIT(SalesLine."Outstanding Amount (LCY)" + SalesLine."Shipped Not Invoiced (LCY)");
    end;

    local procedure ShowWarning(NewCustNo: Code[20]; NewOrderAmountLCY2: Decimal; OldOrderAmountLCY2: Decimal; CheckOverDueBalance: Boolean): Boolean
    begin
        IF NewCustNo = '' THEN
            EXIT;
        CustNo := NewCustNo;
        NewOrderAmountLCY := NewOrderAmountLCY2;
        OldOrderAmountLCY := OldOrderAmountLCY2;
        Rec.GET(CustNo);
        Rec.SETRANGE("No.", Rec."No.");
        Cust2.COPY(Rec);

        CalcCreditLimitLCY();
        IF (CustCreditAmountLCY > Rec."Credit Limit (LCY)") AND (Rec."Credit Limit (LCY)" <> 0) THEN BEGIN
            Heading := Text002;
            EXIT(TRUE);
        END;
    end;

    local procedure CalcCreditLimitLCY()
    begin
        IF Rec.GETFILTER("Date Filter") = '' THEN
            Rec.SETFILTER("Date Filter", '..%1', WORKDATE());
        Rec.CALCFIELDS("Balance (LCY)", "Outstanding Orders (LCY)", "Shipped Not Invoiced (LCY)");
        CalcReturnAmounts(OutstandingRetOrdersLCY, RcdNotInvdRetOrdersLCY);
        OrderAmountTotalLCY := Rec."Outstanding Orders (LCY)" - OutstandingRetOrdersLCY;
        ShippedRetRcdNotIndLCY := Rec."Shipped Not Invoiced (LCY)" - RcdNotInvdRetOrdersLCY;
        IF Rec."No." = CustNo THEN BEGIN
            OrderAmountThisOrderLCY := NewOrderAmountLCY;
            OrderAmountTotalLCY := OrderAmountTotalLCY - OldOrderAmountLCY;
        END ELSE
            OrderAmountThisOrderLCY := 0;
        CustCreditAmountLCY := Rec."Balance (LCY)" +
          (Rec."Shipped Not Invoiced (LCY)" - RcdNotInvdRetOrdersLCY) +
          OrderAmountTotalLCY + OrderAmountThisOrderLCY;
    end;

    local procedure CalcOverdueBalanceLCY()
    begin
        IF Rec.GETFILTER("Date Filter") = '' THEN
            Rec.SETFILTER("Date Filter", '..%1', WORKDATE());
        Rec.CALCFIELDS("Balance Due (LCY)");
    end;

    procedure CalcReturnAmounts(var OutstandingRetOrdersLCY2: Decimal; var RcdNotInvdRetOrdersLCY2: Decimal): Decimal
    begin
        SalesLine.RESET();
        SalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", "Currency Code");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
        SalesLine.SETRANGE("Bill-to Customer No.", Rec."No.");
        SalesLine.CALCSUMS("Outstanding Amount (LCY)", "Return Rcd. Not Invd. (LCY)");
        OutstandingRetOrdersLCY2 := SalesLine."Outstanding Amount (LCY)";
        RcdNotInvdRetOrdersLCY2 := SalesLine."Return Rcd. Not Invd. (LCY)";
    end;
}
