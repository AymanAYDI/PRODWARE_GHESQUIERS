tableextension 60032 "PWD PurchCrMemoHdr" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50000; "PWD Sealing"; Text[30])
        {
            Caption = 'Sealing';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Attachment 1"; Text[50])
        {
            Caption = 'Attachment 1';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Attachment 2"; Text[50])
        {
            Caption = 'Attachment 2';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Attachment 3"; Text[50])
        {
            Caption = 'Attachment 3';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Attachment 4"; Text[50])
        {
            Caption = 'Attachment 4';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50010; "PWD Delivery Time Rating"; Integer)
        {
            Caption = 'Delivery Time Rating';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50011; "PWD Delivered Quantity Rating"; Integer)
        {
            Caption = 'Delivered Quantity Rating';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50012; "PWD Technical Rating"; Integer)
        {
            Caption = 'Technical Rating';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Documentation Rating"; Integer)
        {
            Caption = 'Documentation Rating';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55018; "PWD Reference"; Text[100])
        {
            Caption = 'Référence';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(99008500; "PWD Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = CustomerContent;
        }
        field(99008501; "PWD Time Received"; Time)
        {
            Caption = 'Time Received';
            DataClassification = CustomerContent;
        }
        field(99008508; "PWD BizTalk Purch Cr Memo"; Boolean)
        {
            Caption = 'BizTalk Purchase Credit Memo';
            DataClassification = CustomerContent;
        }
    }
}
