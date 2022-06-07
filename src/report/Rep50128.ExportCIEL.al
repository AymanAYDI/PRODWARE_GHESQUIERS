report 50128 "PWD Export CIEL"
{
    Caption = 'PWD Export CIEL';
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
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
    trigger OnPreReport()
    var
    begin
        //TODO
        /*
                IF ISSERVICETIER THEN
                    TxtGFilename := CduG3TierAutomationMgt.EnvironFileName('', '');

                IF DELCHR(TxtGFilename, '<>') = '' THEN
                    ERROR(CstG003);

                IF EXISTS(TxtGFilename) AND (NOT ISSERVICETIER) THEN
                    IF NOT CONFIRM(CstG004, FALSE, TxtGFilename) THEN
                        ERROR(CstG005, TxtGFilename);

                CREATE(XMLDomDoc, TRUE, FALSE);

        XMLDomDoc.loadXML('<?xml version="1.0" encoding="UTF-8"?><mouvements-balances></mouvements-balances>');
        XMLRootElement := XMLDomDoc.documentElement;
        XMLRootElement.setAttribute('xsi:schemaLocation', 'http://douane.finances.gouv.fr/app/ciel/dtiplus/v1 ciel-dti-plus_v1.0.7.xsd');
        XMLRootElement.setAttribute('xmlns', 'http://douane.finances.gouv.fr/app/ciel/dtiplus/v1');
        XMLRootElement.setAttribute('xmlns:xsi', 'http://www.w3.org/2001/XMLSchema-instance');

        XMLNodeCurr := XMLDomDoc.selectSingleNode('mouvements-balances');

        AddElement(XMLNodeCurr, 'periode-taxation', '', '', XMLNewChild);

        RecGCIELData.RESET();
        RecGCIELData.FINDFIRST();
        AddElement(XMLNewChild, 'mois', FORMAT(RecGCIELData.Month), '', XMLNewChild1);
        AddElement(XMLNewChild, 'annee', FORMAT(RecGCIELData.Year), '', XMLNewChild1);

        RecGInfoSoc.GET();
        AddElement(XMLNodeCurr, 'identification-redevable', RecGInfoSoc."PWD Indebted Identification", '', XMLNewChild);

        RecGCIELData.RESET();
        RecGCIELData.SETRANGE("Right Type", RecGCIELData."Right Type"::"Value acquittees");
        AddElement(XMLNodeCurr, 'droits-acquittes', '', '', XMLNewChild);

        IF RecGCIELData.FINDFIRST() THEN
            REPEAT
                AddElement(XMLNewChild, 'produit', '', '', XMLNewChild1);
                AddElement(XMLNewChild1, 'libelle-personnalise', RecGCIELData."Personnal Caption", '', XMLNewChild2);
                AddElement(XMLNewChild1, 'libelle-fiscal', RecGCIELData."Fiscal Caption", '', XMLNewChild2);
                IF RecGCIELData."Rate Of Alcohol By Volume" <> 0 THEN
                    AddElement(XMLNewChild1, 'tav', CONVERTSTR(FORMAT(RecGCIELData."Rate Of Alcohol By Volume"), ',', '.'), '', XMLNewChild2);
                AddElement(XMLNewChild1, 'observations', RecGCIELData.Observation, '', XMLNewChild2);
                AddElement(XMLNewChild1, 'balance-stock', '', '', XMLNewChild2);
                AddElement(XMLNewChild2, 'stock-debut-periode', CONVERTSTR(FORMAT(RecGCIELData."Begin Period Stock"), ',', '.'), '', XMLNewChild3);
                AddElement(XMLNewChild2, 'entrees-periode', '', '', XMLNewChild3);
                AddElement(XMLNewChild3, 'achats', CONVERTSTR(FORMAT(RecGCIELData.Purchase), ',', '.'), '', XMLNewChild4);
                AddElement(XMLNewChild2, 'sorties-periode', '', '', XMLNewChild3);
                AddElement(XMLNewChild3, 'ventes', CONVERTSTR(FORMAT(RecGCIELData.Sales), ',', '.'), '', XMLNewChild4);
                AddElement(XMLNewChild3, 'replacement-suspension',
                                         CONVERTSTR(FORMAT(RecGCIELData."Suspension Replacement"), ',', '.'), '', XMLNewChild4);
                AddElement(XMLNewChild2, 'stock-fin-periode', CONVERTSTR(FORMAT(RecGCIELData."End Period Stock"), ',', '.'), '', XMLNewChild3);
            UNTIL RecGCIELData.NEXT() = 0;

        RecGCIELData.RESET();
        RecGCIELData.SETRANGE("Right Type", RecGCIELData."Right Type"::"Value suspended");
        AddElement(XMLNodeCurr, 'droits-suspendus', '', '', XMLNewChild);

        IF RecGCIELData.FINDFIRST() THEN
            REPEAT
                AddElement(XMLNewChild, 'produit', '', '', XMLNewChild1);
                AddElement(XMLNewChild1, 'libelle-personnalise', RecGCIELData."Personnal Caption", '', XMLNewChild2);
                AddElement(XMLNewChild1, 'libelle-fiscal', RecGCIELData."Fiscal Caption", '', XMLNewChild2);
                IF RecGCIELData."Rate Of Alcohol By Volume" <> 0 THEN
                    AddElement(XMLNewChild1, 'tav', CONVERTSTR(FORMAT(RecGCIELData."Rate Of Alcohol By Volume"), ',', '.'), '', XMLNewChild2);
                AddElement(XMLNewChild1, 'observations', RecGCIELData.Observation, '', XMLNewChild2);
                AddElement(XMLNewChild1, 'balance-stock', '', '', XMLNewChild2);
                AddElement(XMLNewChild2, 'stock-debut-periode', CONVERTSTR(FORMAT(RecGCIELData."Begin Period Stock"), ',', '.'), '', XMLNewChild3);
                AddElement(XMLNewChild2, 'entrees-periode', '', '', XMLNewChild3);
                AddElement(XMLNewChild3, 'volume-produit', CONVERTSTR(FORMAT(RecGCIELData."Item Volume"), ',', '.'), '', XMLNewChild4);
                AddElement(XMLNewChild3, 'entree-droits-suspendus',
                                         CONVERTSTR(FORMAT(RecGCIELData."Item Suspended Rights"), ',', '.'), '', XMLNewChild4);
                AddElement(XMLNewChild3, 'travail-a-facon', CONVERTSTR(FORMAT(RecGCIELData."Input Work With Way"), ',', '.'), '', XMLNewChild4);
                AddElement(XMLNewChild2, 'sorties-periode', '', '', XMLNewChild3);
                AddElement(XMLNewChild3, 'sorties-avec-paiement-droits', '', '', XMLNewChild4);
                AddElement(XMLNewChild4, 'sorties-avec-paiement-annee-courante',
                                         CONVERTSTR(FORMAT(RecGCIELData."Output With Current Year Paym"), ',', '.'), '', XMLNewChild5);
                AddElement(XMLNewChild3, 'sorties-sans-paiement-droits', '', '', XMLNewChild4);
                AddElement(XMLNewChild4, 'sorties-definitives', CONVERTSTR(FORMAT(RecGCIELData."Definitive Output"), ',', '.'), '', XMLNewChild5);
                AddElement(XMLNewChild4, 'sorties-exoneration-droits',
                                         CONVERTSTR(FORMAT(RecGCIELData."Exemption Rights"), ',', '.'), '', XMLNewChild5);
                AddElement(XMLNewChild4, 'travail-a-facon', CONVERTSTR(FORMAT(RecGCIELData."Output Work With Way"), ',', '.'), '', XMLNewChild5);
                AddElement(XMLNewChild4, 'fabrication-autre-produit',
                                         CONVERTSTR(FORMAT(RecGCIELData."Other Item Production"), ',', '.'), '', XMLNewChild5);
                AddElement(XMLNewChild4, 'lies-vins-distilles', CONVERTSTR(FORMAT(RecGCIELData."Distil Wine Lees"), ',', '.'), '', XMLNewChild5);
                AddElement(XMLNewChild2, 'stock-fin-periode', CONVERTSTR(FORMAT(RecGCIELData."End Period Stock"), ',', '.'), '', XMLNewChild3);
            UNTIL RecGCIELData.NEXT() = 0;

        IF (TxtGDebPerDocAccNumEmp <> '') OR
           (TxtGFinPerDocAccNumEmp <> '') OR
           (IntGNbrDocEmpDocAccNumEmp <> 0) THEN BEGIN
            AddElement(XMLNodeCurr, 'document-accompagnement', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'numero-empreintes', '', '', XMLNewChild1);
            AddElement(XMLNewChild1, 'debut-periode', TxtGDebPerDocAccNumEmp, '', XMLNewChild2);
            AddElement(XMLNewChild1, 'fin-periode', TxtGFinPerDocAccNumEmp, '', XMLNewChild2);
            AddElement(XMLNewChild1, 'nombre-document-empreinte', FORMAT(IntGNbrDocEmpDocAccNumEmp), '', XMLNewChild2);
        END;

        IF (TxtGDebPerDocAccDsaDsac <> '') OR
           (TxtGFinPerDocAccDsaDsac <> '') OR
           (IntGNbrDocEmpDocAccDsaDsac <> 0) THEN BEGIN
            AddElement(XMLNodeCurr, 'document-accompagnement', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'dsa-dsac', '', '', XMLNewChild1);
            AddElement(XMLNewChild1, 'debut-periode', TxtGDebPerDocAccDsaDsac, '', XMLNewChild2);
            AddElement(XMLNewChild1, 'fin-periode', TxtGFinPerDocAccDsaDsac, '', XMLNewChild2);
            AddElement(XMLNewChild1, 'nombre-document-empreinte', FORMAT(IntGNbrDocEmpDocAccDsaDsac), '', XMLNewChild2);
        END;

        IF (TxtGDebPerDocAccDaaDca <> '') OR
           (TxtGFinPerDocAccDaaDca <> '') OR
           (IntGNbrDocEmpDocAccDaaDca <> 0) THEN BEGIN
            AddElement(XMLNodeCurr, 'document-accompagnement', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'daa-dca', '', '', XMLNewChild1);
            AddElement(XMLNewChild1, 'debut-periode', TxtGDebPerDocAccDaaDca, '', XMLNewChild2);
            AddElement(XMLNewChild1, 'fin-periode', TxtGFinPerDocAccDaaDca, '', XMLNewChild2);
            AddElement(XMLNewChild1, 'nombre-document-empreinte', FORMAT(IntGNbrDocEmpDocAccDaaDca), '', XMLNewChild2);
        END;

        IF (TxtGNumRelNonApu <> '') OR
           (DatGDateExpRelNonApu <> 0D) OR
           (TxtGNumAccDesRelNonApu <> '') THEN BEGIN
            AddElement(XMLNodeCurr, 'releve-non-apurement', '', '', XMLNewChild);
            AddElement(XMLNewChild, 'numero-daa-dac-dae', TxtGNumRelNonApu, '', XMLNewChild1);
            AddElement(XMLNewChild, 'date-expedition', FORMAT(DatGDateExpRelNonApu, 0, 9), '', XMLNewChild1);
            AddElement(XMLNewChild, 'numero-accise-destinataire', TxtGNumAccDesRelNonApu, '', XMLNewChild1);
        END;

        AddElement(XMLNodeCurr, 'statistiques', '', '', XMLNewChild);
        AddElement(XMLNewChild, 'quantite-mouts-jus', CONVERTSTR(FORMAT(DecGQtyMoutsJus), ',', '.'), '', XMLNewChild1);
        AddElement(XMLNewChild, 'quantite-mouts-mcr', CONVERTSTR(FORMAT(DecGQtyMoutsMcr), ',', '.'), '', XMLNewChild1);
        AddElement(XMLNewChild, 'quantite-vins-vinaigre', CONVERTSTR(FORMAT(DecGQtyVinVinaigre), ',', '.'), '', XMLNewChild1);

        XMLDomDoc.save(TxtGFilename);
        CLEAR(XMLDomDoc);
    end;

    trigger OnPostReport()
    var
    begin

        IF ISSERVICETIER THEN BEGIN
            TxtGToFile := STRSUBSTNO(CstG006, FORMAT(RecGCIELData.Month), FORMAT(RecGCIELData.Year));
            //TODO
            IF NOT DOWNLOAD(TxtGFilename, CstG001, '', CstG002, TxtGToFile) THEN
                ERROR(CstG007);
    END;
    end;

    procedure AddElement(VAR XMLNode: Automation; NodeName: Text[250]; NodeText: Text[250]; NameSpace: Text[250])
    var
    begin
        //TODO
        /*
                NewChildNode := XMLNode.ownerDocument.createNode('element', NodeName, NameSpace);
                IF ISCLEAR(NewChildNode) THEN
                    EXIT(FALSE);

                IF NodeText <> '' THEN
                    NewChildNode.text := NodeText;
                XMLNode.appendChild(NewChildNode);
                CreatedXMLNode := NewChildNode;
                CLEAR(NewChildNode);
                EXIT(TRUE);*/
    end;
}
