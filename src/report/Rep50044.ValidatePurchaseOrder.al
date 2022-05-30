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
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Date de comptabilisation';
                        ApplicationArea = All;
                    }
                    field(DocumentDate; DocumentDate)
                    {
                        Caption = 'Date de document';
                        ApplicationArea = All;
                    }
                    field(ToReceive; ToReceive)
                    {
                        Caption = 'Receptionner';
                        ApplicationArea = All;
                    }
                    field(ToInvoice; "PWD ToInvoice")
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
        //abu
        PurchHeader.VALIDATE("Posting Date", PostingDate);
        PurchHeader.VALIDATE("Document Date", DocumentDate);
        PurchHeader.Receive := ToReceive;
        PurchHeader.Invoice := "PWD ToInvoice";
        // fin ajout
        CASE PurchHeader."Document Type" OF
            PurchHeader."Document Type"::Order:

                ;
            //Selection := STRMENU(Text000,3);
            //IF Selection = 0 THEN
            //  EXIT;
            //Receive := Selection IN [1,3];
            //Invoice := Selection IN [2,3];
            PurchHeader."Document Type"::"Return Order":

                ;
            //Selection := STRMENU(Text002,3);
            //IF Selection = 0 THEN
            //  EXIT;
            //Ship := Selection IN [1,3];
            //Invoice := Selection IN [2,3];
            ELSE
                IF NOT
                   CONFIRM(
                     Text001, FALSE,
                     PurchHeader."Document Type")
                THEN
                    EXIT;
        END;
        PurchPost.RUN(PurchHeader);
        //>-> GHE.1.10
        IF Gbool_Print THEN
            GcduPuchPrint.GetReport(PurchHeader);
        //<-< GHE.1.10
    end;

    local procedure PrintReport(ReportUsage: Integer)
    begin
        //C2APDE
        ReportSelection.RESET();
        ReportSelection.SETRANGE(Usage, ReportUsage);
        ReportSelection.FIND('-');
        REPEAT
            ReportSelection.TESTFIELD("Report ID");
            CASE ReportUsage OF
                ReportSelection.Usage::"S.Work Order".AsInteger():
                    REPORT.RUN(ReportSelection."Report ID", TRUE, FALSE, PurchRcptHeader);
            END;
        UNTIL ReportSelection.NEXT() = 0;
        //C2APDEEND
    end;

    procedure FctSetPrint()
    begin
        //>-> GHE.1.10
        Gbool_Print := TRUE;
        //<-< GHE.1.10
    end;
}
