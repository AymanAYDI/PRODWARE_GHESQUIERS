report 50061 "PWD Sales - Invoice AVITA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/SalesInvoiceAVITA.rdlc';
    Caption = 'Sales - Invoice AVITA';
    UsageCategory = None;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(ShipToAddr_7_; ShipToAddr[7])
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(au_Capital_de___CompanyInfo__Stock_Capital_; 'au Capital de ' + CompanyInfo."Stock Capital")
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(Pays_Name; Pays.Name)
                    {
                    }
                    column(Tel_______CompanyInfo__Phone_No__; 'Tel : ' + CompanyInfo."Phone No.")
                    {
                    }
                    column(Fax_______CompanyInfo__Fax_No__; 'Fax : ' + CompanyInfo."Fax No.")
                    {
                    }
                    column(E_Mail_______CompanyInfo__E_Mail_; 'E-Mail : ' + CompanyInfo."E-Mail")
                    {
                    }
                    column(N__TVA_____CompanyInfo__VAT_Registration_No__; 'N° TVA : ' + CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo__Logo_AVITA_facture_; CompanyInfo."PWD Logo AVITA facture")
                    {
                    }
                    column(Cust__VAT_Registration_No__; Cust."VAT Registration No.")
                    {
                    }
                    column(RCS____CompanyInfo__Trade_Register_; 'RCS: ' + CompanyInfo."Trade Register")
                    {
                    }
                    column(N__Siret____CompanyInfo__Registration_No__; 'N° Siret: ' + CompanyInfo."Registration No.")
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(Sales_Invoice_Header___Bill_to_Additional_name_; "Sales Invoice Header"."PWD Bill-to Additional name")
                    {
                    }
                    column(TxtGC_O; TxtGC_O)
                    {
                    }
                    column(CustMail4; 'Email4 :  ' + Cust."PWD E-Mail 4")
                    {
                    }
                    column(ShipmentCaption; ShipmentCaptionLbl)
                    {
                    }
                    column(InvoiceCaption; InvoiceCaptionLbl)
                    {
                    }
                    column(CAPTAIN_AND_OWNER_S_OF_M_VCaption; CAPTAIN_AND_OWNER_S_OF_M_VCaptionLbl)
                    {
                    }
                    column(InvoiceCaption_Control1000000064; InvoiceCaption_Control1000000064Lbl)
                    {
                    }
                    column(InvoiceCaption_Control1000000075; InvoiceCaption_Control1000000075Lbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FIND('-') THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DimSetEntry1.NEXT() = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfoV THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        PrintOnlyIfDetail = false;
                        column(STRSUBSTNO_Text004_CopyText_; STRSUBSTNO(Text004, CopyText))
                        {
                        }
                        column(N__de_commande_____Sales_Invoice_Header___Order_No__; 'N° de commande ' + "Sales Invoice Header"."Order No.")
                        {
                        }
                        column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; Text005)
                        {
                        }
                        column(Vos_ref___; 'Vos ref :')
                        {
                        }
                        column(Sales_Invoice_Header__Reference; "Sales Invoice Header"."PWD Reference")
                        {
                        }
                        column(REP________Sales_Invoice_Header___Salesperson_Code_; 'REP : ' + "Sales Invoice Header"."Salesperson Code")
                        {
                        }
                        column(Sales_Invoice_Line__Line_Amount_; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Type_; ShowTypeNo1)
                        {
                        }
                        column(Sales_Invoice_Line_Description; Description)
                        {
                        }
                        column(Sales_Invoice_Line__No__; "No.")
                        {
                        }
                        column(Description__Description_2_; Description)
                        {
                        }
                        column(Sales_Invoice_Line_Quantity; Quantity)
                        {
                            DecimalPlaces = 3 : 3;
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control70; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Line_Discount___; "Line Discount %")
                        {
                        }
                        column(GDescription; GDescription)
                        {
                        }
                        column(Sales_Invoice_Line__VAT_Identifier_; "VAT Identifier")
                        {
                        }
                        column(VAT__Prcnt_; VATAmountLine."VAT %")
                        {
                        }
                        column(Amount_Including_VAT_; VATAmountLine."VAT Amount")
                        {
                        }
                        column(VAT_Base_Amount_; VATAmountLine."VAT Base")
                        {
                        }
                        column(IntTriRTC; IntTriRTC)
                        {
                        }
                        column(TxTGMentionEXO_; TxTGMentionEXO)
                        {
                        }
                        column(Sales_Invoice_Line___Designation_ENU_; "PWD Designation ENU")
                        {
                        }
                        column(Sales_Invoice_Line___Description_2_; "Sales Invoice Line"."Description 2")
                        {
                        }
                        column(SalesLine__Type1_; ShowTypeNo)
                        {
                        }
                        column(IntGLineNo; IntGLineNo)
                        {
                        }
                        column(Sales_Invoice_Line__Line_Amount__Control86; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line_Amount; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Amount_Including_VAT____Amount; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Sales_Invoice_Line__Amount_Including_VAT_; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText())
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
                        column(VatArrayBase_1_; VatArrayBase[1])
                        {
                        }
                        column(VatArrayAmount_1_; VatArrayAmount[1])
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
                        column(VatArrayBase_2_; VatArrayBase[2])
                        {
                        }
                        column(VatArrayBase_3_; VatArrayBase[3])
                        {
                        }
                        column(VatArrayBase_4_; VatArrayBase[4])
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
                        column(PaymentMethod_Description__________PaymentTerms_Description; PaymentMethod.Description + '  ' + PaymentTerms.Description)
                        {
                        }
                        column(Sales_Invoice_Header___Due_Date_; "Sales Invoice Header"."Due Date")
                        {
                        }
                        column(MentionEXO; MentionEXO)
                        {
                        }
                        column(DataItem1000000080; 'Banque : ' + CompanyInfo."Bank Name" + '    Iban : ' + CompanyInfo."Bank Branch No." + CompanyInfo."Bank Account No." + '    Swift code : ' + CompanyInfo."Payment Routing No.")
                        {
                        }
                        column(PaymentMethod_Description_; PaymentMethod.Description)
                        {
                        }
                        column(PaymentTerms_Description_; PaymentTerms.Description)
                        {
                        }
                        column(RecGVatArrayAmount_1; RecGVatArrayAmount[1])
                        {
                        }
                        column(RecGVatArrayRate_4; RecGVatArrayRate[4])
                        {
                        }
                        column(RecGVatArrayRate_3; RecGVatArrayRate[3])
                        {
                        }
                        column(RecGVatArrayRate_2; RecGVatArrayRate[2])
                        {
                        }
                        column(RecGVatArrayRate_1; RecGVatArrayRate[1])
                        {
                        }
                        column(CodGVatArrayID_4; CodGVatArrayID[4])
                        {
                        }
                        column(CodGVatArrayID_3; CodGVatArrayID[3])
                        {
                        }
                        column(CodGVatArrayID_2; CodGVatArrayID[2])
                        {
                        }
                        column(CodGVatArrayID_1; CodGVatArrayID[1])
                        {
                        }
                        column(RecGVatArrayAmount_4; RecGVatArrayAmount[4])
                        {
                        }
                        column(RecGVatArrayAmount_3; RecGVatArrayAmount[3])
                        {
                        }
                        column(RecGVatArrayAmount_2; RecGVatArrayAmount[2])
                        {
                        }
                        column(RecGVatArrayBase_4; RecGVatArrayBase[4])
                        {
                        }
                        column(RecGVatArrayBase_3; RecGVatArrayBase[3])
                        {
                        }
                        column(RecGVatArrayBase_2; RecGVatArrayBase[2])
                        {
                        }
                        column(RecGVatArrayBase_1; RecGVatArrayBase[1])
                        {
                        }
                        column(Sales_Invoice_Line__VAT_Identifier_Caption; Sales_Invoice_Line__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line__No__Caption; FIELDCAPTION("No."))
                        {
                        }
                        column("DésignationCaption"; DésignationCaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_QuantityCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(Sales_Invoice_Line__Unit_of_Measure_Caption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption_Control1000000048; Unit_PriceCaption_Control1000000048Lbl)
                        {
                        }
                        column(AmountCaption_Control1000000052; AmountCaption_Control1000000052Lbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(Remise_DiscountCaption; Remise_DiscountCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(DiscountCaption; DiscountCaptionLbl)
                        {
                        }
                        column(VAT_Identifier_Caption; VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(Identifier_Caption; Identifier_CaptionLbl)
                        {
                        }
                        column(RemiseCaption; RemiseCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control85; ContinuedCaption_Control85Lbl)
                        {
                        }
                        column(Conditions_de_paiement___Settlement___Caption; Conditions_de_paiement___Settlement___CaptionLbl)
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
                        column(Sales_Invoice_Header___Due_Date_Caption; "Sales Invoice Header".FIELDCAPTION("Due Date"))
                        {
                        }
                        column(DataItem1000000053; LA_MARCHANDISE_LIVREE_RESTE_NOTRE_PROPRIETE_JUSQU_AU_REGLEMENT_COMPLET_DE_LA_FACTURE_loi_80335_PARUE_AU_J_O_DU_CaLbl)
                        {
                        }
                        column(DataItem1000000056; AucunEscompteNeSeraAccordéEnCasDePaiementAnticipéToutRetardDePaiementEntraîneraDesPénalitésDeRetardReprésLbl)
                        {
                        }
                        column("Textindemnitéforfaitaire_Caption"; Textindemnitéforfaitaire_CaptionLbl)
                        {
                        }
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_; "Line No.")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FIND('-') THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          '%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DimSetEntry2.NEXT() = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfoV THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(ShipmentDatas; Integer)
                        {
                            DataItemTableView = SORTING(Number);

                            trigger OnAfterGetRecord()
                            begin
                                CLEAR(NoShipmentDatas);
                                NoShipmentNumLoop := 0;
                                IF Number = 1 THEN BEGIN
                                    ShipmentInvoiced.FIND('-');
                                    NoShipmentText := Text007;
                                    REPEAT
                                        NoShipmentNumLoop := NoShipmentNumLoop + 1;
                                        NoShipmentDatas[NoShipmentNumLoop] := ShipmentInvoiced."Shipment No.";
                                    UNTIL (ShipmentInvoiced.NEXT() = 0) OR (NoShipmentNumLoop = 3);
                                END ELSE BEGIN
                                    NoShipmentText := '';
                                    REPEAT
                                        NoShipmentNumLoop := NoShipmentNumLoop + 1;
                                        NoShipmentDatas[NoShipmentNumLoop] := ShipmentInvoiced."Shipment No.";
                                    UNTIL (ShipmentInvoiced.NEXT() = 0) OR (NoShipmentNumLoop = 3);
                                END;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT IncludeShptNoV THEN
                                    CurrReport.BREAK();

                                IF ShipmentInvoiced.COUNT < 1 THEN
                                    CurrReport.BREAK();
                                ShipmentDatas.SETRANGE(Number, 1, ROUND(ShipmentInvoiced.COUNT / 3, 1, '>'));
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            BooLFind: Boolean;
                            j: Integer;
                        begin
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfoV) THEN
                                "No." := '';
                            VATAmountLine.INIT();
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine();
                            IF IncludeShptNoV THEN BEGIN
                                ShipmentInvoiced.RESET();
                                ShipmentInvoiced.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                                ShipmentInvoiced.SETRANGE("Invoice Line No.", "Sales Invoice Line"."Line No.");
                            END;
                            IF Type = Type::Item THEN
                                IF NOT ItemTrans.GET("No.", '', 'ENU') THEN ItemTrans.INIT();
                                ShowTypeNo := Type.AsInteger();
                                ShowTypeNo1 := Type.AsInteger();
                                IntGLineNo := "Sales Invoice Line"."Line No.";
                                IF Type <> Type::Item THEN
                                    IntTriRTC := IntGTotalLocation + 1
                                ELSE
                                    IF ("Location Code" = 'CML') OR ("Location Code" = '1') THEN
                                        IntTriRTC := 1
                                    ELSE BEGIN
                                        j := 2;
                                        BooLFind := FALSE;
                                        IF IntGTotalLocation = 1 THEN
                                            BooLFind := TRUE;
                                        WHILE (j <= IntGTotalLocation) OR (NOT BooLFind) DO BEGIN
                                            IF TxtGLocationFilter[j] = "Location Code" THEN BEGIN
                                                IntTriRTC := j;
                                                BooLFind := TRUE;
                                            END;
                                            j := j + 1;
                                        END;
                                    END;
                                RecGCallType.GET("Sales Invoice Header"."PWD Call Type");
                                IF RecGCallType."Message EXO" = TRUE THEN
                                    TxTGMentionEXO := 'Exonération TVA art.262 II du C.G.I.'
                                ELSE
                                    TxTGMentionEXO := '';

                                IF VATAmountLine.GetTotalVATAmount() = 0 THEN BEGIN
                                    FOR i := 1 TO 4 DO BEGIN
                                        CodGVatArrayID[i] := ' ';
                                        RecGVatArrayRate[i] := 0;
                                        RecGVatArrayBase[i] := 0;
                                        RecGVatArrayAmount[i] := 0;
                                    END;
                                    EXIT;
                                END;
                                FOR i := 1 TO VATAmountLine.COUNT DO BEGIN
                                    VATAmountLine.GetLine(i);
                                    CodGVatArrayID[i] := VATAmountLine."VAT Identifier";
                                    RecGVatArrayRate[i] := VATAmountLine."VAT %";
                                    RecGVatArrayBase[i] := VATAmountLine."VAT Base";
                                    RecGVatArrayAmount[i] := VATAmountLine."VAT Amount";
                                END;
                            IF "Sales Invoice Line"."PWD Designation ENU" <> '' THEN
                                GDescription := "Sales Invoice Line"."PWD Designation ENU"
                            ELSE
                                GDescription := "Sales Invoice Line"."Description 2";
                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DELETEALL();
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
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

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := CopyText;
                        OutputNo += 1;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopiesV) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := "Sales Invoice Header"."No." + ' DU ' + FORMAT("Sales Invoice Header"."Document Date");
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                RecLSalesInvoiceLine: Record "Sales Invoice Line";
                j: Integer;
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

                DimSetEntry1.SETRANGE("Dimension Set ID", "Sales Invoice Header"."Dimension Set ID");
                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
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
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                Cust.GET("Bill-to Customer No.");

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");

                IF NOT PaymentMethod.GET("Payment Method Code") THEN PaymentMethod.INIT();
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.SalesInvSellTo(ShipToAddr, "Sales Invoice Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF LogInteractionV THEN
                    IF NOT CurrReport.PREVIEW THEN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code", '', "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code", '', "Posting Description", '');

                CLEAR(TxtGLocationFilter);
                TxtGLocationFilter[1] := 'CML|1';
                j := 2;
                CLEAR(RecLSalesInvoiceLine);
                CLEAR(CodGLastLocation);
                RecLSalesInvoiceLine.SETCURRENTKEY("Document No.", "Location Code");
                RecLSalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                RecLSalesInvoiceLine.SETRANGE(Type, RecLSalesInvoiceLine.Type::Item);
                RecLSalesInvoiceLine.SETFILTER("Location Code", '<>%1|%2|%3', 'CML', '1', '');
                RecLSalesInvoiceLine.SETFILTER(Quantity, '<>0');
                IF RecLSalesInvoiceLine.FIND('-') THEN
                    REPEAT
                        IF ((RecLSalesInvoiceLine."Location Code" <> CodGLastLocation) AND
                           (RecLSalesInvoiceLine."Location Code" <> 'CML') AND
                           (RecLSalesInvoiceLine."Location Code" <> '1') AND
                           (RecLSalesInvoiceLine."Location Code" <> '')) THEN BEGIN
                            TxtGLocationFilter[j] := RecLSalesInvoiceLine."Location Code";
                            CodGLastLocation := RecLSalesInvoiceLine."Location Code";
                            j += 1;
                        END;
                    UNTIL RecLSalesInvoiceLine.NEXT() = 0;
                IntGTotalLocation := j - 1;

                IF "Sales Invoice Header"."PWD Bill-to C/O" THEN
                    TxtGC_O := 'c/o'
                ELSE
                    TxtGC_O := '';
                PWDFunctionMgt.SalesInvBillToGHES(CustAddr, "Sales Invoice Header");
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
                    field(ShowInternalInfo; ShowInternalInfoV)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; LogInteractionV)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field(IncludeShptNo; IncludeShptNoV)
                    {
                        Caption = 'Inlude Shipment No.';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
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

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction();
    end;

    var
        CompanyInfo: Record "Company Information";
        Pays: Record "Country/Region";
        Cust: Record Customer;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        ItemTrans: Record "Item Translation";
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        RecGCallType: Record "PWD Call Type";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentInvoiced: Record "Shipment Invoiced";
        ShipmentMethod: Record "Shipment Method";
        VATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        PWDFunctionMgt: codeunit "PWD Function Mgt";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        IncludeShptNoV: Boolean;
        LogInteractionV: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfoV: Boolean;
        ShowShippingAddr: Boolean;
        CodGLastLocation: Code[10];
        CodGVatArrayID: array[4] of Code[10];
        VatArrayID: array[4] of Code[10];
        RecGVatArrayAmount: array[4] of Decimal;
        RecGVatArrayBase: array[4] of Decimal;
        RecGVatArrayRate: array[4] of Decimal;
        VatArrayAmount: array[4] of Decimal;
        VatArrayBase: array[4] of Decimal;
        VatArrayRate: array[4] of Decimal;
        i: Integer;
        IntGLineNo: Integer;
        IntGTotalLocation: Integer;
        IntTriRTC: Integer;
        NoOfCopiesV: Integer;
        NoOfLoops: Integer;
        NoShipmentNumLoop: Integer;
        OutputNo: Integer;
        ShowTypeNo: Integer;
        ShowTypeNo1: Integer;
        AmountCaption_Control1000000052Lbl: Label 'Amount';
        AmountCaptionLbl: Label 'Amount';
        AucunEscompteNeSeraAccordéEnCasDePaiementAnticipéToutRetardDePaiementEntraîneraDesPénalitésDeRetardReprésLbl: Label 'Aucun escompte ne sera accordé en cas de paiement anticipé. Tout retard de paiement entraînera des pénalités de retard représentant 1,5% du montant H.T. de la facture par mois de retard.';
        BaseCaptionLbl: Label 'Base';
        CAPTAIN_AND_OWNER_S_OF_M_VCaptionLbl: Label 'MASTER AND OWNER OF VESSEL';
        Conditions_de_paiement___Settlement___CaptionLbl: Label 'Conditions de paiement / Settlement : ';
        ContinuedCaption_Control85Lbl: Label 'Continued';
        ContinuedCaptionLbl: Label 'Continued';
        DescriptionCaptionLbl: Label 'Description';
        "DésignationCaptionLbl": Label 'Désignation';
        DiscountCaptionLbl: Label '%Dis';
        Identifier_CaptionLbl: Label 'TVA';
        InvoiceCaption_Control1000000064Lbl: Label 'Invoice';
        InvoiceCaption_Control1000000075Lbl: Label 'Invoice';
        InvoiceCaptionLbl: Label 'Invoice';
        LA_MARCHANDISE_LIVREE_RESTE_NOTRE_PROPRIETE_JUSQU_AU_REGLEMENT_COMPLET_DE_LA_FACTURE_loi_80335_PARUE_AU_J_O_DU_CaLbl: Label 'LA MARCHANDISE LIVREE RESTE NOTRE PROPRIETE JUSQU''AU REGLEMENT COMPLET DE LA FACTURE (loi 80.335 PARUE AU J.O. DU 13.05.80)';
        MontantCaptionLbl: Label 'Montant';
        QuantityCaptionLbl: Label 'Quantity';
        Remise_DiscountCaptionLbl: Label '% Rem';
        RemiseCaptionLbl: Label '%Rem';
        Sales_Invoice_Line__VAT_Identifier_CaptionLbl: Label '%TVA';
        ShipmentCaptionLbl: Label 'Shipment';
        TauxCaptionLbl: Label 'Taux';
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text004: Label 'Sales - Invoice %1 %2';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'ShipmentNo';
        "Textindemnitéforfaitaire_CaptionLbl": Label 'Le montant de l''indemnité forfaitaire de recouvrement est fixé à 40 euros.';
        Unit_PriceCaption_Control1000000048Lbl: Label 'Unit Price';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        UnitCaptionLbl: Label 'Unit';
        VAT_Identifier_CaptionLbl: Label 'VAT';
        NoShipmentDatas: array[3] of Text[20];
        NoShipmentText: Text[30];
        OrderNoText: Text[30];
        ReferenceText: Text[30];
        SalesPersonText: Text[30];
        TxtGC_O: Text[30];
        TxtGLocationFilter: array[20] of Text[30];
        VATNoText: Text[30];
        CompanyAddr: array[8] of Text[50];
        CopyText: Text[50];
        GDescription: Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        OldDimText: Text[75];
        CustAddr: array[8] of Text[100];
        DimText: Text[120];
        MentionEXO: Text[200];
        TxTGMentionEXO: Text[200];

    procedure InitLogInteraction()
    begin
        LogInteractionV := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure DisplayVAT()
    var
        j: Integer;
    begin
        IF VATAmountLine.GetTotalVATAmount() = 0 THEN
            EXIT;
        FOR j := 1 TO VATAmountLine.COUNT DO BEGIN
            VATAmountLine.GetLine(j);
            VatArrayID[j] := VATAmountLine."VAT Identifier";
            VatArrayRate[j] := VATAmountLine."VAT %";
            VatArrayBase[j] := VATAmountLine."VAT Base";
            VatArrayAmount[j] := VATAmountLine."VAT Amount";
        END;
    end;
}
