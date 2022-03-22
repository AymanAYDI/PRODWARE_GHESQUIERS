tableextension 60024 "PWD SalesInvoiceHeader" extends "Sales Invoice Header"
{
    DataCaptionFields = "No.", "Sell-to Customer Name";
    LookupPageID = "Posted Sales Invoices";
    DrillDownPageID = "Posted Sales Invoices";
    fields
    {
        field(50000; "PWD Call No."; Code[10])
        {
            Caption = 'Call No.';
            Description = 'PW2009';
            TableRelation = "PWD Call"."Call No.";
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Call Type"; Code[10])
        {
            Caption = 'Call Type';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Delivry time"; Time)
        {
            Caption = 'Delivry time';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD DSA No."; Code[10])
        {
            Caption = 'DSA No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50021; "PWD Seafrance Order No."; Code[30])
        {
            Caption = 'Seafrance Order No.';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50110; "PWD Bill-to C/O"; Boolean)
        {
            Caption = 'c/o';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50111; "PWD Bill-to Additional name"; Text[50])
        {
            Caption = 'Nom complémentaire';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(55000; "PWD Filing Reason"; Code[10])
        {
            Caption = 'Filing Reason';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(36), "Field ID" = CONST(55000));
            DataClassification = CustomerContent;
        }
        field(55015; "PWD Ready to ship"; Boolean)
        {
            Caption = 'Prêt à expédier';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55017; "PWD Ne pas utiliser No. de DSA"; Boolean)
        {
            Caption = 'Ne pas utiliser N° de DSA';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55019; "PWD Reference"; Text[100])
        {
            Caption = 'Référence';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55050; "PWD Presta Facturable par fourniss"; Boolean)
        {
            Caption = 'Presta Facturable par fourniss';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60001; "PWD Commentaire 1"; Text[50])
        {
            Caption = 'Commentaire 1';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60002; "PWD Commentaire 2"; Text[50])
        {
            Caption = 'Commentaire 2';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60003; "PWD Commentaire 3"; Text[50])
        {
            Caption = 'Commentaire 3';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60004; "PWD Commentaire 4"; Text[50])
        {
            Caption = 'Commentaire 4';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60005; "PWD Commentaire 5"; Text[50])
        {
            Caption = 'Commentaire 5';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key14; "Salesperson Code", "Bill-to Customer No.")
        {
        }
        key(Key15; "Salesperson Code", "Sell-to Customer No.", "Order No.")
        {
        }
        key(Key16; "Sell-to Customer No.", "Posting Date")
        {
        }
    }
    var
        CstG001: Label 'Suppression impossible';
}

