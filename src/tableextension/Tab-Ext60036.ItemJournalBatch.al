tableextension 60036 "PWD ItemJournalBatch" extends "Item Journal Batch"
{
    fields
    {
        field(50000; "PWD Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur';
            Description = 'PW2009';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Code préstation"; Code[10])
        {
            Caption = 'Code préstation';
            Description = 'PW2009';
            TableRelation = "PWD Prestations";
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Code client"; Code[20])
        {
            Caption = 'Code client';
            Description = 'PW2009';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Sealing"; Text[30])
        {
            Caption = 'Sealing';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Attachment 1"; Text[50])
        {
            Caption = 'Attachment 1';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Attachment 2"; Text[50])
        {
            Caption = 'Attachment 2';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD Attachment 3"; Text[50])
        {
            Caption = 'Attachment 3';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50007; "PWD Attachment 4"; Text[50])
        {
            Caption = 'Attachment 4';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50008; "PWD First Purch. Ord. Seafrance No"; Code[30])
        {
            CalcFormula = Lookup("Item Journal Line"."PWD Seafrance Order No." WHERE("Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD(Name)));
            Caption = 'First document of journal';
            Description = 'PW2009';
            FieldClass = FlowField;
        }
    }
}
