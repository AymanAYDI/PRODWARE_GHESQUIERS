table 50036 "PWD Ligne document Douane"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(20; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = "S.Quote","S.Order","S.Invoice","S.Cr.Memo","P.Quote","P.Order","P.Invoice","P.Cr.Memo","P.Receipt","P.Ret.Shpt.","S.Return","P.Return","S.Shipment","S.Ret.Rcpt.";
            DataClassification = CustomerContent;
        }
        field(30; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(40; "Customs Document Type"; Option)
        {
            Caption = 'Customs Document Type';
            OptionCaption = ' ,T5,T1,TM,COM7,EX1,COM9,EX9';
            OptionMembers = " ",T5,T1,TM,COM7,EX1,COM9,EX9;
            DataClassification = CustomerContent;
        }
        field(45; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(46; "Location Filter"; Text[30])
        {
            Caption = 'Location Filter';
            DataClassification = CustomerContent;
        }
        field(50; "Cle (restitution)"; Code[20])
        {
            Caption = 'Cle (restitution)';
            DataClassification = CustomerContent;
        }
        field(60; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
        }
        field(70; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
        }
        field(80; "Total Parcel"; Decimal)
        {
            Caption = 'Total Parcel';
            DataClassification = CustomerContent;
        }
        field(90; "Parcel nb."; Decimal)
        {
            Caption = 'Parcel nb.';
            DataClassification = CustomerContent;
        }
        field(100; "Total Line"; Integer)
        {
            Caption = 'Total Line';
            DataClassification = CustomerContent;
        }
        field(110; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(120; "Stat Value"; Decimal)
        {
            Caption = 'Stat Value';
            DataClassification = CustomerContent;
        }
        field(130; "Cle Description"; Text[50])
        {
            Caption = 'Cle Description';
            DataClassification = CustomerContent;
        }
        field(131; "Customs Doc. No."; Code[20])
        {
            Caption = 'Customs Doc. No.';
            DataClassification = CustomerContent;
        }
        field(132; "No. sommier"; Text[20])
        {
            Caption = 'No. sommier';
            DataClassification = CustomerContent;
        }
        field(133; "No. facture fournisseur"; Code[20])
        {
            Caption = 'No. facture fournisseur';
            DataClassification = CustomerContent;
        }
        field(134; "Pays d origine"; Text[30])
        {
            Caption = 'Pays d origine';
            DataClassification = CustomerContent;
        }
        field(140; Organisme; Text[50])
        {
            Caption = 'Organisme';
            DataClassification = CustomerContent;
        }
        field(150; "User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Location Code")
        {
            SumIndexFields = "Parcel nb.";
        }
        key(Key3; "Document Type", "Document No.", "Customs Document Type", "Location Code", "Cle (restitution)")
        {
            SumIndexFields = "Parcel nb.";
        }
    }

    fieldgroups
    {
    }
}
