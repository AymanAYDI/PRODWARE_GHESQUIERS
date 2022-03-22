tableextension 60013 "PWD PurchaseHeader" extends "Purchase Header"
{
    fields
    {
        field(50000; "PWD Sealing"; Text[30])
        {
            Caption = 'Sealing';
            Description = 'PW2009';
        }
        field(50001; "PWD Attachment 1"; Text[50])
        {
            Caption = 'Attachment 1';
            Description = 'PW2009';
        }
        field(50002; "PWD Attachment 2"; Text[50])
        {
            Caption = 'Attachment 2';
            Description = 'PW2009';
        }
        field(50003; "PWD Attachment 3"; Text[50])
        {
            Caption = 'Attachment 3';
            Description = 'PW2009';
        }
        field(50004; "PWD Attachment 4"; Text[50])
        {
            Caption = 'Attachment 4';
            Description = 'PW2009';
        }
        field(50005; "PWD Notice Series No."; Code[20])
        {
            Caption = 'Notice Series No.';
            Description = 'PW2009';
        }
        field(50010; "PWD Delivery Time Rating"; Integer)
        {
            Caption = 'Delivery Time Rating';
            Description = 'PW2009';
        }
        field(50011; "PWD Delivered Quantity Rating"; Integer)
        {
            Caption = 'Delivered Quantity Rating';
            Description = 'PW2009';
        }
        field(50012; "PWD Technical Rating"; Integer)
        {
            Caption = 'Technical Rating';
            Description = 'PW2009';
        }
        field(50013; "PWD Documentation Rating"; Integer)
        {
            Caption = 'Documentation Rating';
            Description = 'PW2009';
        }
        field(55018; "PWD Reference"; Text[100])
        {
            Caption = 'Référence';
            Description = 'PW2009';
        }
        field(55019; "PWD Reception OK"; Boolean)
        {
            Caption = 'Réception OK';
            Description = 'PW2009';
        }
        field(55020; "PWD Last Shipment Date"; Date)
        {
            Caption = 'Date de la dernière réception';
            Description = 'PW2009';
        }
    }
}

