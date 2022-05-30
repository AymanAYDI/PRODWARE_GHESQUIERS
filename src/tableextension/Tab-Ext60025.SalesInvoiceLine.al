tableextension 60025 "PWD SalesInvoiceLine" extends "Sales Invoice Line"
{
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
        field(50006; "PWD Origin Area"; Code[10])
        {
            Caption = 'Origin Area';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Document Date"; Date)
        {
            Caption = 'Date Document';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50020; "PWD Posting Date PW"; Date)
        {
            Caption = 'Posting Date';
            Description = 'PW2009';
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
        field(55007; "PWD DSA No."; Code[10])
        {
            Caption = 'DSA No.';
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
            Caption = 'Code famille';
            Description = 'PW2009';
            TableRelation = "PWD Family & Sub Family".Code;
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
        field(55050; "Cle (restitution)"; Code[20])
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
        field(70012; "PWD No. DOC saisie presta"; Code[20])
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
}
