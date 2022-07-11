xmlport 50000 "PWD Export CIEL"
{
    Caption = 'Export CIEL';
    //Direction = Export;
    // FieldDelimiter = '<None>';
    // FieldSeparator = '<;>';
    //FormatEvaluate = Xml;
    // TextEncoding = WINDOWS;
    Format = xml;
    //Encoding = UTF8;
    //UseRequestPage = true;
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    //UseDefaultNamespace = true;
    schema
    {
        textelement(MouvementsBalances)
        {
            //NamespacePrefix = 'xsi:schemaLocation="http://douane.finances.gouv.fr/app/ciel/dtiplus/v1 ciel-dti-plus_v1.0.7.xsd" xmlns="http://douane.finances.gouv.fr/app/ciel/dtiplus/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"';
            textelement(PeriodeTaxation)
            {
                XmlName = 'periode-taxation';
                textelement(mois)
                {
                    XmlName = 'mois';
                }
                textelement(annee)
                {
                    XmlName = 'annee';
                }
            }
            textelement(identificationredevable)
            {
                XmlName = 'identification-redevable';
            }
            tableelement(RecGCIELData1; "PWD CIEL Data")
            {
                SourceTableView = WHERE("Right Type" = filter("Value acquittees"));
                XmlName = 'droits-acquittes';
                textelement(produit)
                {
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

                        fieldelement(stock_debut_periode; RecGCIELData1."Begin Period Stock")
                        {
                        }
                        textelement(entrees_periode)
                        {
                            // fieldelement(achats; RecGCIELData1.Purchase)
                            // {
                            // }
                            // fieldelement(sorties_periode; PWDNationalAddCode.Description)
                            // {
                            // }
                            // fieldelement(ventes; PWDNationalAddCode.Description)
                            // {
                            // }
                            // fieldelement(Description; PWDNationalAddCode.Description)
                            // {
                            // }
                            // fieldelement(Description; PWDNationalAddCode.Description)
                            // {
                            // }
                        }
                        // fieldelement(Description; PWDNationalAddCode.Description)
                        // {
                        // }

                    }
                }
                trigger OnAfterGetRecord()
                begin
                    IF RecGCIELData1."Rate Of Alcohol By Volume" <> 0 THEN
                        EVALUATE(RecGCIELData1."Rate Of Alcohol By Volume", CONVERTSTR(FORMAT(RecGCIELData1."Rate Of Alcohol By Volume"), ',', '.'));
                    EVALUATE(RecGCIELData1."Begin Period Stock", CONVERTSTR(FORMAT(RecGCIELData1."Begin Period Stock"), ',', '.'));
                    EVALUATE(RecGCIELData1.Purchase, CONVERTSTR(FORMAT(RecGCIELData1.Purchase), ',', '.'));
                end;

            }
            // tableelement(RecGCIELData; "PWD CIEL Data")
            // {
            //     fieldelement(libellepersonnalise; RecGCIELData."Personnal Caption")
            //     {
            //     }
            //     // fieldelement(Description; PWDNationalAddCode.Description)
            //     // {
            //     // }
            //     trigger OnAfterInitRecord()
            //     begin
            //         RecGCIELData.SetRange("Right Type", RecGCIELData."Right Type"::"Value suspended");
            //     end;
            // }
        }
    }
    // schema
    // {
    //     textelement(RootNodeName)
    //     {
    //         NamespacePrefix = 'xsi:schemaLocation="http://douane.finances.gouv.fr/app/ciel/dtiplus/v1 ciel-dti-plus_v1.0.7.xsd" xmlns="http://douane.finances.gouv.fr/app/ciel/dtiplus/v1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"';
    //         tableelement(Item; Item)
    //         {
    //             SourceTableView = WHERE("No." = FILTER('1BA1020601B|1EP1060400'));
    //             XmlName = 'Items';
    //             fieldelement(No; Item."No.")
    //             {
    //             }
    //             fieldelement(Description; Item.Description)
    //             {
    //             }
    //         }
    //     }
    // }
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

}
