report 50026 "Sales - Shipment AVITA - DAA"
{
    // Text Exemplaire ...... paramétrer ds OnInitReport
    // --------------------------------------------
    // Prodware - www.prodware.com
    // --------------------------------------------
    // >>GUE-RE1.00:DO 12/04/2011 :
    //   - compilation
    // 
    // //>>GHES
    // P3346_0011 DO:SOBI 12/09/2012  : Add locationFilter from SalesSetup
    //                                 - C/AL code OninitRequestForm
    //                                 - Skip C/AL code OnInitReport
    //                                 - Skip Filter Item.Family='SE' Sales Shipment Line
    // 
    // //>> 01/04/2016 SU-DADE cf appel TI321001
    // //   Sales Shipment Line - OnAfterGetRecord()
    // //<< 01/04/2016 SU-DADE cf appel TI321001
    // 
    // --------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './SalesShipmentAVITADAA.rdl';

    Caption = 'Sales - Shipment';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';
            column(Sales_Shipment_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = true;
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    PrintOnlyIfDetail = true;
                    column(TextExemplaire; TextExemplaire)
                    {
                    }
                    column(ExemplaireT; ExemplaireT)
                    {
                    }
                    column(STRSUBSTNO_Text003_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text003, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
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
                    column(Sales_Shipment_Header___No__; "Sales Shipment Header"."No.")
                    {
                    }
                    column("Dépot____2__"; 'Dépot :  2 ')
                    {
                    }
                    column(FRANCE_; ' - FRANCE')
                    {
                    }
                    column(N__Accises_____________FR012074E1077_; 'N° Accises :           FR012074E1077')
                    {
                    }
                    column(ExemplaireT_Control1000000207; ExemplaireT)
                    {
                    }
                    column(Lieu_d__expedition___CALAIS_; 'Lieu d''expedition : CALAIS')
                    {
                    }
                    column(Sales_Shipment_Header___Posting_Date_; "Sales Shipment Header"."Posting Date")
                    {
                    }
                    column(SellToCustName; SellToCustName)
                    {
                    }
                    column(SellToCustaddr; SellToCustaddr)
                    {
                    }
                    column(SellToCustaddr2; SellToCustaddr2)
                    {
                    }
                    column(SellToPostCode; SellToPostCode)
                    {
                    }
                    column(SellToCity; SellToCity)
                    {
                    }
                    column(BillToCustName; BillToCustName)
                    {
                    }
                    column(BillToCustaddr; BillToCustaddr)
                    {
                    }
                    column(BillToCustaddr2; BillToCustaddr2)
                    {
                    }
                    column(BillToCity; BillToCity)
                    {
                    }
                    column(BillToPostCode; BillToPostCode)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(Sales_Shipment_Header___Shipping_Time_; "Sales Shipment Header"."Shipping Time")
                    {
                    }
                    column(Sales_Shipment_Header___Posting_Date__Control1000000222; "Sales Shipment Header"."Posting Date")
                    {
                    }
                    column(Cust__VAT_Registration_No__; Cust."VAT Registration No.")
                    {
                    }
                    column(Cust__Country_Region_Code_; Cust."Country/Region Code")
                    {
                    }
                    column(CompanyInfo__Country_Region_Code_; CompanyInfo."Country/Region Code")
                    {
                    }
                    column(ShippingAgent_Name; ShippingAgent.Name)
                    {
                    }
                    column(ShippingAgent_Ville; ShippingAgent."PWD Ville")
                    {
                    }
                    column(ShippingAgent_Code; ShippingAgent.Code)
                    {
                    }
                    column(Colonne3; Colonne3)
                    {
                    }
                    column(ContactMag; ContactMag)
                    {
                    }
                    column(TextExemplaire_Control1000000113; TextExemplaire)
                    {
                    }
                    column(STRSUBSTNO_Text003_FORMAT_CurrReport_PAGENO___Control2; STRSUBSTNO(Text003, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(CompanyAddr_1__Control5; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr_2__Control7; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_3__Control9; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_4__Control11; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_5__Control65; CompanyAddr[5])
                    {
                    }
                    column(Colonne3_Control3; Colonne3)
                    {
                    }
                    column(Sales_Shipment_Header___No___Control32; "Sales Shipment Header"."No.")
                    {
                    }
                    column("Dépot____8__"; 'Dépot :  8 ')
                    {
                    }
                    column(FRANCE__Control1000000022; ' - FRANCE')
                    {
                    }
                    column(N__Accises_____________FR012074E1077__Control1000000024; 'N° Accises :           FR012074E1077')
                    {
                    }
                    column(ExemplaireT_Control1000000021; ExemplaireT)
                    {
                    }
                    column(ExemplaireT_Control1000000016; ExemplaireT)
                    {
                    }
                    column(Lieu_d__expedition___CALAIS__Control1000000154; 'Lieu d''expedition : CALAIS')
                    {
                    }
                    column(Sales_Shipment_Header___Posting_Date__Control1000000163; "Sales Shipment Header"."Posting Date")
                    {
                    }
                    column(Cust__Country_Region_Code__Control1000000165; Cust."Country/Region Code")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No___Control1000000188; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(Sales_Shipment_Header___Shipping_Time__Control1000000307; "Sales Shipment Header"."Shipping Time")
                    {
                    }
                    column(Sales_Shipment_Header___Posting_Date__Control1000000310; "Sales Shipment Header"."Posting Date")
                    {
                    }
                    column(CompanyInfo__Country_Region_Code__Control1000000011; CompanyInfo."Country/Region Code")
                    {
                    }
                    column(ShippingAgent_Code_Control1000000117; ShippingAgent.Code)
                    {
                    }
                    column(ShippingAgent_Name_Control1000000155; ShippingAgent.Name)
                    {
                    }
                    column(ShippingAgent_Ville_Control1000000157; ShippingAgent."PWD Ville")
                    {
                    }
                    column(ContactMag_Control1000000160; ContactMag)
                    {
                    }
                    column(BillToCustName_Control1000000179; BillToCustName)
                    {
                    }
                    column(BillToCustaddr_Control1000000249; BillToCustaddr)
                    {
                    }
                    column(BillToCustaddr2_Control1000000250; BillToCustaddr2)
                    {
                    }
                    column(BillToPostCode_Control1000000251; BillToPostCode)
                    {
                    }
                    column(BillToCity_Control1000000252; BillToCity)
                    {
                    }
                    column(Cust__VAT_Registration_No___Control1000000254; Cust."VAT Registration No.")
                    {
                    }
                    column(SellToCustName_Control1000000256; SellToCustName)
                    {
                    }
                    column(SellToCustaddr_Control1000000257; SellToCustaddr)
                    {
                    }
                    column(SellToCustaddr2_Control1000000258; SellToCustaddr2)
                    {
                    }
                    column(SellToPostCode_Control1000000259; SellToPostCode)
                    {
                    }
                    column(SellToCity_Control1000000260; SellToCity)
                    {
                    }
                    column(COMMUNAUTE_EUROPEENNE___PRODUITS_SOUMIS_A_ACCISESCaption; COMMUNAUTE_EUROPEENNE___PRODUITS_SOUMIS_A_ACCISESCaptionLbl)
                    {
                    }
                    column("Expéditeur___Caption"; Expéditeur___CaptionLbl)
                    {
                    }
                    column(Transporteur___Caption; Transporteur___CaptionLbl)
                    {
                    }
                    column(Destinataire___Caption; Destinataire___CaptionLbl)
                    {
                    }
                    column(RECETTE_PRINCIPALE_DES_Caption; RECETTE_PRINCIPALE_DES_CaptionLbl)
                    {
                    }
                    column(DOCUMENT_COMMERCIAL__ACCOMP______DCA_Caption; DOCUMENT_COMMERCIAL__ACCOMP______DCA_CaptionLbl)
                    {
                    }
                    column(N__de_document___Caption; N__de_document___CaptionLbl)
                    {
                    }
                    column(Depot_8___1Caption; Depot_8___1CaptionLbl)
                    {
                    }
                    column(DOUANES______CALAIS_0074Caption; DOUANES______CALAIS_0074CaptionLbl)
                    {
                    }
                    column(Garantie___Caption; Garantie___CaptionLbl)
                    {
                    }
                    column(EXPEDITEURCaption; EXPEDITEURCaptionLbl)
                    {
                    }
                    column(V1Caption; V1CaptionLbl)
                    {
                    }
                    column(V2Caption; V2CaptionLbl)
                    {
                    }
                    column(V4Caption; V4CaptionLbl)
                    {
                    }
                    column(V3_5Caption; V3_5CaptionLbl)
                    {
                    }
                    column(V9Caption; V9CaptionLbl)
                    {
                    }
                    column(V7Caption; V7CaptionLbl)
                    {
                    }
                    column(V7ACaption; V7ACaptionLbl)
                    {
                    }
                    column(V8Caption; V8CaptionLbl)
                    {
                    }
                    column(V10Caption; V10CaptionLbl)
                    {
                    }
                    column(V15Caption; V15CaptionLbl)
                    {
                    }
                    column("Pour_la_circulation_des_produits_soumis_à_accise_en_régime_de_suspension_Caption"; Pour_la_circulation_des_produits_soumis_à_accise_en_régime_de_suspension_CaptionLbl)
                    {
                    }
                    column(Changement_du_lieu_de_livraison__Caption; Changement_du_lieu_de_livraison__CaptionLbl)
                    {
                    }
                    column(BCaption; BCaptionLbl)
                    {
                    }
                    column("Autorisation_accordée_par__autorité_compétente_Caption"; Autorisation_accordée_par__autorité_compétente_CaptionLbl)
                    {
                    }
                    column(Signature_et_cachet__Caption; Signature_et_cachet__CaptionLbl)
                    {
                    }
                    column(V12Caption; V12CaptionLbl)
                    {
                    }
                    column(V6Caption; V6CaptionLbl)
                    {
                    }
                    column(Date__Caption; Date__CaptionLbl)
                    {
                    }
                    column(V13Caption; V13CaptionLbl)
                    {
                    }
                    column(Pays_de_destination__Caption; Pays_de_destination__CaptionLbl)
                    {
                    }
                    column(N__id__intracom___Caption; N__id__intracom___CaptionLbl)
                    {
                    }
                    column(V17Caption; V17CaptionLbl)
                    {
                    }
                    column("Durée_du_transportCaption"; Durée_du_transportCaptionLbl)
                    {
                    }
                    column(V16Caption; V16CaptionLbl)
                    {
                    }
                    column("Date_d_expéditionCaption"; Date_d_expéditionCaptionLbl)
                    {
                    }
                    column(N__TVA__Caption; N__TVA__CaptionLbl)
                    {
                    }
                    column(V12Caption_Control1000000118; V12Caption_Control1000000118Lbl)
                    {
                    }
                    column("Pays_d_expédition__Caption"; Pays_d_expédition__CaptionLbl)
                    {
                    }
                    column(V14Caption; V14CaptionLbl)
                    {
                    }
                    column("Représentant_fiscal___Caption"; Représentant_fiscal___CaptionLbl)
                    {
                    }
                    column(V11Caption; V11CaptionLbl)
                    {
                    }
                    column("Précision_sur_le_transport__Caption"; Précision_sur_le_transport__CaptionLbl)
                    {
                    }
                    column(Lieu_de_livraison__Caption; Lieu_de_livraison__CaptionLbl)
                    {
                    }
                    column(POUR_COMPTE__Caption; POUR_COMPTE__CaptionLbl)
                    {
                    }
                    column(COMMUNAUTE_EUROPEENNE___PRODUITS_SOUMIS_A_ACCISESCaption_Control1000000005; COMMUNAUTE_EUROPEENNE___PRODUITS_SOUMIS_A_ACCISESCaption_Control1000000005Lbl)
                    {
                    }
                    column("Expéditeur___Caption_Control1000000029"; Expéditeur___Caption_Control1000000029Lbl)
                    {
                    }
                    column(Destinataire___Caption_Control1000000030; Destinataire___Caption_Control1000000030Lbl)
                    {
                    }
                    column(RECETTE_PRINCIPALE_DES_Caption_Control1000000033; RECETTE_PRINCIPALE_DES_Caption_Control1000000033Lbl)
                    {
                    }
                    column(DOCUMENT_COMMERCIAL__ACCOMP______DCA_Caption_Control1000000031; DOCUMENT_COMMERCIAL__ACCOMP______DCA_Caption_Control1000000031Lbl)
                    {
                    }
                    column(N__de_document___Caption_Control1000000004; N__de_document___Caption_Control1000000004Lbl)
                    {
                    }
                    column(Depot_8___1Caption_Control1000000080; Depot_8___1Caption_Control1000000080Lbl)
                    {
                    }
                    column(DOUANES______CALAIS_0074Caption_Control1000000026; DOUANES______CALAIS_0074Caption_Control1000000026Lbl)
                    {
                    }
                    column(Garantie___Caption_Control1000000050; Garantie___Caption_Control1000000050Lbl)
                    {
                    }
                    column(EXPEDITEURCaption_Control1000000051; EXPEDITEURCaption_Control1000000051Lbl)
                    {
                    }
                    column(V1Caption_Control1000000099; V1Caption_Control1000000099Lbl)
                    {
                    }
                    column(V2Caption_Control1000000100; V2Caption_Control1000000100Lbl)
                    {
                    }
                    column(V4Caption_Control1000000115; V4Caption_Control1000000115Lbl)
                    {
                    }
                    column(V3_5Caption_Control1000000116; V3_5Caption_Control1000000116Lbl)
                    {
                    }
                    column(V7Caption_Control1000000119; V7Caption_Control1000000119Lbl)
                    {
                    }
                    column(V7ACaption_Control1000000120; V7ACaption_Control1000000120Lbl)
                    {
                    }
                    column(V8Caption_Control1000000121; V8Caption_Control1000000121Lbl)
                    {
                    }
                    column(V10Caption_Control1000000122; V10Caption_Control1000000122Lbl)
                    {
                    }
                    column(V15Caption_Control1000000153; V15Caption_Control1000000153Lbl)
                    {
                    }
                    column("Pour_la_circulation_des_produits_soumis_à_accise_en_régime_de_suspension_Caption_Control1000000156"; Pour_la_circulation_des_produits_soumis_à_accise_en_régime_de_suspension_Caption_Control1000000156Lbl)
                    {
                    }
                    column(V12Caption_Control1000000161; V12Caption_Control1000000161Lbl)
                    {
                    }
                    column(V6Caption_Control1000000162; V6Caption_Control1000000162Lbl)
                    {
                    }
                    column(Date__Caption_Control1000000164; Date__Caption_Control1000000164Lbl)
                    {
                    }
                    column(V13Caption_Control1000000166; V13Caption_Control1000000166Lbl)
                    {
                    }
                    column(Pays_de_destination__Caption_Control1000000167; Pays_de_destination__Caption_Control1000000167Lbl)
                    {
                    }
                    column(N__id__intracom___Caption_Control1000000237; N__id__intracom___Caption_Control1000000237Lbl)
                    {
                    }
                    column(V12Caption_Control1000000265; V12Caption_Control1000000265Lbl)
                    {
                    }
                    column("Pays_d_expédition__Caption_Control1000000266"; Pays_d_expédition__Caption_Control1000000266Lbl)
                    {
                    }
                    column("Représentant_fiscal___Caption_Control1000000272"; Représentant_fiscal___Caption_Control1000000272Lbl)
                    {
                    }
                    column(V14Caption_Control1000000273; V14Caption_Control1000000273Lbl)
                    {
                    }
                    column(Transporteur___Caption_Control1000000300; Transporteur___Caption_Control1000000300Lbl)
                    {
                    }
                    column(V9Caption_Control1000000301; V9Caption_Control1000000301Lbl)
                    {
                    }
                    column(V11Caption_Control1000000302; V11Caption_Control1000000302Lbl)
                    {
                    }
                    column("Précision_sur_le_transport__Caption_Control1000000303"; Précision_sur_le_transport__Caption_Control1000000303Lbl)
                    {
                    }
                    column(V17Caption_Control1000000305; V17Caption_Control1000000305Lbl)
                    {
                    }
                    column("Durée_du_transportCaption_Control1000000306"; Durée_du_transportCaption_Control1000000306Lbl)
                    {
                    }
                    column(V16Caption_Control1000000308; V16Caption_Control1000000308Lbl)
                    {
                    }
                    column("Date_d_expéditionCaption_Control1000000309"; Date_d_expéditionCaption_Control1000000309Lbl)
                    {
                    }
                    column(BCaption_Control1000000312; BCaption_Control1000000312Lbl)
                    {
                    }
                    column(Changement_du_lieu_de_livraison__Caption_Control1000000313; Changement_du_lieu_de_livraison__Caption_Control1000000313Lbl)
                    {
                    }
                    column("Autorisation_accordée_par__autorité_compétente_Caption_Control1000000314"; Autorisation_accordée_par__autorité_compétente_Caption_Control1000000314Lbl)
                    {
                    }
                    column(Signature_et_cachet__Caption_Control1000000315; Signature_et_cachet__Caption_Control1000000315Lbl)
                    {
                    }
                    column(Lieu_de_livraison__Caption_Control1000000159; Lieu_de_livraison__Caption_Control1000000159Lbl)
                    {
                    }
                    column(POUR_COMPTE__Caption_Control1000000255; POUR_COMPTE__Caption_Control1000000255Lbl)
                    {
                    }
                    column(N__TVA__Caption_Control1000000253; N__TVA__Caption_Control1000000253Lbl)
                    {
                    }
                    column("QuantitéCaption"; QuantitéCaptionLbl)
                    {
                    }
                    column(Code_produit_NCCaption; Code_produit_NCCaptionLbl)
                    {
                    }
                    column("Désignation_des_produitsCaption"; Désignation_des_produitsCaptionLbl)
                    {
                    }
                    column(Code_articleCaption; Code_articleCaptionLbl)
                    {
                    }
                    column(N__de_ligneCaption; N__de_ligneCaptionLbl)
                    {
                    }
                    column(Nombre_de_colisCaption; Nombre_de_colisCaptionLbl)
                    {
                    }
                    column("Unité_de_venteCaption"; Unité_de_venteCaptionLbl)
                    {
                    }
                    column("QuantitéCaption_Control1000000067"; QuantitéCaption_Control1000000067Lbl)
                    {
                    }
                    column("Degrés_alcoolCaption"; Degrés_alcoolCaptionLbl)
                    {
                    }
                    column(PoidsCaption; PoidsCaptionLbl)
                    {
                    }
                    column(net_kgCaption; net_kgCaptionLbl)
                    {
                    }
                    column(AlcoolCaption; AlcoolCaptionLbl)
                    {
                    }
                    column(TabacCaption; TabacCaptionLbl)
                    {
                    }
                    column(Depot_8Caption; Depot_8CaptionLbl)
                    {
                    }
                    column(V18Caption; V18CaptionLbl)
                    {
                    }
                    column(V19Caption; V19CaptionLbl)
                    {
                    }
                    column(Vl__En_LitreCaption; Vl__En_LitreCaptionLbl)
                    {
                    }
                    column(V20Caption; V20CaptionLbl)
                    {
                    }
                    column(V21Caption; V21CaptionLbl)
                    {
                    }
                    column(V22Caption; V22CaptionLbl)
                    {
                    }
                    column(brut_kgCaption; brut_kgCaptionLbl)
                    {
                    }
                    column(PoidsCaption_Control1000000279; PoidsCaption_Control1000000279Lbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Location Code")
                                            WHERE(Quantity = FILTER(<> 0));
                        column(Sales_Shipment_Line_Description; Description)
                        {
                        }
                        column(FORMAT__NumLigne__________FORMAT__NbLigneTotal_; FORMAT(NumLigne) + '/' + FORMAT(NbLigneTotal))
                        {
                        }
                        column(Sales_Shipment_Line__No__; "No.")
                        {
                        }
                        column(Sales_Shipment_Line_Description_Control39; Description)
                        {
                        }
                        column(Sales_Shipment_Line__Parcel_Nb__; "PWD Parcel Nb.")
                        {
                            DecimalPlaces = 0 : 0;
                        }
                        column(Sales_Shipment_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                        {
                        }
                        column(Sales_Shipment_Line__Quantity__Base__; "Quantity (Base)")
                        {
                        }
                        column(Item__Tariff_No__; Item."Tariff No.")
                        {
                        }
                        column(Item__Alcool___; Item."PWD Alcool %")
                        {
                        }
                        column(Gross_Weight_____Quantity__Base__; "Gross Weight" * "Quantity (Base)")
                        {
                        }
                        column(Net_Weight_____Quantity__Base__; "Net Weight" * "Quantity (Base)")
                        {
                        }
                        column(Sales_Shipment_Line__Description_2_; "Description 2")
                        {
                        }
                        column("QtéAlcool"; QtéAlcool)
                        {
                        }
                        column("QtéTabac"; QtéTabac)
                        {
                        }
                        column(VolumeEff; VolumeEff)
                        {
                        }
                        column(Sales_Shipment_Line__No___Control43; "No.")
                        {
                        }
                        column(Sales_Shipment_Line_Description_Control44; Description)
                        {
                        }
                        column(Sales_Shipment_Line__Parcel_Nb___Control45; "PWD Parcel Nb.")
                        {
                        }
                        column(Sales_Shipment_Line__Unit_of_Measure_Code__Control46; "Unit of Measure Code")
                        {
                        }
                        column(TotalVin; TotalVin)
                        {
                        }
                        column(TotalPI; TotalPI)
                        {
                        }
                        column(TotalBiere; TotalBiere)
                        {
                        }
                        column(TotalVolEff; TotalVolEff)
                        {
                        }
                        column(TotalMillCig; TotalMillCig)
                        {
                        }
                        column(TotalKgTabac; TotalKgTabac)
                        {
                        }
                        column(TotalAlcoolPur; TotalAlcoolPur)
                        {
                        }
                        column(TotalRhum; TotalRhum)
                        {
                        }
                        column(CompanyInfo_Picture; CompanyInfo.Picture)
                        {
                        }
                        column(CompanyAddr_1__Control1000000061; CompanyAddr[1])
                        {
                        }
                        column(CompanyAddr_2__Control1000000071; CompanyAddr[2])
                        {
                        }
                        column(CompanyAddr_3__Control1000000072; CompanyAddr[3])
                        {
                        }
                        column(CompanyAddr_4__Control1000000076; CompanyAddr[4])
                        {
                        }
                        column(TEL_______CompanyInfo__Phone_No__; 'TEL   ' + CompanyInfo."Phone No.")
                        {
                        }
                        column(UserTable_Name_; 'UserTable.Name')
                        {
                        }
                        column(CompanyInfo_City_______Le_____FORMAT___Sales_Shipment_Header___Posting_Date__0_4_; CompanyInfo.City + '   Le ' + FORMAT("Sales Shipment Header"."Posting Date", 0, 4))
                        {
                        }
                        column(Depot_8Caption_Control1000000082; Depot_8Caption_Control1000000082Lbl)
                        {
                        }
                        column(Depot_8Caption_Control1000000083; Depot_8Caption_Control1000000083Lbl)
                        {
                        }
                        column(Depot_8Caption_Control1000000084; Depot_8Caption_Control1000000084Lbl)
                        {
                        }
                        column(RHUMS_DOMCaption; RHUMS_DOMCaptionLbl)
                        {
                        }
                        column(VIN_Champ__MousseuxCaption; VIN_Champ__MousseuxCaptionLbl)
                        {
                        }
                        column(BIERECaption; BIERECaptionLbl)
                        {
                        }
                        column(VOL__EN_LITRECaption; VOL__EN_LITRECaptionLbl)
                        {
                        }
                        column(MILLE_CIGARETTESCaption; MILLE_CIGARETTESCaptionLbl)
                        {
                        }
                        column(Kg_TABACCaption; Kg_TABACCaptionLbl)
                        {
                        }
                        column(ALCOOL_PURCaption; ALCOOL_PURCaptionLbl)
                        {
                        }
                        column(PICaption; PICaptionLbl)
                        {
                        }
                        column(V23cCaption; V23cCaptionLbl)
                        {
                        }
                        column(Attestation__Caption; Attestation__CaptionLbl)
                        {
                        }
                        column(ACaption; ACaptionLbl)
                        {
                        }
                        column(V24Caption; V24CaptionLbl)
                        {
                        }
                        column("Cases__1_22_certifiées_correctesCaption"; Cases__1_22_certifiées_correctesCaptionLbl)
                        {
                        }
                        column("Entreprise_du_signataire_et_n__de_téléphoneCaption"; Entreprise_du_signataire_et_n__de_téléphoneCaptionLbl)
                        {
                        }
                        column(Nom_du_signataireCaption; Nom_du_signataireCaptionLbl)
                        {
                        }
                        column(Lieu_et_date_Caption; Lieu_et_date_CaptionLbl)
                        {
                        }
                        column(SignatureCaption; SignatureCaptionLbl)
                        {
                        }
                        column(ControlesCaption; ControlesCaptionLbl)
                        {
                        }
                        column("Certificat_de_réceptionCaption"; Certificat_de_réceptionCaptionLbl)
                        {
                        }
                        column(Envoi_conformeCaption; Envoi_conformeCaptionLbl)
                        {
                        }
                        column(Envoi_non_conformeCaption; Envoi_non_conformeCaptionLbl)
                        {
                        }
                        column("Marchandises_reçues_par_le_destinataireCaption"; Marchandises_reçues_par_le_destinataireCaptionLbl)
                        {
                        }
                        column("En_cas_de_non_conformité___Caption"; En_cas_de_non_conformité___CaptionLbl)
                        {
                        }
                        column(Description_marchandisesCaption; Description_marchandisesCaptionLbl)
                        {
                        }
                        column("Marchandises_excédantesCaption"; Marchandises_excédantesCaptionLbl)
                        {
                        }
                        column(Marchandises_manquantesCaption; Marchandises_manquantesCaptionLbl)
                        {
                        }
                        column("Visa_à_réception_par_le_destinataireCaption"; Visa_à_réception_par_le_destinataireCaptionLbl)
                        {
                        }
                        column(oCaption; oCaptionLbl)
                        {
                        }
                        column(oCaption_Control1000000108; oCaption_Control1000000108Lbl)
                        {
                        }
                        column(oCaption_Control1000000114; oCaption_Control1000000114Lbl)
                        {
                        }
                        column(CCaption; CCaptionLbl)
                        {
                        }
                        column(Sales_Shipment_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Shipment_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT ShowCorrectionLines AND Correction THEN
                                CurrReport.SKIP();

                            PostedDocDim2.SETRANGE("Dimension Set ID", "Sales Shipment Line"."Dimension Set ID");

                            IF "Sales Shipment Line".Type = "Sales Shipment Line".Type::Item THEN BEGIN
                                NumLigne := NumLigne + 1;
                                IF NOT Item.GET("Sales Shipment Line"."No.") THEN
                                    Item.INIT();
                            END;

                            CodeDEpotEntete := "Sales Shipment Line"."Location Code";

                            // Calcul total tabac alcool
                            QtéAlcool := 0;
                            QtéTabac := 0;
                            IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family") THEN BEGIN
                                IF ((ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool) AND (Item."PWD Family" = '47')) THEN BEGIN
                                    IF Item."PWD Alcool %" <> 0 THEN BEGIN
                                        IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN BEGIN
                                            QtéAlcool := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)" / 100;
                                        END;
                                        IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net x °Alcool" THEN BEGIN
                                            QtéAlcool := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)" * Item."PWD Alcool %" / 100;
                                        END;
                                    END;
                                    IF ((Item."PWD Family" = '47') AND (Item."PWD Sub Family" <> '05')) THEN TotalAlcoolPur += QtéAlcool;
                                    IF ((Item."PWD Family" = '47') AND (Item."PWD Sub Family" = '05')) THEN TotalRhum += QtéAlcool;

                                END;

                                IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN BEGIN
                                    IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN BEGIN
                                        QtéTabac := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)";
                                    END;
                                END;
                            END;
                            QtéAlcoolTotal := QtéAlcoolTotal + QtéAlcool;
                            QtéTabacTotal := QtéTabacTotal + QtéTabac;

                            CalcTotalVentil();

                            // ** Calcul total tabac alcool SEA FRANCE **
                            //>>P3346_0011
                            //>> 01/04/2016 SU-DADE cf appel TI321001 => j'enlève le commentaire sur ce code
                            IF Item."PWD Family" = 'SE' THEN BEGIN
                                //<< 01/04/2016 SU-DADE cf appel TI321001
                                //<<P3346_0011
                                QtéAlcool := 0;
                                QtéTabac := 0;

                                IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family (Sea France)") THEN BEGIN
                                    IF ((ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool) AND (Item."PWD Family (Sea France)" = '47')) THEN BEGIN
                                        IF Item."PWD Alcool %" <> 0 THEN BEGIN
                                            IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN BEGIN
                                                QtéAlcool := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)" / 100;
                                            END;
                                            IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net x °Alcool" THEN BEGIN
                                                QtéAlcool := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)" * Item."PWD Alcool %" / 100;
                                            END;
                                        END;
                                        IF ((Item."PWD Family (Sea France)" = '47') AND (Item."PWD Sub Family (Sea France)" <> '05')) THEN TotalAlcoolPur += QtéAlcool;
                                        IF ((Item."PWD Family (Sea France)" = '47') AND (Item."PWD Sub Family (Sea France)" = '05')) THEN TotalRhum += QtéAlcool;

                                    END;

                                    IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN BEGIN
                                        IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN BEGIN
                                            QtéTabac := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)";
                                        END;
                                    END;
                                END;
                                QtéAlcoolTotal := QtéAlcoolTotal + QtéAlcool;
                                QtéTabacTotal := QtéTabacTotal + QtéTabac;

                                CalcTotalVentilSEAF();
                                //>>P3346_0011
                            END;
                            //<<P3346_0011
                        end;

                        trigger OnPreDataItem()
                        begin
                            //MoreLines := FIND('+');
                            //WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                            //  MoreLines := NEXT(-1) <> 0;
                            //IF NOT MoreLines THEN
                            //  CurrReport.BREAK;
                            //SETRANGE("Line No.",0,"Line No.");

                            SETFILTER("Location Code", LocationFilter);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        NumLigne := 0;

                        // Calcul total tabac alcool
                        QtéAlcoolTotal := 0;
                        QtéTabacTotal := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    // ** RAZ
                    CLEAR(TotalPI);
                    CLEAR(TotalBiere);
                    CLEAR(TotalVin);
                    CLEAR(TotalVolEff);
                    CLEAR(TotalMillCig);
                    CLEAR(TotalKgTabac);
                    CLEAR(TotalAlcoolPur);
                    CLEAR(TotalRhum);


                    IF Number > 1 THEN
                        CopyText := Text001;
                    CurrReport.PAGENO := 1;

                    NumCopie := ROUND(Number / 5, 1, '>');
                    Exemplaire := Number - ((NumCopie - 1) * 5);


                    CASE Exemplaire OF
                        1:
                            BEGIN
                                TextExemplaire := TextExemplaire1;
                                ExemplaireT := '1';
                            END;
                        2:
                            BEGIN
                                TextExemplaire := TextExemplaire2;
                                ExemplaireT := '2'
                            END;
                        3:
                            BEGIN
                                TextExemplaire := TextExemplaire3;
                                ExemplaireT := '3'
                            END;
                        4:
                            BEGIN
                                TextExemplaire := TextExemplaire4;
                                ExemplaireT := '4'
                            END;
                        5:
                            BEGIN
                                TextExemplaire := TextExemplaire5;
                                ExemplaireT := '1 BIS';
                            END;

                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        ShptCountPrinted.RUN("Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 5 * (1 + ABS(NoOfCopies));
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // Modif LLE 01-09-04
                SellToCustName := "Sell-to Customer Name";
                SellToCustaddr := "Sell-to Address";
                SellToCustaddr2 := "Sell-to Address 2";
                SellToPostCode := "Sell-to Post Code";
                SellToCity := "Sell-to City";
                BillToCustName := "Bill-to Name";
                BillToCustaddr := "Bill-to Address";
                BillToCustaddr2 := "Bill-to Address 2";
                BillToPostCode := "Bill-to Post Code";
                BillToCity := "Bill-to City";
                // fin modif LLE

                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    CompanyInfo.GET();
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;

                PostedDocDim1.SETRANGE("Dimension Set ID", "Sales Shipment Header"."Dimension Set ID");

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
                FormatAddr.SalesShptShipTo(ShipToAddr, "Sales Shipment Header");

                FormatAddr.SalesShptBillTo(CustAddr, "Sales Shipment Header");
                ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                FOR i := 1 TO ARRAYLEN(CustAddr) DO
                    IF CustAddr[i] <> ShipToAddr[i] THEN
                        ShowCustAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        //>-> GUE-RE.1.00
                        //    SegManagement.LogDocument(
                        //      5,"No.",0,0,DATABASE::Customer,"Sell-to Customer No.","Salesperson Code","Posting Description");
                        SegManagement.LogDocument(
                      5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", '', "Posting Description", '');
                //<-< GUE-RE.1.00
                //*** Recherche du nom du transporteur
                IF NOT ShippingAgent.GET("Sales Shipment Header"."Shipping Agent Code") THEN BEGIN
                    ShippingAgent.Name := '';
                END;

                //*** Calcul du nombre de ligne article total / doc
                SalesShipLine.SETCURRENTKEY("Document No.", "Location Code");
                SalesShipLine.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                SalesShipLine.SETFILTER("Location Code", LocationFilter);
                SalesShipLine.SETRANGE(Type, SalesShipLine.Type::Item);
                SalesShipLine.SETFILTER(Quantity, '<>0');
                NbLigneTotal := SalesShipLine.COUNT;
                SalesShipLine.SETRANGE(Type);
                IF SalesShipLine.FIND('-') THEN
                    CodeDEpotEntete := SalesShipLine."Location Code"
                ELSE
                    CodeDEpotEntete := '';

                NumLigne := 0;

                //- Total tabac alcool
                QtéAlcoolTotal := 0;
                QtéTabacTotal := 0;

                NumCopie := 0;
                // Modif C2A(LLE) 161104
                // suite demande Mme Danneels
                Cust.GET("Sales Shipment Header"."Bill-to Customer No.");
                Colonne3 := 'N° D''ACCISES :' + Cust."PWD No. d accises";
                /*
                //GTE
                Cust.GET ("Sales Shipment Header"."Bill-to Customer No.");
                IF ("Sales Shipment Header"."Call Type" = 'SHIPPING') OR ("Sales Shipment Header"."Shortcut Dimension 1 Code" = 'SEAFRANCE')  THEN
                  Colonne3:='N° D''ACCISES : DSA N° '+FORMAT ("Sales Shipment Header"."DSA No.") ELSE
                  Colonne3:='N° D''ACCISES :'+Cust."N° d'accises";
                */
                // Fin Modif
                /*IF "Sales Shipment Header"."Ship-to Country Code"<>'' THEN BEGIN
                  IF PaysDest.GET ("Sales Shipment Header"."Ship-to Country Code") THEN NomPaysDest := PaysDest.Name
                  ELSE
                  NomPaysDest:='FRANCE';
                END ELSE
                  NomPaysDest:='FRANCE';*/
                NomPaysDest := "Sales Shipment Header"."Ship-to Post Code" + ' ' + "Sales Shipment Header"."Ship-to City";

            end;

            trigger OnPreDataItem()
            begin
                // IDU-C2A le 21/03/05 modif du filtre à la demande de Mme Daneels
                // LocationFilter:='8|7VD|7CD|2';
                // IDU-C2A le 30/06/05 modif du filtre à la demande de Mme Nathalie Jankoviak
                // LocationFilter:='8|7VD|7CD';
                LocationFilter := '8|7VD|7CD|3|5S|10S|11S';
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
        TextExemplaire1 := 'Exemplaire à conserver par l''expéditeur';
        TextExemplaire2 := 'Exemplaire à conserver par le destinataire';
        TextExemplaire3 := 'Exemplaire à renvoyer à l''expéditeur';
        TextExemplaire4 := 'Exemplaire pour le pays de destination';
        TextExemplaire5 := 'Exemplaire destiné au bureau de départ';
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction();


        DepotSpecial := '8';

        IF USERID <> '' THEN
            UserTable.GET(USERID);

        If UserSetup.Get() then
            userSetup.CALCFIELDS("PWD Signing");
    end;

    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        PostedDocDim1: Record "Dimension Set Entry";
        PostedDocDim2: Record "Dimension Set Entry";
        Item: Record Item;
        Language: Record Language;
        ItemFamily: Record "PWD Family & Sub Family";
        ItemSubFamily: Record "PWD Family & Sub Family";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        SalesShipLine: Record "Sales Shipment Line";
        ShippingAgent: Record "Shipping Agent";
        UserSetup: record "User Setup";
        UserTable: Record "User Setup";
        FormatAddr: Codeunit "Format Address";
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        SegManagement: Codeunit SegManagement;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        ShowCustAddr: Boolean;
        BillToPostCode: Code[10];
        DepotSpecial: Code[10];
        SellToPostCode: Code[10];
        CodeDEpotEntete: Code[20];
        "QtéAlcool": Decimal;
        "QtéAlcoolTotal": Decimal;
        "QtéTabac": Decimal;
        "QtéTabacTotal": Decimal;
        TotalAlcoolPur: Decimal;
        TotalBiere: Decimal;
        TotalKgTabac: Decimal;
        TotalMillCig: Decimal;
        TotalPI: Decimal;
        TotalRhum: Decimal;
        TotalVin: Decimal;
        TotalVolEff: Decimal;
        VolumeEff: Decimal;
        Exemplaire: Integer;
        i: Integer;
        NbLigneTotal: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        NumCopie: Integer;
        NumLigne: Integer;
        ACaptionLbl: Label 'A';
        ALCOOL_PURCaptionLbl: Label 'ALCOOL PUR';
        AlcoolCaptionLbl: Label 'Alcool';
        Attestation__CaptionLbl: Label ' Attestation :';
        "Autorisation_accordée_par__autorité_compétente_Caption_Control1000000314Lbl": Label 'Autorisation accordée par (autorité compétente)';
        "Autorisation_accordée_par__autorité_compétente_CaptionLbl": Label 'Autorisation accordée par (autorité compétente)';
        BCaption_Control1000000312Lbl: Label 'B';
        BCaptionLbl: Label 'B';
        BIERECaptionLbl: Label 'BIERE';
        brut_kgCaptionLbl: Label 'brut kg';
        "Cases__1_22_certifiées_correctesCaptionLbl": Label 'Cases  1-22 certifiées correctes';
        CCaptionLbl: Label 'C';
        "Certificat_de_réceptionCaptionLbl": Label 'Certificat de réception';
        Changement_du_lieu_de_livraison__Caption_Control1000000313Lbl: Label 'Changement du lieu de livraison :';
        Changement_du_lieu_de_livraison__CaptionLbl: Label 'Changement du lieu de livraison :';
        Code_articleCaptionLbl: Label 'Code article';
        Code_produit_NCCaptionLbl: Label 'Code produit NC';
        COMMUNAUTE_EUROPEENNE___PRODUITS_SOUMIS_A_ACCISESCaption_Control1000000005Lbl: Label 'COMMUNAUTE EUROPEENNE - PRODUITS SOUMIS A ACCISES';
        COMMUNAUTE_EUROPEENNE___PRODUITS_SOUMIS_A_ACCISESCaptionLbl: Label 'COMMUNAUTE EUROPEENNE - PRODUITS SOUMIS A ACCISES';
        ControlesCaptionLbl: Label 'Controles';
        Date__Caption_Control1000000164Lbl: Label 'Date :';
        Date__CaptionLbl: Label ' Date :';
        "Date_d_expéditionCaption_Control1000000309Lbl": Label 'Date d''expédition';
        "Date_d_expéditionCaptionLbl": Label 'Date d''expédition';
        "Degrés_alcoolCaptionLbl": Label 'Degrés alcool';
        Depot_8___1Caption_Control1000000080Lbl: Label 'Depot 8 / 1';
        Depot_8___1CaptionLbl: Label 'Depot 8 / 1';
        Depot_8Caption_Control1000000082Lbl: Label 'Depot 8';
        Depot_8Caption_Control1000000083Lbl: Label 'Depot 8';
        Depot_8Caption_Control1000000084Lbl: Label 'Depot 8';
        Depot_8CaptionLbl: Label 'Depot 8';
        Description_marchandisesCaptionLbl: Label 'Description marchandises';
        "Désignation_des_produitsCaptionLbl": Label 'Désignation des produits';
        Destinataire___Caption_Control1000000030Lbl: Label 'Destinataire : ';
        Destinataire___CaptionLbl: Label 'Destinataire : ';
        DOCUMENT_COMMERCIAL__ACCOMP______DCA_Caption_Control1000000031Lbl: Label ' DOCUMENT COMMERCIAL. ACCOMP.    (DCA)';
        DOCUMENT_COMMERCIAL__ACCOMP______DCA_CaptionLbl: Label ' DOCUMENT COMMERCIAL. ACCOMP.    (DCA)';
        DOUANES______CALAIS_0074Caption_Control1000000026Lbl: Label 'DOUANES      CALAIS 0074';
        DOUANES______CALAIS_0074CaptionLbl: Label 'DOUANES      CALAIS 0074';
        "Durée_du_transportCaption_Control1000000306Lbl": Label 'Durée du transport';
        "Durée_du_transportCaptionLbl": Label 'Durée du transport';
        "En_cas_de_non_conformité___CaptionLbl": Label 'En cas de non conformité : ';
        "Entreprise_du_signataire_et_n__de_téléphoneCaptionLbl": Label 'Entreprise du signataire et n° de téléphone';
        Envoi_conformeCaptionLbl: Label 'Envoi conforme';
        Envoi_non_conformeCaptionLbl: Label 'Envoi non conforme';
        "Expéditeur___Caption_Control1000000029Lbl": Label 'Expéditeur : ';
        "Expéditeur___CaptionLbl": Label 'Expéditeur : ';
        EXPEDITEURCaption_Control1000000051Lbl: Label 'EXPEDITEUR';
        EXPEDITEURCaptionLbl: Label 'EXPEDITEUR';
        Garantie___Caption_Control1000000050Lbl: Label 'Garantie : ';
        Garantie___CaptionLbl: Label 'Garantie : ';
        Kg_TABACCaptionLbl: Label 'Kg TABAC';
        Lieu_de_livraison__Caption_Control1000000159Lbl: Label 'Lieu de livraison :';
        Lieu_de_livraison__CaptionLbl: Label 'Lieu de livraison :';
        Lieu_et_date_CaptionLbl: Label 'Lieu et date ';
        "Marchandises_excédantesCaptionLbl": Label 'Marchandises excédantes';
        Marchandises_manquantesCaptionLbl: Label 'Marchandises manquantes';
        "Marchandises_reçues_par_le_destinataireCaptionLbl": Label 'Marchandises reçues par le destinataire';
        MILLE_CIGARETTESCaptionLbl: Label 'MILLE CIGARETTES';
        N__de_document___Caption_Control1000000004Lbl: Label 'N° de document : ';
        N__de_document___CaptionLbl: Label ' N° de document : ';
        N__de_ligneCaptionLbl: Label 'N° de ligne';
        N__id__intracom___Caption_Control1000000237Lbl: Label 'N° id. intracom. :';
        N__id__intracom___CaptionLbl: Label 'N° id. intracom. :';
        N__TVA__Caption_Control1000000253Lbl: Label 'N° TVA :';
        N__TVA__CaptionLbl: Label 'N° TVA :';
        net_kgCaptionLbl: Label 'net kg';
        Nom_du_signataireCaptionLbl: Label 'Nom du signataire';
        Nombre_de_colisCaptionLbl: Label 'Nombre de colis';
        oCaption_Control1000000108Lbl: Label 'o';
        oCaption_Control1000000114Lbl: Label 'o';
        oCaptionLbl: Label 'o';
        "Pays_d_expédition__Caption_Control1000000266Lbl": Label 'Pays d''expédition :';
        "Pays_d_expédition__CaptionLbl": Label 'Pays d''expédition :';
        Pays_de_destination__Caption_Control1000000167Lbl: Label 'Pays de destination :';
        Pays_de_destination__CaptionLbl: Label 'Pays de destination :';
        PICaptionLbl: Label 'PI';
        PoidsCaption_Control1000000279Lbl: Label 'Poids';
        PoidsCaptionLbl: Label 'Poids';
        POUR_COMPTE__Caption_Control1000000255Lbl: Label 'POUR COMPTE :';
        POUR_COMPTE__CaptionLbl: Label 'POUR COMPTE :';
        "Pour_la_circulation_des_produits_soumis_à_accise_en_régime_de_suspension_Caption_Control1000000156Lbl": Label 'Pour la circulation des produits soumis à accise en régime de suspension.';
        "Pour_la_circulation_des_produits_soumis_à_accise_en_régime_de_suspension_CaptionLbl": Label 'Pour la circulation des produits soumis à accise en régime de suspension.';
        "Précision_sur_le_transport__Caption_Control1000000303Lbl": Label 'Précision sur le transport :';
        "Précision_sur_le_transport__CaptionLbl": Label 'Précision sur le transport :';
        "QuantitéCaption_Control1000000067Lbl": Label 'Quantité';
        "QuantitéCaptionLbl": Label 'Quantité';
        RECETTE_PRINCIPALE_DES_Caption_Control1000000033Lbl: Label 'RECETTE PRINCIPALE DES ';
        RECETTE_PRINCIPALE_DES_CaptionLbl: Label 'RECETTE PRINCIPALE DES ';
        "Représentant_fiscal___Caption_Control1000000272Lbl": Label 'Représentant fiscal : ';
        "Représentant_fiscal___CaptionLbl": Label 'Représentant fiscal : ';
        RHUMS_DOMCaptionLbl: Label 'RHUMS DOM';
        Signature_et_cachet__Caption_Control1000000315Lbl: Label 'Signature et cachet :';
        Signature_et_cachet__CaptionLbl: Label 'Signature et cachet :';
        SignatureCaptionLbl: Label 'Signature';
        TabacCaptionLbl: Label 'Tabac';
        Text000: Label 'Salesperson';
        Text001: Label 'COPY';
        Text003: Label 'Page %1';
        Transporteur___Caption_Control1000000300Lbl: Label 'Transporteur : ';
        Transporteur___CaptionLbl: Label 'Transporteur : ';
        "Unité_de_venteCaptionLbl": Label 'Unité de vente';
        V1Caption_Control1000000099Lbl: Label '1';
        V1CaptionLbl: Label '1';
        V2Caption_Control1000000100Lbl: Label '2';
        V2CaptionLbl: Label '2';
        V3_5Caption_Control1000000116Lbl: Label '3-5';
        V3_5CaptionLbl: Label '3-5';
        V4Caption_Control1000000115Lbl: Label '4';
        V4CaptionLbl: Label '4';
        V6Caption_Control1000000162Lbl: Label '6';
        V6CaptionLbl: Label '6';
        V7ACaption_Control1000000120Lbl: Label '7A';
        V7ACaptionLbl: Label '7A';
        V7Caption_Control1000000119Lbl: Label '7';
        V7CaptionLbl: Label '7';
        V8Caption_Control1000000121Lbl: Label '8';
        V8CaptionLbl: Label ' 8';
        V9Caption_Control1000000301Lbl: Label '9';
        V9CaptionLbl: Label '9';
        V10Caption_Control1000000122Lbl: Label '10';
        V10CaptionLbl: Label '10';
        V11Caption_Control1000000302Lbl: Label '11';
        V11CaptionLbl: Label '11';
        V12Caption_Control1000000118Lbl: Label '12';
        V12Caption_Control1000000161Lbl: Label '12';
        V12Caption_Control1000000265Lbl: Label '12';
        V12CaptionLbl: Label '12';
        V13Caption_Control1000000166Lbl: Label '13';
        V13CaptionLbl: Label '13';
        V14Caption_Control1000000273Lbl: Label '14';
        V14CaptionLbl: Label '14';
        V15Caption_Control1000000153Lbl: Label '15';
        V15CaptionLbl: Label '15';
        V16Caption_Control1000000308Lbl: Label '16';
        V16CaptionLbl: Label '16';
        V17Caption_Control1000000305Lbl: Label '17';
        V17CaptionLbl: Label '17';
        V18CaptionLbl: Label '18';
        V19CaptionLbl: Label '19';
        V20CaptionLbl: Label '20';
        V21CaptionLbl: Label '21';
        V22CaptionLbl: Label '22';
        V23cCaptionLbl: Label '23c';
        V24CaptionLbl: Label '24';
        VIN_Champ__MousseuxCaptionLbl: Label 'VIN/Champ./Mousseux';
        "Visa_à_réception_par_le_destinataireCaptionLbl": Label 'Visa à réception par le destinataire';
        Vl__En_LitreCaptionLbl: Label 'Vl. En Litre';
        VOL__EN_LITRECaptionLbl: Label 'VOL. EN LITRE';
        SalesPersonText: Text[20];
        BillToCity: Text[30];
        BillToCustaddr: Text[30];
        BillToCustaddr2: Text[30];
        BillToCustName: Text[30];
        ContactMag: Text[30];
        ExemplaireT: Text[30];
        LocationFilter: Text[30];
        ReferenceText: Text[30];
        SellToCity: Text[30];
        SellToCustaddr: Text[30];
        SellToCustaddr2: Text[30];
        SellToCustName: Text[30];
        Colonne3: Text[50];
        CompanyAddr: array[8] of Text[50];
        CopyText: Text[50];
        CustAddr: array[8] of Text[50];
        NomPaysDest: Text[50];
        ShipToAddr: array[8] of Text[50];
        TextExemplaire: Text[100];
        TextExemplaire1: Text[100];
        TextExemplaire2: Text[100];
        TextExemplaire3: Text[100];
        TextExemplaire4: Text[100];
        TextExemplaire5: Text[100];

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
    end;

    procedure CalcTotalVentil()
    var
        PoidsLigne: Decimal;
        VolumeLigne: Decimal;
    begin

        VolumeLigne := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)";
        PoidsLigne := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)";

        CLEAR(VolumeEff);
        Item.GET("Sales Shipment Line"."No.");

        IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family") THEN BEGIN
            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool THEN BEGIN
                VolumeEff := VolumeLigne;
                TotalVolEff += VolumeEff;
                IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family",
                                      Item."PWD Family", Item."PWD Sub Family") THEN BEGIN
                    IF ((Item."PWD Family" = '46') AND (Item."PWD Sub Family" = '02')) THEN TotalPI += VolumeLigne;
                    IF (Item."PWD Family" = '41') THEN TotalBiere += VolumeLigne;
                    IF (Item."PWD Family" IN ['43', '44', '45']) THEN TotalVin += VolumeLigne;

                END;
            END;
            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN BEGIN
                IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family",
                                      Item."PWD Family", Item."PWD Sub Family") THEN BEGIN
                    IF ((Item."PWD Family" = '48') AND (Item."PWD Sub Family" = '10')) THEN
                        //TotalMillCig += (("Sales Shipment Line"."Quantity (Base)" * 200)/1000);
                        // MODIF GTE DDE CHRISTINE 15 03
                        //TotalMillCig += (("Sales Shipment Line"."Gross Weight"));
                        TotalMillCig += (("Sales Shipment Line"."Net Weight" * "Sales Shipment Line".Quantity));
                    IF ((Item."PWD Family" = '48') AND (Item."PWD Sub Family" IN ['20', '30'])) THEN TotalKgTabac += PoidsLigne;
                END;
            END;
        END;
    end;

    procedure CalcTotalVentilSEAF()
    var
        PoidsLigne: Decimal;
        VolumeLigne: Decimal;
    begin
        VolumeLigne := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)";
        PoidsLigne := "Sales Shipment Line"."Net Weight" * "Sales Shipment Line"."Quantity (Base)";

        CLEAR(VolumeEff);
        Item.GET("Sales Shipment Line"."No.");

        IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family (Sea France)") THEN BEGIN
            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool THEN BEGIN
                VolumeEff := VolumeLigne;
                TotalVolEff += VolumeEff;
                IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family",
                                      Item."PWD Family (Sea France)", Item."PWD Sub Family (Sea France)") THEN BEGIN
                    IF ((Item."PWD Family (Sea France)" = '46') AND (Item."PWD Sub Family (Sea France)" = '02')) THEN TotalPI += VolumeLigne;
                    IF (Item."PWD Family (Sea France)" = '41') THEN TotalBiere += VolumeLigne;
                    IF (Item."PWD Family (Sea France)" IN ['43', '44', '45']) THEN TotalVin += VolumeLigne;

                END;
            END;
            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN BEGIN
                IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family",
                                      Item."PWD Family (Sea France)", Item."PWD Sub Family (Sea France)") THEN BEGIN
                    IF ((Item."PWD Family (Sea France)" = '48') AND (Item."PWD Sub Family (Sea France)" = '10')) THEN
                        //TotalMillCig += (("Sales Shipment Line"."Quantity (Base)" * 200)/1000);
                        //TotalMillCig += (("Sales Shipment Line"."Gross Weight"));
                        TotalMillCig += (("Sales Shipment Line"."Net Weight" * "Sales Shipment Line".Quantity));
                    IF ((Item."PWD Family (Sea France)" = '48') AND (Item."PWD Sub Family (Sea France)" IN ['20', '30'])) THEN TotalKgTabac += PoidsLigne;
                END;
            END;
        END;
    end;
}

