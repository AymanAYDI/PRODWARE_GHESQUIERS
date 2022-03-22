table 50018 "PWD Export COALA"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "G/L Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(4; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            DataClassification = CustomerContent;
        }
        field(8; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            DataClassification = CustomerContent;
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            DataClassification = CustomerContent;
        }
        field(10; "Document Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            DataClassification = CustomerContent;
        }
        field(11; "Export COALA Succes"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(12; "G/L Account No. COALA"; Code[8])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Export DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Date premier export"; Date)
        {
            CalcFormula = Lookup("G/L Entry"."PWD Export Date" WHERE("Entry No." = FIELD("G/L Entry No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.")
        {
        }
        key(Key3; "Posting Date")
        {
        }
        key(Key4; "Document Date")
        {
        }
    }

    fieldgroups
    {
    }
}

