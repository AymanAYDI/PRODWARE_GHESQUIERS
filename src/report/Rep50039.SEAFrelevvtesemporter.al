report 50039 "SEAF : relevé vtes à emporter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/SEAFrelevévtesàemporter.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("PWD DSA No.", "Posting Date");
            RequestFilterFields = "Posting Date", "Location Code", "No.";
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(au_; 'au')
            {
            }
            column(Page___FORMAT_CurrReport_PAGENO_; 'Page ')
            {
            }
            column(NetWeight; NetWeight)
            {
            }
            column(LineAmount; LineAmount)
            {
            }
            column("Relevé_des_ventes_à_emporter___consommation_à_bord_du__Caption"; Relevé_des_ventes_à_emporter___consommation_à_bord_du__CaptionLbl)
            {
            }
            column(CDSCaption; CDSCaptionLbl)
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
            column(NDPCaption; NDPCaptionLbl)
            {
            }
            column(POIDSCaption; POIDSCaptionLbl)
            {
            }
            column(VALEURCaption; VALEURCaptionLbl)
            {
            }
            column(Bon_de_livraisonCaption; Bon_de_livraisonCaptionLbl)
            {
            }
            column("Ventes_à_emporterCaption"; Ventes_à_emporterCaptionLbl)
            {
            }
            column(Sales_Shipment_Header_No_; "No.")
            {
            }
            dataitem(VAE; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Location Code", "PWD Provision/materiel", "PWD National Add. Code") WHERE(Type = CONST(Item), Quantity = FILTER(<> 0));
                column(V7_; '7')
                {
                }
                column(Sales_Shipment_Header___DSA_No__; "Sales Shipment Header"."PWD DSA No.")
                {
                }
                column(Sales_Shipment_Header___Posting_Date_; "Sales Shipment Header"."Posting Date")
                {
                }
                column(VAE__National_Add__Code_; "PWD National Add. Code")
                {
                }
                column(NetWeight_Control1000000005; NetWeight)
                {
                }
                column(LineAmount_Control1000000004; LineAmount)
                {
                }
                column(VAE__Document_No__; "Document No.")
                {
                }
                column(V1Caption; V1CaptionLbl)
                {
                }
                column(VAE_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT Item.GET("No.") THEN Item.INIT();
                    NetWeight := "Net Weight" * Quantity;
                    VAEWeight += NetWeight;
                    CLEAR(LineAmount);
                    //>> 03/08/2011 SU-DADE cf appel TI056815
                    //OLD CODE
                    //IF ("No."<>'POMONA') AND ("No."<>'PROLAIDIS') THEN
                    IF ("No." <> 'DAVIGEL') AND ("No." <> 'EPISAVEURS') AND
                       ("No." <> 'FOURNIER') AND ("No." <> 'MIX BUFFET') AND
                       ("No." <> 'PRUVOST') AND ("No." <> 'TERRE AZUR') AND
                    //>>TI170895
                       ("No." <> 'MBRIDOR') AND ("No." <> 'LESAGE') AND ("No." <> 'MGLACE') AND
                       ("No." <> 'MUNEL') AND ("No." <> 'MDAVIGEL') AND ("No." <> 'MCHOCOLAT') AND

                    //<<TI170895
                    //<< 03/08/2011 SU-DADE cf appel TI056815
                    //>> 03/02/2016 SU-DADE cf appel TI312622
                       ("No." <> 'DPOMONA') AND
                    //<< 03/02/2016 SU-DADE cf appel TI312622
                    //>> 01/07/2016 SU-DADE cf appel TI333205
                       ("No." <> 'DEPISAV') AND
                    //<< 01/07/2016 SU-DADE cf appel TI333205
                    //>> 07/05/2018 SU-DADE cf appel TI414520
                       ("No." <> 'DTERREA') THEN
                        //<< 07/05/2018 SU-DADE cf appel TI414520
                        LineAmount := Quantity * Item."PWD Customs Price" ELSE
                        IF "Valeur douane (correction)" <> 0 THEN
                            LineAmount := Quantity * "Valeur douane (correction)" ELSE
                            LineAmount := Quantity * "Unit Cost (LCY)";
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(NetWeight, LineAmount);
                end;
            }

            trigger OnPostDataItem()
            begin
                NetWeightTotal += NetWeight;
                AmountTotal += LineAmount;
                VAEAmount := LineAmount;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CREATETOTALS(NetWeight, LineAmount);
                StartDate := GETRANGEMIN("Posting Date");
                EndDate := GETRANGEMAX("Posting Date");

                IF NOT (BlankDSA) THEN SETFILTER("PWD DSA No.", '<>%1', '');
            end;
        }
        dataitem(VAECrMemoHeader; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("Posting Date", "PWD DSA No.");
            RequestFilterFields = "No.", "Location Code";
            column(NetWeight_Control1000000072; NetWeight)
            {
            }
            column(LineAmount_Control1000000073; LineAmount)
            {
            }
            column(VAEWeight_VAECrMemoWeight; VAEWeight - VAECrMemoWeight)
            {
            }
            column(VAEAmount_LineAmount; VAEAmount - LineAmount)
            {
            }
            column("Avoirs_Ventes_à_emporterCaption"; Avoirs_Ventes_à_emporterCaptionLbl)
            {
            }
            column("Total_Avoirs_Ventes_à_emporterCaption"; Total_Avoirs_Ventes_à_emporterCaptionLbl)
            {
            }
            column("Total_Ventes_à_emporterCaption"; Total_Ventes_à_emporterCaptionLbl)
            {
            }
            column(VAECrMemoHeader_No_; "No.")
            {
            }
            dataitem(VAECrMemoLine; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "PWD National Add. Code") WHERE(Type = CONST(Item), Quantity = FILTER(<> 0));
                column(VAECrMemoLine__Document_No__; "Document No.")
                {
                }
                column(LineAmount_Control1000000059; LineAmount)
                {
                }
                column(NetWeight_Control1000000060; NetWeight)
                {
                }
                column(VAECrMemoLine__National_Add__Code_; "PWD National Add. Code")
                {
                }
                column(VAECrMemoHeader__Posting_Date_; VAECrMemoHeader."Posting Date")
                {
                }
                column(VAECrMemoHeader__DSA_No__; VAECrMemoHeader."PWD DSA No.")
                {
                }
                column(V7__Control1000000065; '7')
                {
                }
                column(V1Caption_Control1000000064; V1Caption_Control1000000064Lbl)
                {
                }
                column(VAECrMemoLine_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT Item.GET("No.") THEN Item.INIT();
                    NetWeight := "Net Weight" * Quantity;
                    VAECrMemoWeight += NetWeight;
                    CLEAR(LineAmount);
                    //>> 03/08/2011 SU-DADE cf appel TI056815
                    //OLD CODE
                    //IF ("No."<>'POMONA') AND ("No."<>'PROLAIDIS') THEN
                    IF ("No." <> 'DAVIGEL') AND ("No." <> 'EPISAVEURS') AND
                       ("No." <> 'FOURNIER') AND ("No." <> 'MIX BUFFET') AND
                       ("No." <> 'PRUVOST') AND ("No." <> 'TERRE AZUR') AND
                    //<< 03/08/2011 SU-DADE cf appel TI056815

                    //>> 03/02/2016 SU-DADE cf appel TI312622
                       ("No." <> 'DPOMONA') AND
                    //<< 03/02/2016 SU-DADE cf appel TI312622
                    //>> 01/07/2016 SU-DADE cf appel TI333205
                       ("No." <> 'DEPISAV') AND
                    //<< 01/07/2016 SU-DADE cf appel TI333205
                    //>> 07/05/2018 SU-DADE cf appel TI414520
                       ("No." <> 'DTERREA') THEN
                        //<< 07/05/2018 SU-DADE cf appel TI414520

                        LineAmount := Quantity * Item."PWD Customs Price" ELSE
                        IF "PWD Valeur douane (correction)" <> 0 THEN
                            LineAmount := Quantity * "PWD Valeur douane (correction)" ELSE
                            LineAmount := Quantity * "Unit Cost (LCY)";

                    VAECrMemoAmount += LineAmount;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(NetWeight, LineAmount);
                end;
            }

            trigger OnPreDataItem()
            begin
                IF NOT (BlankDSA) THEN SETFILTER("PWD DSA No.", '<>%1', '');

                SETRANGE("Posting Date", StartDate, EndDate);

                //CurrReport.CREATETOTALS(NetWeight, LineAmount);
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
        BlankDSA: Boolean;
        EndDate: Date;
        StartDate: Date;
        AmountTotal: Decimal;
        LineAmount: Decimal;
        NetWeight: Decimal;
        NetWeightTotal: Decimal;
        VAEAmount: Decimal;
        VAECrMemoAmount: Decimal;
        VAECrMemoWeight: Decimal;
        VAEWeight: Decimal;
        "Avoirs_Ventes_à_emporterCaptionLbl": Label 'Avoirs Ventes à emporter';
        BLCaptionLbl: Label 'BL';
        Bon_de_livraisonCaptionLbl: Label 'Bon de livraison';
        CDSCaptionLbl: Label 'CDS';
        DATECaptionLbl: Label 'DATE';
        NDPCaptionLbl: Label 'NDP';
        POIDSCaptionLbl: Label 'POIDS';
        "Relevé_des_ventes_à_emporter___consommation_à_bord_du__CaptionLbl": Label 'Relevé des ventes à emporter & consommation à bord du :';
        "Total_Avoirs_Ventes_à_emporterCaptionLbl": Label 'Total Avoirs Ventes à emporter';
        "Total_Ventes_à_emporterCaptionLbl": Label 'Total Ventes à emporter';
        TYPECaptionLbl: Label 'TYPE';
        V1Caption_Control1000000064Lbl: Label '1';
        V1CaptionLbl: Label '1';
        VALEURCaptionLbl: Label 'VALEUR';
        "Ventes_à_emporterCaptionLbl": Label 'Ventes à emporter';
}
