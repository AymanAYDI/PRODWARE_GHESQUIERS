tableextension 60030 "PWD PurchInvHeader" extends "Purch. Inv. Header"
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
        field(55018; "PWD Reference"; Text[100])
        {
            Caption = 'Référence';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key50000; "Purchaser Code", "Order No.", "Buy-from Vendor No.")
        {
        }
    }
}
