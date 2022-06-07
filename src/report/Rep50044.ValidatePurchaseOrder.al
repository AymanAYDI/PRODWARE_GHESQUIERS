report 50044 "PWD Validate Purchase Order"
{
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem(PurchHeader; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");

            trigger OnAfterGetRecord()
            begin
                Code();
            end;

            trigger OnPreDataItem()
            begin
                IF PostingDate = 0D THEN
                    ERROR(Text1000000003);
                IF DocumentDate = 0D THEN
                    ERROR(Text1000000004);
                PurchHeader.SETRANGE(PurchHeader."Document Type", DocType);
                PurchHeader.SETRANGE(PurchHeader."No.", NumDocument);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Control1000000001)
                {
                    field("Field_PostingDate"; PostingDate)
                    {
                        Caption = 'Date de comptabilisation';
                        ApplicationArea = All;
                    }
                    field("Field_DocumentDate"; DocumentDate)
                    {
                        Caption = 'Date de document';
                        ApplicationArea = All;
                    }
                    field("Field_ToReceive"; ToReceive)
                    {
                        Caption = 'Receptionner';
                        ApplicationArea = All;
                    }
                    field("Field_ToInvoice"; "PWD ToInvoice")
                    {
                        Caption = 'Facturer';
                        ApplicationArea = All;
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

    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ReportSelection: Record "Report Selections";
        PurchPost: Codeunit "Purch.-Post";
        Gbool_Print: Boolean;
        "PWD ToInvoice": Boolean;
        ToReceive: Boolean;
        NumDocument: Code[20];
        DocumentDate: Date;
        PostingDate: Date;
        Text001: Label 'Do you want to post the %1?';
        Text1000000003: Label 'Please enter a posting date !';
        Text1000000004: Label 'Please enter a document date !';
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";

    procedure InitRequete(PurchHeader1: Record "Purchase Header")
    begin
        PostingDate := WORKDATE();
        DocumentDate := WORKDATE();
        DocType := PurchHeader1."Document Type".AsInteger();
        NumDocument := PurchHeader1."No.";
        ToReceive := TRUE;
        "PWD ToInvoice" := TRUE;
    end;

    local procedure "Code"()
    var
        GcduPuchPrint: Codeunit "Purch.-Post + Print";
    begin
        PurchHeader.VALIDATE("Posting Date", PostingDate);
        PurchHeader.VALIDATE("Document Date", DocumentDate);
        PurchHeader.Receive := ToReceive;
        PurchHeader.Invoice := "PWD ToInvoice";
        CASE PurchHeader."Document Type" OF
            PurchHeader."Document Type"::Order:
                ;
            PurchHeader."Document Type"::"Return Order":
                ;
            ELSE
                IF NOT
                   CONFIRM(
                     Text001, FALSE,
                     PurchHeader."Document Type")
                THEN
                    EXIT;
        END;
        PurchPost.RUN(PurchHeader);
        IF Gbool_Print THEN
            GcduPuchPrint.GetReport(PurchHeader);
    end;

    local procedure PrintReport(ReportUsage: Integer)
    begin
        ReportSelection.RESET();
        ReportSelection.SETRANGE(Usage, ReportUsage);
        ReportSelection.FindSet();
        REPEAT
            ReportSelection.TESTFIELD("Report ID");
            CASE ReportUsage OF
                ReportSelection.Usage::"S.Work Order".AsInteger():
                    REPORT.RUN(ReportSelection."Report ID", TRUE, FALSE, PurchRcptHeader);
            END;
        UNTIL ReportSelection.NEXT() = 0;
    end;

    procedure FctSetPrint()
    begin
        Gbool_Print := TRUE;
    end;
}
