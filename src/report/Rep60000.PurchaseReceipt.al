report 60000 "PWD Purchase - Receipt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/PurchaseReceipt.rdl';
    Caption = 'Purchase - Receipt';
    UsageCategory = None;
    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Receipt';
            column(Purch__Rcpt__Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(STRSUBSTNO_Text002_CopyText_; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(Text003; Text003)
                    {
                    }
                    column(ShipToAddr_1_; ShipToAddr[1])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(ShipToAddr_2_; ShipToAddr[2])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(ShipToAddr_3_; ShipToAddr[3])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(ShipToAddr_4_; ShipToAddr[4])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(ShipToAddr_5_; ShipToAddr[5])
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(ShipToAddr_6_; ShipToAddr[6])
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(FORMAT__Purch__Rcpt__Header___Document_Date__0_4_; FORMAT("Purch. Rcpt. Header"."Document Date", 0, 4))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Purch__Rcpt__Header___No__; "Purch. Rcpt. Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(Purch__Rcpt__Header___Your_Reference_; "Purch. Rcpt. Header"."Your Reference")
                    {
                    }
                    column(ShipToAddr_7_; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr_8_; ShipToAddr[8])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddr[6])
                    {
                    }
                    column(SPE_Purch__Inv__Contact_Vendor; "Purch. Rcpt. Header"."Buy-from Contact")
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(Purch__Rcpt__Header___No__CaptionLbl; Purch__Rcpt__Header___No__CaptionLbl)
                    {
                    }
                    column(SPE_Invoice_No_Caption; SPE_Invoice_No_CaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(AccNoCaption; AccNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(DocDateCaption; DocDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(PaytoVenNoCaption; PaytoVenNoCaptionLbl)
                    {
                    }
                    column(DescCaption; DescCaptionLbl)
                    {
                    }
                    column(QtyCaption; QtyCaptionLbl)
                    {
                    }
                    column(UOMCaption; UOMCaptionLbl)
                    {
                    }
                    column(PaytoAddrCaption; PaytoAddrCaptionLbl)
                    {
                    }
                    column(LocationCap; LocationCap)
                    {
                    }
                    column(CoutUnitDirectCap; CoutUnitDirectCap)
                    {
                    }
                    column(RemiseLigneCap; RemiseLigneCap)
                    {
                    }
                    column(MontantLigneCap; MontantLigneCap)
                    {
                    }
                    column(PoidsNetLigneCap; PoidsNetLigneCap)
                    {
                    }
                    column(PoidsbrutLigneCap; PoidsbrutLigneCap)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfoV)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control47; DimText)
                        {
                        }
                        column(HeaderDimCaption; Header_DimensionsCaptionLbl)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT PostedDocDim1.FindFirst() THEN
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
                                      '%1 - %2', PostedDocDim1."Dimension Code", PostedDocDim1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
                                        PostedDocDim1."Dimension Code", PostedDocDim1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (PostedDocDim1.NEXT() = 0);
                        end;

                        trigger OnPreDataItem()
                        begin

                            IF NOT ShowInternalInfoV THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Purch__Rcpt__Line_Description; Description)
                        {
                        }
                        column(Type_PurchRcptLine; Format(Type, 0, 2))
                        {
                        }
                        column(Purch__Rcpt__Line_Description_Control38; Description)
                        {
                        }
                        column(Purch__Rcpt__Line_Quantity; Quantity)
                        {
                        }
                        column(Purch__Rcpt__Line__Unit_of_Measure_; "Unit of Measure")
                        {
                        }
                        column(No_PurchRcptLine; "No.")
                        {
                        }
                        column(Desc_PurchRcptLine; Description)
                        {
                        }
                        column(Qty_PurchRcptLine; Quantity)
                        {
                        }
                        column(UOM_PurchRcptLine; "Unit of Measure")
                        {
                        }
                        column(Purch__Rcpt__Line__Direct_Unit_Cost_; "Direct Unit Cost")
                        {
                        }
                        column(Purch__Rcpt__Line__Line_Discount___; "Line Discount %")
                        {
                        }
                        column(PrixLigne; PrixLigne)
                        {
                        }
                        column(PoidsNetLigne; PoidsNetLigne)
                        {
                        }
                        column(PoidsBrutLigne; PoidsBrutLigne)
                        {
                        }
                        column(Purch__Rcpt__Line__Location_Code_; "Location Code")
                        {
                        }
                        column(PrixLigne_Control1000000052; PrixLigne)
                        {
                        }
                        column(PoidsNetLigne_Control1000000053; PoidsNetLigne)
                        {
                        }
                        column(PoidsBrutLigne_Control1000000054; PoidsBrutLigne)
                        {
                        }
                        column("UnitéCaption"; UnitéCaptionLbl)
                        {
                        }
                        column("QuantitéCaption"; QuantitéCaptionLbl)
                        {
                        }
                        column("DésignationCaption"; DésignationCaptionLbl)
                        {
                        }
                        column(N_Caption; N_CaptionLbl)
                        {
                        }
                        column(remise_ligneCaption; remise_ligneCaptionLbl)
                        {
                        }
                        column(Cout_unit__DirectCaption; Cout_unit__DirectCaptionLbl)
                        {
                        }
                        column(Montant_LigneCaption; Montant_LigneCaptionLbl)
                        {
                        }
                        column(Poids_net_LigneCaption; Poids_net_LigneCaptionLbl)
                        {
                        }
                        column(Poids_brut_LigneCaption; Poids_brut_LigneCaptionLbl)
                        {
                        }
                        column(Code_Mag_Caption; Code_Mag_CaptionLbl)
                        {
                        }
                        column(Total_Poids_netCaption; Total_Poids_netCaptionLbl1)
                        {
                        }
                        column(Montant_TotalCaption; Montant_TotalCaptionLbl1)
                        {
                        }
                        column(Total_Poids_brutCaption; Total_Poids_brutCaptionLbl1)
                        {
                        }
                        column(Purch__Rcpt__Line_Document_No_; "Document No.")
                        {
                        }
                        column(LineNo_PurchRcptLine; "Line No.")
                        {
                        }
                        column(No_PurchRcptLineCaption; FieldCaption("No."))
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(DimText_Control67; DimText)
                            {
                            }
                            column(LineDimCaption; Line_DimensionsCaptionLbl)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT PostedDocDim2.FindFirst() THEN
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
                                          '%1 - %2', PostedDocDim2."Dimension Code", PostedDocDim2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText,
                                            PostedDocDim2."Dimension Code", PostedDocDim2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (PostedDocDim2.NEXT() = 0);
                            end;

                            trigger OnPreDataItem()
                            begin

                                IF NOT ShowInternalInfoV THEN
                                    CurrReport.BREAK();
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF (NOT ShowCorrectionLinesV) AND Correction THEN
                                CurrReport.SKIP();
                            PostedDocDim2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            PrixLigne := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Direct Unit Cost";
                            IF "Purch. Rcpt. Line"."Line Discount %" <> 0 THEN
                                PrixLigne := ROUND(PrixLigne - (PrixLigne * "Purch. Rcpt. Line"."Line Discount %" / 100), 0.01);
                            PoidsNetLigne := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Net Weight";
                            PoidsBrutLigne := "Purch. Rcpt. Line".Quantity * "Purch. Rcpt. Line"."Gross Weight";
                        end;

                        trigger OnPreDataItem()
                        begin

                            MoreLines := FindLast();
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(BuyfromVenNo_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
                        {
                        }
                        column(BuyfromVenNo_PurchRcptHeaderCaption; "Purch. Rcpt. Header".FIELDCAPTION("Buy-from Vendor No."))
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin

                            IF "Purch. Rcpt. Header"."Buy-from Vendor No." = "Purch. Rcpt. Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(Purch__Rcpt__Header___Pay_to_Vendor_No__; "Purch. Rcpt. Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(Pay_to_AddressCaption; Pay_to_AddressCaptionLbl)
                        {
                        }
                        column(Purch__Rcpt__Header___Pay_to_Vendor_No__Caption; "Purch. Rcpt. Header".FIELDCAPTION("Pay-to Vendor No."))
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN begin
                        CopyText := Text001;
                        //IF ISSERVICETIER THEN
                        OutputNo += 1;
                        //CurrReport.PAGENO := 1;
                    end
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        RcptCountPrinted.RUN("Purch. Rcpt. Header");
                end;

                trigger OnPreDataItem()
                begin
                    //IF ISSERVICETIER THEN
                    OutputNo := 1;

                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.GET();

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                PostedDocDim1.SETRANGE("Dimension Set ID", "Purch. Rcpt. Header"."Dimension Set ID");

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
                FormatAddr.PurchRcptShipTo(ShipToAddr, "Purch. Rcpt. Header");

                FormatAddr.PurchRcptPayTo(VendAddr, "Purch. Rcpt. Header");

                IF LogInteractionV THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          15, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
                ;
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
                    field(NoOfCopies; NoOfCopies)
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
                    field(ShowCorrectionLines; ShowCorrectionLinesV)
                    {
                        Caption = 'Show Correction Lines';
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
            LogInteractionV := SegManagement.FindInteractTmplCode(15) <> '';
            LogInteractionEnable := LogInteractionV;
        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        PostedDocDim1: Record "Dimension Set Entry";
        PostedDocDim2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        RcptCountPrinted: Codeunit "Purch.Rcpt.-Printed";
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        LogInteractionV: Boolean;
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowCorrectionLinesV: Boolean;
        ShowInternalInfoV: Boolean;
        PoidsBrutLigne: Decimal;
        PoidsNetLigne: Decimal;
        PrixLigne: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        Code_Mag_CaptionLbl: Label 'Code Mag.';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        Cout_unit__DirectCaptionLbl: Label 'Cout unit. Direct';
        "DésignationCaptionLbl": Label 'Désignation';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        Montant_LigneCaptionLbl: Label 'Montant Ligne';
        Montant_TotalCaptionLbl1: Label 'Montant Total';
        N_CaptionLbl: Label 'N°';
        Pay_to_AddressCaptionLbl: Label 'Pay-to Address';
        Poids_brut_LigneCaptionLbl: Label 'Poids brut Ligne';
        Poids_net_LigneCaptionLbl: Label 'Poids net Ligne';
        Purch__Rcpt__Header___No__CaptionLbl: Label 'Shipment No.';
        "QuantitéCaptionLbl": Label 'Quantité';
        remise_ligneCaptionLbl: Label '% remise ligne';
        SPE_Invoice_No_CaptionLbl: Label 'Vendor Contact';
        Text000: Label 'Purchaser';
        Text001: Label 'COPY';
        Text002: Label 'Purchase - Receipt %1';
        Text003: Label 'Page';
        AccNoCaptionLbl: Label 'Account No.';
        PhoneNoCaptionLbl: Label 'Phone No.';
        HomePageCaptionLbl: Label 'Home Page';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        DocDateCaptionLbl: Label 'Document Date';
        PageCaptionLbl: Label 'Page';
        EmailCaptionLbl: Label 'Email';
        DescCaptionLbl: Label 'Description';
        QtyCaptionLbl: Label 'Quantity';
        UOMCaptionLbl: Label 'Unit Of Measure';
        PaytoVenNoCaptionLbl: Label 'Pay-to Vendor No.';
        PaytoAddrCaptionLbl: Label 'Pay-to Address';
        Total_Poids_brutCaptionLbl1: Label 'Total Poids brut';
        Total_Poids_netCaptionLbl1: Label 'Total Poids net';
        "UnitéCaptionLbl": Label 'Unité';
        LocationCap: Label 'Code Mag.';
        CoutUnitDirectCap: Label 'Cout unit. Direct';
        RemiseLigneCap: Label '% remise ligne';
        MontantLigneCap: Label 'Montant Ligne';
        PoidsNetLigneCap: Label 'Poids net Ligne';
        PoidsbrutLigneCap: Label 'Poids brut Ligne';
        CopyText: Text[30];
        PurchaserText: Text[30];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        DimText: Text[120];

}
