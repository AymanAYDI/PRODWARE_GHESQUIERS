table 50030 "PWD Customs Documents Template"
{
    Caption = 'Customs Documents Template';
    DrillDownPageID = "PWD Customs Document Template";
    LookupPageID = "PWD Customs Document Template";
    DataClassification = CustomerContent;

    fields
    {
        field(10; "No."; Code[10])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(12; "Attachment No."; Integer)
        {
            Caption = 'Attachment No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; Attachment; BLOB)
        {
            Caption = 'Attachment';
            DataClassification = CustomerContent;
        }
        field(14; "Storage Type"; Option)
        {
            Caption = 'Storage Type';
            OptionCaption = 'Embedded,Disk File,Exchange Storage';
            OptionMembers = Embedded,"Disk File","Exchange Storage";
            DataClassification = CustomerContent;
        }
        field(15; "Storage Pointer"; Text[250])
        {
            Caption = 'Storage Pointer';
            DataClassification = CustomerContent;
        }
        field(16; "File Extension"; Text[250])
        {
            Caption = 'File Extension';
            DataClassification = CustomerContent;
        }
        field(17; "Read Only"; Boolean)
        {
            Caption = 'Read Only';
            DataClassification = CustomerContent;
        }
        field(18; "Template Type"; Option)
        {
            Caption = 'Template Type';
            OptionCaption = 'Health Certificate';
            OptionMembers = "Health Certificate";
            DataClassification = CustomerContent;
        }
        field(19; Correspondence; Option)
        {
            Caption = 'Correspondence Type';
            InitValue = "Hard Copy";
            OptionCaption = ' ,Hard Copy,E-Mail,Fax';
            OptionMembers = " ","Hard Copy","E-Mail",Fax;
            DataClassification = CustomerContent;
        }
        field(20; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = CustomerContent;
        }
        field(21; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
            DataClassification = CustomerContent;
        }
        field(22; "Based On"; Option)
        {
            Caption = 'Based On';
            OptionCaption = 'Sales,Shipment';
            OptionMembers = Sales,Shipment;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RMSetup: Record "Marketing Setup";
        Text001: Label 'Replace existing attachment?';
        Text002: Label 'The attachment is empty.';
        Text003: Label 'Attachment is already in use on this machine.';
        Text004: Label 'When you have saved your document, click Yes to import the document.';
        Text005: Label 'Export Attachment';
        Text006: Label 'Import Attachment';
        Text007: Label 'All Files (*.*)|*.*';
        Text008: Label 'Error during copying file.';
        Text009: Label 'Do you want to remove %1?';
        Text010: Label 'External file could not be removed.';
        Text013: Label 'Only Microsoft Word documents can be printed.';
        Text014: Label 'Only Microsoft Word documents can be faxed.';


    procedure OpenAttachment(Caption: Text[260]; IsTemporary: Boolean)
    var
        WordManagement: Codeunit "Customs Sales Doc WordMngt";
        ShipWordManagement: Codeunit "Customs Shipmt Doc WordMngt";
        AttachmentManagement: Codeunit "PWD Customs Doc AttachmentMngt";
        FileName: Text[260];
    begin
        IF "Storage Type" = "Storage Type"::Embedded THEN BEGIN
            CALCFIELDS(Attachment);
            IF NOT Attachment.HASVALUE THEN
                ERROR(Text002);
        END;

        FileName := ConstFilename();
        IF EXISTS(FileName) THEN
            IF NOT DeleteFile(FileName) THEN
                ERROR(Text003);
        ExportAttachment(FileName);

        IF AttachmentManagement.UseComServer("File Extension", FALSE) THEN BEGIN
            IF "Based On" = "Based On"::Sales THEN
                WordManagement.OpenWordAttachment(Rec, FileName, Caption, IsTemporary) ELSE
                ShipWordManagement.OpenWordAttachment(Rec, FileName, Caption, IsTemporary)
        END ELSE BEGIN
            HYPERLINK(FileName);
            IF NOT "Read Only" THEN BEGIN
                IF CONFIRM(Text004, TRUE) THEN BEGIN
                    ImportAttachment(FileName, IsTemporary);
                    MODIFY(TRUE);
                END;
            END ELSE
                SLEEP(10000);
        END;

        DeleteFile(FileName);
    end;


    procedure ExportAttachment(ExportToFile: Text[260]): Boolean
    var
        CommonDialogMgt: Codeunit "Common Dialog Management";
        FileFilter: Text[260];
        FileName: Text[260];
    begin
        RMSetup.GET();
        CASE "Storage Type" OF
            "Storage Type"::Embedded:
                BEGIN
                    IF RMSetup."Attachment Storage Type" =
                       RMSetup."Attachment Storage Type"::"Disk File"
                    THEN
                        RMSetup.TESTFIELD("Attachment Storage Location");
                    CALCFIELDS(Attachment);
                    IF Attachment.HASVALUE THEN BEGIN
                        IF ExportToFile = '' THEN BEGIN
                            FileFilter := UPPERCASE("File Extension") + ' ';
                            FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
                            FileName := CommonDialogMgt.OpenFile(Text005, '', 4, FileFilter, 1);
                        END ELSE
                            FileName := ExportToFile;
                        IF FileName <> '' THEN BEGIN
                            Attachment.EXPORT(FileName);
                            EXIT(TRUE);
                        END ELSE
                            EXIT(FALSE)
                    END ELSE
                        EXIT(FALSE)
                END;

            "Storage Type"::"Disk File":
                BEGIN
                    IF RMSetup."Attachment Storage Type" =
                       RMSetup."Attachment Storage Type"::"Disk File"
                    THEN
                        RMSetup.TESTFIELD("Attachment Storage Location");
                    IF ExportToFile = '' THEN BEGIN
                        FileFilter := UPPERCASE("File Extension") + ' ';
                        FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
                        FileName := CommonDialogMgt.OpenFile(Text005, '', 4, FileFilter, 1);
                    END ELSE
                        FileName := ExportToFile;
                    IF FileName <> '' THEN BEGIN
                        IF FILE.COPY(ConstDiskFileName(), FileName) THEN
                            EXIT(TRUE)
                        ELSE
                            EXIT(FALSE);
                    END ELSE
                        EXIT(FALSE)
                END;
        END;
    end;


    procedure ImportAttachment(ImportFromFile: Text[260]; IsTemporary: Boolean): Boolean
    var
        CommonDialogMgt: Codeunit "Common Dialog Management";
        AttachmentManagement: Codeunit "PWD Customs Doc AttachmentMngt";
        FileName: Text[260];
    begin
        IF IsTemporary THEN BEGIN
            IF ImportFromFile = '' THEN
                FileName := CommonDialogMgt.OpenFile(Text006, ImportFromFile, 4, Text007, 0)
            ELSE
                FileName := ImportFromFile;
            IF FileName <> '' THEN BEGIN
                Attachment.IMPORT(FileName);
                "File Extension" := UPPERCASE(AttachmentManagement.FileExtension(FileName));
                EXIT(TRUE)
            END ELSE
                EXIT(FALSE);
        END;

        TESTFIELD("Read Only", FALSE);
        RMSetup.GET();
        IF RMSetup."Attachment Storage Type" = RMSetup."Attachment Storage Type"::"Disk File" THEN
            RMSetup.TESTFIELD("Attachment Storage Location");

        IF ImportFromFile = '' THEN
            FileName := CommonDialogMgt.OpenFile(Text006, '', 4, Text007, 0)
        ELSE
            FileName := ImportFromFile;

        IF FileName <> '' THEN BEGIN
            IF "Storage Pointer" = '' THEN
                "Storage Pointer" := RMSetup."Attachment Storage Location";
            IF RMSetup."Attachment Storage Type" =
              RMSetup."Attachment Storage Type"::"Disk File"
            THEN BEGIN
                IF NOT FILE.COPY(FileName, ConstDiskFileName()) THEN
                    ERROR(
                      Text008);
                "File Extension" := UPPERCASE(AttachmentManagement.FileExtension(FileName));
                "Storage Pointer" := RMSetup."Attachment Storage Location";
                "Storage Type" := "Storage Type"::"Disk File";
                MODIFY(TRUE);
            END ELSE BEGIN
                Attachment.IMPORT(FileName);
                "File Extension" := UPPERCASE(AttachmentManagement.FileExtension(FileName));
                "Storage Type" := "Storage Type"::Embedded;
                IF MODIFY(TRUE) THEN;
            END;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;


    procedure RemoveAttachment(Prompt: Boolean) DeleteOK: Boolean
    var
        DeleteYesNo: Boolean;
    begin
        DeleteOK := FALSE;
        DeleteYesNo := TRUE;
        IF Prompt THEN
            IF NOT CONFIRM(
              Text009, FALSE, TABLECAPTION)
            THEN
                DeleteYesNo := FALSE;

        IF DeleteYesNo THEN BEGIN
            IF "Storage Type" = "Storage Type"::"Disk File" THEN
                IF NOT DeleteFile(ConstDiskFileName()) THEN
                    MESSAGE(Text010);
            Rec.DELETE(TRUE);
            DeleteOK := TRUE;
        END;
    end;


    procedure WizSaveAttachment()
    var
        Attachment2: Record "PWD Customs Documents Template";
        FileName: Text[260];
    begin
        RMSetup.GET();
        IF RMSetup."Attachment Storage Type" = RMSetup."Attachment Storage Type"::Embedded THEN BEGIN
            "Storage Pointer" := '';
            EXIT;
        END;

        "Storage Pointer" := RMSetup."Attachment Storage Location";
        IF "No." <> '' THEN BEGIN
            FileName := ConstDiskFileName();
            IF FileName <> '' THEN
                Attachment.EXPORT(FileName);
        END;

        Attachment2."No." := Rec."No.";
        Attachment2."Storage Type" := Attachment2."Storage Type"::"Disk File";
        Attachment2."Storage Pointer" := RMSetup."Attachment Storage Location";
        Attachment2."File Extension" := Rec."File Extension";
        Attachment2."Read Only" := Rec."Read Only";
        //"Last Date Modified" := Rec."Last Date Modified";
        //"Last Time Modified" := Rec."Last Time Modified";
        CLEAR(Rec);
        Rec := Attachment2;
    end;


    procedure DeleteFile(FileName: Text[260]): Boolean
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


    procedure ConstFilename() FileName: Text[260]
    var
        I: Integer;
        DocNo: Text[30];
    begin
        REPEAT
            IF I <> 0 THEN
                DocNo := FORMAT(I);
            //todo
            //FileName := ENVIRON('TEMP') + Text012 + DocNo + '.' + "File Extension";
            IF NOT EXISTS(FileName) THEN
                EXIT;
            I := I + 1;
        UNTIL I = 999;
    end;


    procedure ConstDiskFileName() DiskFileName: Text[260]
    begin
        DiskFileName := "Storage Pointer" + '\' + FORMAT("No.") + '.';
    end;


    procedure CheckCorrespondenceType(CorrespondenceType: Option " ","Hard Copy","E-Mail",Fax) ErrorText: Text[80]
    begin
        CASE CorrespondenceType OF
            CorrespondenceType::"Hard Copy":
                IF UPPERCASE("File Extension") <> 'DOC' THEN
                    EXIT(Text013);
            CorrespondenceType::"E-Mail":
                EXIT('');
            CorrespondenceType::Fax:
                IF UPPERCASE("File Extension") <> 'DOC' THEN
                    EXIT(Text014);
        END;
    end;


    procedure CreateAttachment()
    var
        Attachment: Record "PWD Customs Documents Template";
        WordManagement: Codeunit "Customs Sales Doc WordMngt";
        ShipWordManagement: Codeunit "Customs Shipmt Doc WordMngt";
        AttachmentManagement: Codeunit "PWD Customs Doc AttachmentMngt";
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
        END;

        IF AttachmentManagement.UseComServer('DOC', TRUE) THEN;

        IF "Based On" = "Based On"::Sales THEN
            WordManagement.CreateWordAttachment("No." + ' ' + Description, "No.") ELSE
            IF "Based On" = "Based On"::Shipment THEN
                ShipWordManagement.CreateWordAttachment("No." + ' ' + Description, "No.");
    end;
}

