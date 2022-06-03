report 50034 "Relevé des Sorties Export 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/RelevédesSortiesExport2.rdl';

    Permissions = TableData "Sales Shipment Line" = rm,
                  TableData "Sales Cr.Memo Line" = rm;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("PWD DSA No.", "Posting Date");
            RequestFilterFields = "Posting Date", "PWD Location Filter";
            column(GETFILTER___Posting_Date__; GETFILTER("Posting Date"))
            {
            }
            column(GETFILTER___Location_Filter__; GETFILTER("PWD Location Filter"))
            {
            }
            column(Page___FORMAT_CurrReport_PAGENO_; 'Page ')
            {
            }
            column(NetWeight; NetWeight)
            {
            }
            column(Sales_Shipment_Line___Line_Amount_; "Sales Shipment Line"."PWD Line Amount")
            {
            }
            column("Relevé_des_sorties_du__Caption"; Relevé_des_sorties_du__CaptionLbl)
            {
            }
            column(CODECaption; CODECaptionLbl)
            {
            }
            column(TYPECaption; TYPECaptionLbl)
            {
            }
            column(BLCaption; BLCaptionLbl)
            {
            }
            column(DATECaption; DATECaptionLbl)
            {
            }
            column(POIDSCaption; POIDSCaptionLbl)
            {
            }
            column(VALEURCaption; VALEURCaptionLbl)
            {
            }
            column(COMMANDECaption; COMMANDECaptionLbl)
            {
            }
            column(PAYSCaption; PAYSCaptionLbl)
            {
            }
            column(MAGCaption; MAGCaptionLbl)
            {
            }
            column(CUMULSCaption; CUMULSCaptionLbl)
            {
            }
            column(Sales_Shipment_Header_No_; "No.")
            {
            }
            column(Sales_Shipment_Header_Location_Filter; "PWD Location Filter")
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No."), "Location Code" = FIELD("PWD Location Filter");
                DataItemTableView = SORTING("Document No.", "Location Code", "PWD Provision/materiel", "PWD National Add. Code") WHERE(Type = CONST(Item));
                column(Sales_Shipment_Header___Sell_to_Customer_No________Sales_Shipment_Header___No__; "Sales Shipment Header"."Sell-to Customer No." + '/' + "Sales Shipment Header"."No.")
                {
                }
                column(Sales_Shipment_Line__Line_Amount_; "PWD Line Amount")
                {
                }
                column(NetWeight_Control1000000011; NetWeight)
                {
                }
                column(Sales_Shipment_Header___Posting_Date_; "Sales Shipment Header"."Posting Date")
                {
                }
                column(CustType; CustType)
                {
                }
                column(Sales_Shipment_Line__Location_Code_; "Location Code")
                {
                }
                column(Sales_Shipment_Line__Monthly_Code_; "PWD Monthly Code")
                {
                }
                column(Sales_Shipment_Header___DSA_No__; "Sales Shipment Header"."PWD DSA No.")
                {
                }
                column(CodeDouane; CodeDouane)
                {
                }
                column(Sales_Shipment_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Shipment_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Shipment_Line_Provision_materiel; "Provision/materiel")
                {
                }

                trigger OnAfterGetRecord()
                var
                    RecLCountry: Record "Country/Region";
                    RecLCustomer: Record Customer;
                begin
                    IF Quantity = 0 THEN CurrReport.SKIP();
                    CLEAR(CodGCodeMensuel);
                    IF RecLCustomer.GET("Sales Shipment Line"."Sell-to Customer No.") THEN BEGIN
                        RecLCountry.RESET();
                        RecLCountry.SETFILTER("PWD Flag", RecLCustomer."PWD Flag");
                        IF RecLCountry.FindFirst() THEN
                            CodGCodeMensuel := RecLCountry."PWD Monthly Code";
                    END;
                    Item.RESET();
                    IF NOT Item.GET("Sales Shipment Line"."No.") THEN Item.INIT();

                    NetWeight := "Net Weight" * Quantity;
                    TotWeight := NetWeight;
                    TotAmount := "PWD Line Amount";

                    ShipWeight += NetWeight;

                    CASE "PWD Provision/materiel" OF
                        "PWD Provision/materiel"::Provision:
                            "Sales Shipment Line"."PWD DCG Tariff No." := Text001;
                        "PWD Provision/materiel"::Materiel:
                            "Sales Shipment Line"."PWD DCG Tariff No." := Text002;
                        "PWD Provision/materiel"::" ":
                            "Sales Shipment Line"."PWD DCG Tariff No." := '';
                    END;

                    "Sales Shipment Line".MODIFY();
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(CurrMonthly);
                    CLEAR(CurrPM);
                end;
            }

            trigger OnPreDataItem()
            begin
                LocationFilter := GETFILTER("PWD Location Filter");
                DateFilter := GETFILTER("Posting Date");
                DateMin := GETRANGEMIN("Posting Date");
                DateMax := GETRANGEMAX("Posting Date");

                IF NOT (BlankDSA) THEN SETFILTER("Sales Shipment Header"."PWD DSA No.", '<>%1', '');
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("Posting Date", "PWD DSA No.");
            column(DateFilter; DateFilter)
            {
            }
            column(LocationFilter; LocationFilter)
            {
            }
            column(Page___FORMAT_CurrReport_PAGENO__Control1000000020; 'Page ')
            {
            }
            column(NetWeight_Control1000000061; NetWeight)
            {
            }
            column(Sales_Cr_Memo_Line___Line_Amount_; "Sales Cr.Memo Line"."Line Amount")
            {
            }
            column(ShipWeight_CrMemoWeight; ShipWeight - CrMemoWeight)
            {
            }
            column(Sales_Shipment_Line___Line_Amount___Sales_Cr_Memo_Line___Line_Amount_; "Sales Shipment Line"."PWD Line Amount" - "Sales Cr.Memo Line"."Line Amount")
            {
            }
            column(AvoirsCaption; AvoirsCaptionLbl)
            {
            }
            column(CODECaption_Control1000000051; CODECaption_Control1000000051Lbl)
            {
            }
            column(CUMUL_AVOIRCaption; CUMUL_AVOIRCaptionLbl)
            {
            }
            column(CUMULS_LIVRAISON___AVOIRSCaption; CUMULS_LIVRAISON___AVOIRSCaptionLbl)
            {
            }
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "PWD Provision/materiel") WHERE(Type = CONST(Item));
                column(Sales_Cr_Memo_Header___Sell_to_Customer_No________Sales_Cr_Memo_Header___No__; "Sales Cr.Memo Header"."Sell-to Customer No." + '/' + "Sales Cr.Memo Header"."No.")
                {
                }
                column(Sales_Cr_Memo_Line__Sales_Cr_Memo_Line___Line_Amount_; "Sales Cr.Memo Line"."Line Amount")
                {
                }
                column(NetWeight_Control1000000054; NetWeight)
                {
                }
                column(CodeDouane_Control1000000055; CodeDouane)
                {
                }
                column(Sales_Cr_Memo_Header___Posting_Date_; "Sales Cr.Memo Header"."Posting Date")
                {
                }
                column(CustType_Control1000000057; CustType)
                {
                }
                column(Sales_Cr_Memo_Line__Monthly_Code_; "PWD Monthly Code")
                {
                }
                column(Sales_Cr_Memo_Header___DSA_No__; "Sales Cr.Memo Header"."PWD DSA No.")
                {
                }
                column(Sales_Cr_Memo_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Cr_Memo_Line_Line_No_; "Line No.")
                {
                }
                column(Sales_Cr_Memo_Line_Provision_materiel; "Provision/materiel")
                {
                }

                trigger OnAfterGetRecord()
                var
                    RecLCountry: Record "Country/Region";
                    RecLCustomer: Record Customer;
                begin
                    IF Quantity = 0 THEN CurrReport.SKIP();
                    CLEAR(CodGCodeMensuel);
                    IF RecLCustomer.GET("Sales Cr.Memo Line"."Sell-to Customer No.") THEN BEGIN
                        RecLCountry.RESET();
                        RecLCountry.SETFILTER("PWD Flag", RecLCustomer."PWD Flag");
                        IF RecLCountry.FindFirst() THEN
                            CodGCodeMensuel := RecLCountry."PWD Monthly Code";
                    END;

                    NetWeight := "Net Weight" * Quantity;

                    CASE "PWD Provision/materiel" OF
                        "PWD Provision/materiel"::Provision:
                            "PWD DCG Tariff No." := Text001;
                        "PWD Provision/materiel"::Materiel:
                            "PWD DCG Tariff No." := Text002;
                        "PWD Provision/materiel"::" ":
                            "PWD DCG Tariff No." := '';
                    END;

                    CrMemoWeight += NetWeight;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Location Code", LocationFilter);
                    SETRANGE(Type, "Sales Cr.Memo Line".Type::Item);
                end;
            }

            trigger OnPreDataItem()
            begin
                IF NOT (BlankDSA) THEN
                    SETFILTER("PWD DSA No.", '<>%1', '');
                SETFILTER("Posting Date", DateFilter);
            end;
        }
        dataitem(Cumul; "Sales Shipment Line")
        {
            DataItemTableView = SORTING(Type, "PWD Monthly Code", "PWD Provision/materiel", "Location Code") WHERE(Type = CONST(Item));
            column(DateFilter_Control1000000012; DateFilter)
            {
            }
            column(GETFILTER___Location_Filter___Control1000000028; GETFILTER("PWD Location Filter"))
            {
            }
            column(Page___FORMAT_CurrReport_PAGENO__Control1000000069; 'Page ')
            {
            }
            column(Lineamount_DSACrMemoAmount; Lineamount - DSACrMemoAmount)
            {
            }
            column(NetWeight_DSACrMemoWeight; NetWeight - DSACrMemoWeight)
            {
            }
            column(CodeDouane_Control1000000042; CodeDouane)
            {
            }
            column(CustType_Control1000000044; CustType)
            {
            }
            column(Cumul__Location_Code_; "Location Code")
            {
            }
            column(Cumul__Monthly_Code_; "PWD Monthly Code")
            {
            }
            column(TypeMchds; TypeMchds)
            {
            }
            column(NetWeight_DSACrMemoWeight_Control1000000049; NetWeight - DSACrMemoWeight)
            {
            }
            column(Lineamount_DSACrMemoAmount_Control1000000050; Lineamount - DSACrMemoAmount)
            {
            }
            column("Relevé_des_sorties_du__Caption_Control1000000027"; Relevé_des_sorties_du__Caption_Control1000000027Lbl)
            {
            }
            column(CODECaption_Control1000000029; CODECaption_Control1000000029Lbl)
            {
            }
            column(COMMANDECaption_Control1000000031; COMMANDECaption_Control1000000031Lbl)
            {
            }
            column(VALEURCaption_Control1000000032; VALEURCaption_Control1000000032Lbl)
            {
            }
            column(POIDSCaption_Control1000000033; POIDSCaption_Control1000000033Lbl)
            {
            }
            column(TYPECaption_Control1000000035; TYPECaption_Control1000000035Lbl)
            {
            }
            column(MAGCaption_Control1000000036; MAGCaption_Control1000000036Lbl)
            {
            }
            column(PAYSCaption_Control1000000037; PAYSCaption_Control1000000037Lbl)
            {
            }
            column(TYPECaption_Control1000000047; TYPECaption_Control1000000047Lbl)
            {
            }
            column(CUMULSCaption_Control1000000048; CUMULSCaption_Control1000000048Lbl)
            {
            }
            column(Cumul_Document_No_; "Document No.")
            {
            }
            column(Cumul_Line_No_; "Line No.")
            {
            }
            column(Cumul_Provision_materiel; "PWD Provision/materiel")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Quantity = 0 THEN CurrReport.SKIP();
                SalesShipHeader.SETCURRENTKEY("PWD DSA No.", "Posting Date");
                SalesShipHeader.GET(Cumul."Document No.");
                IF NOT (SalesShipHeader."Posting Date" IN [DateMin .. DateMax]) THEN CurrReport.SKIP();
                IF ((BlankDSA = FALSE) AND (SalesShipHeader."PWD DSA No." = '')) THEN CurrReport.SKIP();
                NetWeight := "Net Weight" * Quantity;
                IF ((CurrMonthly <> "PWD Monthly Code") OR ("PWD Provision/materiel" <> CurrPM) OR (CurrLoc <> "Location Code")) THEN BEGIN
                    i += 1;
                    CurrLoc := "Location Code";
                    CurrMonthly := "PWD Monthly Code";
                    CurrPM := "PWD Provision/materiel";
                    FindCRMemoLines('', "PWD Provision/materiel", "PWD Monthly Code", TRUE, "Location Code");
                END;
                Lineamount := "PWD Line Amount";
            end;

            trigger OnPreDataItem()
            begin
                DSACrMemoWeight := 0;
                DSACrMemoAmount := 0;
                NetWeight := 0;
                Lineamount := 0;
                SETFILTER("Location Code", LocationFilter);
                CLEAR(CurrMonthly);
                CLEAR(CurrPM);
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

    var
        Item: Record Item;
        SalesShipHeader: Record "Sales Shipment Header";
        BlankDSA: Boolean;
        CurrLoc: Code[10];
        CustType: Code[10];
        TypeMchds: Code[10];
        CodGCodeMensuel: Code[20];
        CurrMonthly: Code[20];
        DateMax: Date;
        DateMin: Date;
        CrMemoWeight: Decimal;
        DSACrMemoAmount: Decimal;
        DSACrMemoWeight: Decimal;
        Lineamount: Decimal;
        NetWeight: Decimal;
        ShipWeight: Decimal;
        TotalCrMemoAmount: Decimal;
        TotalCrMemoWeight: Decimal;
        TotAmount: Decimal;
        TotWeight: Decimal;
        CurrPM: Integer;
        i: Integer;
        AvoirsCaptionLbl: Label 'Avoirs';
        BLCaptionLbl: Label 'BL';
        CODECaption_Control1000000029Lbl: Label 'CODE';
        CODECaption_Control1000000051Lbl: Label 'CODE';
        CODECaptionLbl: Label 'CODE';
        COMMANDECaption_Control1000000031Lbl: Label 'COMMANDE';
        COMMANDECaptionLbl: Label 'COMMANDE';
        CUMUL_AVOIRCaptionLbl: Label 'CUMUL AVOIR';
        CUMULS_LIVRAISON___AVOIRSCaptionLbl: Label 'CUMULS LIVRAISON - AVOIRS';
        CUMULSCaption_Control1000000048Lbl: Label 'CUMULS';
        CUMULSCaptionLbl: Label 'CUMULS';
        DATECaptionLbl: Label 'DATE';
        MAGCaption_Control1000000036Lbl: Label 'MAG';
        MAGCaptionLbl: Label 'MAG';
        PAYSCaption_Control1000000037Lbl: Label 'PAYS';
        PAYSCaptionLbl: Label 'PAYS';
        POIDSCaption_Control1000000033Lbl: Label 'POIDS';
        POIDSCaptionLbl: Label 'POIDS';
        "Relevé_des_sorties_du__Caption_Control1000000027Lbl": Label 'Relevé des sorties du :';
        "Relevé_des_sorties_du__CaptionLbl": Label 'Relevé des sorties du :';
        Text001: Label '9930 24 00 00 00C';
        Text002: Label '9930 99 00 00 00Z';
        TYPECaption_Control1000000035Lbl: Label 'TYPE';
        TYPECaption_Control1000000047Lbl: Label 'TYPE';
        TYPECaptionLbl: Label 'TYPE';
        VALEURCaption_Control1000000032Lbl: Label 'VALEUR';
        VALEURCaptionLbl: Label 'VALEUR';
        CodeDouane: Text[30];
        DateFilter: Text[30];
        LocationFilter: Text[30];

    procedure FindCRMemoLines(FromDSANo: Code[20]; var FromPM: Option " ",Materiel,Provision; var FromCountry: Code[10]; RAZ: Boolean; var FromLoc: Code[10])
    var
        FromCRMemoHeader: Record "Sales Cr.Memo Header";
        FromCRMemoLines: Record "Sales Cr.Memo Line";
    begin
        FromCRMemoLines.RESET();
        FromCRMemoHeader.RESET();
        CLEAR(DSACrMemoWeight);
        CLEAR(DSACrMemoAmount);
        DSACrMemoWeight := 0;
        DSACrMemoAmount := 0;
        FromCRMemoLines.SETCURRENTKEY("Document No.", "PWD Provision/materiel");
        FromCRMemoLines.SETFILTER("PWD Posting Date PW", DateFilter);
        FromCRMemoLines.SETRANGE(Type, FromCRMemoLines.Type::Item);
        FromCRMemoLines.SETRANGE("PWD Provision/materiel", Cumul."PWD Provision/materiel");
        FromCRMemoLines.SETRANGE("Location Code", Cumul."Location Code");
        FromCRMemoLines.SETRANGE("PWD Monthly Code", Cumul."PWD Monthly Code");
        IF FromCRMemoLines.FIND('-') THEN
            REPEAT
                IF NOT BlankDSA THEN BEGIN
                    FromCRMemoHeader.GET(FromCRMemoLines."Document No.");
                    IF FromCRMemoHeader."PWD DSA No." <> '' THEN BEGIN
                        DSACrMemoWeight += FromCRMemoLines.Quantity * FromCRMemoLines."Net Weight";
                        DSACrMemoAmount += FromCRMemoLines."Line Amount";
                    END;
                END ELSE BEGIN
                    DSACrMemoWeight += FromCRMemoLines.Quantity * FromCRMemoLines."Net Weight";
                    DSACrMemoAmount += FromCRMemoLines."Line Amount";
                END;
            UNTIL FromCRMemoLines.NEXT() = 0;

        TotalCrMemoWeight += DSACrMemoWeight;
        TotalCrMemoAmount += DSACrMemoAmount;
    end;

}
