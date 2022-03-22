codeunit 50002 "Customs Shipmt Doc WordMngt"
{

    trigger OnRun()
    begin
    end;

    var
        Text003: Label 'Merging Microsoft Word Documents...\\';
        Text004: Label 'Preparing';
        Text005: Label 'Program status';
        Text006: Label 'Preparing Merge...';
        Text007: Label 'Waiting for print job...';
        Text008: Label 'Transferring %1 data to Microsoft Word...';
        Text009: Label 'Sending individual mails...';
        Text010: Label '%1 %2 must have %3 DOC.';
        Text011: Label 'Attachment file error';
        Text012: Label 'Creating merge source...';
        Text013: Label 'Microsoft Word is opening merge source...';
        Text014: Label 'Merging %1 in Microsoft Word...';
        Text015: Label 'FaxMailTo';
        Text017: Label 'The merge source file is locked by another process.\';
        Text018: Label 'Please try again later.';
        Text019: Label ' Mail Address';
        Text020: Label 'Document ';
        Text021: Label 'Import attachment ';
        Text022: Label 'Delete %1?';
        Text023: Label 'Another user has modified the record for this %1\after you retrieved it from the database.\\';
        Text025: Label 'Enter the changes again in the updated document.';
        Text027: Label '\Doc';
        Text029: Label '\MergeSource';
        Window: Dialog;
        AttachmentManagement: Codeunit "PWD Customs Doc AttachmentMngt";
        Text030: Label 'Formal Salutation';
        Text031: Label 'Informal Salutation';


    procedure CreateWordAttachment(WordCaption: Text[260]; AttchmentNo: Code[10]) NewAttachNo: Code[10]
    var
        Attachment: Record "PWD Customs Documents Template";
        AttachmentManagement: Codeunit "PWD Customs Doc AttachmentMngt";
        wrdApp: Automation;
        wrdDoc: Automation;
        wrdMergefile: Automation;
        FileName: Text[260];
        MergeFileName: Text[260];
        ParamInt: Integer;
    begin
        Attachment.GET(AttchmentNo);
        Attachment."File Extension" := 'DOC';

        IF ISCLEAR(wrdApp) THEN
            CREATE(wrdApp);
        IF ISCLEAR(wrdMergefile) THEN
            CREATE(wrdMergefile);

        MergeFileName := ConstMergeSourceFileName();
        CreateHeader(wrdMergefile, TRUE, MergeFileName);

        wrdDoc := wrdApp.Documents.Add;
        wrdDoc.MailMerge.MainDocumentType := 0;
        ParamInt := 7;
        wrdDoc.MailMerge.OpenDataSource2000(MergeFileName, ParamInt);

        FileName := Attachment.ConstFilename();
        wrdDoc.SaveAs2000(FileName);
        wrdDoc.ActiveWindow.Caption := WordCaption;
        wrdDoc.Saved := TRUE;
        wrdApp.Visible := TRUE;
        IF WordHandler(wrdDoc, Attachment, WordCaption, FALSE, FileName) THEN
            NewAttachNo := Attachment."No."
        ELSE
            NewAttachNo := '';
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
        CLEAR(wrdApp);
        DeleteFile(MergeFileName);
    end;

    procedure OpenWordAttachment(var Attachment: Record "PWD Customs Documents Template"; FileName: Text[260]; Caption: Text[260]; IsTemporary: Boolean)
    var
        wrdApp: Automation;
        wrdDoc: Automation;
        wrdMergefile: Automation;
        ParamFalse: Boolean;
        MergeFileName: Text[260];
        ParamInt: Integer;
    begin
        IF ISCLEAR(wrdApp) THEN
            CREATE(wrdApp);
        IF ISCLEAR(wrdMergefile) THEN
            CREATE(wrdMergefile);
        MergeFileName := ConstMergeSourceFileName();
        CreateHeader(wrdMergefile, TRUE, MergeFileName);
        ParamFalse := FALSE;
        wrdDoc := wrdApp.Documents.Open2000(FileName, ParamFalse, Attachment."Read Only");
        IF wrdDoc.MailMerge.MainDocumentType = -1 THEN BEGIN
            wrdDoc.MailMerge.MainDocumentType := 0;
            MergeFileName := ConstMergeSourceFileName();
            CreateHeader(wrdMergefile, TRUE, MergeFileName);
            wrdDoc.MailMerge.OpenDataSource2000(MergeFileName, ParamInt);
        END;
        IF wrdDoc.MailMerge.Fields.Count > 0 THEN BEGIN
            IF ISCLEAR(wrdMergefile) THEN
                CREATE(wrdMergefile);
            ParamInt := 7;
            wrdDoc.MailMerge.OpenDataSource2000(MergeFileName, ParamInt);
        END;
        wrdDoc.ActiveWindow.Caption := Caption;
        wrdDoc.ActiveWindow.WindowState := 1;
        wrdDoc.Saved := TRUE;
        wrdApp.Visible := TRUE;
        WordHandler(wrdDoc, Attachment, Caption, IsTemporary, FileName);
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
        CLEAR(wrdApp);
        DeleteFile(MergeFileName);
    end;

    procedure Merge(var ShipmentLine: Record "Sales Shipment Line" temporary; var Attachement: Record "PWD Customs Documents Template"; TemplateCode: Code[10])
    var
        wrdApp: Automation;
        wrdMergefile: Automation;
        WordHided: Boolean;
        Param: Boolean;
    begin
        Window.OPEN(
          Text003 +
          '#1############ \' +
          '#5############ #6################################');
        Window.UPDATE(1, Text004);
        Window.UPDATE(5, Text005);
        IF ISCLEAR(wrdApp) THEN
            CREATE(wrdApp);
        IF ISCLEAR(wrdMergefile) THEN
            CREATE(wrdMergefile);
        IF wrdApp.Documents.Count > 0 THEN BEGIN
            wrdApp.Visible := FALSE;
            WordHided := TRUE;
        END;
        Window.UPDATE(6, Text006);
        IF ShipmentLine.FIND('-') THEN
            REPEAT
                ExecuteMerge(wrdApp, ShipmentLine, Attachement, TemplateCode);
            UNTIL ShipmentLine.NEXT() = 0;
        IF WordHided THEN
            wrdApp.Visible := TRUE
        ELSE BEGIN
            IF wrdApp.BackgroundPrintingStatus <> 0 THEN
                REPEAT
                    Window.UPDATE(6, Text007);
                    SLEEP(500);
                UNTIL wrdApp.BackgroundPrintingStatus = 0;
            Param := FALSE;
            wrdApp.Quit(Param)
        END;

        CLEAR(wrdMergefile);
        CLEAR(wrdApp);
    end;

    local procedure ExecuteMerge(var wrdApp: Automation; var ShipmentLine: Record "Sales Shipment Line" temporary; Attachment: Record "PWD Customs Documents Template"; TemplateCode: Code[10])
    var
        Country2: Record "Country/Region";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        WordTemplate: Record "PWD Customs Documents Template";
        wrdDoc: Automation;
        wrdMergefile: Automation;
        FormatAddr: Codeunit "Format Address";
        Mail: Codeunit Mail;
        MergeFileName: Text[260];
        MainFileName: Text[260];
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        NoOfRecords: Integer;
        ParamBln: Boolean;
        ParamInt: Integer;
        ContAddr: array[8] of Text[50];
        ContAddr2: array[8] of Text[50];
        MultiAddress: array[2] of Text[260];
        i: Integer;
        ShowShippingAddr: Boolean;
        TextShipAddr: Label 'Ship-to Adress';
        ShipmentHeader: Record "Sales Shipment Header";
        Item: Record Item;
    begin
        WordTemplate.GET(TemplateCode);
        Window.UPDATE(6, STRSUBSTNO(Text008,
                FORMAT(WordTemplate.Correspondence)));

        IF NOT DocContainMergefields(Attachment) THEN BEGIN
            CASE WordTemplate.Correspondence OF
                WordTemplate.Correspondence::"Hard Copy":
                    BEGIN
                        MainFileName := ConstDocFilename();
                        Attachment.ExportAttachment(MainFileName);
                        wrdDoc := wrdApp.Documents.Open2000(MainFileName);
                        wrdDoc.PrintOut2000;
                        ParamBln := FALSE;
                        wrdDoc.Close(ParamBln);
                    END;
                WordTemplate.Correspondence::"E-Mail":
                    BEGIN
                        Window.UPDATE(6, Text009);
                        Attachment.TESTFIELD("File Extension");
                        MainFileName := ConstDocFilename();
                        Attachment.ExportAttachment(MainFileName);
                        DeleteFile(MainFileName);
                    END;
            END;
            EXIT;
        END;
        MergeFileName := ConstMergeSourceFileName();
        IF DeleteFile(MergeFileName) THEN;
        CREATE(wrdMergefile);
        CreateHeader(wrdMergefile, FALSE, MergeFileName);
        MainFileName := ConstDocFilename();
        IF Attachment."File Extension" <> 'DOC' THEN
            ERROR(STRSUBSTNO(Text010, Attachment.TABLECAPTION, Attachment."No.",
              Attachment.FIELDCAPTION("File Extension")));
        IF AttachmentManagement.UseComServer(Attachment."File Extension", TRUE) THEN;
        IF NOT Attachment.ExportAttachment(MainFileName) THEN
            ERROR(Text011);
        Window.UPDATE(6, Text012);
        CompanyInfo.GET();
        IF NOT Country2.GET(CompanyInfo."Country/Region Code") THEN
            CLEAR(Country2);
        IF NOT ShipmentHeader.GET(ShipmentLine."Document No.") THEN
            CLEAR(ShipmentHeader);
        FormatAddr.SalesShptShipTo(ShipToAddr, ShipmentHeader);
        FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
            IF ShipToAddr[i] <> CustAddr[i] THEN
                ShowShippingAddr := TRUE;
        IF NOT ShowShippingAddr THEN
            CLEAR(ShipToAddr);
        IF NOT Item.GET(ShipmentLine."No.") THEN
            CLEAR(Item);
        AddField(CompanyInfo.Name);
        AddField(CompanyInfo."Name 2");
        AddField(CompanyInfo.Address);
        AddField(CompanyInfo."Address 2");
        AddField(CompanyInfo."Post Code");
        AddField(CompanyInfo.City);
        AddField(CompanyInfo.County);
        AddField(Country2.Name);
        AddField(CompanyInfo."VAT Registration No.");
        AddField(CompanyInfo."Registration No.");
        AddField(CompanyInfo."Phone No.");
        AddField(CompanyInfo."Fax No.");
        AddField(ShipmentLine."No.");
        AddField(FORMAT(ShipmentLine."Shipment Date", 0, 4));
        AddField(ShipmentLine.Description);
        AddField(ShipmentLine."Bill-to Customer No.");
        AddField(FORMAT(ShipmentLine."PWD Output Date"));
        AddField(ShipmentLine."PWD Health Approval No.");
        AddField(ShipmentLine.Mark());
        AddField(FORMAT(ShipmentLine."Shipment Date", 0, 4));
        AddField(FORMAT(Item."PWD Conserving Temperature"));
        AddField(FORMAT(Item."PWD Transport Temperature"));
        IF ShowShippingAddr THEN
            AddField(TextShipAddr)
        ELSE
            AddField('');
        AddField(ShipToAddr[1]);
        AddField(ShipToAddr[2]);
        AddField(ShipToAddr[3]);
        AddField(ShipToAddr[4]);
        AddField(ShipToAddr[5]);
        AddField(ShipToAddr[6]);
        AddField(ShipToAddr[7]);
        AddField(ShipToAddr[8]);
        AddField(PaymentTerms.Description);
        AddField(ShipmentMethod.Description);
        WriteLine;
        wrdMergefile.CloseFile;

        wrdDoc := wrdApp.Documents.Open2000(MainFileName);
        wrdDoc.MailMerge.MainDocumentType := 0;

        Window.UPDATE(6, Text013);
        ParamInt := 7;
        wrdDoc.MailMerge.OpenDataSource2000(MergeFileName, ParamInt);
        Window.UPDATE(6, STRSUBSTNO(Text014, WordTemplate.Correspondence));
        CASE WordTemplate.Correspondence OF
            WordTemplate.Correspondence::Fax:
                BEGIN
                    wrdDoc.MailMerge.Destination := 3;
                    wrdDoc.MailMerge.MailAddressFieldName := Text015;
                    wrdDoc.MailMerge.MailAsAttachment := TRUE;
                    wrdDoc.MailMerge.Execute;
                END;
            WordTemplate.Correspondence::"E-Mail":
                BEGIN
                    wrdDoc.MailMerge.Destination := 2;
                    wrdDoc.MailMerge.MailAddressFieldName := Text015;
                    wrdDoc.MailMerge.MailSubject := ShipmentLine."No.";
                    wrdDoc.MailMerge.MailAsAttachment := FALSE;
                    wrdDoc.MailMerge.Execute;
                END;
            WordTemplate.Correspondence::"Hard Copy":
                BEGIN
                    wrdDoc.MailMerge.Destination := 0;
                    wrdDoc.MailMerge.Execute;
                    wrdApp.ActiveDocument.PrintOut2000;
                    ParamBln := FALSE;
                    wrdApp.ActiveDocument.Close(ParamBln);
                END;
        END;

        ParamBln := FALSE;
        wrdDoc.Close(ParamBln);
        ERASE(MainFileName);
        ERASE(MergeFileName);
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
    end;

    procedure ShowMergedDocument(var ShipmentLine: Record "Sales Shipment Line" temporary; var Attachment: Record "PWD Customs Documents Template"; WordCaption: Text[260]; IsTemporary: Boolean; TemplateCode: Code[10])
    var
        Country2: Record "Country/Region";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        wrdMergefile: Automation;
        wrdApp: Automation;
        wrdDoc: Automation;
        AppExcel: Automation;
        FormatAddr: Codeunit "Format Address";
        MergeFileName: Text[260];
        MainFileName: Text[260];
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        ParamInt: Integer;
        ParamFalse: Boolean;
        i: Integer;
        j: Integer;
        ShowShippingAddr: Boolean;
        TextShipAddr: Label 'Ship-to Adress';
        ShipmentHeader: Record "Sales Shipment Header";
        Item: Record Item;
    begin
        IF NOT AttachmentManagement.UseComServer(Attachment."File Extension", TRUE) THEN
            ERROR(STRSUBSTNO(Text010, Attachment.TABLECAPTION, Attachment."No.",
              Attachment.FIELDCAPTION("File Extension")));

        IF ISCLEAR(wrdApp) THEN
            CREATE(wrdApp);
        IF ISCLEAR(wrdMergefile) THEN
            CREATE(wrdMergefile);
        IF NOT DocContainMergefields(Attachment) THEN BEGIN
            MainFileName := ConstDocFilename();
            Attachment.ExportAttachment(MainFileName);
            ParamFalse := FALSE;
            wrdDoc := wrdApp.Documents.Open2000(MainFileName, ParamFalse, Attachment."Read Only");
            wrdDoc.ActiveWindow.Caption := WordCaption;
            wrdDoc.Saved := TRUE;
            wrdApp.Visible := TRUE;
            WordHandler(wrdDoc, Attachment, WordCaption, FALSE, MainFileName);
        END ELSE BEGIN
            MergeFileName := ConstMergeSourceFileName();
            IF ERASE(MergeFileName) THEN;

            CreateHeader(wrdMergefile, FALSE, MergeFileName);
            MainFileName := ConstDocFilename();
            IF NOT Attachment.ExportAttachment(MainFileName) THEN
                ERROR(Text011);
            CompanyInfo.GET();
            IF NOT Country2.GET(CompanyInfo."Country/Region Code") THEN
                CLEAR(Country2);
            IF NOT ShipmentHeader.GET(ShipmentLine."Document No.") THEN
                CLEAR(ShipmentHeader);
            FormatAddr.SalesShptBillTo(ShipToAddr, ShipmentHeader);
            FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                IF ShipToAddr[i] <> CustAddr[i] THEN
                    ShowShippingAddr := TRUE;
            IF NOT ShowShippingAddr THEN
                CLEAR(ShipToAddr);
            IF NOT Item.GET(ShipmentLine."No.") THEN
                CLEAR(Item);
            AddField(CompanyInfo.Name);
            AddField(CompanyInfo."Name 2");
            AddField(CompanyInfo.Address);
            AddField(CompanyInfo."Address 2");
            AddField(CompanyInfo."Post Code");
            AddField(CompanyInfo.City);
            AddField(CompanyInfo.County);
            AddField(Country2.Name);
            AddField(CompanyInfo."VAT Registration No.");
            AddField(CompanyInfo."Registration No.");
            AddField(CompanyInfo."Phone No.");
            AddField(CompanyInfo."Fax No.");
            AddField(ShipmentLine."No.");
            AddField(FORMAT(ShipmentLine."Shipment Date", 0, 4));
            AddField(ShipmentLine.Description);
            AddField(ShipmentLine."Bill-to Customer No.");
            AddField(FORMAT(ShipmentLine."PWD Output Date"));
            AddField(ShipmentLine."PWD Health Approval No.");
            AddField(ShipmentLine.Mark());
            AddField(FORMAT(Item."PWD Conserving Temperature"));
            AddField(FORMAT(Item."PWD Transport Temperature"));
            IF ShowShippingAddr THEN
                AddField(TextShipAddr)
            ELSE
                AddField('');
            AddField(ShipToAddr[1]);
            AddField(ShipToAddr[2]);
            AddField(ShipToAddr[3]);
            AddField(ShipToAddr[4]);
            AddField(ShipToAddr[5]);
            AddField(ShipToAddr[6]);
            AddField(ShipToAddr[7]);
            AddField(ShipToAddr[8]);
            AddField(PaymentTerms.Description);
            AddField(ShipmentMethod.Description);
            AddField('');
            WriteLine;
            CloseFile;

            ParamFalse := FALSE;
            wrdDoc := wrdApp.Documents.Open2000(MainFileName, ParamFalse, Attachment."Read Only");
            wrdDoc.MailMerge.MainDocumentType := 0;
            ParamInt := 7;
            wrdDoc.MailMerge.OpenDataSource2000(MergeFileName, ParamInt);
            ParamInt := 9999998;
            wrdDoc.MailMerge.ViewMailMergeFieldCodes(ParamInt);
            wrdDoc.ActiveWindow.Caption := WordCaption;
            wrdDoc.Saved := TRUE;
            wrdApp.Visible := TRUE;
        END;

        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
        CLEAR(wrdApp);

        DeleteFile(MergeFileName);
    end;

    local procedure CreateHeader(var wrdMergefile: Automation; MergeFieldsOnly: Boolean; MergeFileName: Text[260])
    var
        Country: Record "Country/Region";
        CompanyInfo: Record "Company Information";
        ShipmentHeader: Record "Sales Shipment Header";
        ShipmentLine: Record "Sales Shipment Line";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        I: Integer;
        CreateOk: Boolean;
        TextAddrCust: Label 'Customer Adresse';
        TextShipAddr: Label 'Ship-to Adress';
        Item: Record Item;
    begin
        CreateOk := TRUE;
        IF NOT wrdMergefile.CreateFile(MergeFileName) THEN
            ERROR(Text017 + Text018);
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(Name));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Name 2"));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(Address));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Address 2"));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Post Code"));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(City));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(County));
        AddField(CompanyInfo.TABLECAPTION + ' ' + Country.TABLECAPTION + ' ' +
          Country.FIELDCAPTION(Name));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("VAT Registration No."));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Registration No."));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Phone No."));
        AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Fax No."));
        AddField(ShipmentLine.TABLECAPTION + ' ' + ShipmentLine.FIELDCAPTION("No."));
        AddField(ShipmentLine.TABLECAPTION + ' ' + ShipmentLine.FIELDCAPTION("Shipment Date"));
        AddField(ShipmentLine.TABLECAPTION + ' ' + ShipmentLine.FIELDCAPTION(Description));
        AddField(ShipmentLine.TABLECAPTION + ' ' + ShipmentLine.FIELDCAPTION("Bill-to Customer No."));
        AddField(ShipmentLine.TABLECAPTION + ' ' + ShipmentLine.FIELDCAPTION("Output Date"));
        AddField(ShipmentLine.TABLECAPTION + ' ' + ShipmentLine.FIELDCAPTION("Health Approval No."));
        AddField(ShipmentLine.TABLECAPTION + ' ' + ShipmentLine.FIELDCAPTION(Mark()));
        AddField(Item.TABLECAPTION + ' ' + Item.FIELDCAPTION(Item."Conserving Temperature"));
        AddField(Item.TABLECAPTION + ' ' + Item.FIELDCAPTION(Item."Transport Temperature"));
        IF NOT ShipmentHeader.GET(ShipmentLine."Document No.") THEN
            CLEAR(ShipmentHeader);
        AddField('Text ' + TextShipAddr);
        FOR I := 1 TO 8 DO
            AddField(ShipmentHeader.TABLECAPTION + ' ' + TextShipAddr + ' ' + FORMAT(I));
        AddField(PaymentTerms.TABLECAPTION + ' ' + PaymentTerms.FIELDCAPTION(Description));
        AddField(ShipmentMethod.TABLECAPTION + ' ' + ShipmentMethod.FIELDCAPTION(Description));
        AddField(Text015);
        WriteLine;
        IF MergeFieldsOnly THEN BEGIN
            FOR I := 1 TO 47 DO
                AddField('');
            WriteLine;
            CloseFile;
        END;
    end;


    procedure WordHandler(var wrdDoc: Automation; var Attachment: Record "PWD Customs Documents Template"; Caption: Text[260]; IsTemporary: Boolean; FileName: Text[260]) DocImported: Boolean
    var
        Attachment2: Record "PWD Customs Documents Template";
        wrdHandler: Automation;
        NewFileName: Text[260];
    begin
        CREATE(wrdHandler);
        NewFileName := wrdHandler.WaitForDocument(wrdDoc);

        IF NOT Attachment."Read Only" THEN
            IF wrdHandler.DocIsClosed THEN
                IF wrdHandler.DocChanged THEN BEGIN
                    CLEAR(wrdHandler);
                    IF CONFIRM(Text021 + Caption + '?', TRUE) THEN BEGIN
                        IF (NOT IsTemporary) AND Attachment2.GET(Attachment."No.") THEN
                            IF Attachment2."Last Time Modified" <> Attachment."Last Time Modified" THEN BEGIN
                                DeleteFile(FileName);
                                IF NewFileName <> FileName THEN
                                    IF CONFIRM(
                                      STRSUBSTNO(Text022, NewFileName), FALSE)
                                    THEN
                                        DeleteFile(NewFileName);
                                ERROR(
                                  STRSUBSTNO(Text023 + Text025, Attachment.TABLECAPTION));
                            END;
                        Attachment.ImportAttachment(NewFileName, IsTemporary);
                        DeleteFile(NewFileName);
                        DocImported := TRUE;
                    END;
                END;

        IF NOT ISCLEAR(wrdHandler) THEN
            CLEAR(wrdHandler);

        DeleteFile(FileName);
    end;

    procedure DeleteFile(FileName: Text[260]) DeleteOk: Boolean
    var
        I: Integer;
    begin
        IF FileName = '' THEN
            EXIT(FALSE);

        IF NOT EXISTS(FileName) THEN
            EXIT(TRUE);

        REPEAT
            SLEEP(250);
            I := I + 1;
        UNTIL ERASE(FileName) OR (I = 25);
        EXIT(NOT EXISTS(FileName));
    end;

    procedure ConstDocFilename() FileName: Text[260]
    var
        I: Integer;
        DocNo: Text[30];
    begin
        REPEAT
            IF I <> 0 THEN
                DocNo := FORMAT(I);
            FileName := ENVIRON('TEMP') + Text027 + DocNo + '.DOC';
            IF NOT EXISTS(FileName) THEN
                EXIT;
            I := I + 1;
        UNTIL I = 999;
    end;

    procedure ConstMergeSourceFileName() FileName: Text[260]
    var
        DocNo: Text[30];
        I: Integer;
    begin
        REPEAT
            IF I <> 0 THEN
                DocNo := FORMAT(I);
            FileName := ENVIRON('TEMP') + Text029 + DocNo + '.HTM';
            IF NOT EXISTS(FileName) THEN
                EXIT;
            I := I + 1;
        UNTIL I = 999;
    end;


    procedure DocContainMergefields(var Attachment: Record "PWD Customs Documents Template") MergeFields: Boolean
    var
        [WithEvents]
        wrdApp: Automation;
        wrdDoc: Automation;
        ParamBln: Boolean;
        FileName: Text[260];
    begin
        IF ISCLEAR(wrdApp) THEN
            CREATE(wrdApp);

        IF UPPERCASE(Attachment."File Extension") <> 'DOC' THEN
            EXIT(FALSE);
        FileName := Attachment.ConstFilename();
        Attachment.ExportAttachment(FileName);
        wrdDoc := wrdApp.Documents.Open2000(FileName);
        MergeFields := (wrdDoc.MailMerge.Fields.Count > 0);
        ParamBln := FALSE;
        wrdDoc.Close(ParamBln);
        ERASE(FileName);

        CLEAR(wrdDoc);
        CLEAR(wrdApp);
    end;
}

