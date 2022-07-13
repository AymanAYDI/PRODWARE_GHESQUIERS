xmlport 50000 "PWD Export CIEL"
{
    Caption = 'Export CIEL';
    //Direction = Export;
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<;>';
    FormatEvaluate = Xml;
    // TextEncoding = WINDOWS;
    Format = xml;
    Encoding = UTF8;
    Namespaces = bc = 'xsi:schemaLocation="http://douane.finances.gouv.fr/app/ciel/dtiplus/v1 ciel-dti-plus_v1.0.7.xsd" xmlns="http://douane.finances.gouv.fr/app/ciel/dtiplus/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"';
    //UseRequestPage = true;
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    //UseDefaultNamespace = true;
    schema
    {
        textelement(MouvementsBalances)
        {
            NamespacePrefix = 'bc';//'xsi:schemaLocation="http://douane.finances.gouv.fr/app/ciel/dtiplus/v1 ciel-dti-plus_v1.0.7.xsd" xmlns="http://douane.finances.gouv.fr/app/ciel/dtiplus/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"';
            tableelement(PeriodeTaxation; "PWD CIEL Data")
            {
                MinOccurs = Once;
                MaxOccurs = Once;
                XmlName = 'periode-taxation';
                fieldelement(mois; PeriodeTaxation.Month)
                {
                }
                fieldelement(annee; PeriodeTaxation.Year)
                {
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
                    fieldelement(tav; RecGCIELData1."Rate Of Alcohol By Volume")
                    {

                    }
                    fieldelement(observations; RecGCIELData1.Observation)
                    {
                    }
                    textelement(balance_stock)
                    {
                        XmlName = 'balance_stock';

                        fieldelement(stock_debut_periode; RecGCIELData1."Begin Period Stock")
                        {
                        }
                        textelement(entrees_periode)
                        {
                            XmlName = 'entrees_periode';
                            fieldelement(achats; RecGCIELData1.Purchase)
                            {
                            }
                        }
                        textelement(sorties_periode)
                        {
                            XmlName = 'sorties_periode';
                            fieldelement(ventes; RecGCIELData1.Sales)
                            {
                            }
                            fieldelement(replacement_suspension; RecGCIELData1."Suspension Replacement")
                            {
                            }
                        }
                        fieldelement(stock_fin_periode; RecGCIELData1."End Period Stock")
                        {
                        }

                    }
                }
                trigger OnAfterGetRecord()
                begin
                    // IF RecGCIELData1."Rate Of Alcohol By Volume" <> 0 THEN
                    //     EVALUATE(RecGCIELData1."Rate Of Alcohol By Volume", CONVERTSTR(FORMAT(RecGCIELData1."Rate Of Alcohol By Volume"), ',', '.'));
                    // EVALUATE(RecGCIELData1."Begin Period Stock", CONVERTSTR(FORMAT(RecGCIELData1."Begin Period Stock"), ',', '.'));
                    // EVALUATE(RecGCIELData1.Purchase, CONVERTSTR(FORMAT(RecGCIELData1.Purchase), ',', '.'));
                    // EVALUATE(RecGCIELData1.Sales, CONVERTSTR(FORMAT(RecGCIELData1.Sales), ',', '.'));
                    // EVALUATE(RecGCIELData1."Suspension Replacement", CONVERTSTR(FORMAT(RecGCIELData1."Suspension Replacement"), ',', '.'));
                    // EVALUATE(RecGCIELData1."End Period Stock", CONVERTSTR(FORMAT(RecGCIELData1."End Period Stock"), ',', '.'));
                end;

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
                    fieldelement(tav; RecGCIELData."Rate Of Alcohol By Volume")
                    {

                    }
                    fieldelement(observations; RecGCIELData.Observation)
                    {
                    }
                    textelement(balance_stock1)
                    {
                        XmlName = 'balance_stock';
                        fieldelement(stock_debut_periode; RecGCIELData."Begin Period Stock")
                        {
                        }
                        textelement(entrees_periode1)
                        {
                            XmlName = 'entrees_periode';
                            fieldelement(volume_produit; RecGCIELData."Item Volume")
                            {
                            }
                            fieldelement(entree_droits_suspendus; RecGCIELData."Item Suspended Rights")
                            {
                            }
                            fieldelement(travail_a_facon; RecGCIELData."Input Work With Way")
                            {
                            }
                        }
                        textelement(sorties_periode1)
                        {
                            XmlName = 'sorties_periode';
                            textelement(sorties_avec_paiement_droits)
                            {
                                XmlName = 'sorties_avec_paiement_droits';
                                fieldelement(sorties_avec_paiement_annee_courante; RecGCIELData."Output With Current Year Paym")
                                {
                                }
                            }
                            textelement(sorties_sans_paiement_droits)
                            {
                                XmlName = 'sorties_sans_paiement_droits';
                                fieldelement(sorties_definitives; RecGCIELData."Definitive Output")
                                {
                                }

                                fieldelement(sorties_exoneration_droits; RecGCIELData."Exemption Rights")
                                {
                                }

                                fieldelement(travail_a_facon; RecGCIELData."Output Work With Way")
                                {
                                }

                                fieldelement(fabrication_autre_produit; RecGCIELData."Other Item Production")
                                {
                                }

                                fieldelement(lies_vins_distilles; RecGCIELData."Distil Wine Lees")
                                {
                                }
                            }

                        }
                        fieldelement(stock_fin_periode; RecGCIELData."End Period Stock")
                        {
                        }

                    }
                }
                trigger OnAfterGetRecord()
                begin
                    // IF RecGCIELData."Rate Of Alcohol By Volume" <> 0 THEN
                    //     EVALUATE(RecGCIELData."Rate Of Alcohol By Volume", CONVERTSTR(FORMAT(RecGCIELData."Rate Of Alcohol By Volume"), ',', '.'));
                    // EVALUATE(RecGCIELData."Begin Period Stock", CONVERTSTR(FORMAT(RecGCIELData."Begin Period Stock"), ',', '.'));
                    // EVALUATE(RecGCIELData.Purchase, CONVERTSTR(FORMAT(RecGCIELData.Purchase), ',', '.'));
                    // EVALUATE(RecGCIELData.Sales, CONVERTSTR(FORMAT(RecGCIELData.Sales), ',', '.'));
                    // EVALUATE(RecGCIELData."Suspension Replacement", CONVERTSTR(FORMAT(RecGCIELData."Suspension Replacement"), ',', '.'));
                    // EVALUATE(RecGCIELData."End Period Stock", CONVERTSTR(FORMAT(RecGCIELData."End Period Stock"), ',', '.'));
                    // EVALUATE(RecGCIELData."Item Volume", CONVERTSTR(FORMAT(RecGCIELData."Item Volume"), ',', '.'));
                    // EVALUATE(RecGCIELData."Item Suspended Rights", CONVERTSTR(FORMAT(RecGCIELData."Item Suspended Rights"), ',', '.'));
                    // EVALUATE(RecGCIELData."Input Work With Way", CONVERTSTR(FORMAT(RecGCIELData."Input Work With Way"), ',', '.'));
                    // EVALUATE(RecGCIELData."Input Work With Way", CONVERTSTR(FORMAT(RecGCIELData."Output With Current Year Paym"), ',', '.'));
                    // EVALUATE(RecGCIELData."Input Work With Way", CONVERTSTR(FORMAT(RecGCIELData."Definitive Output"), ',', '.'));
                    // EVALUATE(RecGCIELData."Input Work With Way", CONVERTSTR(FORMAT(RecGCIELData."Exemption Rights"), ',', '.'));
                    // EVALUATE(RecGCIELData."Input Work With Way", CONVERTSTR(FORMAT(RecGCIELData."Output Work With Way"), ',', '.'));
                    // EVALUATE(RecGCIELData."Input Work With Way", CONVERTSTR(FORMAT(RecGCIELData."Other Item Production"), ',', '.'));
                    // EVALUATE(RecGCIELData."Input Work With Way", CONVERTSTR(FORMAT(RecGCIELData."Distil Wine Lees"), ',', '.'));
                end;

            }
            textelement(document_accompagnement)
            {

                textelement(numero_empreintes)
                {
                    textelement(debut_periode)
                    {
                        textattribute(TxtGDebPerDocAccNumEmp)
                        {


                        }
                    }
                    textelement(fin_periode)
                    {
                        textattribute(TxtGFinPerDocAccNumEmp)
                        {
                        }
                    }
                    textelement(nombre_document_empreinte)
                    {
                        textattribute(IntGNbrDocEmpDocAccNumEmp)
                        {

                        }
                    }

                }
                trigger OnBeforePassVariable()
                begin


                    IF not ((TxtGDebPerDocAccNumEmp <> '') OR
                       (TxtGFinPerDocAccNumEmp <> '') OR
                       (IntGNbrDocEmpDocAccNumEmp <> '')) THEN
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
                        textattribute(TxtGDebPerDocAccDsaDsac)
                        {

                        }
                    }
                    textelement(fin_periode1)
                    {
                        XmlName = 'fin_periode';
                        textattribute(TxtGFinPerDocAccDsaDsac)
                        {
                        }
                    }
                    textelement(nombre_document_empreinte1)
                    {
                        XmlName = 'nombre_document_empreinte';
                        textattribute(IntGNbrDocEmpDocAccDsaDsac)
                        {

                        }
                    }

                }
                trigger OnBeforePassVariable()
                begin

                    IF not ((TxtGDebPerDocAccDsaDsac <> '') OR
                       (TxtGFinPerDocAccDsaDsac <> '') OR
                       (IntGNbrDocEmpDocAccDsaDsac <> '')) THEN
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
                        textattribute(TxtGDebPerDocAccDaaDca)
                        {

                        }
                    }
                    textelement(fin_periode2)
                    {
                        XmlName = 'fin_periode';
                        textattribute(TxtGFinPerDocAccDaaDca)
                        {
                        }
                    }
                    textelement(nombre_document_empreinte2)
                    {
                        XmlName = 'nombre_document_empreinte';
                        textattribute(IntGNbrDocEmpDocAccDaaDca)
                        {

                        }
                    }

                }
                trigger OnBeforePassVariable()
                begin

                    IF not ((TxtGDebPerDocAccDsaDsac <> '') OR
                       (TxtGFinPerDocAccDsaDsac <> '') OR
                       (IntGNbrDocEmpDocAccDsaDsac <> '')) THEN
                        currXMLport.Skip();
                end;
            }
            textelement(releve_non_apurement)
            {
                XmlName = 'releve-non-apurement';

                textelement(numero_daa_dac_dae)
                {
                    textattribute(TxtGNumRelNonApu)
                    {
                    }
                }
                textelement(date_expedition)
                {
                    XmlName = 'date-expedition';
                    textattribute(DatGDateExpRelNonApu)
                    {
                    }
                }
                textelement(numero_accise_destinataire)
                {
                    XmlName = 'numero-accise-destinataire';
                    textattribute(TxtGNumAccDesRelNonApu)
                    {
                    }
                }
                trigger OnBeforePassVariable()
                begin

                    IF not ((TxtGNumRelNonApu <> '') OR
                    (DatGDateExpRelNonApu <> '') OR
                    (TxtGNumAccDesRelNonApu <> '')) THEN
                        currXMLport.Skip();
                end;
            }
            textelement(statistiques)
            {
                XmlName = 'statistiques';

                textelement(quantite_mouts_jus)
                {
                    textattribute(DecGQtyMoutsJus)
                    {
                    }
                }
                textelement(quantite_mouts_mcr)
                {
                    textattribute(DecGQtyMoutsMcr)
                    {
                    }
                }
                textelement(quantite_vins_vinaigre)
                {
                    textattribute(DecGQtyVinVinaigre)
                    {
                    }


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
                group(GroupFile)
                {
                    field(TxtGFilename; TxtGFilename)
                    {
                        Caption = 'File name';
                        ApplicationArea = All;
                    }
                }
                group(numero_empreintes)
                {
                    caption = 'Document-accompagnement > numero-empreintes';
                    field(TxtGDebPerDocAccNumEmp; TxtGDebPerDocAccNumEmp)
                    {
                        Caption = 'Debut-periode';
                        ApplicationArea = All;
                    }
                    field(TxtGFinPerDocAccNumEmp; TxtGFinPerDocAccNumEmp)
                    {
                        Caption = 'Fin-periode';
                        ApplicationArea = All;
                    }
                    field(IntGNbrDocEmpDocAccNumEmp; IntGNbrDocEmpDocAccNumEmp)
                    {
                        Caption = 'Nombre-document-empreinte';
                        ApplicationArea = All;
                    }
                }
                group(dsa_dsac)
                {
                    caption = 'Document-accompagnement > dsa-dsac';
                    field(TxtGDebPerDocAccDsaDsac; TxtGDebPerDocAccDsaDsac)
                    {
                        Caption = 'Debut-periode';
                        ApplicationArea = All;
                    }
                    field(TxtGFinPerDocAccDsaDsac; TxtGFinPerDocAccDsaDsac)
                    {
                        Caption = 'Fin-periode';
                        ApplicationArea = All;
                    }
                    field(IntGNbrDocEmpDocAccDsaDsac; IntGNbrDocEmpDocAccDsaDsac)
                    {
                        Caption = 'Nombre-document-empreinte';
                        ApplicationArea = All;
                    }
                }
                group(daa_dca)
                {
                    caption = 'Document-accompagnement > daa-dca';
                    field(TxtGDebPerDocAccDaaDca; TxtGDebPerDocAccDaaDca)
                    {
                        Caption = 'Debut-periode';
                        ApplicationArea = All;
                    }
                    field(TxtGFinPerDocAccDaaDca; TxtGFinPerDocAccDaaDca)
                    {
                        Caption = 'Fin-periode';
                        ApplicationArea = All;
                    }
                    field(IntGNbrDocEmpDocAccDaaDca; IntGNbrDocEmpDocAccDaaDca)
                    {
                        Caption = 'Nombre-document-empreinte';
                        ApplicationArea = All;
                    }
                }
                group(relevenonrequest)
                {
                    caption = 'Releve-non-apurement';
                    field(TxtGNumRelNonApu; TxtGNumRelNonApu)
                    {
                        Caption = 'Numero-daa-dac-dae';
                        ApplicationArea = All;
                    }
                    field(DatGDateExpRelNonApu; DatGDateExpRelNonApu)
                    {
                        Caption = 'Date-expedition';
                        ApplicationArea = All;
                    }
                    field(TxtGNumAccDesRelNonApu; TxtGNumAccDesRelNonApu)
                    {
                        Caption = 'Numero-accise-destinataire';
                        ApplicationArea = All;
                    }
                }
                group(Statistiques)
                {
                    caption = 'Statistiques';
                    field(DecGQtyMoutsJus; DecGQtyMoutsJus)
                    {
                        Caption = 'Quantite-mouts-jus';
                        ApplicationArea = All;
                    }
                    field(DecGQtyMoutsMcr; DecGQtyMoutsMcr)
                    {
                        Caption = 'Quantite-mouts-mcr';
                        ApplicationArea = All;
                    }
                    field(DecGQtyVinVinaigre; DecGQtyVinVinaigre)
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
        TxtGFilename: text[1024];
        TxtGToFile: text[1024];
    //TxtGDebPerDocAccNumEmp: text[30];
    //TxtGFinPerDocAccNumEmp: text[30];
    // TxtGDebPerDocAccDsaDsac: text[30];
    // TxtGFinPerDocAccDsaDsac: text[30];
    // TxtGDebPerDocAccDaaDca: text[30];
    // TxtGFinPerDocAccDaaDca: text[30];
    // TxtGNumRelNonApu: text[30];
    // TxtGNumAccDesRelNonApu: text[30];
    //IntGNbrDocEmpDocAccNumEmp: integer;
    // IntGNbrDocEmpDocAccDsaDsac: integer;
    // IntGNbrDocEmpDocAccDaaDca: integer;
    // DatGDateExpRelNonApu: Date;
    // DecGQtyMoutsJus: Decimal;
    // DecGQtyMoutsMcr: Decimal;
    // DecGQtyVinVinaigre: Decimal;


}
