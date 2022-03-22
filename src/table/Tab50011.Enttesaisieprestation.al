table 50011 "PWD En-tête saisie prestation"
{
    DataClassification = CustomerContent;

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'N°';
            DataClassification = CustomerContent;
        }
        field(20; "Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur';
            DataClassification = CustomerContent;
        }
        field(30; "Date comptabilisation"; Date)
        {
            Caption = 'Date comptabilisation';
            DataClassification = CustomerContent;
        }
        field(40; "Type de prestation"; Code[10])
        {
            Caption = 'Type de préstation';
            DataClassification = CustomerContent;
        }
        field(50; "Nom modele feuille"; Code[20])
        {
            Caption = 'Nom modèle feuille';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

