report 50103 "Sales - Shipment BL bac blanc"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/SalesShipmentBLbacblanc.rdl';
    Caption = 'Sales - Shipment BL bac blanc';
    UsageCategory = None;
    dataset
    {
        dataitem(copyLoop; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(2));
            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
                RequestFilterHeading = 'Posted Sales Shipment';
                column(BON_DE_LIVRAISON_; 'BON DE LIVRAISON')
                {
                }
                column(Sales_Shipment_Header__Sales_Shipment_Header__Reference; "Sales Shipment Header"."PWD Reference")
                {
                }
                column(Sales_Shipment_Header__Sales_Shipment_Header___Bill_to_Customer_No__; "Sales Shipment Header"."Bill-to Customer No.")
                {
                }
                column(Titre; Titre)
                {
                }
                column(Sales_Shipment_Header__Promised_Delivery_Date_; "Promised Delivery Date")
                {
                }
                column(Sales_Shipment_Header__Sales_Shipment_Header___Order_No__; "Sales Shipment Header"."Order No.")
                {
                }
                column(Sales_Shipment_Header___Sales_Shipment_Header___Posting_Date_; "Sales Shipment Header"."Posting Date")
                {
                }
                column(Sales_Shipment_Header__Sales_Shipment_Header___Ship_to_City_; "Sales Shipment Header"."Ship-to City")
                {
                }
                column(ShipToAddr_1_; ShipToAddr[1])
                {
                }
                column(ShippingAgent_Name; ShippingAgent.Name)
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
                column(Tel_______CompanyInfo__Phone_No__; 'Tel : ' + CompanyInfo."Phone No.")
                {
                }
                column(E_Mail_______CompanyInfo__E_Mail_; 'E-Mail : ' + CompanyInfo."E-Mail")
                {
                }
                column(au_Capital_de___CompanyInfo__Stock_Capital_; 'au Capital de ' + CompanyInfo."Stock Capital")
                {
                }
                column(Fax_______CompanyInfo__Fax_No__; 'Fax : ' + CompanyInfo."Fax No.")
                {
                }
                column(N__id__intracom_____CompanyInfo__VAT_Registration_No__; 'N° id. intracom : ' + CompanyInfo."VAT Registration No.")
                {
                }
                column(Sales_Shipment_Header__Sales_Shipment_Header___Bill_to_Name_; "Sales Shipment Header"."Bill-to Name")
                {
                }
                column(CompanyAddr_1_; CompanyAddr[1])
                {
                }
                column(Sales_Shipment_Header__Sales_Shipment_Header___No__; "Sales Shipment Header"."No.")
                {
                }
                column(CompanyInfo__Logo_AVITA_facture_; CompanyInfo."PWD Logo AVITA facture")
                {
                }
                column(Sales_Shipment_Header__Sales_Shipment_Header___Ship_to_Address_; "Sales Shipment Header"."Ship-to Address")
                {
                }
                column(Sales_Shipment_Header___Sales_Shipment_Header___Delivry_time_; "Sales Shipment Header"."PWD Delivry time")
                {
                }
                column(ADMIS_ET_RECONNU_CONFORME_LE_; 'ADMIS ET RECONNU CONFORME LE')
                {
                }
                column(FORMAT___Sales_Shipment_Header___Posting_Date__0_4_; FORMAT("Sales Shipment Header"."Posting Date", 0, 4))
                {
                }
                column(TotalPoidsNet; TotalPoidsNet)
                {
                }
                column(articles_sur_le_BL_n_________Sales_Shipment_Line___Document_No__; 'articles sur le BL n° : ' + SalesShipLine."Document No.")
                {
                }
                column(NbLigneTotal; NbLigneTotal)
                {
                }
                column(TotalQuantite; TotalQuantite)
                {
                }
                column(Destinataire___Caption; Destinataire___CaptionLbl)
                {
                }
                column(Date_livraisonCaption; Date_livraisonCaptionLbl)
                {
                }
                column(Date_de_doc__Caption; Date_de_doc__CaptionLbl)
                {
                }
                column(Lieu__Caption; Lieu__CaptionLbl)
                {
                }
                column(Emplacement__Caption; Emplacement__CaptionLbl)
                {
                }
                column(Commande_n____Caption; Commande_n____CaptionLbl)
                {
                }
                column(N__de_véhicule__Caption; N__de_véhicule__CaptionLbl)
                {
                }
                column(Navire__Caption; Navire__CaptionLbl)
                {
                }
                column(Armateur__Caption; Armateur__CaptionLbl)
                {
                }
                column(Destinataire___Caption_Control1000000043; Destinataire___Caption_Control1000000043Lbl)
                {
                }
                column(Transporteur___Caption; Transporteur___CaptionLbl)
                {
                }
                column(Expéditeur___Caption; Expéditeur___CaptionLbl)
                {
                }
                column("Référence_commande__Caption"; Référence_commande__CaptionLbl)
                {
                }
                column(N__de_document___Caption; N__de_document___CaptionLbl)
                {
                }
                column(Poids_net_ligneCaption; Poids_net_ligneCaptionLbl)
                {
                }
                column("QuantitéCaption"; QuantitéCaptionLbl)
                {
                }
                column("UnitéCaption"; UnitéCaptionLbl)
                {
                }
                column("DésignationCaption"; DésignationCaptionLbl)
                {
                }
                column(Code_articleCaption; Code_articleCaptionLbl)
                {
                }
                column(N__de_ligneCaption; N__de_ligneCaptionLbl)
                {
                }
                column(Heure_livraisonCaption; Heure_livraisonCaptionLbl)
                {
                }
                column(Caption; CaptionLbl)
                {
                }
                column(Par_procurationCaption; Par_procurationCaptionLbl)
                {
                }
                column(VisaCaption; VisaCaptionLbl)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1000000023; EmptyStringCaption_Control1000000023Lbl)
                {
                }
                column(A_Calais_leCaption; A_Calais_leCaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1000000014; EmptyStringCaption_Control1000000014Lbl)
                {
                }
                column(TOTAL_Poids_netCaption; TOTAL_Poids_netCaptionLbl)
                {
                }
                column("Arrété_àCaption"; Arrété_àCaptionLbl)
                {
                }
                column("TOTAL_QuantitéCaption"; TOTAL_QuantitéCaptionLbl)
                {
                }
                dataitem(BoucleMag; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Location Code", "PWD Shelf/Bin No.");
                        column(Entrepot_______LocationFilter_BoucleMag_Number______LocationName_BoucleMag_Number_; 'Entrepot : ' + LocationFilter[BoucleMag.Number] + ' ' + LocationName[BoucleMag.Number])
                        {
                        }
                        column(Sales_Shipment_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
                        {
                        }
                        column(Sales_Shipment_Line_Quantity; Quantity)
                        {
                        }
                        column(Sales_Shipment_Line_Shelf_Bin_No; "PWD Shelf/Bin No.")
                        {
                        }
                        column(Description__Description_2_; Description + "Description 2")
                        {
                        }
                        column(Sales_Shipment_Line__No__; "No.")
                        {
                        }
                        column(NumLigne; NumLigne)
                        {
                        }
                        column(Net_Weight__Quantity; "Net Weight" * Quantity)
                        {
                        }
                        column(TextDLC_SF; TextDLC_SF)
                        {
                        }
                        column(Sales_Shipment_Line_Description; Description)
                        {
                        }
                        column(Type_; Type)
                        {
                        }
                        column(Sales_Shipment_Header___Call_Type_; "Sales Shipment Header"."PWD Call Type")
                        {
                        }
                        column(Sales_Shipment_Line___Location_Code_; "Sales Shipment Line"."Location Code")
                        {
                        }
                        column(TextDLC_; TextDLC)
                        {
                        }
                        column(Item__Vendor_Item_No__; Item."Vendor Item No.")
                        {
                        }
                        column(Sales_Shipment_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Shipment_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            ItemTrackingMgt: Codeunit "Item Tracking Management";
                        begin
                            NewBinNo := FALSE;
                            DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Shipment Line"."Dimension Set ID");
                            IF ("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) AND
                               ("Sales Shipment Line".Quantity <> 0) THEN BEGIN
                                NumLigne := NumLigne + 1;
                                IF NOT Item.GET("Sales Shipment Line"."No.") THEN
                                    Item.INIT();
                            END;
                            CodeDEpotEntete := "Sales Shipment Line"."Location Code";
                            CodeSeaFrance := '';
                            IF "Sales Shipment Header"."Shortcut Dimension 1 Code" = 'SEAFRANCE' THEN
                                IF Type = Type::Item THEN
                                    IF Item.GET("No.") THEN CodeSeaFrance := Item."PWD SEAF Code";
                            IF LocationFilter[BoucleMag.Number] <> 'CML|1' THEN BEGIN
                                IF LocationFilter[BoucleMag.Number] = '9HCEE' THEN BEGIN
                                    IF Item."PWD No. sommier hors CEE" <> '' THEN
                                        CodeSommier := Item."PWD No. sommier hors CEE" ELSE
                                        CodeSommier := Item."PWD Base Customs No.";
                                END ELSE
                                    CodeSommier := Item."PWD Base Customs No.";
                            END ELSE
                                CodeSommier := '';
                            CLEAR(TextDLC);
                            ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
                            ItemEntryRelation.SETRANGE("Source Type", DATABASE::"Sales Shipment Line");
                            ItemEntryRelation.SETRANGE("Source Subtype", 0);
                            ItemEntryRelation.SETRANGE("Source ID", "Document No.");
                            ItemEntryRelation.SETRANGE("Source Batch Name", '');
                            ItemEntryRelation.SETRANGE("Source Prod. Order Line", 0);
                            ItemEntryRelation.SETRANGE("Source Ref. No.", "Line No.");
                            IF ItemEntryRelation.FIND('-') THEN
                                REPEAT
                                    ItemLedgEntry.GET(ItemEntryRelation."Item Entry No.");
                                    TextDLC := 'DLC : ' + FORMAT(ItemLedgEntry."Expiration Date");
                                UNTIL ItemEntryRelation.NEXT() = 0
                            ELSE
                                CLEAR(TextDLC);
                            NombreLigne := NombreLigne - 1;
                            IF NombreLigne = 0 THEN FinLigne := TRUE;
                            IF (LastBinNo <> '') AND ("Sales Shipment Line"."PWD Shelf/Bin No." <> LastBinNo) THEN
                                NewBinNo := TRUE;
                            LastBinNo := "Sales Shipment Line"."PWD Shelf/Bin No.";
                            IF "Sales Shipment Line".Type = "Sales Shipment Line".Type::Resource THEN
                                "Sales Shipment Line".Quantity := 0;
                            TotalPoidsNet := TotalPoidsNet + "Sales Shipment Line".Quantity * "Sales Shipment Line"."Net Weight";
                            TotalQuantite := TotalQuantite + "Sales Shipment Line".Quantity;
                            IF COPYSTR("Sales Shipment Line"."Location Code", 1, 1) = '7' THEN
                                TextDLC_SF := TextDLC
                            ELSE
                                CLEAR(TextDLC_SF);
                            IF TextDLC_SF = '' THEN
                                TextDLC_SF := Item."Vendor Item No.";

                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("Document No.", "Sales Shipment Header"."No.");
                            SETFILTER("Location Code", LocationFilter[BoucleMag.Number]);

                            IF LocationFilter[BoucleMag.Number] IN ['3', '5', '6'] THEN
                                DesAFD := 'AFD' ELSE
                                DesAFD := '';

                            IF LocationFilter[BoucleMag.Number] <> '7VL' THEN
                                NumDSA := "Sales Shipment Header"."PWD DSA No."
                            ELSE
                                NumDSA := '';

                            NombreLigne := "Sales Shipment Line".COUNT;
                            FinLigne := FALSE;
                            CLEAR(LastBinNo);

                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, TotalLocation);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");
                    IF NOT Call.GET("Sales Shipment Header"."PWD Call No.") THEN Call.INIT();
                    IF RespCenter.GET("Responsibility Center") THEN BEGIN
                        FormatAddr.RespCenter(CompanyAddr, RespCenter);
                        CompanyInfo."Phone No." := RespCenter."Phone No.";
                        CompanyInfo."Fax No." := RespCenter."Fax No.";
                    END ELSE BEGIN
                        CompanyInfo.GET();
                        FormatAddr.Company(CompanyAddr, CompanyInfo);
                        CompanyInfo.CALCFIELDS("PWD Logo AVITA facture", "PWD Logo ISSA");
                    END;
                    DimSetEntry1.SETRANGE("Dimension Set ID", "Sales Shipment Header"."Dimension Set ID");
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
                    //ToDo verifier
                    FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, "Sales Shipment Header");
                    ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                    FOR i := 1 TO ARRAYLEN(CustAddr) DO
                        IF CustAddr[i] <> ShipToAddr[i] THEN
                            ShowCustAddr := TRUE;

                    IF LogInteractionV THEN
                        IF NOT CurrReport.PREVIEW THEN
                            SegManagement.LogDocument(
                            5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                            '', "Posting Description", '');
                    IF NOT ShippingAgent.GET("Sales Shipment Header"."Shipping Agent Code") THEN
                        ShippingAgent.Name := '';
                    SalesShipLine.SETCURRENTKEY("Document No.", "Location Code");
                    SalesShipLine.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                    SalesShipLine.SETRANGE(Type, SalesShipLine.Type::Item);
                    SalesShipLine.SETFILTER("Location Code", '<>%1&<>%2', '', '7VL');
                    SalesShipLine.SETFILTER(Quantity, '<>0');
                    NbLigneTotal := SalesShipLine.COUNT;
                    SalesShipLine.SETRANGE(Type);
                    IF SalesShipLine.FIND('-') THEN
                        CodeDEpotEntete := SalesShipLine."Location Code"
                    ELSE
                        CodeDEpotEntete := '';
                    QtéAlcoolTotal := 0;
                    QtéTabacTotal := 0;

                    CLEAR(SalesShipLine);
                    SalesShipLine.SETCURRENTKEY("Document No.", "Location Code");
                    SalesShipLine.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                    SalesShipLine.SETRANGE(Type, SalesShipLine.Type::Item);
                    SalesShipLine.SETFILTER("Location Code", '<>%1', '');
                    SalesShipLine.SETFILTER(Quantity, '<>0');
                    SalesShipLine.FIND('-');
                    REPEAT
                        Item.GET(SalesShipLine."No.");
                        IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."Pwd Family") THEN BEGIN
                            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool THEN
                                IF Item."PWD Alcool %" <> 0 THEN BEGIN
                                    IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN
                                        QtéAlcoolTotal += SalesShipLine."Net Weight" * SalesShipLine."Quantity (Base)" / 100;
                                    IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net x °Alcool" THEN
                                        QtéAlcoolTotal += SalesShipLine."Net Weight" * SalesShipLine."Quantity (Base)" * Item."PWD Alcool %" / 100;
                                END;
                            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN
                                IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN
                                    QtéTabacTotal += SalesShipLine."Net Weight" * SalesShipLine."Quantity (Base)";
                        END;
                    UNTIL SalesShipLine.NEXT() = 0;

                    CLEAR(LocationFilter);
                    CLEAR(LocationName);
                    LocationFilter[1] := 'CML|1';
                    IF Location.GET('CML') THEN LOC1 := Location.Name;
                    IF Location.GET('1') THEN LOC2 := Location.Name;
                    LocationName[1] := LOC1 + '|' + LOC2;
                    j := 2;
                    CLEAR(SalesShipmentLine2);
                    CLEAR(LastLocation);
                    SalesShipmentLine2.SETRANGE("Document No.", "Sales Shipment Header"."No.");
                    SalesShipmentLine2.SETCURRENTKEY("Document No.", "Location Code", "PWD Shelf/Bin No.");
                    SalesShipmentLine2.SETFILTER("Location Code", '<>%1|%2|%3', 'CML', '1', '');
                    SalesShipmentLine2.SETFILTER(Quantity, '<>0');
                    IF SalesShipmentLine2.FIND('-') THEN
                        REPEAT
                            IF ((SalesShipmentLine2."Location Code" <> LastLocation) AND
                               (SalesShipmentLine2."Location Code" <> 'CML') AND
                               (SalesShipmentLine2."Location Code" <> '1') AND
                               (SalesShipmentLine2."Location Code" <> '')) THEN BEGIN
                                LocationFilter[j] := SalesShipmentLine2."Location Code";
                                Location.GET(SalesShipmentLine2."Location Code");
                                LocationName[j] := Location.Name;
                                LastLocation := SalesShipmentLine2."Location Code";
                                j += 1;
                            END;
                        UNTIL SalesShipmentLine2.NEXT() = 0;
                    TotalLocation := j - 1;
                    NumLigne := 0;
                    IF ("Sales Shipment Header"."PWD Call Type" = 'PO CAB') OR
                       ("Sales Shipment Header"."PWD Call Type" = 'SEAFR.CAB') THEN
                        Titre := 'CONSOMMATION A BORD';
                    IF ("Sales Shipment Header"."PWD Call Type" = 'PO VAE') OR
                       ("Sales Shipment Header"."PWD Call Type" = 'SEAFR.VAE') THEN
                        Titre := 'VENTE A EMPORTER';
                end;

                trigger OnPreDataItem()
                begin
                    TotalPoidsNet := 0;
                    TotalQuantite := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF copyLoop.Number IN [1 .. 3] THEN BEGIN
                    TextFooter1 := 'ADMIS ET RECONNU CONFORME';
                    TextFooter2 := 'BON A EMBARQUER';
                    TextFooter3 := 'DUNKERQUE LE : _ _ _ _ _ _ _ ';
                    TextFooter4 := 'VU EMBARQUER  _ _ _ _ _ _ _ _ ';
                END ELSE BEGIN
                    TextFooter1 := '';
                    TextFooter2 := '';
                    TextFooter3 := ' ';
                    TextFooter4 := 'Signature du bord :';
                END;

                CLEAR(NumLigne);
                if Number > 1 then begin
                    OutputNo += 1;
                end;
            end;

            trigger OnPreDataItem()
            begin
                TextLineFooter[1] := 'EXEMPLAIRE ORIGINAL - A CONSERVER';
                TextLineFooter[2] := 'EXEMPLAIRE A RETOURNER AU SERVICE DOUANE AVITA';
                TextLineFooter[3] := 'EXEMPLAIRE A RETOURNER AU BUREAU DOUANE DE DUNKERQUE PORT OUEST 59279 LOON PLAGE';
                TextLineFooter[4] := 'EXEMPLAIRE A REMETTRE A BORD - STEWARD''S RECEIPT';
                TextLineFooter[5] := 'DUPLICATA A NOUS RETOURNER SIGNE - DUPLICATA TO BE RETURNED DULY SIGNED';
                OutputNo := 1;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Option")
                {
                    Caption = 'Option';
                    field(NoOfCopies; NoOfCopiesV)
                    {
                        ApplicationArea = all;
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfoV)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteractionV)
                    {
                        ApplicationArea = all;
                        Caption = 'Log Interaction';
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Correction Lines';
                    }
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

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction();
        DepotSpecial := '8';
        If UserSetup.Get() then
            UserSetup.CALCFIELDS("PWD Signing");
    end;

    var
        CompanyInfo: Record "Company Information";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Item: Record Item;
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgEntry: Record "Item Ledger Entry";
        Location: Record Location;
        Call: Record "PWD Call";
        ItemFamily: Record "PWD Family & Sub Family";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        SalesShipLine: Record "Sales Shipment Line";
        SalesShipmentLine2: Record "Sales Shipment Line";
        ShippingAgent: Record "Shipping Agent";
        UserSetup: record "User Setup";
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        FinLigne: Boolean;
        LogInteractionV: Boolean;
        NewBinNo: Boolean;
        ShowCorrectionLines: Boolean;
        ShowCustAddr: Boolean;
        ShowInternalInfoV: Boolean;
        DepotSpecial: Code[10];
        DesAFD: Code[10];
        LastBinNo: Code[10];
        LastLocation: Code[10];
        CodeDEpotEntete: Code[20];
        CodeSeaFrance: Code[20];
        CodeSommier: Code[20];
        NumDSA: Code[20];
        "QtéAlcoolTotal": Decimal;
        "QtéTabacTotal": Decimal;
        TotalPoidsNet: Decimal;
        TotalQuantite: Decimal;
        i: Integer;
        j: Integer;
        NbLigneTotal: Integer;
        NombreLigne: Integer;
        NoOfCopiesV: Integer;
        NumLigne: Integer;
        OutputNo: Integer;
        TotalLocation: Integer;
        A_Calais_leCaptionLbl: Label 'A Calais le';
        Armateur__CaptionLbl: Label 'Client :';
        "Arrété_àCaptionLbl": Label 'Arrété à';
        CaptionLbl: Label 'S.A.S. GHESQUIERS JPG';
        Code_articleCaptionLbl: Label 'Code article';
        Commande_n____CaptionLbl: Label 'Commande n° :   ';
        Date_de_doc__CaptionLbl: Label 'Date de doc.:';
        Date_livraisonCaptionLbl: Label 'Date livraison';
        "DésignationCaptionLbl": Label 'Désignation';
        Destinataire___Caption_Control1000000043Lbl: Label 'Destinataire : ';
        Destinataire___CaptionLbl: Label 'Destinataire : ';
        Emplacement__CaptionLbl: Label 'Ref :';
        EmptyStringCaption_Control1000000014Lbl: Label ' : ';
        EmptyStringCaption_Control1000000023Lbl: Label ' : ';
        EmptyStringCaptionLbl: Label ' : ';
        "Expéditeur___CaptionLbl": Label 'Expéditeur : ';
        Heure_livraisonCaptionLbl: Label 'Heure livraison';
        Lieu__CaptionLbl: Label 'Lieu :';
        N__de_document___CaptionLbl: Label 'N° de document : ';
        N__de_ligneCaptionLbl: Label 'N° de ligne';
        "N__de_véhicule__CaptionLbl": Label 'N° de véhicule :';
        Navire__CaptionLbl: Label 'Navire :';
        Par_procurationCaptionLbl: Label 'Par procuration';
        Poids_net_ligneCaptionLbl: Label 'Poids net ligne';
        "QuantitéCaptionLbl": Label 'Quantité';
        "Référence_commande__CaptionLbl": Label 'Référence commande :';
        Text000: Label 'Salesperson';
        TOTAL_Poids_netCaptionLbl: Label 'TOTAL Poids net';
        "TOTAL_QuantitéCaptionLbl": Label 'TOTAL Quantité';
        Transporteur___CaptionLbl: Label 'Transporteur : ';
        "UnitéCaptionLbl": Label 'Unité';
        VisaCaptionLbl: Label 'Visa';
        SalesPersonText: Text[20];
        LOC1: Text[30];
        LOC2: Text[30];
        LocationFilter: array[20] of Text[30];
        ReferenceText: Text[30];
        TextDLC: Text[30];
        TextDLC_SF: Text[30];
        Titre: Text[30];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        LocationName: array[20] of Text[60];
        TextFooter1: Text[80];
        TextFooter2: Text[80];
        TextFooter3: Text[80];
        TextFooter4: Text[80];
        TextLineFooter: array[5] of Text[80];
        CustAddr: array[8] of Text[100];

    procedure InitLogInteraction()
    begin
        LogInteractionV := SegManagement.FindInteractTmplCode(5) <> '';
    end;
}