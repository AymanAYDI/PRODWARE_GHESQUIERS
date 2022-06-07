codeunit 60003 "PWD Function Mgt AB"
{
    /*
    //---CDU5703---
    procedure FCT_CDU5703OnCreateNewItemOnBeforeItemInsert(var Item: Record Item)
    var
        NonStock: Record "Nonstock Item";
    begin
        Item.VALIDATE("Tariff No.", NonStock."PWD Tariff No.");
        Item."Description 2" := NonStock."PWD Description 2";
        Item.VALIDATE("Shelf No.", NonStock."PWD Shelf No.");
        Item.VALIDATE("PWD Family", NonStock."PWD Family");
        Item.VALIDATE("PWD National Add. Code", NonStock."PWD National Add. Code");
        Item.VALIDATE("PWD IMPA Code", NonStock."PWD IMPA Code");
        Item.VALIDATE("PWD Trading Brand", TRUE);
    end;
    //---CDU333---
    procedure FCT_CDU333OnAfterInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line")
    var
        SalesOrderLine: Record "Sales Line";
    begin
        PurchOrderLine."Special Order Sales No." := '';
        PurchOrderLine."Special Order Sales Line No." := 0;
        PurchOrderLine."Special Order" := FALSE;
        PurchOrderLine.MODIFY();
        SalesOrderLine."Special Order" := FALSE;
        SalesOrderLine."Special Order Purchase No." := '';
        SalesOrderLine."Special Order Purch. Line No." := 0;
        SalesOrderLine.MODIFY();
    end;
    //---CDU365---
    PROCEDURE SeafranceSalesHeaderBillTo(VAR AddrArray: ARRAY[8] OF Text[50]; VAR SalesHeader: Record "PWD Seafrance Sales Header");
    var
        FormatAddress: Codeunit "Format Address";
    BEGIN
        //>>MIGRATION2009R2
        WITH SalesHeader DO
            FormatAddress.FormatAddr(
              AddrArray, "Sell-to Customer Name", "Sell-to Customer Name 2", "Sell-to Contact", "Sell-to Address", "Sell-to Address 2",
              "Sell-to City", "Sell-to Post Code", "Sell-to County", "Sell-to Country Code");
        //<<MIGRATION2009R2
    END;

    PROCEDURE SeafranceSalesHeaderShipTo(VAR AddrArray: ARRAY[8] OF Text[50]; VAR SalesHeader: Record "PWD Seafrance Sales Header");
    var
        FormatAddress: Codeunit "Format Address";
    BEGIN
        //>>MIGRATION2009R2
        WITH SalesHeader DO
            FormatAddress.FormatAddr(
              AddrArray, "Ship-to Name", "Ship-to Name 2", "Ship-to Contact", "Ship-to Address", "Ship-to Address 2",
              "Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country Code");
        //<<MIGRATION2009R2
    END;

    PROCEDURE FormatAddrInvoiceGHES(VAR AddrArray: ARRAY[8] OF Text[90]; Name: Text[90]; Name2: Text[90]; Contact: Text[90]; Addr: Text[50]; Addr2: Text[50]; City: Text[50]; PostCode: Code[20]; County: Text[50]; CountryCode: Code[10]);
    VAR
        Country: Record "Country/Region";
        InsertText: Integer;
        Index: Integer;
        NameLineNo: Integer;
        Name2LineNo: Integer;
        AddrLineNo: Integer;
        Addr2LineNo: Integer;
        ContLineNo: Integer;
        PostCodeCityLineNo: Integer;
        CountyLineNo: Integer;
        CountryLineNo: Integer;
        Dummy: Text[50];
        GLSetup: Record "General Ledger Setup";
    BEGIN
        //>>SOBI
        // Le code r‚gion est plac‚ avant le code postal + ville
        // Par rapport … la fonction standard on a invers‚ les affectations de PostCodeCityLineNo et CountyLineNo

        CLEAR(AddrArray);

        IF CountryCode = '' THEN BEGIN
            GLSetup.GET();
            CLEAR(Country);
            Country."Address Format" := GLSetup."Local Address Format";
            Country."Contact Address Format" := GLSetup."Local Cont. Addr. Format";
        END ELSE
            Country.GET(CountryCode);

        CASE Country."Contact Address Format" OF
            Country."Contact Address Format"::First:
                BEGIN
                    NameLineNo := 2;
                    Name2LineNo := 3;
                    ContLineNo := 1;
                    AddrLineNo := 4;
                    Addr2LineNo := 5;
                    PostCodeCityLineNo := 7;
                    CountyLineNo := 6;
                    CountryLineNo := 8;
                END;
            Country."Contact Address Format"::"After Company Name":
                BEGIN
                    NameLineNo := 1;
                    Name2LineNo := 2;
                    ContLineNo := 3;
                    AddrLineNo := 4;
                    Addr2LineNo := 5;
                    PostCodeCityLineNo := 7;
                    CountyLineNo := 6;
                    CountryLineNo := 8;
                END;
            Country."Contact Address Format"::Last:
                BEGIN
                    NameLineNo := 1;
                    Name2LineNo := 2;
                    ContLineNo := 8;
                    AddrLineNo := 3;
                    Addr2LineNo := 4;
                    PostCodeCityLineNo := 6;
                    CountyLineNo := 5;
                    CountryLineNo := 7;
                END;
        END;

        IF Country."Address Format" = Country."Address Format"::"County/Post Code+City" THEN BEGIN
            CountyLineNo := PostCodeCityLineNo;
            PostCodeCityLineNo := CountyLineNo + 1;
        END;

        AddrArray[NameLineNo] := Name;
        AddrArray[Name2LineNo] := Name2;
        AddrArray[AddrLineNo] := Addr;
        AddrArray[Addr2LineNo] := Addr2;

        CASE Country."Address Format" OF
            Country."Address Format"::"Post Code+City",
              Country."Address Format"::"City+County+Post Code",
              Country."Address Format"::"City+Post Code",
              Country."Address Format"::"Post Code+City/County",
              Country."Address Format"::"County/Post Code+City":
                BEGIN
                    AddrArray[ContLineNo] := Contact;
                    //TODO: GeneratePostCodeCity Fonction local dans le codeunit "Format Address"
                    "Format Address" "Format Address" "Format Address" City(AddrArray[PostCodeCityLineNo], AddrArray[CountyLineNo], City, PostCode, County, Country);
                    AddrArray[CountryLineNo] := Country.Name;
                    COMPRESSARRAY(AddrArray);
                END;
            Country."Address Format"::"Blank Line+Post Code+City":
                BEGIN
                    IF ContLineNo < PostCodeCityLineNo THEN
                        AddrArray[ContLineNo] := Contact;
                    COMPRESSARRAY(AddrArray);

                    Index := 1;
                    InsertText := 1;
                    REPEAT
                        IF AddrArray[Index] = '' THEN BEGIN
                            CASE InsertText OF
                                2:
                                    GeneratePostCodeCity(AddrArray[Index], Dummy, City, PostCode, County, Country);
                                3:
                                    AddrArray[Index] := Country.Name;
                                4:
                                    IF ContLineNo > PostCodeCityLineNo THEN
                                        AddrArray[Index] := Contact;
                            END;
                            InsertText := InsertText + 1;
                        END;
                        Index := Index + 1;
                    UNTIL Index = 9;
                END;
        END;
        //<<SOBI
    END;

    PROCEDURE SalesInvBillToGHES(VAR AddrArray: ARRAY[8] OF Text[50]; VAR SalesInvHeader: Record "Sales Invoice Header");
    BEGIN
        //>>SOBI
        WITH SalesInvHeader DO
            FormatAddrInvoiceGHES(
              AddrArray, "Bill-to Name", "Bill-to Name 2", "Bill-to Contact", "Bill-to Address", "Bill-to Address 2",
              "Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code");
        //<<SOBI
    END;

    //---CDU414---
    procedure FCT_CDU414OnBeforeReleaseSalesDocEvent(var SalesHeader: Record "Sales Header")
    var
        SetGetFunction: Codeunit "PWD Set/Get Functions";
        //TODO : Record Member of n'existe pas
        UserRole: Record "Member Of";
    begin
        IF SalesHeader."PWD Preparation Status" = SalesHeader."PWD Preparation Status"::" " THEN
            SalesHeader."PWD Preparation Status" := SalesHeader."PWD Preparation Status"::"Ready to prepare";
        IF NOT SetGetFunction.GetProcessing() THEN BEGIN
            IF NOT UserRole.GET(USERID, 'DIRECTION') THEN
                SalesHeaderCheckError(SalesHeader)
            ELSE
                SalesHeaderCheckMessage(SalesHeader)
        END;
    end;

    procedure FCT_CDU414OnAfterReleaseSalesDocEvent(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Txt50000: Label 'une ou plusieur(s) ligne(s) ne possède(nt) pas de quantitéé à expédier.Souhaitez-vous effectuer leur(s) mise à jours?';

    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            SalesLine.SETFILTER(Quantity, '<>0');
            SalesLine.SETFILTER("Qty. to Ship", '%1', 0);
            IF SalesLine.FINDFIRST() THEN BEGIN
                IF CONFIRM(Txt50000, TRUE) THEN
                    REPEAT
                        SalesLine.VALIDATE("Qty. to Ship", SalesLine.Quantity);
                        SalesLine.MODIFY;
                    UNTIL SalesLine.NEXT = 0;
            END;
        END;
    end;

    procedure TestDocumentAvita(VAR SalesHeader: Record "Sales Header")
    VAR
        SalesLine: Record "Sales Line";
        Item: Record "Sales Line";
        Txt1000000003: Label 'La marge sur la ligne %1 (article %2) doit être au minimum de %3 %4.';
        Txt1000000004: Label 'Les poids doivent être renseignés sur la ligne %1 .';
        Txt1000000005: Label 'Le prix doit être renseignés sur la ligne %1 .';
    begin
        TestDocProfit(SalesHeader);
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, 2);
        IF SalesLine.FindSet() THEN begin
            REPEAT
                //Contole marge article
                Item.GET(SalesLine."No.");
                //   IF SalesLine."% de marge r‚alis‚" < Item."Profit %" THEN ERROR (Text1000000003,SalesLine."Line No.",SalesLine."No.",
                //    Item."Profit %",'%');
                IF (SalesLine."Net Weight" = 0) OR (SalesLine."Gross Weight" = 0) THEN
                    ERROR(Txt1000000004, SalesLine."Line No.");
            //*** Suppr SCA - C2A - 13/11/2003
            //IF SalesLine."Unit Price" = 0 THEN ERROR (Text1000000005,SalesLine."Line No.");
            UNTIL SalesLine.NEXT = 0;
        end
    end;

    procedure TestDocProfit(VAR Rec: Record "Sales Header");
    VAR
        TotalSalesLine: ARRAY[3] OF Record "Sales Line";
        TotalSalesLineLCY: ARRAY[3] OF Record "Sales Line";
        Cust: Record Customer;
        TempVATAmountLine1: Record "VAT Amount Line" TEMPORARY;
        TempVATAmountLine2: Record "VAT Amount Line" TEMPORARY;
        TempVATAmountLine3: Record "VAT Amount Line" TEMPORARY;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPost: Codeunit "Sales-Post";
        TotalAmount1: ARRAY[3] OF Decimal;
        TotalAmount2: ARRAY[3] OF Decimal;
        VATAmount: ARRAY[3] OF Decimal;
        VATAmountText: ARRAY[3] OF Text[30];
        ProfitLCY: ARRAY[3] OF Decimal;
        ProfitPct: ARRAY[3] OF Decimal;
        CreditLimitLCYExpendedPct: Decimal;
        i: Integer;
        PrevNo: Code[20];
        ActiveTab: Option General,Invoicing,Shipping;
        PrevTab: Option General,Invoicing,Shipping;
        SubformIsReady: Boolean;
        SubformIsEditable: Boolean;
        AllowInvDisc: Boolean;
        AllowVATDifference: Boolean;
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" TEMPORARY;
        Text1000000004: Label 'La marge sur la commande %1 doit être au minimum de  %2 %3.';
        DecLTotalAdjCostLCY: Decimal;
    BEGIN
        WITH Rec DO BEGIN
            CLEAR(SalesLine);
            CLEAR(TotalSalesLine);
            CLEAR(TotalSalesLineLCY);

            FOR i := 1 TO 3 DO BEGIN
                TempSalesLine.DELETEALL;
                CLEAR(TempSalesLine);
                CLEAR(SalesPost);
                SalesPost.GetSalesLines(Rec, TempSalesLine, i - 1);
                CLEAR(SalesPost);
                CASE i OF
                    1:
                        SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine1);
                    2:
                        SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine2);
                    3:
                        SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine3);
                END;
                //add a specific parameter : DecLTotalAdjCostLCY
                SalesPost.SumSalesLinesTemp(
                  Rec, TempSalesLine, i - 1, TotalSalesLine[i], TotalSalesLineLCY[i],
                  VATAmount[i], VATAmountText[i], ProfitLCY[i], ProfitPct[i], DecLTotalAdjCostLCY);
                IF "Prices Including VAT" THEN BEGIN
                    TotalAmount2[i] := TotalSalesLine[i].Amount;
                    TotalAmount1[i] := TotalAmount2[i] + VATAmount[i];
                    TotalSalesLine[i]."Line Amount" := TotalAmount1[i] + TotalSalesLine[i]."Inv. Discount Amount";
                END ELSE BEGIN
                    TotalAmount1[i] := TotalSalesLine[i].Amount;
                    TotalAmount2[i] := TotalSalesLine[i]."Amount Including VAT";
                END;
            END;

            IF Cust.GET("Bill-to Customer No.") THEN
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

            TempVATAmountLine1.MODIFYALL(Modified, FALSE);
            TempVATAmountLine2.MODIFYALL(Modified, FALSE);
            TempVATAmountLine3.MODIFYALL(Modified, FALSE);
            Cust.GET("Bill-to Customer No.");
            IF ProfitPct[1] < Cust."Discount Profit %" THEN MESSAGE(Text1000000004, Rec."No.", Cust."Discount Profit %", '%');
        END;
    END;

    procedure GetPassWord();
    VAR
        SalesSetup: Record "Sales & Receivables Setup";
        Password: Text[30];
        //TODO : Record Member of n'existe pas
        UserRole: Record "Member Of";
    BEGIN
        //IF NOT UserRole.GET (USERID,'DIRECTION') THEN ERROR (Text1000000001);
    END;

    procedure SalesHeaderCheckError(SalesHeader: Record "Sales Header");
    VAR
        CustCheckCreditLimit: Page "PWD Check Credit Limit Release";
        OK: Boolean;
        Text000: Label 'The update has been interrupted to respect the warning.', Comment = 'FRA="La mise à jour a été interrompue pour respecter l''alerte."';
    BEGIN
        IF CustCheckCreditLimit.SalesHeaderShowWarning(SalesHeader) THEN BEGIN
            CustCheckCreditLimit.LOOKUPMODE := TRUE;
            CustCheckCreditLimit.RUNMODAL;
            CLEAR(CustCheckCreditLimit);
            ERROR(Text000);
        END;
    END;

    procedure SalesHeaderCheckMessage(SalesHeader: Record "Sales Header");
    VAR
        CustCheckCreditLimit: Page "PWD Check Credit Limit Release";
        OK: Boolean;
        Text000: label 'The update has been interrupted to respect the warning.', Comment = 'FRA="La mise à jour a été interrompue pour respecter l''alerte."';
    BEGIN
        IF CustCheckCreditLimit.SalesHeaderShowWarning(SalesHeader) THEN BEGIN
            OK := CustCheckCreditLimit.RUNMODAL = ACTION::Yes;
            CLEAR(CustCheckCreditLimit);
            IF NOT OK THEN
                ERROR(Text000);
        END;
    END;

    var
*/
}
