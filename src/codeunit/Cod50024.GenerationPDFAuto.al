codeunit 50024 "PWD Generation PDF Auto"
{
    trigger OnRun()
    begin
    end;

    var
        gRecPrinterSelection: Record "Printer Selection";
        TempRecPrinterSelMod: Record "Printer Selection" temporary;
        TempRecPrinterSelNew: Record "Printer Selection" temporary;
        FunctionMgt: codeunit "PWD Function Mgt";
    //TODO
    //BullZipPDF: DotNet ComPdfSettings;
    //BullZipPDFUtil: DotNet ComPdfUtil;

    procedure GeneratePDFSalesQuote(pCodeDocumentNo: Code[20])
    var
        lRecCompanyInfo: Record "Company Information";
        lRecCustomer: Record Customer;
        lRecReportSelect: Record "Report Selections";
        lRecSalesHeader: Record "Sales Header";
        lTxtNewLine: Text[30];
        lTxtEmail: Text[80];
        lTxtFileName: Text[1024];
        lTxtStatusFile: Text[1024];
        lTxtClientFileName: Text[1024];

    begin
        lRecSalesHeader.SETRANGE("Document Type", lRecSalesHeader."Document Type"::Quote);
        lRecSalesHeader.SETRANGE("No.", pCodeDocumentNo);
        lRecSalesHeader.FINDFIRST();
        //TODO
        //lTxtClientFileName := FileManagement.ClientTempFileName('', '');
        lTxtFileName := STRSUBSTNO('%1%2.pdf', FunctionMgt.Path(lTxtClientFileName), lRecSalesHeader."No.");
        lTxtStatusFile := fInitBullZipPDF(lTxtFileName);
        lRecReportSelect.SETRANGE(Usage, lRecReportSelect.Usage::"S.Quote");
        IF NOT lRecReportSelect.FINDFIRST() THEN
            ERROR('Aucun état trouvé pour l''impression du devis');
        SetPrinterSelection(lRecReportSelect."Report ID");
        REPORT.RUNMODAL(lRecReportSelect."Report ID", FALSE, FALSE, lRecSalesHeader);
        IF NOT CONFIRM('Veuillez attendre que Navision Classic soit lancé. Voulez-vous envoyer le document par email ? ', FALSE, FALSE)
        THEN
            EXIT;
        fWaitForFile(lTxtStatusFile);
        DeletePrinterSelection();
        IF NOT lRecCustomer.GET(lRecSalesHeader."Sell-to Customer No.") THEN
            lTxtEmail := lRecCustomer."E-Mail";
        lRecCompanyInfo.Get();
        lTxtNewLine := fGetNewLine();
        //TODO
        /*AddBodyline('Bonjour,');
        AddBodyline(lTxtNewLine);
        AddBodyline('Suite à votre demande, veuillez trouver ci-joint notre devis.');
        AddBodyline(lTxtNewLine);
        AddBodyline('Cordialement.');
        AddBodyline(lTxtNewLine);
        AddBodyline(lTxtNewLine);
        AddBodyline('Good Day,');
        AddBodyline(lTxtNewLine);
        AddBodyline('Following your request, please find attached our quotation.');
        AddBodyline(lTxtNewLine);
        AddBodyline('Best regards.');
        AddBodyline(lTxtNewLine);
        AddBodyline(lTxtNewLine);
        AddBodyline('Frédéric MAGNIER');
        AddBodyline(lTxtNewLine);
        AddBodyline('Tel +33 3 21 19 66 37');
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo.Name);
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo.Address);
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo."Address 2");
        AddBodyline(lTxtNewLine);
        AddBodyline(STRSUBSTNO('%1 %2', lRecCompanyInfo."Post Code", lRecCompanyInfo.City));
        AddBodyline(lTxtNewLine);
        AddBodyline('FRANCE');
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo."Home Page");
        AddBodyline(lTxtNewLine);
        NewMessage(lTxtEmail, '', '', STRSUBSTNO(Txt001, lRecSalesHeader."No."), '', lTxtFileName, TRUE);*/
    end;

    procedure GeneratePDFSalesOrder(pCodeDocumentNo: Code[20])
    var
        lRecCompanyInfo: Record "Company Information";
        lRecCustomer: Record Customer;
        lRecReportSelect: Record "Report Selections";
        lRecSalesHeader: Record "Sales Header";
        lTxtNewLine: Text[30];
        lTxtEMail: Text[80];
        lTxtFileName: Text[1024];
        lTxtStatusFile: Text[1024];
        lTxtClientFileName: Text[1024];
    begin
        lRecSalesHeader.SETRANGE("Document Type", lRecSalesHeader."Document Type"::Order);
        lRecSalesHeader.SETRANGE("No.", pCodeDocumentNo);
        lRecSalesHeader.FINDFIRST();
        //TODO
        //lTxtClientFileName := gCUThreeTierMgt.ClientTempFileName('', '');
        lTxtFileName := STRSUBSTNO('%1%2.pdf', FunctionMgt.Path(lTxtClientFileName), lRecSalesHeader."No.");
        lTxtStatusFile := fInitBullZipPDF(lTxtFileName);
        lRecReportSelect.SETRANGE(Usage, lRecReportSelect.Usage::"S.Order");
        IF NOT lRecReportSelect.FINDFIRST() THEN
            ERROR('Aucun état trouvé pour l''impression de la commande de vente');
        SetPrinterSelection(lRecReportSelect."Report ID");
        REPORT.RUNMODAL(lRecReportSelect."Report ID", FALSE, FALSE, lRecSalesHeader);
        IF NOT CONFIRM('Veuillez attendre que Navision Classic soit lancé. Voulez-vous envoyer le document par email ? ', FALSE, FALSE) THEN
            EXIT;
        fWaitForFile(lTxtStatusFile);
        DeletePrinterSelection();
        IF NOT lRecCustomer.GET(lRecSalesHeader."Sell-to Customer No.") THEN
            lTxtEMail := lRecCustomer."E-Mail";
        lRecCompanyInfo.Get();
        lTxtNewLine := fGetNewLine();
        /*AddBodyline('Bonjour,');
        AddBodyline(lTxtNewLine);
        AddBodyline('Nous vous prions de bien vouloir trouver ci-joint votre confirmation de commande.');
        AddBodyline(lTxtNewLine);
        AddBodyline('Cordialement.');
        AddBodyline(lTxtNewLine);
        AddBodyline(lTxtNewLine);
        AddBodyline('Good Day,');
        AddBodyline(lTxtNewLine);
        AddBodyline('Please find attached the order confirmation.');
        AddBodyline(lTxtNewLine);
        AddBodyline('Best regards.');
        AddBodyline(lTxtNewLine);
        AddBodyline(lTxtNewLine);
        AddBodyline('Frédéric MAGNIER');
        AddBodyline(lTxtNewLine);
        AddBodyline('Tel +33 3 21 19 66 37');
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo.Name);
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo.Address);
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo."Address 2");
        AddBodyline(lTxtNewLine);
        AddBodyline(STRSUBSTNO('%1 %2', lRecCompanyInfo."Post Code", lRecCompanyInfo.City));
        AddBodyline(lTxtNewLine);
        AddBodyline('FRANCE');
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo."Home Page");
        AddBodyline(lTxtNewLine);
        NewMessage(lTxtEMail, '', '', STRSUBSTNO(Txt001, lRecSalesHeader."No."), '', lTxtFileName, TRUE);*/
    end;

    procedure GeneratePDFPurchaseOrder(pCodeDocumentNo: Code[20])
    var
        lRecCompanyInfo: Record "Company Information";
        lRecPurchaseHeader: Record "Purchase Header";
        lRecReportSelect: Record "Report Selections";
        lRecVendor: Record Vendor;
        lTxtNewLine: Text[30];
        lTxtEmail: Text[80];
        lTxtFileName: Text[1024];
        lTxtStatusFile: Text[1024];
        lTxtClientFileName: Text[1024];

    begin
        lRecPurchaseHeader.SETRANGE("Document Type", lRecPurchaseHeader."Document Type"::Order);
        lRecPurchaseHeader.SETRANGE("No.", pCodeDocumentNo);
        lRecPurchaseHeader.FINDFIRST();
        //TODO
        //lTxtClientFileName := gCUThreeTierMgt.ClientTempFileName('', '');
        lTxtFileName := STRSUBSTNO('%1%2.pdf', FunctionMgt.Path(lTxtClientFileName), lRecPurchaseHeader."No.");
        lTxtStatusFile := fInitBullZipPDF(lTxtFileName);
        lRecReportSelect.SETRANGE(Usage, lRecReportSelect.Usage::"P.Order");
        IF NOT lRecReportSelect.FINDFIRST() THEN
            ERROR('Aucun état trouvé pour l''impression de la commande d''achat');
        SetPrinterSelection(lRecReportSelect."Report ID");
        REPORT.RUNMODAL(lRecReportSelect."Report ID", FALSE, FALSE, lRecPurchaseHeader);
        IF NOT CONFIRM('Veuillez attendre que Navision Classic soit lancé. Voulez-vous envoyer le document par email ? ', FALSE, FALSE) THEN
            EXIT;
        fWaitForFile(lTxtStatusFile);
        DeletePrinterSelection();
        IF NOT lRecVendor.GET(lRecPurchaseHeader."Buy-from Vendor No.") THEN
            lTxtEmail := lRecVendor."E-Mail";
        lRecCompanyInfo.Get();
        lTxtNewLine := fGetNewLine();
        /*AddBodyline('Bonjour,');
        AddBodyline(lTxtNewLine);
        AddBodyline(STRSUBSTNO(Txt002, lRecPurchaseHeader."No.", lRecPurchaseHeader."Buy-from Contact"));
        AddBodyline(lTxtNewLine);
        AddBodyline('Veuillez svp en accuser réception par retour d''e-mail.');
        AddBodyline(lTxtNewLine);
        AddBodyline(STRSUBSTNO(Txt004, lRecPurchaseHeader."Requested Receipt Date"));
        AddBodyline(lTxtNewLine);
        AddBodyline('Cordialement.');
        AddBodyline(lTxtNewLine);
        AddBodyline(lTxtNewLine);
        AddBodyline('Good Day,');
        AddBodyline(lTxtNewLine);
        AddBodyline(STRSUBSTNO(Txt003, lRecPurchaseHeader."No.", lRecPurchaseHeader."Buy-from Contact"));
        AddBodyline(lTxtNewLine);
        AddBodyline('Please revert with delivery note.');
        AddBodyline(lTxtNewLine);
        AddBodyline(STRSUBSTNO(Txt005, lRecPurchaseHeader."Requested Receipt Date"));
        AddBodyline(lTxtNewLine);
        AddBodyline('Best regards.');
        AddBodyline(lTxtNewLine);
        AddBodyline(lTxtNewLine);
        AddBodyline('Frédéric MAGNIER');
        AddBodyline(lTxtNewLine);
        AddBodyline('Tel +33 3 21 19 66 37');
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo.Name);
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo.Address);
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo."Address 2");
        AddBodyline(lTxtNewLine);
        AddBodyline(STRSUBSTNO('%1 %2', lRecCompanyInfo."Post Code", lRecCompanyInfo.City));
        AddBodyline(lTxtNewLine);
        AddBodyline('FRANCE');
        AddBodyline(lTxtNewLine);
        AddBodyline(lRecCompanyInfo."Home Page");
        AddBodyline(lTxtNewLine);
        NewMessage(lRecVendor."E-Mail", '', '', STRSUBSTNO(Txt001, lRecPurchaseHeader."No."), '', lTxtFileName, TRUE);
    */
    end;

    procedure SetPrinterSelection(pReportID: Integer)
    begin
        TempRecPrinterSelNew.DELETEALL();
        TempRecPrinterSelMod.DELETEALL();
        IF gRecPrinterSelection.GET(USERID, pReportID) THEN BEGIN
            TempRecPrinterSelMod.INIT();
            TempRecPrinterSelMod.TRANSFERFIELDS(gRecPrinterSelection);
            TempRecPrinterSelMod.INSERT();
            gRecPrinterSelection."Printer Name" := 'Bullzip PDF Printer';
            gRecPrinterSelection.MODIFY();
        END ELSE BEGIN
            gRecPrinterSelection.INIT();
            gRecPrinterSelection."User ID" := USERID;
            gRecPrinterSelection."Report ID" := pReportID;
            gRecPrinterSelection."Printer Name" := 'Bullzip PDF Printer';
            gRecPrinterSelection.INSERT();
            TempRecPrinterSelNew.INIT();
            TempRecPrinterSelNew.TRANSFERFIELDS(gRecPrinterSelection);
            TempRecPrinterSelNew.INSERT();
        END;
        COMMIT();
    end;

    procedure DeletePrinterSelection()
    begin
        IF TempRecPrinterSelMod.FINDFIRST() THEN
            IF gRecPrinterSelection.GET(TempRecPrinterSelMod."User ID", TempRecPrinterSelMod."Report ID") THEN BEGIN
                gRecPrinterSelection."Printer Name" := TempRecPrinterSelMod."Printer Name";
                gRecPrinterSelection.MODIFY();
            END;
        IF TempRecPrinterSelNew.FINDFIRST() THEN BEGIN
            gRecPrinterSelection.GET(TempRecPrinterSelNew."User ID", TempRecPrinterSelNew."Report ID");
            gRecPrinterSelection.DELETE();
        END;
    end;

    procedure fInitBullZipPDF(pTxtFileName: Text[1024]) rTxtStatusFile: Text[1024]
    begin
        /*  rTxtStatusFile := gCUThreeTierMgt.ClientTempFileName('', 'ini');
         BullZipPDF := BullZipPDF.ComPdfSettings;
         BullZipPDFUtil := BullZipPDFUtil.ComPdfUtil;
         Init;
          PrinterName := BullZipPDFUtil.DefaultPrinterName;
          SetValue('Output', pTxtFileName);
          SetValue('ShowSaveAs', 'never');
          SetValue('ShowSettings', 'never');
          SetValue('ShowPDF', 'no');
          SetValue('ShowProgress', 'no');
          SetValue('ShowProgressFinished', 'no');
          SetValue('SuppressErrors', 'yes');
          SetValue('ConfirmOverwrite', 'no');
          SetValue('StatusFile', rTxtStatusFile);
          WriteSettings(TRUE);*/
    end;

    local procedure fWaitForFile(pTxtStatusFile: Text[1024])
    begin
        //TODO
        /*IF BullZipPDFUtil.WaitForFile(pTxtStatusFile, 20000) THEN BEGIN
            IF BullZipPDFUtil.ReadIniString(pTxtStatusFile, 'Status', 'Errors', '') <> '0' THEN
                ERROR('Erreur lors de la création du PDF. %1', BullZipPDFUtil.ReadIniString(pTxtStatusFile, 'Status', 'MessageText', ''));
        END ELSE
            ERROR('Erreur lors de la création du PDF.');*/
    end;

    local procedure fGetNewLine(): Text[30]
    var
        CR: Char;
        LF: Char;
    begin
        CR := 13;
        LF := 10;
        EXIT(FORMAT(CR) + FORMAT(LF))
    end;
}
