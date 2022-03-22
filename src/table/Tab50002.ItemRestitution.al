table 50002 "PWD Item Restitution"
{
    Caption = 'Item Restitution';
    Description = 'Navita360';
    LookupPageID = "PWD Restitution List";
    DataClassification = CustomerContent;

    fields
    {
        field(5; Cle; Code[10])
        {
            Caption = 'Clé';
            DataClassification = CustomerContent;
        }
        field(6; Groupe; Code[10])
        {
            Caption = 'Groupe';
            DataClassification = CustomerContent;
        }
        field(7; Nomenclature; Code[13])
        {
            Caption = 'NSP 13';
            TableRelation = "PWD National Add. Code"."National Add. Code";
            DataClassification = CustomerContent;
        }
        field(10; "Code restitution"; Code[20])
        {
            Caption = 'Restitution Code';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(20; Organisme; Text[30])
        {
            Caption = 'Description';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(30; Tableau; Text[30])
        {
            Caption = 'Table';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(40; "Donnees comptables"; Text[30])
        {
            Caption = 'Accounting Information';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(50; Designation; Text[50])
        {
            Caption = 'Désignation';
            DataClassification = CustomerContent;
        }
        field(60; "Taux aide avitaillement"; Decimal)
        {
            Caption = 'Taux aide avitaillement';
            DataClassification = CustomerContent;
        }
        field(70; "Taux aide export"; Decimal)
        {
            Caption = 'Taux aide export';
            DataClassification = CustomerContent;
        }
        field(80; Memo; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Restitution), "No." = FIELD(Cle)));
            Caption = 'Memo';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Cle)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

