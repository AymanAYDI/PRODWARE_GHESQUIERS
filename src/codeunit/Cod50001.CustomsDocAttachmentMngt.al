codeunit 50001 "PWD Customs Doc AttachmentMngt"
{//TODO Automation
 /*
     trigger OnRun()
     begin
     end;

     var
         Text000: Label 'Send attachments...\\';
         Text001: Label 'Preparing';
         Text002: Label 'Deliver misc.';
         Text005: Label '\Attachment.%1';
         Text007: Label 'This feature requires that Microsoft Word 2000 is installed on your system.';

     procedure InsertAttachment(AttachmentNo: Integer): Integer
     var
         Attachment: Record "PWD Customs Documents Template";
         Attachment2: Record "PWD Customs Documents Template";
         Attachment3: Record "PWD Customs Documents Template";
         "NextAttachmentNo.": Integer;
     begin
     end;

     procedure FileExtension(FileName: Text[260]) Extension: Text[260]
     var
         I: Integer;
     begin
         I := STRLEN(FileName);
         WHILE COPYSTR(FileName, I, 1) <> '.' DO
             I := I - 1;
         Extension := COPYSTR(FileName, I + 1, STRLEN(FileName) - I);
     end;

     local procedure TransferAttachment(FromAttachment: Record "PWD Customs Documents Template"; var ToAttachment: Record "PWD Customs Documents Template")
     var
         RMSetup: Record "Marketing Setup";
     begin
         IF (FromAttachment."Storage Type" = FromAttachment."Storage Type"::Embedded) AND
            (ToAttachment."Storage Type" = ToAttachment."Storage Type"::"Disk File")
         THEN BEGIN
             FromAttachment.ExportAttachment(ToAttachment.ConstDiskFileName());
             CLEAR(ToAttachment.Attachment);
             RMSetup.GET();
             RMSetup.TESTFIELD("Attachment Storage Location");
             ToAttachment."Storage Pointer" := RMSetup."Attachment Storage Location";
             ToAttachment.MODIFY();
         END;

         IF (FromAttachment."Storage Type" = FromAttachment."Storage Type"::"Disk File") AND
            (ToAttachment."Storage Type" = ToAttachment."Storage Type"::"Disk File")
         THEN BEGIN
             RMSetup.GET();
             RMSetup.TESTFIELD("Attachment Storage Location");
             ToAttachment."Storage Pointer" := RMSetup."Attachment Storage Location";
             ToAttachment.MODIFY();
             FILE.COPY(FromAttachment.ConstDiskFileName(), ToAttachment.ConstDiskFileName());
         END;

         IF (FromAttachment."Storage Type" = FromAttachment."Storage Type"::"Disk File") AND
            (ToAttachment."Storage Type" = ToAttachment."Storage Type"::Embedded)
         THEN BEGIN
             ToAttachment.ImportAttachment(FromAttachment.ConstDiskFileName(), FALSE);
             ToAttachment."File Extension" := FromAttachment."File Extension";
             ToAttachment."Storage Pointer" := '';
             ToAttachment.MODIFY();
         END;
     end;

     procedure UseComServer(FileExtension: Text[250]; RequireAutomation: Boolean): Boolean
     var
         AutomationServers: Record "Automation Server";
     begin
         IF UPPERCASE(FileExtension) <> 'DOC' THEN
             EXIT(FALSE);

         SETRANGE(GUID, '{00020905-0000-0000-C000-000000000046}');
         SETFILTER(Version, '>=%1', '8.1');
         IF FindFirst() THEN
             EXIT(TRUE);

         IF RequireAutomation THEN
             ERROR(Text007)
         ELSE
             EXIT(FALSE);
     end;
     */
}
