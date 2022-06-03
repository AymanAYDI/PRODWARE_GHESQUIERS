report 50072 "PWD Quote AVITA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/QuoteAVITA.rdl';
    Caption = 'Quote AVITA';
    UsageCategory = None;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
            {
            }
            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
            {
            }
            column(Remise___Discount_Caption; Remise___Discount_CaptionLbl)
            {
            }
            column(Sales_Line___No__Caption; "Sales Line".FIELDCAPTION("No."))
            {
            }
            column(Sales_Line__Description_Control63Caption; "Sales Line".FIELDCAPTION(Description))
            {
            }
            column(Quantité_QuantityCaption; Quantité_QuantityCaptionLbl)
            {
            }
            column(Unité_UnitCaption; Unité_UnitCaptionLbl)
            {
            }
            column(Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Sales_Line___VAT_Identifier_Caption; "Sales Line".FIELDCAPTION("VAT Identifier"))
            {
            }
            column(ContinuedCaption; ContinuedCaptionLbl)
            {
            }
            column(ContinuedCaption_Control83; ContinuedCaption_Control83Lbl)
            {
            }
            column(SalesLine__Inv__Discount_Amount_Caption; SalesLine__Inv__Discount_Amount_CaptionLbl)
            {
            }
            column(SubtotalCaption; SubtotalCaptionLbl)
            {
            }
            column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
            {
            }
            column(PAGENO_Caption; Text005)
            {
            }
            column(SalesHeader_BillToCustomerNo_Caption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
            {
            }
            column(SalesHeader_ShipmentDate_Caption; "Sales Header".FIELDCAPTION("Shipment Date"))
            {
            }
            column(OrderNo_Caption; Order_No_CaptionLbl)
            {
            }
            column(SalesHeader_PricesIncludingVAT_Caption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
            {
            }
            column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
            {
            }
            column(SalesHeader_ReferenceCaption; Sales_Header__ReferenceCaptionLbl)
            {
            }
            column(VATAmountLineVAT_Caption; VATAmountLine__VAT___CaptionLbl)
            {
            }
            column(VATAmountLine_VATBaseCaption; VATAmountLine__VAT_Base__Control106CaptionLbl)
            {
            }
            column(VATAmountLine_VATAmountCaption; VATAmountLine__VAT_Amount__Control107CaptionLbl)
            {
            }
            column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
            {
            }
            column(VATAmountLine__VAT_Base__Control110Caption; VATAmountLine__VAT_Base__Control110CaptionLbl)
            {
            }
            column(ConditionsDePaiementSettlementCaption; Conditions_de_paiement_Settlement__CaptionLbl)
            {
            }
            column(ShipmentMethod_DescriptionCaption; ShipmentMethod_DescriptionCaptionLbl)
            {
            }
            column(TotalText; TotalText)
            {
            }
            column(TotalExclVATText; TotalExclVATText)
            {
            }
            column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
            {
            }
            column(TotalInclVATText; TotalInclVATText)
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
            {
            }
            column(ShipmentMethod_Description; ShipmentMethod.Description)
            {
            }
            column(VATDiscountAmount; VATDiscountAmount)
            {
                AutoFormatExpression = "Sales Header"."Currency Code";
                AutoFormatType = 1;
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);

                dataitem(PageLoop; integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyInfo__Logo_ISSA_; CompanyInfo."PWD Logo ISSA")
                    {
                    }
                    column(CopyText; STRSUBSTNO(Text004, CopyText))
                    {
                    }

                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
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
                    column(SalesHeader_BillToCustomerNo; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(SalesHeader_DocumentDate; FORMAT("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(SalesHeader_ShipmentDate; "Sales Header"."Shipment Date")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(SalesHeader_No; "Sales Header"."No.")
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(SalesHeader_PricesIncludingVAT; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CompanyInfoStockCapital_Caption; 'au Capital de ' + CompanyInfo."Stock Capital")
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
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; 'Tel : ' + CompanyInfo."Phone No.")
                    {
                    }
                    column(FaxCompanyInfoFaxNo; 'Fax : ' + CompanyInfo."Fax No.")
                    {
                    }
                    column(E_MailCompanyInfoEMail; 'E-Mail : ' + CompanyInfo."E-Mail")
                    {
                    }
                    column(IdIntracomCompanyInfoVATRegistrationNo; 'N° id. intracom : ' + CompanyInfo."VAT Registration No.")
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
                    column(SalesHeader_Reference; "Sales Header"."PWD Reference")
                    {
                    }
                    column(CompanyInfo__Logo_AVITA_facture_; CompanyInfo."PWD Logo AVITA facture")
                    {
                    }

                    column(PageLoop_Number; Number)
                    {
                    }

                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }

                        column(DimensionLoop1_Number; Number)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSet() THEN
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
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        column(DocumentNo; "Document No.")
                        {
                        }
                        column(LineNo; "Line No.")
                        {
                        }
                        column(Description; Description)
                        {
                        }
                        column(GDescription2; GDescription)
                        {
                        }
                        column(Quantity; Quantity)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLine_Type; "Sales Line".Type)
                        {
                        }
                        column(SalesLineLine_Amount; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Description; "Sales Line".Description)
                        {
                        }
                        column(Sales_Line___Unit_of_Measure_; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(GDescription; GDescription)
                        {
                        }
                        column(SalesLine_No; "Sales Line"."No.")
                        {
                        }
                        column(SalesLine_DocumentNo; "Sales Line"."Document No.")
                        {
                        }
                        column(SalesLine_LineNo; "Sales Line"."Line No.")
                        {
                        }
                        column(SalesLine_Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line___Unit_Price_; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(SalesLine_LineDiscount; "Sales Line"."Line Discount %")
                        {
                        }
                        column(Sales_Line___Line_Amount_; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___VAT_Identifier_; "Sales Line"."VAT Identifier")
                        {
                        }
                        column(SalesLine_InvDiscountAmount_; -TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }

                        column(SalesLineLineAmount_SalesLineInvDiscountAmount; TempSalesLine."Line Amount" - TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }

                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount__Control88; TempSalesLine."Line Amount" - TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineLineAmount_SalesLineInvDiscount_AmountVATAmount; TempSalesLine."Line Amount" - TempSalesLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }

                        column(TotalExclVATText_Control131; TotalExclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText_Control133; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText_Control135; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }

                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(ShowPaymentDisc; ShowPaymentDisc)
                        {
                        }
                        column(ShowTotalExcl; ShowTotalExcl)
                        { }

                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimTextLine; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }
                            column(Dim2_ShowInternalInfo; ShowInternalInfo)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FindSet() THEN
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
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempSalesLine.FindSet()
                            ELSE
                                TempSalesLine.NEXT();
                            "Sales Line" := TempSalesLine;

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (TempSalesLine."VAT Calculation Type" = TempSalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempSalesLine."Line Amount" := 0;

                            IF (TempSalesLine.Type = TempSalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Sales Line"."No." := '';
                            IF TempSalesLine."PWD Designation ENU" <> '' THEN
                                GDescription := TempSalesLine."PWD Designation ENU"
                            ELSE
                                GDescription := "Sales Line"."Description 2";
                            if ((VATDiscountAmount <> 0) and (VATAmount <> 0) and ("Sales Header"."Prices Including VAT") and ("Sales Header"."VAT Base Discount %" <> 0)) then
                                ShowPaymentDisc := true
                            else
                                ShowPaymentDisc := false;
                            if ("Sales Header"."Prices Including VAT") and (VATAmount <> 0) then
                                ShowTotalExcl := true
                            else
                                ShowTotalExcl := false;
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempSalesLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempSalesLine.FindLast();
                            WHILE MoreLines AND (TempSalesLine.Description = '') AND (TempSalesLine."Description 2" = '') AND
                                  (TempSalesLine."No." = '') AND (TempSalesLine.Quantity = 0) AND
                                  (TempSalesLine.Amount = 0)
                            DO
                                MoreLines := TempSalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            TempSalesLine.SETRANGE("Line No.", 0, TempSalesLine."Line No.");
                            SETRANGE(Number, 1, TempSalesLine.COUNT);
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine_VATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmount; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }

                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));


                        column(Total_Number; Number)
                        {
                        }
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
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(TempSalesLine);
                    CLEAR(SalesPost);
                    TempVATAmountLine.DELETEALL();
                    SalesPost.GetSalesLines("Sales Header", TempSalesLine, 0);
                    TempSalesLine.CalcVATAmountLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    TempSalesLine.UpdateVATOnLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN
                        CopyText := Text003;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
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

                DimSetEntry1.SETRANGE("Dimension Set ID", "Sales Header"."Dimension Set ID");

                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
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
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", '', "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", '', "Posting Description", '');
                    END;
                END;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(ShowInternalInformation; ShowInternalInfo)
                {
                    caption = 'Show Internal Info';
                    ApplicationArea = all;
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

    trigger OnInitReport()
    begin
        GLSetup.GET();
    end;

    var
        CompanyInfo: Record "Company Information";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        TempSalesLine: Record "Sales Line" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        SalesCountPrinted: Codeunit "Sales-Printed";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        ShowPaymentDisc: Boolean;
        ShowShippingAddr: Boolean;
        ShowTotalExcl: boolean;
        TotalAmountInclVAT: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        i: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        AmountCaptionLbl: Label 'Amount';
        Conditions_de_paiement_Settlement__CaptionLbl: Label 'Conditions de paiement/Settlement :';
        ContinuedCaption_Control83Lbl: Label 'Continued';
        ContinuedCaptionLbl: Label 'Continued';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        Order_No_CaptionLbl: Label 'Order No.';
        "Quantité_QuantityCaptionLbl": Label 'Quantité Quantity';
        Remise___Discount_CaptionLbl: Label 'Remise % Discount ';
        Sales_Header__ReferenceCaptionLbl: Label 'Référence commande';
        SalesLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method :';
        SubtotalCaptionLbl: Label 'Subtotal';
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order Confirmation %1';
        Text005: Label 'Page';
        Text006: Label 'Total %1 Excl. VAT';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        "Unité_UnitCaptionLbl": Label 'Unité Unit';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Amount__Control107CaptionLbl: Label 'VAT Amount';
        VATAmountLine__VAT_Base__Control106CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT_Base__Control110CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        CopyText: Text[30];
        ReferenceText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        CompanyAddr: array[8] of Text[50];
        GDescription: Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        OldDimText: Text[75];
        CustAddr: array[8] of Text[100];
        DimText: Text[120];
}
