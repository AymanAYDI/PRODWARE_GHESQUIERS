xmlport 50000 "PWD Export CIEL"
{
    Caption = 'Export CIEL';
    Direction = Export;
    FormatEVALUATE = Xml;
    Encoding = UTF8;
    Namespaces = "" = 'http://douane.finances.gouv.fr/app/ciel/dtiplus/v1', xsi = 'http://www.w3.org/2001/XMLSchema-instance',
    "schemaLocation" = 'http://douane.finances.gouv.fr/app/ciel/dtiplus/v1%20ciel-dti-plus_v1.0.7.xsd';

    schema
    {
        tableelement(MouvementsBalances; Integer)
        {
            XmlName = 'mouvements-balances';
            UseTemporary = true;
            textelement(PeriodeTaxation)
            {
                XmlName = 'periode-taxation';
                textelement(mois)
                {
                    trigger OnBeforePassVariable()
                    var
                        PeriodeTaxation: Record "PWD CIEL Data";
                    begin
                        PeriodeTaxation.FINDFIRST();
                        mois := Format(PeriodeTaxation.Month);
                    end;

                }
                textelement(annee)
                {
                    trigger OnBeforePassVariable()
                    var
                        PeriodeTaxation: Record "PWD CIEL Data";
                    begin
                        PeriodeTaxation.FINDFIRST();
                        annee := Format(PeriodeTaxation.Year);
                    end;

                }

            }
            tableelement(RecGInfoSoc; "Company Information")
            {

                XmlName = 'identification-redevable';
                fieldelement(identification_redevable; RecGInfoSoc."PWD Indebted Identification")
                {
                }
            }
            tableelement(RecGCIELData1; "PWD CIEL Data")
            {
                SourceTableView = WHERE("Right Type" = filter("Value acquittees"));
                XmlName = 'droits-acquittes';
                textelement(produit)
                {
                    XmlName = 'produit';
                    fieldelement(libelle_personnalise; RecGCIELData1."Personnal Caption")
                    {
                    }
                    fieldelement(libelle_fiscal; RecGCIELData1."Fiscal Caption")
                    {
                    }
                    textelement(RateOfAlcoholByVolume)
                    {
                        XmlName = 'tav';
                        trigger OnBeforePassVariable()
                        begin
                            IF RecGCIELData1."Rate Of Alcohol By Volume" <> 0 THEN
                                EVALUATE(RateOfAlcoholByVolume, CONVERTSTR(FORMAT(RecGCIELData1."Rate Of Alcohol By Volume"), ',', '.'));

                        end;

                    }
                    fieldelement(observations; RecGCIELData1.Observation)
                    {
                    }
                    textelement(balance_stock)
                    {
                        XmlName = 'balance_stock';

                        textelement(StockDebutPeriode)
                        {
                            XmlName = 'stock_debut_periode';
                            trigger OnBeforePassVariable()
                            begin
                                EVALUATE(StockDebutPeriode, CONVERTSTR(FORMAT(RecGCIELData1."Begin Period Stock"), ',', '.'));
                            end;
                        }
                        textelement(entrees_periode)
                        {
                            XmlName = 'entrees_periode';
                            textelement(achats)
                            {
                                XmlName = 'achats';
                                trigger OnBeforePassVariable()
                                begin
                                    EVALUATE(achats, CONVERTSTR(FORMAT(RecGCIELData1.Purchase), ',', '.'));
                                end;
                            }
                        }
                        textelement(sorties_periode)
                        {
                            XmlName = 'sorties_periode';
                            textelement(ventes)
                            {
                                XmlName = 'ventes';
                                trigger OnBeforePassVariable()
                                begin
                                    EVALUATE(ventes, CONVERTSTR(FORMAT(RecGCIELData1.Sales), ',', '.'));
                                end;
                            }
                            textelement(replacement_suspension)
                            {
                                XmlName = 'replacement_suspension';
                                trigger OnBeforePassVariable()
                                begin
                                    EVALUATE(replacement_suspension, CONVERTSTR(FORMAT(RecGCIELData1."Suspension Replacement"), ',', '.'));
                                end;
                            }
                        }
                        textelement(stock_fin_periode)
                        {
                            XmlName = 'stock_fin_periode';
                            trigger OnBeforePassVariable()
                            begin
                                EVALUATE(stock_fin_periode, CONVERTSTR(FORMAT(RecGCIELData1."End Period Stock"), ',', '.'));
                            end;
                        }


                    }
                }

            }
            tableelement(RecGCIELData; "PWD CIEL Data")
            {
                SourceTableView = WHERE("Right Type" = filter("Value suspended"));
                XmlName = 'droits-suspendu';
                textelement(produit1)
                {
                    XmlName = 'produit';
                    fieldelement(libelle_personnalise; RecGCIELData."Personnal Caption")
                    {
                    }
                    fieldelement(libelle_fiscal; RecGCIELData."Fiscal Caption")
                    {
                    }
                    textelement(tav)
                    {
                        XmlName = 'tav';
                        trigger OnBeforePassVariable()
                        begin
                            IF RecGCIELData."Rate Of Alcohol By Volume" <> 0 THEN
                                EVALUATE(tav, CONVERTSTR(FORMAT(RecGCIELData."Rate Of Alcohol By Volume"), ',', '.'));
                        end;
                    }
                    fieldelement(observations; RecGCIELData.Observation)
                    {
                    }
                    textelement(balance_stock1)
                    {
                        XmlName = 'balance_stock';
                        textelement(stock_debut_periode1)
                        {
                            XmlName = 'stock_debut_periode';
                            trigger OnBeforePassVariable()
                            begin
                                EVALUATE(stock_debut_periode1, CONVERTSTR(FORMAT(RecGCIELData."Begin Period Stock"), ',', '.'));
                            end;
                        }
                        textelement(entrees_periode1)
                        {
                            XmlName = 'entrees_periode';
                            textelement(volume_produit)
                            {
                                XmlName = 'volume_produit';
                                trigger OnBeforePassVariable()
                                begin
                                    EVALUATE(volume_produit, CONVERTSTR(FORMAT(RecGCIELData."Item Volume"), ',', '.'));
                                end;
                            }
                            textelement(entree_droits_suspendus)
                            {
                                XmlName = 'entree_droits_suspendus';
                                trigger OnBeforePassVariable()
                                begin
                                    EVALUATE(entree_droits_suspendus, CONVERTSTR(FORMAT(RecGCIELData."Item Suspended Rights"), ',', '.'));
                                end;
                            }
                            textelement(travail_a_facon)
                            {
                                XmlName = 'travail_a_facon';
                                trigger OnBeforePassVariable()
                                begin
                                    EVALUATE(travail_a_facon, CONVERTSTR(FORMAT(RecGCIELData."Input Work With Way"), ',', '.'));
                                end;
                            }
                        }
                        textelement(sorties_periode1)
                        {
                            XmlName = 'sorties_periode';
                            textelement(sorties_avec_paiement_droits)
                            {
                                XmlName = 'sorties_avec_paiement_droits';
                                textelement(sorties_avec_paiement_annee_courante)
                                {
                                    XmlName = 'sorties_avec_paiement_annee_courante';
                                    trigger OnBeforePassVariable()
                                    begin
                                        EVALUATE(sorties_avec_paiement_annee_courante, CONVERTSTR(FORMAT(RecGCIELData."Output With Current Year Paym"), ',', '.'));
                                    end;
                                }
                            }
                            textelement(sorties_sans_paiement_droits)
                            {
                                XmlName = 'sorties_sans_paiement_droits';
                                textelement(sorties_definitives)
                                {
                                    XmlName = 'sorties_definitives';
                                    trigger OnBeforePassVariable()
                                    begin
                                        EVALUATE(sorties_definitives, CONVERTSTR(FORMAT(RecGCIELData."Definitive Output"), ',', '.'));
                                    end;
                                }

                                textelement(sorties_exoneration_droits)
                                {
                                    XmlName = 'sorties_exoneration_droits';
                                    trigger OnBeforePassVariable()
                                    begin
                                        EVALUATE(sorties_exoneration_droits, CONVERTSTR(FORMAT(RecGCIELData."Exemption Rights"), ',', '.'));
                                    end;
                                }

                                textelement(travail_a_facon1)
                                {
                                    XmlName = 'travail_a_facon';
                                    trigger OnBeforePassVariable()
                                    begin
                                        EVALUATE(travail_a_facon1, CONVERTSTR(FORMAT(RecGCIELData."Output Work With Way"), ',', '.'));
                                    end;
                                }

                                textelement(fabrication_autre_produit)
                                {
                                    XmlName = 'fabrication_autre_produit';
                                    trigger OnBeforePassVariable()
                                    begin
                                        EVALUATE(fabrication_autre_produit, CONVERTSTR(FORMAT(RecGCIELData."Other Item Production"), ',', '.'));
                                    end;
                                }

                                textelement(lies_vins_distilles)
                                {
                                    XmlName = 'lies_vins_distilles';
                                    trigger OnBeforePassVariable()
                                    begin
                                        EVALUATE(lies_vins_distilles, CONVERTSTR(FORMAT(RecGCIELData."Distil Wine Lees"), ',', '.'));
                                    end;
                                }
                            }

                        }
                        textelement(stock_fin_periode1)
                        {
                            XmlName = 'stock_fin_periode';
                            trigger OnBeforePassVariable()
                            begin
                                EVALUATE(stock_fin_periode1, CONVERTSTR(FORMAT(RecGCIELData."End Period Stock"), ',', '.'));
                            end;
                        }

                    }
                }

            }
            textelement(document_accompagnement)
            {

                textelement(numero_empreintes)
                {
                    textelement(debut_periode)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            debut_periode := TxtGDebPerDocAccNumEmp1;
                        end;

                    }
                    textelement(fin_periode)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            fin_periode := TxtGFinPerDocAccNumEmp1;
                        end;
                    }
                    textelement(nombre_document_empreinte)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            nombre_document_empreinte := FORMAT(IntGNbrDocEmpDocAccNumEmp1);
                        end;
                    }

                }
                trigger OnBeforePassVariable()
                begin


                    IF not ((TxtGDebPerDocAccNumEmp1 <> '') OR
                       (TxtGFinPerDocAccNumEmp1 <> '') OR
                       (IntGNbrDocEmpDocAccNumEmp1 <> 0)) THEN
                        currXMLport.Skip();
                end;
            }
            textelement(document_accompagnement1)
            {
                XmlName = 'document_accompagnement';

                textelement(dsa_dsac)
                {
                    textelement(debut_periode1)
                    {
                        XmlName = 'debut_periode';
                        trigger OnBeforePassVariable()
                        begin
                            debut_periode1 := TxtGDebPerDocAccDsaDsac1;
                        end;
                    }
                    textelement(fin_periode1)
                    {
                        XmlName = 'fin_periode';
                        trigger OnBeforePassVariable()
                        begin
                            fin_periode1 := TxtGFinPerDocAccDsaDsac1;
                        end;
                    }
                    textelement(nombre_document_empreinte1)
                    {
                        XmlName = 'nombre_document_empreinte';
                        trigger OnBeforePassVariable()
                        begin
                            nombre_document_empreinte1 := FORMAT(IntGNbrDocEmpDocAccDsaDsac1);
                        end;
                    }

                }
                trigger OnBeforePassVariable()
                begin

                    IF not ((TxtGDebPerDocAccDsaDsac1 <> '') OR
                       (TxtGFinPerDocAccDsaDsac1 <> '') OR
                       (IntGNbrDocEmpDocAccDsaDsac1 <> 0)) THEN
                        currXMLport.Skip();
                end;
            }
            textelement(document_accompagnement2)
            {
                XmlName = 'document_accompagnement';

                textelement(daa_dca)
                {
                    textelement(debut_periode2)
                    {
                        XmlName = 'debut_periode';
                        trigger OnBeforePassVariable()
                        begin
                            debut_periode2 := TxtGDebPerDocAccDaaDca1;
                        end;
                    }
                    textelement(fin_periode2)
                    {
                        XmlName = 'fin_periode';
                        trigger OnBeforePassVariable()
                        begin
                            fin_periode2 := TxtGFinPerDocAccDaaDca1;
                        end;
                    }
                    textelement(nombre_document_empreinte2)
                    {
                        XmlName = 'nombre_document_empreinte';
                        trigger OnBeforePassVariable()
                        begin
                            nombre_document_empreinte2 := FORMAT(IntGNbrDocEmpDocAccDaaDca1);
                        end;
                    }

                }
                trigger OnBeforePassVariable()
                begin

                    IF not ((TxtGDebPerDocAccDsaDsac1 <> '') OR
                       (TxtGFinPerDocAccDsaDsac1 <> '') OR
                       (IntGNbrDocEmpDocAccDsaDsac1 <> 0)) THEN
                        currXMLport.Skip();
                end;
            }
            textelement(releve_non_apurement)
            {
                XmlName = 'releve-non-apurement';

                textelement(numero_daa_dac_dae)
                {
                    trigger OnBeforePassVariable()
                    begin
                        numero_daa_dac_dae := TxtGNumRelNonApu1;
                    end;
                }
                textelement(date_expedition)
                {
                    XmlName = 'date-expedition';
                    trigger OnBeforePassVariable()
                    begin
                        date_expedition := FORMAT(DatGDateExpRelNonApu1, 0, 9);
                    end;
                }
                textelement(numero_accise_destinataire)
                {
                    XmlName = 'numero-accise-destinataire';
                    trigger OnBeforePassVariable()
                    begin
                        numero_accise_destinataire := TxtGNumAccDesRelNonApu1;
                    end;
                }
                trigger OnBeforePassVariable()
                begin

                    IF not ((TxtGNumRelNonApu1 <> '') OR
                    (DatGDateExpRelNonApu1 <> 0D) OR
                    (TxtGNumAccDesRelNonApu1 <> '')) THEN
                        currXMLport.Skip();
                end;
            }
            textelement(statistiques)
            {
                XmlName = 'statistiques';

                textelement(quantite_mouts_jus)
                {
                    trigger OnBeforePassVariable()
                    begin
                        quantite_mouts_jus := CONVERTSTR(FORMAT(DecGQtyMoutsJus1), ',', '.');
                    end;
                }
                textelement(quantite_mouts_mcr)
                {
                    trigger OnBeforePassVariable()
                    begin
                        quantite_mouts_mcr := CONVERTSTR(FORMAT(DecGQtyMoutsMcr1), ',', '.');
                    end;
                }
                textelement(quantite_vins_vinaigre)
                {
                    trigger OnBeforePassVariable()
                    begin
                        quantite_vins_vinaigre := CONVERTSTR(FORMAT(DecGQtyVinVinaigre1), ',', '.');
                    end;


                }
            }

        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                // group(GroupFile)
                // {
                //     field(TxtGFilename; TxtGFilename1)
                //     {
                //         Caption = 'File name';
                //         ApplicationArea = All;
                //     }
                // }
                group(numero_empreintes)
                {
                    caption = 'Document-accompagnement > numero-empreintes';
                    field(TxtGDebPerDocAccNumEmp; TxtGDebPerDocAccNumEmp1)
                    {
                        Caption = 'Debut-periode';
                        ApplicationArea = All;
                    }
                    field(TxtGFinPerDocAccNumEmp; TxtGFinPerDocAccNumEmp1)
                    {
                        Caption = 'Fin-periode';
                        ApplicationArea = All;
                    }
                    field(IntGNbrDocEmpDocAccNumEmp; IntGNbrDocEmpDocAccNumEmp1)
                    {
                        Caption = 'Nombre-document-empreinte';
                        ApplicationArea = All;
                    }
                }
                group(dsa_dsac)
                {
                    caption = 'Document-accompagnement > dsa-dsac';
                    field(TxtGDebPerDocAccDsaDsac; TxtGDebPerDocAccDsaDsac1)
                    {
                        Caption = 'Debut-periode';
                        ApplicationArea = All;
                    }
                    field(TxtGFinPerDocAccDsaDsac; TxtGFinPerDocAccDsaDsac1)
                    {
                        Caption = 'Fin-periode';
                        ApplicationArea = All;
                    }
                    field(IntGNbrDocEmpDocAccDsaDsac; IntGNbrDocEmpDocAccDsaDsac1)
                    {
                        Caption = 'Nombre-document-empreinte';
                        ApplicationArea = All;
                    }
                }
                group(daa_dca)
                {
                    caption = 'Document-accompagnement > daa-dca';
                    field(TxtGDebPerDocAccDaaDca; TxtGDebPerDocAccDaaDca1)
                    {
                        Caption = 'Debut-periode';
                        ApplicationArea = All;
                    }
                    field(TxtGFinPerDocAccDaaDca; TxtGFinPerDocAccDaaDca1)
                    {
                        Caption = 'Fin-periode';
                        ApplicationArea = All;
                    }
                    field(IntGNbrDocEmpDocAccDaaDca; IntGNbrDocEmpDocAccDaaDca1)
                    {
                        Caption = 'Nombre-document-empreinte';
                        ApplicationArea = All;
                    }
                }
                group(relevenonrequest)
                {
                    caption = 'Releve-non-apurement';
                    field(TxtGNumRelNonApu; TxtGNumRelNonApu1)
                    {
                        Caption = 'Numero-daa-dac-dae';
                        ApplicationArea = All;
                    }
                    field(DatGDateExpRelNonApu; DatGDateExpRelNonApu1)
                    {
                        Caption = 'Date-expedition';
                        ApplicationArea = All;
                    }
                    field(TxtGNumAccDesRelNonApu; TxtGNumAccDesRelNonApu1)
                    {
                        Caption = 'Numero-accise-destinataire';
                        ApplicationArea = All;
                    }
                }
                group(Statistiques)
                {
                    caption = 'Statistiques';
                    field(DecGQtyMoutsJus; DecGQtyMoutsJus1)
                    {
                        Caption = 'Quantite-mouts-jus';
                        ApplicationArea = All;
                    }
                    field(DecGQtyMoutsMcr; DecGQtyMoutsMcr1)
                    {
                        Caption = 'Quantite-mouts-mcr';
                        ApplicationArea = All;
                    }
                    field(DecGQtyVinVinaigre; DecGQtyVinVinaigre1)
                    {
                        Caption = 'Quantite-vins-vinaigre';
                        ApplicationArea = All;
                    }
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
    var
        //TxtGFilename1: text[1024];
        //TxtGToFile1: text[1024];
        TxtGDebPerDocAccNumEmp1: text[30];
        TxtGFinPerDocAccNumEmp1: text[30];
        TxtGDebPerDocAccDsaDsac1: text[30];
        TxtGFinPerDocAccDsaDsac1: text[30];
        TxtGDebPerDocAccDaaDca1: text[30];
        TxtGFinPerDocAccDaaDca1: text[30];
        TxtGNumRelNonApu1: text[30];
        TxtGNumAccDesRelNonApu1: text[30];
        IntGNbrDocEmpDocAccNumEmp1: integer;
        IntGNbrDocEmpDocAccDsaDsac1: integer;
        IntGNbrDocEmpDocAccDaaDca1: integer;
        DatGDateExpRelNonApu1: Date;
        DecGQtyMoutsJus1: Decimal;
        DecGQtyMoutsMcr1: Decimal;
        DecGQtyVinVinaigre1: Decimal;


}
