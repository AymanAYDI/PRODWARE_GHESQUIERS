tableextension 60028 "PWD PurchRcptHeader" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "PWD Sealing"; Text[30])
        {
            Caption = 'Sealing';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Attachment 1"; Text[50])
        {
            Caption = 'Attachment 1';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Attachment 2"; Text[50])
        {
            Caption = 'Attachment 2';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Attachment 3"; Text[50])
        {
            Caption = 'Attachment 3';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Attachment 4"; Text[50])
        {
            Caption = 'Attachment 4';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Notice Series No."; Code[20])
        {
            Caption = 'Notice Series No.';
            DataClassification = CustomerContent;
        }
        field(50010; "PWD Delivery Time Rating"; Integer)
        {
            Caption = 'Delivery Time Rating';
            DataClassification = CustomerContent;
        }
        field(50011; "PWD Delivered Quantity Rating"; Integer)
        {
            Caption = 'Delivered Quantity Rating';
            DataClassification = CustomerContent;
        }
        field(50012; "PWD Technical Rating"; Integer)
        {
            Caption = 'Technical Rating';
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Documentation Rating"; Integer)
        {
            Caption = 'Documentation Rating';
            DataClassification = CustomerContent;
        }
        field(50014; "PWD No. de COM7"; Code[20])
        {
            Caption = 'N° de COM7';
            DataClassification = CustomerContent;
        }
        field(50015; "PWD No. de DS"; Code[20])
        {
            Caption = 'N° de DS';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key50000; "Order No.", "Document Date")
        {
        }
    }

    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";

    procedure PrintRecordsNoticeInv(ShowRequestForm: Boolean)
    var
        ReportSelection: Record "Report Selections";
    begin
        PurchRcptHeader.COPY(Rec);
        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::"Notice Investment");
        ReportSelection.SETFILTER("Report ID", '<>0');
        ReportSelection.FIND('-');
        REPEAT
            REPORT.RUNMODAL(ReportSelection."Report ID", ShowRequestForm, FALSE, PurchRcptHeader);
        UNTIL ReportSelection.NEXT() = 0;
    end;

    procedure PrintCOM7(ShowRequestForm: Boolean)
    var
        ReportSelection: Record "Report Selections";
    begin
        PurchRcptHeader.COPY(Rec);
        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::COM7);
        ReportSelection.SETFILTER("Report ID", '<>0');
        ReportSelection.FIND('-');
        REPEAT
            REPORT.RUNMODAL(ReportSelection."Report ID", ShowRequestForm, FALSE, PurchRcptHeader);
        UNTIL ReportSelection.NEXT() = 0;
    end;

    procedure PrintDS()
    begin
        //ToDo
        //REPORT.RUNMODAL(REPORT::"Déclaration sommaire", TRUE, TRUE, Rec);
    end;
}
