tableextension 60023 "PWD SalesShipmentLine" extends "Sales Shipment Line"
{

    LookupPageID = "Posted Sales Shipment Lines";


    fields
    {
        field(50000; "PWD Call No."; Code[10])
        {
            Caption = 'Call No.';
            Description = 'PW2009';
            TableRelation = "PWD Call"."Call No.";
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Parcel Nb."; Decimal)
        {
            Caption = 'Parcel Nb.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Unit per Parcel"; Decimal)
        {
            Caption = 'Unit per Parcel';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Output Date"; Date)
        {
            Caption = 'Output Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Health Approval No."; Code[20])
        {
            Caption = 'Health Approval No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Mark"; Code[30])
        {
            Caption = 'Mark';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD Origin Area"; Code[20])
        {
            Caption = 'Origin Area';
            Description = 'PW2009';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Country: Record "Country/Region";
            begin
                IF Country.GET("PWD Origin Area") THEN
                    "PWD Continental Code" := Country."PWD Continental Code" ELSE
                    "PWD Continental Code" := '';
            end;
        }
        field(50007; "PWD Continental Code"; Code[10])
        {
            AutoFormatType = 1;
            Caption = 'Continental Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50008; "PWD Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50009; "PWD Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50010; "PWD Certified Origin"; Boolean)
        {
            Caption = 'Certified Origin';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Document Date"; Date)
        {
            Caption = 'Date Document';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50014; "PWD Certificate Transit No."; Code[30])
        {
            Caption = 'Certificate Transit No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50020; "PWD Posting Date PW"; Date)
        {
            Caption = 'Posting Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50024; "PWD Seafrance Order Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Seafrance Order Line No.';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50041; "PWD Shelf/Bin No."; Code[10])
        {
            Caption = 'Shelf/Bin No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50052; "PWD Provision/materiel"; Option)
        {
            Caption = 'Provision/matériel';
            Description = 'PW2009';
            OptionMembers = " ",Materiel,Provision;
            DataClassification = CustomerContent;
        }
        field(50053; "PWD Coefficient Seafrance"; Decimal)
        {
            BlankZero = true;
            Caption = 'Coefficient Seafrance';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50054; "PWD Quantity Seafrance"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity Seafrance';
            DecimalPlaces = 0 : 2;
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55007; "PWD DSA No."; Code[10])
        {
            Caption = 'DSA No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55008; "PWD Family"; Code[10])
        {
            Caption = 'Family';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55042; "PWD Code ventilation article"; Code[10])
        {
            Caption = 'Code ventilation article';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55043; "PWD Family Code"; Code[20])
        {
            Caption = 'Family Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55044; "PWD Quantity Ordered Sp. Order"; Decimal)
        {
            Caption = 'Quantity Ordered Purch.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55046; "PWD Quantity Receipted Sp. Order"; Decimal)
        {
            Caption = 'Quantity Receipted Purch.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55047; "PWD National Add. Code"; Code[19])
        {
            Caption = 'National Add. Code';
            Description = 'PW2009';
            TableRelation = "PWD National Add. Code";
            DataClassification = CustomerContent;
        }
        field(55048; "PWD Monthly Code"; Code[10])
        {
            Caption = 'Monthly Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55049; "PWD Quantite initiale"; Decimal)
        {
            Caption = 'Quantité initiale';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55050; "PWD Cle (restitution)"; Code[20])
        {
            Caption = 'Restitution Key';
            Description = 'PW2009';
            TableRelation = "PWD Item Restitution".Cle;
            DataClassification = CustomerContent;
        }
        field(55051; "PWD Designation ENU"; Text[50])
        {
            Caption = 'Désignation ENU';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55052; "PWD Sell-to Country Code"; Code[10])
        {
            Caption = 'Sell-to Country Code';
            Description = 'PW2009';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(60000; "PWD DCG Tariff No."; Code[20])
        {
            Caption = 'DCG Tariff No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70000; "Valeur douane (correction)"; Decimal)
        {
            Caption = 'Valeur douane (correction)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70010; "Methode de Calcul (prestation)"; Text[30])
        {
            Caption = 'Methode de Calcul (prestation)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70011; "Reference Calcul (prestation)"; Text[30])
        {
            Caption = 'Référence Calcul (prestation)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70012; "PWD No.DOC saisie presta"; Code[20])
        {
            Caption = 'N°DOC saisie presta';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70013; "PWD Code prestation"; Code[10])
        {
            Caption = 'Code prestation';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70014; "PWD Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key8; "PWD Continental Code")
        {
        }
        key(Key10; "PWD Origin Area")
        {
        }
        key(Key11; "PWD Code ventilation article")
        {
        }
        key(Key12; "Document No.", Type, "Location Code", Quantity)
        {
        }
        key(Key13; "Document No.", "Location Code")
        {
        }
        key(Key16; "Location Code")
        {
        }
        key(Key17; "PWD Family")
        {
        }
    }
}

