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
            column(Txt_au; Au_Lbl)
            {
            }
            column(PageNo_Caption; Page_Caption)
            {
            }
            column(NetWeight; NetWeight)
            {
            }
            column(LineAmount; LineAmount)
            {
            }
            column(Relevé_des_ventes_Caption; ReleveVentesEmporterConsommationBordLbl)
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
            column(Avoirs_Ventes_à_emporterCaption; AvoirsVentesEmporterCaption)
            {
            }
            column(Bon_de_livraisonCaption; Bon_de_livraisonCaptionLbl)
            {
            }
            column(Ventes_à_emporterCaption; Ventes_à_emporterCaptionLbl)
            {
            }
            column(Sales_Shipment_Header_No_; "No.")
            {
            }
            column(NetWeightTotal; NetWeightTotal)
            {
            }
            column(AmountTotal; AmountTotal)
            {
            }
            column(VAEAmount; VAEAmount)
            {
            }
            dataitem(VAE; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Location Code", "PWD Provision/materiel", "PWD National Add. Code") WHERE(Type = CONST(Item), Quantity = FILTER(<> 0));
                column(V7Caption; V7CaptionLbL)
                {
                }
                column(Sales_Shipment_Header_DSA_No; "Sales Shipment Header"."PWD DSA No.")
                {
                }
                column(Sales_Shipment_Header_Posting_Date; "Sales Shipment Header"."Posting Date")
                {
                }
                column(Sales_Shipment_Line_National_Add_Code; "PWD National Add. Code")
                {
                }
                column(Sales_Shipment_Line_NetWeight; NetWeight)
                {
                }
                column(Sales_Shipment_Line_LineAmount; LineAmount)
                {
                }
                column(Sales_Shipment_Line_Document_No; "Document No.")
                {
                }
                column(V1Caption; V1CaptionLbl)
                {
                }
                column(VAE_Line_No_; "Line No.")
                {
                }
                column(V7_Lbl; V7CaptionLbL)
                {
                }
                column(V1_Lbl; V1CaptionLbl)
                {
                }
                column(Total_Avoirs_Ventes_emporterCaption; TotalAvoirsVentesemporterCaptionLbl)
                {
                }
                column(Total_Ventes_emporterCaption; Total_Ventes_emporterCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT Item.GET("No.") THEN Item.INIT();
                    NetWeight := "Net Weight" * Quantity;
                    VAEWeight += NetWeight;
                    CLEAR(LineAmount);
                    IF ("No." <> 'DAVIGEL') AND ("No." <> 'EPISAVEURS') AND
                       ("No." <> 'FOURNIER') AND ("No." <> 'MIX BUFFET') AND
                       ("No." <> 'PRUVOST') AND ("No." <> 'TERRE AZUR') AND
                       ("No." <> 'MBRIDOR') AND ("No." <> 'LESAGE') AND ("No." <> 'MGLACE') AND
                       ("No." <> 'MUNEL') AND ("No." <> 'MDAVIGEL') AND ("No." <> 'MCHOCOLAT') AND
                       ("No." <> 'DPOMONA') AND
                       ("No." <> 'DEPISAV') AND
                       ("No." <> 'DTERREA') THEN
                        LineAmount := Quantity * Item."PWD Customs Price" ELSE
                        IF "PWD Valeur douane (correction)" <> 0 THEN
                            LineAmount := Quantity * "PWD Valeur douane (correction)" ELSE
                            LineAmount := Quantity * "Unit Cost (LCY)";
                end;

                trigger OnPreDataItem()
                begin
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
                StartDate := GETRANGEMIN("Posting Date");
                EndDate := GETRANGEMAX("Posting Date");

                //_IF NOT (BlankDSA) THEN;
            end;
        }
        dataitem(VAECrMemoHeader; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("Posting Date", "PWD DSA No.");
            RequestFilterFields = "No.", "Location Code";
            column(NetWeight_; NetWeight)
            {
            }
            column(LineAmount_; LineAmount)
            {
            }


            column(VAEWeight_VAECrMemoWeight; VAEWeight - VAECrMemoWeight)
            {
            }
            column(VAEAmount_LineAmount; VAEAmount - LineAmount)
            {
            }



            column(VAECrMemoHeader_No_; "No.")
            {
            }
            dataitem(VAECrMemoLine; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "PWD National Add. Code") WHERE(Type = CONST(Item), Quantity = FILTER(<> 0));
                column(VAECrMemoLine_Document_No; "Document No.")
                {
                }

                column(VAECrMemoLine_LineAmount; LineAmount)
                {
                }
                column(VAECrMemoLine_NetWeight; NetWeight)
                {
                }
                column(VAECrMemoLine_National_Add_Code; "PWD National Add. Code")
                {
                }
                column(V7_CrLbl; V7CaptionLbL)
                {
                }
                column(V1_CrLbl; V1CaptionLbl)
                {
                }

                column(VAECrMemoHeader_Posting_Date; VAECrMemoHeader."Posting Date")
                {
                }
                column(VAECrMemoHeader_DSA_No; VAECrMemoHeader."PWD DSA No.")
                {
                }

                column(VAECrMemoLine_Line_No_; "Line No.")
                {
                }
                column(VAECrMemoAmount; VAECrMemoAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF NOT Item.GET("No.") THEN Item.INIT();
                    NetWeight := "Net Weight" * Quantity;
                    VAECrMemoWeight += NetWeight;
                    CLEAR(LineAmount);
                    IF ("No." <> 'DAVIGEL') AND ("No." <> 'EPISAVEURS') AND
                       ("No." <> 'FOURNIER') AND ("No." <> 'MIX BUFFET') AND
                       ("No." <> 'PRUVOST') AND ("No." <> 'TERRE AZUR') AND
                       ("No." <> 'DPOMONA') AND
                       ("No." <> 'DEPISAV') AND
                       ("No." <> 'DTERREA') THEN
                        LineAmount := Quantity * Item."PWD Customs Price" ELSE
                        IF "PWD Valeur douane (correction)" <> 0 THEN
                            LineAmount := Quantity * "PWD Valeur douane (correction)" ELSE
                            LineAmount := Quantity * "Unit Cost (LCY)";
                    VAECrMemoAmount += LineAmount;
                end;

                trigger OnPreDataItem()
                begin
                end;
            }

            trigger OnPreDataItem()
            begin
                //_ IF NOT (BlankDSA) THEN;
                SETRANGE("Posting Date", StartDate, EndDate);
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
        BlankDSA: Boolean;
        BLCaptionLbl: Label 'BL';
        Bon_de_livraisonCaptionLbl: Label 'Bon de livraison';
        CDSCaptionLbl: Label 'CDS';
        DATECaptionLbl: Label 'DATE';
        NDPCaptionLbl: Label 'NDP';
        POIDSCaptionLbl: Label 'POIDS';
        Au_Lbl: label 'au';
        Page_Caption: label 'Page';
        ReleveVentesEmporterConsommationBordLbl: Label 'Relevé des ventes à emporter & consommation à bord du :';
        TotalAvoirsVentesemporterCaptionLbl: Label 'Total Avoirs Ventes à emporter';
        "Total_Ventes_emporterCaptionLbl": Label 'Total Ventes à emporter';
        TYPECaptionLbl: Label 'TYPE';
        V1CaptionLbl: Label '1';
        V7CaptionLbL: Label '7';
        VALEURCaptionLbl: Label 'VALEUR';
        AvoirsVentesEmporterCaption: label 'Avoirs Ventes à emporter';
        Ventes_à_emporterCaptionLbl: Label 'Ventes à emporter';
}
