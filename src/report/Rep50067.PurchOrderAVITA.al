report 50067 "PWD Purch Order AVITA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/PurchOrderAVITA.rdl';
    Caption = 'Order';
    UsageCategory = None;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Fax_______CompanyInfo__Fax_No__; 'Fax : ' + CompanyInfo."Fax No.")
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
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(VendAddr_1_; VendAddr[1])
                    {
                    }
                    column(VendAddr_2_; VendAddr[2])
                    {
                    }
                    column(VendAddr_3_; VendAddr[3])
                    {
                    }
                    column(VendAddr_4_; VendAddr[4])
                    {
                    }
                    column(VendAddr_5_; VendAddr[5])
                    {
                    }
                    column(Tel_______CompanyInfo__Phone_No__; 'Tel : ' + CompanyInfo."Phone No.")
                    {
                    }
                    column(E_Mail_______CompanyInfo__E_Mail_; 'E-Mail : ' + CompanyInfo."E-Mail")
                    {
                    }
                    column(N__TVA_____CompanyInfo__VAT_Registration_No__; 'N° TVA : ' + CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo__Ship_to_Name_; CompanyInfo."Ship-to Name")
                    {
                    }
                    column(VendAddr_6_; VendAddr[6])
                    {
                    }
                    column(VendAddr_7_; VendAddr[7])
                    {
                    }
                    column(CompanyInfo__Ship_to_Address_; CompanyInfo."Ship-to Address")
                    {
                    }
                    column(VendAddr_8_; VendAddr[8])
                    {
                    }
                    column(CompanyInfo__Ship_to_Address_2_; CompanyInfo."Ship-to Address 2")
                    {
                    }
                    column(Purchase_Header___Document_Date_; FORMAT("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(ShipToAddr_4_; CompanyInfo."Ship-to Post Code" + '  ' + CompanyInfo."Ship-to City")
                    {
                    }
                    column(Purchase_Header___No__; "Purchase Header"."No.")
                    {
                    }
                    column(Page___FORMAT_CurrReport_PAGENO_; 'Page ')
                    {
                    }
                    column(Purchase_Header___Requested_Receipt_Date__; FORMAT("Purchase Header"."Requested Receipt Date", 0, 4))
                    {
                    }
                    column(CompanyInfo__Logo_AVITA_facture_; CompanyInfo."PWD Logo AVITA facture")
                    {
                    }
                    column(UserTable_Name; 'UserTable.Name')
                    {
                    }
                    column(User_Name; user."Full Name")
                    {
                    }
                    column(Purchase_Header___Buy_from_Contact_; "Purchase Header"."Buy-from Contact")
                    {
                    }
                    column(Adresse_de_livraisonCaption; Adresse_de_livraisonCaptionLbl)
                    {
                    }
                    column(ORDERCaption; ORDERCaptionLbl)
                    {
                    }
                    column(ORDERCaption_Control1000000047; ORDERCaption_Control1000000047Lbl)
                    {
                    }
                    column("Date_de_réception_demandée__Caption"; Date_de_réception_demandée__CaptionLbl)
                    {
                    }
                    column(Contact_livraison__Caption; Contact_livraison__CaptionLbl)
                    {
                    }
                    column(Tel_03_21_19_66_37___Fax_03_21_96_89_39Caption; Tel_03_21_19_66_37___Fax_03_21_96_89_39CaptionLbl)
                    {
                    }
                    column(Date_de_commande__Caption; Date_de_commande__CaptionLbl)
                    {
                    }
                    column("Notre_référence__Caption"; Notre_référence__CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control72; DimText)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
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
                                    DimText := STRSUBSTNO(
                                      '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DocDim1."Dimension Code", DocDim1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DocDim1.NEXT() = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            //IF NOT ShowInternalInfo THEN
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PurchLine__Line_Amount_; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line__Description; "Purchase Line".Description)
                        {
                        }
                        column("RéfFournisseur"; RéfFournisseur)
                        {
                        }
                        column(Purchase_Line__Quantity; "Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure_; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(Purchase_Line__Description_Control63; "Purchase Line".Description)
                        {
                        }
                        column(Item_Family; Item."PWD Family")
                        {
                        }
                        column(Purchase_Line___No__; "Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line___Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line___Line_Amount_; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DescriptionENU; DescriptionENU)
                        {
                        }
                        column(PurchLine__Line_Amount__Control77; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Inv__Discount_Amount_; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__Control109; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount_; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TextTVA; TextTVA)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount____VATAmount; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount__Control147; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText_Control51; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText_Control69; TotalInclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_Control83; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column("Réf__FnsCaption"; Réf__FnsCaptionLbl)
                        {
                        }
                        column("QuantitéCaption"; QuantitéCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(Purchase_Line__Description_Control63Caption; "Purchase Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Code_familleCaption; Code_familleCaptionLbl)
                        {
                        }
                        column(Purchase_Line___No__Caption; "Purchase Line".FIELDCAPTION("No."))
                        {
                        }
                        column("UnitéCaption"; UnitéCaptionLbl)
                        {
                        }
                        column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Direct_Unit_CostCaption_Control1000000060; Direct_Unit_CostCaption_Control1000000060Lbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column("Désignation_ENUCaption"; Désignation_ENUCaptionLbl)
                        {
                        }
                        column(AmountCaption_Control45; AmountCaption_Control45Lbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control76; ContinuedCaption_Control76Lbl)
                        {
                        }
                        column(PurchLine__Inv__Discount_Amount_Caption; PurchLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(DataItem1000000038; Veuillez_respecter_l_adresse_et_la_date_de_livraison_spécif__De_même__les_quant_et_les_prix_sont_impératifs__ToutLbl)
                        {
                        }
                        column("Nous_vous_prions_de_nous_apporter_une_information_systématique_et_immédiate_en_cas_de_manquants_Caption"; Nous_vous_prions_de_nous_apporter_une_information_systématique_et_immédiate_en_cas_de_manquants_CaptionLbl)
                        {
                        }
                        column("Sincères_salutations_Caption"; Sincères_salutations_CaptionLbl)
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(ShowRow; ShowRow)
                        {
                        }
                        column(ShowRectangle4; ShowRectangle4)
                        {
                        }
                        column(ShowRectangle5; ShowRectangle5)
                        {
                        }
                        column(ShowRectangle6; ShowRectangle6)
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord()
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
                                        DimText := STRSUBSTNO(
                                          '%1 %2', DocDim2."Dimension Code", DocDim2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DocDim2."Dimension Code", DocDim2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DocDim2.NEXT() = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                                DocDim2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                PurchLine.FindFirst()
                            ELSE
                                PurchLine.NEXT();
                            "Purchase Line" := PurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';

                            IF "Purchase Header"."Language Code" = '' THEN BEGIN
                                CLEAR(Translation);
                                IF "Purchase Line".Type = "Purchase Line".Type::Item THEN BEGIN
                                    Item.GET("Purchase Line"."No.");
                                    Translation := Item."PWD Translation";
                                END ELSE
                                    Translation := '';
                            END ELSE BEGIN
                                CLEAR(Translation);
                                IF "Purchase Line".Type = "Purchase Line".Type::Item THEN BEGIN
                                    Item.GET("Purchase Line"."No.");
                                    Translation := Item.Description;
                                END ELSE
                                    Translation := '';
                            END;
                            CLEAR(RéfFournisseur);
                            CLEAR(DescriptionENU);

                            ItemVend.RESET();
                            ItemVend.SETCURRENTKEY("Vendor No.", "Item No.");
                            IF ItemVend.GET("Purchase Line"."Buy-from Vendor No.", "Purchase Line"."No.") THEN
                                RéfFournisseur := ItemVend."Vendor Item No.";

                            IF ItemTranslation.GET("Purchase Line"."No.", '', 'ENU') THEN
                                DescriptionENU := ItemTranslation.Description;

                            IF DescriptionENU = '' THEN
                                DescriptionENU := PurchLine."Description 2";

                            if PurchLine."Inv. Discount Amount" <> 0 then
                                ShowRow := true
                            else
                                ShowRow := false;

                            if ("Purchase Header"."Prices Including VAT" = false) and (VATAmount <> 0) then
                                ShowRectangle4 := true
                            else
                                ShowRectangle4 := false;

                            if (VATDiscountAmount <> 0) AND (VATAmount <> 0) AND "Purchase Header"."Prices Including VAT" AND ("Purchase Header"."VAT Base Discount %" <> 0) then
                                ShowRectangle5 := true
                            else
                                ShowRectangle5 := false;
                            if ("Purchase Header"."Prices Including VAT" AND (VATAmount <> 0)) then
                                ShowRectangle6 := true
                            else
                                ShowRectangle6 := false;
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FindLast();
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0) DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    VATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();
                    IF Number > 1 THEN
                        CopyText := Text003;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            var
                FromPurchLine: Record "Purchase Line";
            begin
                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    CompanyInfo.GET();
                    CompanyInfo.CALCFIELDS("PWD Logo AVITA facture", "PWD Logo ISSA");
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                DocDim1.SETRANGE("Dimension Set ID", "Purchase Header"."Dimension Set ID");

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
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
                Gcontact := "Purchase Header"."Buy-from Contact";
                "Purchase Header"."Buy-from Contact" := '';
                FormatAddr.PurchHeaderBuyFrom(VendAddr, "Purchase Header");

                "Purchase Header"."Buy-from Contact" := Gcontact;
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.Company(ShipToAddr, CompanyInfo);

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);
                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;

                PurchLineDDE.SETRANGE("Document Type", "Purchase Header"."Document Type");
                PurchLineDDE.SETRANGE("Document No.", "Purchase Header"."No.");
                IF NOT PurchLineDDE.FindFirst() THEN
                    PurchLineDDE.INIT();

                CLEAR(SalesOrderNo);
                FromPurchLine.SETRANGE("Document Type", "Document Type");
                FromPurchLine.SETRANGE("Document No.", "No.");
                IF FromPurchLine.FindSet() THEN
                    REPEAT
                        IF FromPurchLine."Sales Order No." <> '' THEN SalesOrderNo := FromPurchLine."Sales Order No.";
                        IF FromPurchLine."Special Order Sales No." <> '' THEN SalesOrderNo := FromPurchLine."Special Order Sales No.";
                        CLEAR(ShipName);
                        IF ShowInternalInfo THEN
                            IF NOT SalesHeader.GET(SalesHeader."Document Type"::Order, FromPurchLine."Special Order Sales No.") THEN
                                SalesHeader.INIT()
                            ELSE
                                ShipName := 'Navire : ' + SalesHeader."Sell-to Customer Name";
                    UNTIL FromPurchLine.NEXT() = 0;
            end;
        }
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

    trigger OnInitReport()
    begin
        GLSetup.GET();
    end;

    trigger OnPreReport()
    begin
        IF USERID() <> '' THEN
            IF NOT UserTable.GET(USERID) THEN;
        IF UserSecurityId() <> '' THEN
            IF NOT User.GET(UserSecurityId()) THEN;
    end;

    var

        CompanyInfo: Record "Company Information";
        DocDim1: Record "Dimension Set Entry";
        DocDim2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        ItemTranslation: Record "Item Translation";
        ItemVend: Record "Item Vendor";
        PaymentTerms: Record "Payment Terms";
        PurchLine: Record "Purchase Line" temporary;
        PurchLineDDE: Record "Purchase Line";
        RespCenter: Record "Responsibility Center";
        SalesHeader: Record "Sales Header";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        User: record User;
        UserTable: Record "User Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        PurchPost: Codeunit "Purch.-Post";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        ShowRectangle4: Boolean;
        ShowRectangle5: Boolean;
        ShowRectangle6: Boolean;
        ShowRow: Boolean;
        SalesOrderNo: Code[20];
        TotalAmountInclVAT: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        Adresse_de_livraisonCaptionLbl: Label 'Adresse de livraison';
        AmountCaption_Control45Lbl: Label 'Amount';
        AmountCaptionLbl: Label 'Amount';
        Code_familleCaptionLbl: Label 'Code famille';
        Contact_livraison__CaptionLbl: Label 'Contact livraison :';
        ContinuedCaption_Control76Lbl: Label 'Continued';
        ContinuedCaptionLbl: Label 'Continued';
        Date_de_commande__CaptionLbl: Label 'Date de commande :';
        "Date_de_réception_demandée__CaptionLbl": Label 'Date de réception demandée :';
        "Désignation_ENUCaptionLbl": Label '/ Désignation ENU';
        Direct_Unit_CostCaption_Control1000000060Lbl: Label 'Direct Unit Cost';
        Direct_Unit_CostCaptionLbl: Label 'Direct Unit Cost';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        "Notre_référence__CaptionLbl": Label 'Notre référence :';
        Nous_vous_prions_de_nous_apporter_une_information_systématique_et_immédiate_en_cas_de_manquants_CaptionLbl: Label 'Nous vous prions de nous apporter une information systématique et immédiate en cas de manquants.';
        ORDERCaption_Control1000000047Lbl: Label 'ORDER';
        ORDERCaptionLbl: Label 'ORDER';
        PurchLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        "QuantitéCaptionLbl": Label 'Quantité';
        QuantityCaptionLbl: Label 'Quantity';
        "Réf__FnsCaptionLbl": Label ' Réf. Fns';
        Sincères_salutations_CaptionLbl: Label ' Tout défaut pourra motiver le refus de la livraison.';
        SubtotalCaptionLbl: Label 'Subtotal';
        Tel_03_21_19_66_37___Fax_03_21_96_89_39CaptionLbl: Label 'Tel 03 21 19 66 37 / Fax 03 21 96 89 39';
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text006: Label 'Total %1 Excl. VAT';
        TextTVA: Label 'Montant TVA';
        UnitCaptionLbl: Label 'Unit';
        "UnitéCaptionLbl": Label 'Unité';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        Veuillez_respecter_l_adresse_et_la_date_de_livraison_spécif__De_même__les_quant_et_les_prix_sont_impératifs__ToutLbl: Label '    Veuillez respecter l''adresse et la date de livraison spécifiées, de même que les quantités et les prix.         NE PAS DEPASSER LES QUANTITES COMMANDEES.';
        "RéfFournisseur": Text[20];
        CopyText: Text[30];
        DescriptionENU: Text[30];
        PurchaserText: Text[30];
        ReferenceText: Text[30];
        Translation: Text[30];
        VATNoText: Text[30];
        CompanyAddr: array[8] of Text[50];
        Gcontact: Text[50];
        ShipName: Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        DimText: Text[120];
}