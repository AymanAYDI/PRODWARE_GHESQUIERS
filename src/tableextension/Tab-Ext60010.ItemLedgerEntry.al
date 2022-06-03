tableextension 60010 "PWD ItemLedgerEntry" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "PWD Notice Series No."; Code[20])
        {
            Caption = 'Notice Series No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Origin"; Code[10])
        {
            Caption = 'Origin';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Cetificate Transit No."; Code[50])
        {
            Caption = 'Cetificate Transit No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Origin Lot No."; Code[20])
        {
            Caption = 'Origin Lot No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Meat Family"; Code[10])
        {
            Caption = 'Meat Family';
            Description = 'PW2009';
            TableRelation = "PWD Meat Family";
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Meat Type"; Option)
        {
            Caption = 'Meat Type';
            Description = 'PW2009';
            OptionCaption = 'InPut,OutPut';
            OptionMembers = "Entrée",Sortie;
            DataClassification = CustomerContent;
        }
        field(50010; "PWD Code prestation"; Code[10])
        {
            Caption = 'Code prestation';
            Description = 'PW2009';
            TableRelation = "PWD Prestations";
            DataClassification = CustomerContent;
        }
        field(50011; "PWD Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50012; "PWD Code client"; Code[20])
        {
            Caption = 'Code client';
            Description = 'PW2009';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Family Code"; Code[20])
        {
            Caption = 'Family Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50014; "PWD Date Fact. Prestation"; Date)
        {
            Caption = 'Date facturation prestation';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50015; "PWD Magasin DEB"; Boolean)
        {
            Caption = 'Magasin DEB';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50016; "PWD Type Escale"; Code[10])
        {
            Caption = 'Type Escale';
            Description = 'PW2009';
            TableRelation = "PWD Call Type".Code;
            DataClassification = CustomerContent;
        }
        field(50017; "PWD Prest Entree Fact"; Boolean)
        {
            Caption = 'Prest Entrée Fact';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50018; "PWD Prest Sortie Fact"; Boolean)
        {
            Caption = 'Prest Sortie Fact';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50019; "PWD Parcel Nb"; Decimal)
        {
            BlankZero = true;
            Caption = 'Parcel Nb';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50020; "PWD COM 7 No."; Code[20])
        {
            Caption = 'COM 7 No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50021; "PWD Nb. unite"; Decimal)
        {
            Caption = 'Nb. unité';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50022; "PWD Montant douane"; Decimal)
        {
            Caption = 'Montant douane';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50023; "PWD Lot Reserved Qty"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = FIELD("Item No."), "Lot No." = FIELD("Lot No."), "Source Type" = CONST(37), "Source Subtype" = CONST(1)));
            Caption = 'Lot Reserved Qty';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "PWD Seafrance Order No."; Code[30])
        {
            Caption = 'Seafrance Order No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50025; "PWD Seafrance Order Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Seafrance Order Line No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50026; "PWD Seafrance Quantity"; Decimal)
        {
            Caption = 'Seafrance Quantity';
            DecimalPlaces = 0 : 2;
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55103; "PWD Gross Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids brut';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55104; "PWD Net Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids Net';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55200; "PWD Comments"; Text[30])
        {
            Caption = 'Comments';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key50000; "Expiration Date", "Location Code", "Item No.", "Lot No.", "Remaining Quantity", Positive)
        {
        }
        key(Key50001; "PWD Meat Family", "PWD Meat Type")
        {
        }
        key(Key50002; "PWD Origin Lot No.")
        {
        }
        key(Key50003; "Source No.", "Item No.")
        {
        }
        key(Key50004; "Country/Region Code", "Entry Type", "Posting Date", "Location Code")
        {
        }
        key(Key50005; "Item No.", Positive, "Completely Invoiced", "Last Invoice Date", "Location Code", "Variant Code")
        {
        }
        key(Key50006; "Item No.", "Variant Code", "Drop Shipment", "Location Code", "Posting Date")
        {
        }
        key(Key50007; "Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.")
        {
        }
    }
}
