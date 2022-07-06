report 50062 "PWD Sales - Cr.memo AVITA"
{
    Caption = 'Sales - Cr.memo AVITA';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/SalesCrMemoAVITA.rdl';
    UsageCategory = None;
    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Cr.Memo';
            column(Sales_CrMemo_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo__Logo_ISSA_; CompanyInfo."PWD Logo AVITA facture")
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }

                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(InvoiceCaption; InvoiceCaptionLbl)
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr_7_; ShipToAddr[7])
                    {
                    }

                    column(N__id__intracom_____CompanyInfo__VAT_Registration_No__; IdintracomCaptionLbl + CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(Fax_______CompanyInfo__Fax_No__; FaxCaptionLbl + CompanyInfo."Fax No.")
                    {
                    }
                    column(E_Mail_______CompanyInfo__E_Mail_; EMailCaptionLbl + CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(Tel_CompanyInfo_Phone_No__; TelCaptionLbl + CompanyInfo."Phone No.")
                    {
                    }
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(CAPTAIN_AND_OWNER_S_OF_M_VCaption; CAPTAIN_AND_OWNER_S_OF_M_VCaptionLbl)
                    {
                    }
                    column(au_Capital_de___CompanyInfo__Stock_Capital_; 'au Capital de ' + CompanyInfo."Stock Capital")
                    {
                    }
                    column(CompanyInfo__Logo_AVITA_facture_; CompanyInfo."PWD Logo AVITA facture")
                    {
                    }
                    column(Sales_Cr_Memo_Header___DSA_No__; "Sales Cr.Memo Header"."PWD DSA No.")
                    {
                    }
                    column(Cust__VAT_Registration_No__; Cust."VAT Registration No.")
                    {
                    }
                    column(InvoiceCaption_Control1000000058; InvoiceCaptionLbl2)
                    {
                    }
                    column(CustAdditionalname; Cust."PWD Additional name")
                    {
                    }
                    column(CustMail4; 'E-mail 4 :  ' + Cust."PWD E-Mail 4")
                    {

                    }
                    column(GCO; GCO)
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; Text0051)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        trigger OnPreDataItem()
                        begin

                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;

                        trigger OnAfterGetRecord()
                        var
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DocDim1.FindFirst() THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO('%1, %2 %3', DimText, DocDim1."Dimension Code", DocDim1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DocDim1.NEXT() = 0);
                        end;

                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(STRSUBSTNO_Text004_CopyText_; STRSUBSTNO(Text004, CopyText))
                        {
                        }
                        column(Sales_CrMemo_Header__Reference; 'Vos Références :  ' + "Sales Cr.Memo Header"."PWD Reference")
                        {
                        }
                        column(Sales_Cr_Memo_Line_Description_Caption; FIELDCAPTION(Description))
                        {
                        }
                        column(Sales_Cr_Memo_Line__No__Caption; FIELDCAPTION("No."))
                        {
                        }
                        column(Sales_Cr_Memo_Line__VAT_Identifier_Caption; FIELDCAPTION("VAT Identifier"))
                        {

                        }
                        column(AmountCaption; AmountLbl)
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(UnitCaptionFR; UnitCaptionFRLbl)
                        {
                        }
                        column(ReferenceText; ReferenceText)
                        {
                        }
                        column(Sales_Cr_Memo_Header___Your_Reference_; "Sales Cr.Memo Header"."Your Reference")
                        {
                        }
                        column(AmountCaptionFR; AmountCaptionFRLbl)
                        {
                        }
                        column(Unit_PriceCaptionFR; Unit_PriceCaptionFRLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(QuantityCaptionFR; QuantityCaptionFRLbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Line_Amount_; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Type_; ShowTypeNo)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Description; Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line__No__; "No.")
                        {
                        }
                        column(Sales_Cr_Memo_Line_Quantity; Quantity)
                        {
                            DecimalPlaces = 3 : 3;
                        }
                        column(Sales_Cr_Memo_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Cr_Memo_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(Sales_Cr_Memo_Line__Line_Amount__Control70; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Sales_Cr_Memo_Line__VAT_Identifier_; "VAT Identifier")
                        {
                        }
                        column(Amount_Including_VAT_; TempVATAmountLine."VAT Amount")
                        {
                        }
                        column(ItemTrans_Description; ItemTrans.Description)
                        {
                        }
                        column(Sales_Cr_Memo_Line__Line_Amount__Control86; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(InvoiceCaption_Control1000000002; InvoiceCaption_Control1000000002Lbl)
                        {
                        }
                        column(Sales_Cr_Memo_Line_Amount; Amount)
                        {
                            AutoFormatType = 1;
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                        }
                        column(Amount_Including_VAT____Amount; "Amount Including VAT" - Amount)
                        {
                            AutoFormatType = 1;
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                        }
                        column(Sales_Cr_Memo_Line__Amount_Including_VAT_; "Amount Including VAT")
                        {
                            AutoFormatType = 1;
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode();
                        }
                        column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VatArrayID_1_; VatArrayID[1])
                        {
                        }
                        column(VatArrayID_2_; VatArrayID[2])
                        {
                        }
                        column(VatArrayID_3_; VatArrayID[3])
                        {
                        }
                        column(VatArrayID_4_; VatArrayID[4])
                        {
                        }
                        column(VatArrayRate_1_; VatArrayRate[1])
                        {
                        }
                        column(VatArrayRate_2_; VatArrayRate[2])
                        {
                        }
                        column(VatArrayRate_3_; VatArrayRate[3])
                        {
                        }
                        column(VatArrayRate_4_; VatArrayRate[4])
                        {
                        }
                        column(VatArrayBase_1_; VatArrayBase[1])
                        {
                        }
                        column(VatArrayBase_2_; VatArrayBase[2])
                        {
                        }
                        column(VatArrayBase_3_; VatArrayBase[3])
                        {
                        }
                        column(VatArrayBase_4_; VatArrayBase[4])
                        {
                        }

                        column(VatArrayAmount_1_; VatArrayAmount[1])
                        {
                        }
                        column(VatArrayAmount_2_; VatArrayAmount[2])
                        {
                        }
                        column(VatArrayAmount_3_; VatArrayAmount[3])
                        {
                        }
                        column(VatArrayAmount_4_; VatArrayAmount[4])
                        {
                        }
                        column(PaymentMethod_Description__________PaymentTerms_Description; PaymentMethod.Description + ' ' + PaymentTerms.Description)
                        {
                        }
                        column(Conditions_de_paiement___Settlement___Caption; Conditions_de_paiement___SettlementCaptionLbl)
                        {
                        }
                        column(TauxCaption; TauxCaptionLbl)
                        {
                        }
                        column(BaseCaption; BaseCaptionLbl)
                        {
                        }
                        column(MontantCaption; MontantCaptionLbl)
                        {
                        }
                        column(LA_MARCHANDISE_LIVREE_RESTECaption; LA_MARCHANDISE_LIVREE_RESTECaptionLbl)
                        {
                        }
                        column(Sales_CrMemo_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_CrMemo_Line_Line_No_; "Line No.")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();
                                DocDim2.SETRANGE("Dimension Set ID", "Sales Cr.Memo Line"."Dimension Set ID");
                            end;

                            trigger OnAfterGetRecord()
                            var
                            begin

                                IF Number = 1 THEN BEGIN
                                    IF NOT DocDim2.FindFirst() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DocDim2."Dimension Code", DocDim2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO('%1, %2 %3', DimText, DocDim2."Dimension Code", DocDim2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DocDim2.NEXT() = 0);
                            end;

                        }
                        trigger OnPreDataItem()
                        begin

                            TempVATAmountLine.DELETEALL();
                            MoreLines := FindLast();
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
                            //CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                        end;

                        trigger OnAfterGetRecord()
                        var
                        begin
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                            TempVATAmountLine.INIT();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                TempVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            TempVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            TempVATAmountLine.InsertLine();
                            //C2A
                            IF Type = Type::Item THEN
                                IF NOT ItemTrans.GET("No.", '', 'ENU') THEN ItemTrans.INIT();
                            ShowTypeNo := Type.AsInteger();
                        end;

                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        trigger OnPreDataItem()
                        begin

                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK();
                        end;

                    }

                }
                // trigger OnPreDataItem()
                // begin
                //     NoOfLoops := ABS(NoOfCopiesV) + Cust."Invoice Copies" + 1;
                //     IF NoOfLoops <= 0 THEN
                //         NoOfLoops := 1;
                //     CopyText := "Sales Cr.Memo Header"."No." + ' DU ' + FORMAT("Sales Cr.Memo Header"."Document Date");
                //     SETRANGE(Number, 1, NoOfLoops);
                //     OutputNo := 1;
                // end;

                // trigger OnAfterGetRecord()
                // var
                //     Text003: Label 'COPY';
                // begin
                //     IF Number > 1 THEN
                //         CopyText := CopyText + ' ' + Text003;
                //     OutputNo += 1;
                // end;

                // trigger OnPostDataItem()
                // var
                // begin
                //     IF NOT CurrReport.PREVIEW THEN
                //         SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
                // end;
                trigger OnAfterGetRecord()
                var
                    Text003: Label 'COPY';
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := CopyText + ' ' + Text003;
                        OutputNo += 1;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopiesV) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := "Sales Cr.Memo Header"."No." + ' DU ' + FORMAT("Sales Cr.Memo Header"."Document Date");
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    CompanyInfo.GET();
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                    CompanyInfo.CALCFIELDS("PWD Logo AVITA facture", "PWD Logo ISSA");

                END;

                DocDim1.SETRANGE("Dimension Set ID", "Sales Cr.Memo Header"."Dimension Set ID");

                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;
                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                Cust.GET("Bill-to Customer No.");
                //>> 01/07/2019 SU-DADE cf appel TI462849
                IF Cust."PWD C/O" THEN
                    GCO := 'C/O'
                ELSE
                    GCO := '';
                //<< 01/07/2019 SU-DADE cf appel TI462849

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                //BEGIN   11/10/06   C2A(LLE)   cf CDVN001274
                IF NOT PaymentMethod.GET("Payment Method Code") THEN
                    PaymentMethod.INIT();
                //END   11/10/06   C2A(LLE)

                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, "Sales Cr.Memo Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;
                //>-> GUE-RE.1.00
                IF LogInteractionV THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", '', "Posting Description", '');

                //<-< GUE-RE.1.00
            end;
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
                    field(NoOfCopies; NoOfCopiesV)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = All;
                    }
                    field(LogInteractionV; LogInteractionV)
                    {
                        Caption = 'Log Interaction';
                        enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field(IncludeShptNo; IncludeShptNo)
                    {
                        Caption = 'Inlude Shipment No.';
                        ApplicationArea = All;
                    }
                }
            }
        }
        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteractionV;
        end;
    }
    trigger OnInitReport()
    begin
        GLSetup.GET();
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.UseRequestPage THEN
            InitLogInteraction();
    end;

    procedure InitLogInteraction()
    begin
        LogInteractionV := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure DisplayVAT()
    var
        i: Integer;
    begin

        IF TempVATAmountLine.GetTotalVATAmount() = 0 THEN
            EXIT;
        FOR i := 1 TO TempVATAmountLine.COUNT DO BEGIN
            TempVATAmountLine.GetLine(i);
            VatArrayID[i] := TempVATAmountLine."VAT Identifier";
            VatArrayRate[i] := TempVATAmountLine."VAT %";
            VatArrayBase[i] := TempVATAmountLine."VAT Base";
            VatArrayAmount[i] := TempVATAmountLine."VAT Amount";
        END;
    end;

    var
        LogInteractionEnable: Boolean;
        OutputNo: Integer;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        TempVATAmountLine: Record "VAT Amount Line" TEMPORARY;
        DocDim1: Record "Dimension Set Entry";
        DocDim2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        SalesCrMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        OrderNoText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopiesV: Integer;
        NoOfLoops: Integer;
        CopyText: Text[50];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteractionV: Boolean;
        IncludeShptNo: Boolean;
        NoShipmentDatas: ARRAY[3] OF Text[20];
        NoShipmentNumLoop: Integer;
        NoShipmentText: Text[30];
        VatArrayID: array[4] of Code[10];
        VatArrayRate: ARRAY[4] OF Decimal;
        VatArrayBase: ARRAY[4] OF Decimal;
        VatArrayAmount: ARRAY[4] OF Decimal;
        Trad: Text[30];
        ItemTrans: Record "Item Translation";
        PaymentMethod: Record "Payment Method";
        GCO: Text[30];
        InvoiceCaptionLbl: Label 'Invoice';
        IdintracomCaptionLbl: Label 'N° id. intracom : ';
        FaxCaptionLbl: Label 'Fax : ';
        EMailCaptionLbl: Label 'E-Mail : ';
        TelCaptionLbl: Label 'Tel : ';
        ShipmentCaptionLbl: Label 'Shipment';
        CAPTAIN_AND_OWNER_S_OF_M_VCaptionLbl: Label 'CAPTAIN AND OWNER''S OF M/V';
        InvoiceCaptionLbl2: Label 'Invoice';
        Text004: Label 'Sales - Cr.Memo %1 %2';
        AmountLbl: Label 'Amount';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        UnitCaptionFRLbl: Label 'Unit';
        UnitCaptionLbl: Label 'Unit';
        Text0051: Label 'Page ';
        AmountCaptionFRLbl: Label 'Amount';
        Unit_PriceCaptionFRLbl: Label 'Unit Price';
        InvoiceCaption_Control1000000002Lbl: Label 'Invoice';
        Conditions_de_paiement___SettlementCaptionLbl: Label 'Conditions de paiement / Settlement';
        TauxCaptionLbl: Label 'Taux';
        BaseCaptionLbl: Label 'Base';
        MontantCaptionLbl: Label 'Montant';
        LA_MARCHANDISE_LIVREE_RESTECaptionLbl: Label 'LA MARCHANDISE LIVREE RESTE NOTRE PROPRIETE JUSQU''AU REGLEMENT COMPLET DE LA FACTURE (loi 80.335 PARUE AU J.O. DU 13.05.80)';
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text006: Label 'Total %1 Excl. VAT';
        QuantityCaptionLbl: Label 'Quantity';
        QuantityCaptionFRLbl: Label 'Quantity';
        ShowTypeNo: Integer;
}
