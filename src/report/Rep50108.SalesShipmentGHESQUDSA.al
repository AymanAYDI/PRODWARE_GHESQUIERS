report 50108 "Sales - Shipment GHESQU-DSA"
{
    Caption = 'Sales - Shipment';
    RDLCLayout = './src/report/rdl/SalesShipmentGHESQUDSA.rdl';

    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';
            column(SalesShipmentHeaderNo; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = True;
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    PrintOnlyIfDetail = True;
                    column(PageCaption; Text003)
                    {
                    }
                    column(ExemplaireT; ExemplaireT)
                    {
                    }

                    column(FournisseurCaption; 'Fournisseur : ')
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(ShippingAgentCode; SalesShipmentHeader."Shipping Agent Code")
                    {
                    }
                    column(TransporteurCaption; 'Transporteur : ')
                    {
                    }
                    column(DureetransportCaption; 'Durée du transport')
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(NAccisesTxt; 'N° Accises : FR012074E1077')
                    {
                    }
                    column(ShippingTime; SalesShipmentHeader."Shipping Time")
                    {
                    }
                    column(DestinataireCaption; 'Destinataire : ')
                    {
                    }
                    column(PostingDate; SalesShipmentHeader."Posting Date")
                    {
                    }
                    column(DateexpeditionCaption; 'Date d''expédition')
                    {
                    }
                    column(ShipmentNoCaption; 'Shipment No.')
                    {
                    }
                    column(NdocumentCaption; 'N° de document : ')
                    {
                    }
                    column(Depot81Caption; 'Depot 8 / 1')
                    {
                    }
                    column(FRANCECaption; ' - FRANCE')
                    {
                    }
                    column(Colonne3; Colonne3)
                    {
                    }
                    column(TextExemplaire; TextExemplaire)
                    {
                    }
                    column(Txt1; Txt1)
                    {
                    }
                    column(Txt2; Txt2)
                    {
                    }
                    column(Txt3; Txt3)
                    {
                    }
                    column(Txt4; Txt4)
                    {
                    }
                    column(Txt5; Txt5)
                    {
                    }
                    column(Txt6; Txt6)
                    {
                    }
                    column(Txt7; Txt7)
                    {
                    }
                    column(Txt8; Txt8)
                    {
                    }
                    column(Txt9; Txt9)
                    {
                    }
                    column(Txt10; Txt10)
                    {
                    }

                    column(Txt11; Txt11)
                    {
                    }

                    column(Txt12; Txt12)
                    {
                    }
                    column(DateCaption; 'Date : ')
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
                    column(BillToPostCode; BillToPostCode)
                    {
                    }
                    column(CommunauteEurpCaption; 'COMMUNAUTE EUROPEENNE - ACCISES')
                    {
                    }
                    column(DocumentSimplifieCaption; 'DOCUMENT SIMPLIFIE D''ACCOMPAGNEMENT')
                    {
                    }
                    column(CirculationIntraCaption; 'CIRCULATION INTRA-COMMUNAUTAIRE-PRODUITS DEJA MIS A LA CONSOMMATION')
                    {
                    }
                    column(TextExemplaire1; TextExemplaire1)
                    {
                    }
                    column(LieulivraisonCaption; 'Lieu de livraison : ')
                    {
                    }
                    column(BillToCity; BillToCity)
                    {
                    }
                    column(ShipToCustName; ShipToCustName)
                    {
                    }
                    column(ShipToCustaddr; ShipToCustaddr)
                    {
                    }
                    column(ShipToCustaddr2; ShipToCustaddr2)
                    {
                    }
                    column(ShipToPostCode; ShipToPostCode)
                    {
                    }
                    column(ShipToCity; ShipToCity)
                    {
                    }
                    column(NumeroreferenceCaption; 'Numéro de référence ')
                    {
                    }
                    column(AutoritecompetenteCaption; 'Autorité compétente du pays de destination')
                    {
                    }
                    column(TxtO; TxtO)
                    {
                    }
                    column(NomAdresseCaption; '(Nom et adresse)')
                    {
                    }
                    column(VATRegistrationNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(NoTVA; 'N° de TVA :')
                    {
                    }
                    column(PourCOMPTECaption; 'POUR COMPTE ' + text1)
                    {
                    }
                    column(CustVATRegistrationNo; 'N° de TVA: ' + Cust."VAT Registration No.")
                    {
                    }
                    column(RecettePrinciCaption; 'RECETTE PRINCIPALE DES DOUANES CALAIS 0074')
                    {
                    }
                    column(transName; trans.Name)
                    {
                    }
                    column(provtrans; provtrans)
                    {
                    }
                    column(NodateDeclaration; 'N° et date de la déclaration')
                    {
                    }
                    column(DesignationProdCaption; 'Désignation des produits')
                    {
                    }
                    column(CodearticleCaption; 'Code article')
                    {
                    }
                    column(NLigneCaption; 'N° de ligne')
                    {
                    }
                    column(NombreEmballageCaption; 'Nombre d''emballage')
                    {
                    }
                    column(TypeEmballageCaption; 'Type d''emballage')
                    {
                    }
                    column(PoidsbrutKgCaption; 'Poids brut Kg')
                    {
                    }
                    column(PoidsnetKgCaption; 'Poids net Kg')
                    {
                    }
                    column(Depot8Caption; 'Depot 8')
                    {
                    }
                    column(AlcoolCaption; 'Alcool %')
                    {
                    }
                    column(QuantiteCaption; 'Quantité')
                    {
                    }
                    column(TabacCaption; 'Tabac')
                    {
                    }
                    column(AlcoolCaption2; 'Alcool')
                    {
                    }
                    column(VolEffectifCaption2; 'Vol Effectif')
                    {
                    }
                    column(CodeproduitNCCaption; 'Code produit NC')
                    {
                    }
                    dataitem(SalesShipmentLine; "Sales Shipment Line")
                    {
                        DataItemTableView = SORTING("Document No.", "Location Code") WHERE(Quantity = FILTER(<> 0));
                        DataItemLinkReference = SalesShipmentHeader;
                        DataItemLink = "Document No." = FIELD("No.");
                        column(NumLigne; FORMAT(NumLigne) + '/' + FORMAT(NbLigneTotal))
                        {
                        }
                        column(SalesShipmentLineNo; "No.")
                        {
                        }
                        column(SalesShipmentLineType; Type.AsInteger())
                        {
                        }
                        column(DescriptionTotale; DescriptionTotale)
                        {
                        }
                        column(UnitMeasureCode; "Unit of Measure Code")
                        {
                        }
                        column(QuantityBase; "Quantity (Base)")
                        {
                        }
                        column(GrossWeight; "Gross Weight" * "Quantity (Base)")
                        {
                        }
                        column(NetWeight; "Net Weight" * "Quantity (Base)")
                        {
                        }
                        column(AlcoolItem; Item."PWD Alcool %")
                        {
                        }
                        column(VolumeEff; VolumeEff)
                        {
                        }
                        column(QtéAlcool; QtéAlcool)
                        {
                        }
                        column(QtéTabac; QtéTabac)
                        {
                        }
                        column(TariffNo; Item."Tariff No.")
                        {
                        }
                        column(Description; Description)
                        {
                        }
                        column(TotalPI; TotalPI)
                        {
                        }
                        column(TotalBiere; TotalBiere)
                        {
                        }
                        column(TotalVin; TotalVin)
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
                        column(PICaption; 'PI')
                        {
                        }
                        column(BIERECaption; 'BIERE')
                        {
                        }
                        column(VINChampMousseuxCap; 'VIN/Champ./Mousseux')
                        {
                        }
                        column(VOLEFFECTIFCaption; 'VOL.EFFECTIF')
                        {
                        }
                        column(MilleCigaCaption; 'MILLE CIGARETTES')
                        {
                        }
                        column(KgTabacCaption; 'Kg TABAC')
                        {
                        }
                        column(AlcoolPurCaption; 'ALCOOL PUR')
                        {
                        }
                        column(RhumsDomCaption; 'RHUMS DOM')
                        {
                        }
                        column(LitresCaption; 'LITRES')
                        {
                        }
                        column(PrixfactValCaption; 'Prix de facture/Valeur commerciale')
                        {
                        }
                        column(prixfact; prixfact)
                        {
                        }
                        column(Signing; UserRec."PWD Signing")
                        {
                        }
                        column(ACaption; 'A')
                        {
                        }
                        column(Txt15; Txt15)
                        {
                        }
                        column(Cases113Caption; 'Cases  1-13 certifiées correctes')
                        {
                        }
                        column(EntrepriseSignataireCaption; 'Entreprise du signataire et n° de téléphone')
                        {
                        }
                        column(Tel; 'TEL   ' + CompanyInfo."Phone No.")
                        {
                        }
                        column(NomsignataireCaption; 'Nom du signataire')
                        {
                        }
                        column(LieudateCaption; 'Lieu et date ')
                        {
                        }
                        column(SignatureCaption; 'Signature')
                        {
                        }
                        column(UserTableName; UserTable."Full Name")
                        {
                        }
                        column(CompanyInfoCityCaption; CompanyInfo.City + '   Le ' + FORMAT(SalesShipmentHeader."Posting Date", 0, 4))
                        {
                        }
                        column(Contrôleautoritéscaption; 'Contrôles par les autorités compétentes')
                        {
                        }
                        column(Renvoi3iemeCaption; 'Renvoi du 3ième exemplaire demandé')
                        {
                        }
                        column(ouiCaption; 'oui')
                        {
                        }
                        column(nonCaption; 'non')
                        {
                        }
                        column(Txt14; Txt14)
                        {
                        }
                        column(Txt13; Txt13)
                        {
                        }
                        column(AttestationsCaption; 'Attestations (relatives à certains vins et alcools,petites brasseries et distilleries)')
                        {
                        }
                        column(NoOfCopies; 'No. of Copies')
                        {
                        }
                        column(ShowInternalInfo; 'Show Internal Information')
                        {
                        }
                        column(LogInteraction; 'Log Interaction')
                        {
                        }
                        column(ShowCorrectionLines; 'Show Correction Lines')
                        {
                        }
                        column(LocationFilter; 'Filtre Code magasin')
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            //MoreLines := FIND('+');
                            //WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                            //  MoreLines := NEXT(-1) <> 0;
                            //IF NOT MoreLines THEN
                            //  CurrReport.BREAK;
                            //SETRANGE("Line No.",0,"Line No.");

                            SETFILTER("Location Code", LocationFilter);

                            //Ajout AMI - C2A - 22/04/05 BEGIN

                            //CurrReport.CREATETOTALS(MontantLigne);
                            CurrReport.CREATETOTALS(prixfact);
                            CurrReport.CREATETOTALS(prixdouane);

                            //- Ajout AMI - C2A - 22/04/05 END
                        end;

                        trigger OnAfterGetRecord()
                        begin
                            IF NOT ShowCorrectionLines AND Correction THEN
                                CurrReport.SKIP();
                            PostedDocDim1.SETRANGE("Dimension Set ID", SalesShipmentLine."Dimension Set ID");

                            IF SalesShipmentLine.Type = SalesShipmentLine.Type::Item THEN BEGIN
                                NumLigne := NumLigne + 1;
                                IF NOT Item.GET(SalesShipmentLine."No.") THEN
                                    Item.INIT();
                            END;

                            CodeDEpotEntete := SalesShipmentLine."Location Code";

                            // Calcul total tabac alcool
                            QtéAlcool := 0;
                            QtéTabac := 0;
                            IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family") THEN
                                IF ((ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool) AND (Item."PWD Family" = '47')) THEN
                                    IF Item."PWD Alcool %" <> 0 THEN
                                        IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN
                                            QtéAlcool := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)" / 100;
                            IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net x °Alcool" THEN
                                QtéAlcool := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)" * Item."PWD Alcool %" / 100;
                            IF ((Item."PWD Family" = '47') AND (Item."PWD Sub Family" <> '05')) THEN TotalAlcoolPur += QtéAlcool;
                            IF ((Item."PWD Family" = '47') AND (Item."PWD Sub Family" = '05')) THEN TotalRhum += QtéAlcool;

                            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN
                                IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN
                                    QtéTabac := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)";
                            QtéAlcoolTotal := QtéAlcoolTotal + QtéAlcool;
                            QtéTabacTotal := QtéTabacTotal + QtéTabac;

                            CalcTotalVentil();

                            // ** Calcul total tabac alcool SEA FRANCE **
                            //>>P3346_0011
                            //IF Item.Family='SE' THEN BEGIN
                            //<<P3346_0011

                            //>> 02/06/2014 SU-DADE cf appel TI227779 + TI228784
                            IF (Item."PWD Family" = 'SE')
                              OR (Item."PWD Family" = 'MFL') THEN BEGIN
                                //<< 02/06/2014 SU-DADE cf appel TI227779 + TI228784
                                QtéAlcool := 0;
                                QtéTabac := 0;

                                IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family (Sea France)") THEN
                                    IF ((ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool) AND (Item."PWD Family (Sea France)" = '47')) THEN
                                        IF Item."PWD Alcool %" <> 0 THEN
                                            IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN
                                                QtéAlcool := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)" / 100;
                                IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net x °Alcool" THEN
                                    QtéAlcool := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)" * Item."PWD Alcool %" / 100;
                                IF ((Item."PWD Family (Sea France)" = '47') AND (Item."PWD Sub Family (Sea France)" <> '05')) THEN TotalAlcoolPur += QtéAlcool;
                                IF ((Item."PWD Family (Sea France)" = '47') AND (Item."PWD Sub Family (Sea France)" = '05')) THEN TotalRhum += QtéAlcool;


                                IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN
                                    IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN
                                        QtéTabac := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)";
                                QtéAlcoolTotal := QtéAlcoolTotal + QtéAlcool;
                                QtéTabacTotal := QtéTabacTotal + QtéTabac;

                                CalcTotalVentilSEAF();
                                //>>P3346_0011
                                //END;
                                //<<P3346_0011
                                //>> 02/06/2014 SU-DADE cf appel TI227779
                            END;
                            //<< 02/06/2014 SU-DADE cf appel TI227779
                            DescriptionTotale := SalesShipmentLine.Description + SalesShipmentLine."Description 2";

                            //Ajout AMI - C2A - 22/04/05 BEGIN

                            //MontantLigne:="Sales Shipment Line"."Line Amount";
                            prixfact := SalesShipmentLine."PWD Line Amount";
                            prixdouane := SalesShipmentLine."PWD Valeur douane (correction)" * SalesShipmentLine."Quantity (Base)";


                            IF NOT Call.GET(SalesShipmentLine."PWD Call No.") THEN
                                Call.INIT()
                                ;
                            IF SalesShipmentHeader."PWD Call No." <> '' THEN
                                IF Call."DSA 13" = Call."DSA 13"::"Valeur Facture" THEN
                                    prixfact := SalesShipmentLine."PWD Line Amount" ELSE
                                    IF Call."DSA 13".AsInteger() = 1 THEN
                                        prixfact := prixdouane;
                            IF SalesShipmentHeader."PWD Call No." = '' THEN
                                prixfact := SalesShipmentLine."PWD Line Amount";


                            //Ajout AMI - C2A - 22/04/05 END

                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        NumLigne := 0;

                        // Calcul total tabac alcool
                        QtéAlcoolTotal := 0;
                        QtéTabacTotal := 0;

                        //Ajout AMI - C2A - 22/04/05 BEGIN

                        CompanyInfo.GET(CompanyInfo."Primary Key");
                        IF NOT trans.GET(SalesShipmentHeader."Shipping Agent Code") THEN
                            trans.INIT();
                        IF trans."PWD Ville" <> '' THEN
                            provtrans := trans."PWD Ville" ELSE
                            provtrans := trans."PWD Pays";

                        //Ajout AMI - C2A - 22/04/05 END
                    end;
                }
                trigger OnPreDataItem()
                begin
                    NoOfLoops := 3 * (1 + ABS(NoOfCopies));
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;

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

                    NumCopie := ROUND(Number / 4, 1, '>');
                    Exemplaire := Number - ((NumCopie - 1) * 4);


                    CASE Exemplaire OF
                        1:
                            BEGIN
                                TextExemplaire := TextExemplaire1;
                                ExemplaireT := '1';
                            END;
                        2:
                            BEGIN
                                TextExemplaire := TextExemplaire2;
                                ExemplaireT := '2';
                            END;
                        3:
                            BEGIN

                                TextExemplaire := TextExemplaire3;
                                ExemplaireT := '3';
                            END;
                        4:
                            BEGIN

                                TextExemplaire := TextExemplaire4;
                                ExemplaireT := '4';
                            END;

                    END;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        ShptCountPrinted.RUN(SalesShipmentHeader);
                end;

            }
            trigger OnPreDataItem()
            begin
                // IDU-C2A le 21/03/05 modif du filtre … la demande de Mme Daneels
                // LocationFilter:='8|7VD|7CD|2';
                LocationFilter := '2|8';
            end;

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
                Cust.GET(SalesShipmentHeader."Bill-to Customer No.");
                BillToCity := "Bill-to City";
                // fin modif LLE
                // Modif C2A(LLE)
                ShipToCustName := "Ship-to Name";
                ShipToCustaddr := "Ship-to Address";
                ShipToCustaddr2 := "Ship-to Address 2";
                ShipToPostCode := "Ship-to Post Code";
                ShipToCity := "Ship-to City";

                // fin Modif C2A(LLE)

                CurrReport.LANGUAGE := Language.GetLanguageIdOrDefault("Language Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE BEGIN
                    CompanyInfo.GET();
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                END;
                PostedDocDim1.SETRANGE("Dimension Set ID", SalesShipmentHeader."Dimension Set ID");

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
                FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);

                FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
                ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                FOR i := 1 TO ARRAYLEN(CustAddr) DO
                    IF CustAddr[i] <> ShipToAddr[i] THEN
                        ShowCustAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code", '', "Posting Description", '');

                //*** Recherche du nom du transporteur
                IF NOT ShippingAgent.GET(SalesShipmentHeader."Shipping Agent Code") THEN
                    ShippingAgent.Name := '';

                //*** Calcul du nombre de ligne article total / doc
                SalesShipLine.SETCURRENTKEY("Document No.", "Location Code");
                SalesShipLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
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

                // Modif C2A(LLE) 16/11/04
                // suite demande Mme Danneels
                Cust.GET(SalesShipmentHeader."Bill-to Customer No.");
                Colonne3 := 'N° D''ACCISES :' + Cust."PWD No. d accises";
                // Fin Modif

                NomPaysDest := SalesShipmentHeader."Ship-to Post Code" + ' ' + SalesShipmentHeader."Ship-to City";

                //AMI - C2A - 22/04/05 BEGIN

                ligneExpeEnreg.RESET();
                ligneExpeEnreg.SETRANGE("Document No.", SalesShipmentHeader."No.");
                ligneExpeEnreg.SETFILTER("Location Code", LocationFilter);
                IF ligneExpeEnreg.FIND('-') THEN BEGIN
                    Location.GET(ligneExpeEnreg."Location Code");
                    text1 := Location.Contact;
                END;
                //AMI - C2A - 22/04/05 END
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        TextExemplaire1 := 'Exemplaire à conserver par le fournisseur';
        TextExemplaire2 := 'Exemplaire à conserver par le destinataire';
        TextExemplaire3 := 'Exemplaire à renvoyer au fournisseur';
        // IDU-C2A le 21/03/05 modif du filtre à la demande de Mme Daneels
        // LocationFilter:='8|7VD|7CD|2';
        //>>TI117138
        // LocationFilter:='2|8|5A|10A|11A|5S|10S|11S';

        //>>P3346_0011
        //    LocationFilter:='1|11A|11S|12|12A|13|13S|2|4CCRD|4CL|7CABA|7CABL|7CCRD|7CD|7CL|7VAEA|7VAEL|7VCRD|7VD|7VL|8|9|9NCCE|'+
        //                     'CML|GRATUIT|MADT';
        //<<P3346_0011

        //<<TI117138
    end;

    trigger OnPreReport()
    var
        USID: Guid;
    begin
        IF NOT CurrReport.UseRequestPage THEN
            InitLogInteraction();


        DepotSpecial := '8';
        USID := Database.UserSecurityId();
        //IF USID <> '' THEN
        UserTable.GET(USID);

        UserRec.GET(USERID);
        UserRec.CALCFIELDS("PWD Signing");
    END;

    PROCEDURE InitLogInteraction();
    BEGIN
        LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
    END;

    PROCEDURE CalcTotalVentil();
    VAR
        VolumeLigne: Decimal;
        PoidsLigne: Decimal;
    BEGIN
        VolumeLigne := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)";
        PoidsLigne := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)";

        CLEAR(VolumeEff);
        Item.GET(SalesShipmentLine."No.");

        IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family") THEN
            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool THEN BEGIN
                VolumeEff := VolumeLigne;
                TotalVolEff += VolumeEff;
                IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family", Item."PWD Family", Item."PWD Sub Family") THEN BEGIN
                    IF ((Item."PWD Family" = '46') AND (Item."PWD Sub Family" = '02')) THEN TotalPI += VolumeLigne;
                    IF (Item."PWD Family" = '41') THEN TotalBiere += VolumeLigne;
                    IF (Item."PWD Family" IN ['43', '44', '45']) THEN TotalVin += VolumeLigne;

                END;
            END;
        IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN
            IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family",
                                  Item."PWD Family", Item."PWD Sub Family") THEN
                IF ((Item."PWD Family" = '48') AND (Item."PWD Sub Family" = '10')) THEN
                    //TotalMillCig += (("Sales Shipment Line"."Quantity (Base)" * 200)/1000);
                    // MODIF GTE DDE CHRISTINE 15 03
                    //TotalMillCig += (("Sales Shipment Line"."Gross Weight"));
                    TotalMillCig += ((SalesShipmentLine."Net Weight" * SalesShipmentLine.Quantity));
        IF ((Item."PWD Family" = '48') AND (Item."PWD Sub Family" IN ['20', '30'])) THEN TotalKgTabac += PoidsLigne;
    END;

    PROCEDURE CalcTotalVentilSEAF();
    VAR
        VolumeLigne: Decimal;
        PoidsLigne: Decimal;
    BEGIN
        VolumeLigne := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)";
        PoidsLigne := SalesShipmentLine."Net Weight" * SalesShipmentLine."Quantity (Base)";

        CLEAR(VolumeEff);
        Item.GET(SalesShipmentLine."No.");

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
            IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN
                IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family", Item."PWD Family (Sea France)", Item."PWD Sub Family (Sea France)") THEN
                    IF ((Item."PWD Family (Sea France)" = '48') AND (Item."PWD Sub Family (Sea France)" = '10')) THEN
                        IF ((Item."PWD Family (Sea France)" = '48') AND (Item."PWD Sub Family (Sea France)" = '10')) THEN
                            //TotalMillCig += (("Sales Shipment Line"."Quantity (Base)" * 200)/1000);
                            //TotalMillCig += (("Sales Shipment Line"."Gross Weight"));
                            TotalMillCig += ((SalesShipmentLine."Net Weight" * SalesShipmentLine.Quantity));
            IF ((Item."PWD Family (Sea France)" = '48') AND (Item."PWD Sub Family (Sea France)" IN ['20', '30'])) THEN TotalKgTabac += PoidsLigne;
        END;
    END;


    VAR
        Text000: Label 'Salesperson';
        Text001: Label 'COPY';
        Text002: Label 'Sales - Shipment %1';
        Text003: Label 'Page ';
        SalesPurchPerson: Record 13;
        CompanyInfo: Record 79;
        PostedDocDim1: Record "Dimension Set Entry";
        PostedDocDim2: Record "Dimension Set Entry";
        Language: Codeunit Language;
        ShptCountPrinted: Codeunit 314;
        SegManagement: Codeunit 5051;
        RespCenter: Record 5714;
        CustAddr: ARRAY[8] OF Text[100];
        ShipToAddr: ARRAY[8] OF Text[50];
        CompanyAddr: ARRAY[8] OF Text[50];
        SalesPersonText: Text[20];
        ReferenceText: Text[30];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[50];
        ShowCustAddr: Boolean;
        i: Integer;
        FormatAddr: Codeunit 365;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        DepotSpecial: Code[10];
        ShippingAgent: Record 291;
        NumLigne: Integer;
        NbLigneTotal: Integer;
        SalesShipLine: Record 111;
        Item: Record 27;
        CodeDEpotEntete: Code[20];
        QtéAlcool: Decimal;
        QtéTabac: Decimal;
        QtéAlcoolTotal: Decimal;
        QtéTabacTotal: Decimal;
        ItemFamily: Record 50008;
        Exemplaire: Integer;
        NumCopie: Integer;
        UserTable: Record "User";
        TextExemplaire: Text[100];
        TextExemplaire1: Text[100];
        TextExemplaire2: Text[100];
        TextExemplaire3: Text[100];
        TextExemplaire4: Text[100];
        Colonne3: Text[50];
        Cust: Record 18;
        VolumeEff: Decimal;
        TotalPI: Decimal;
        TotalBiere: Decimal;
        TotalVin: Decimal;
        TotalVolEff: Decimal;
        TotalMillCig: Decimal;
        TotalKgTabac: Decimal;
        TotalAlcoolPur: Decimal;
        TotalRhum: Decimal;
        ItemSubFamily: Record 50008;
        PaysDest: Record 9;
        NomPaysDest: Text[50];
        UserRec: Record "User Setup";
        LocationFilter: Text[250];
        SellToCustName: Text[30];
        SellToCustaddr: Text[30];
        SellToCustaddr2: Text[30];
        SellToPostCode: Code[10];
        SellToCity: Text[30];
        BillToCustName: Text[30];
        BillToCustaddr: Text[30];
        BillToCustaddr2: Text[30];
        ExemplaireT: Text[30];
        BillToPostCode: Code[10];
        BillToCity: Text[30];
        ShipToCustName: Text[30];
        ShipToCustaddr: Text[30];
        ShipToCustaddr2: Text[30];
        ShipToPostCode: Code[10];
        ShipToCity: Text[30];
        DescriptionTotale: Text[60];
        MontantLigne: Decimal;
        text1: Text[30];
        Location: Record 14;
        trans: Record 291;
        provtrans: Text[30];
        Call: Record 50001;
        prixfact: Decimal;
        sommevaldouane: Decimal;
        prixdouane: Decimal;
        ligneExpeEnreg: Record 111;
        recGSalesSetup: Record 311;
        Txt1: Label '1';
        Txt2: Label '2';
        Txt3: Label '3';
        Txt4: Label '4';
        Txt5: Label '5';
        Txt6: Label '6';
        Txt7: Label '7';
        TxtO: Label 'o';

        Txt8: Label '8';
        Txt9: Label '9';
        Txt10: Label '10';

        Txt11: Label '11';
        Txt12: Label '12';
        Txt14: Label '14';
        Txt13: Label '13';
        Txt15: Label '15';

}
