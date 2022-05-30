table 50008 "PWD Family & Sub Family"
{
    Caption = 'Family & Sub Family';
    LookupPageID = "PWD Family & Sub Family";
    DataClassification = CustomerContent;

    fields
    {
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Item';
            OptionMembers = Item;
            DataClassification = CustomerContent;
        }
        field(11; "Group Type"; Option)
        {
            Caption = 'Group Type';
            OptionCaption = 'Family,Sub Family';
            OptionMembers = Family,"Sub Family";
            DataClassification = CustomerContent;
        }
        field(12; "Relative Group Code"; Code[10])
        {
            Caption = 'Relative Group Code';
            TableRelation = "PWD Family & Sub Family".Code WHERE(Type = FIELD(Type), "Group Type" = CONST(Family));
            DataClassification = CustomerContent;
        }
        field(13; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(14; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(50000; "Type famille"; Option)
        {
            Caption = 'Type famille';
            OptionMembers = " ",Alcool,Tabac;
            DataClassification = CustomerContent;
        }
        field(50001; "Mode de calcul AT"; Option)
        {
            Caption = 'Mode de calcul AT';
            Description = 'Mode de calcul Alcool Tabac';
            OptionMembers = " ","Poids Net","Poids Net x °Alcool";
            DataClassification = CustomerContent;
        }
        field(50010; "Fruit and Vegetable"; Boolean)
        {
            Caption = 'Fruit and vegetable';
            Description = 'Fruits & légumes';
            DataClassification = CustomerContent;
        }
        field(50020; "Provision/materiel"; Option)
        {
            Caption = 'Provision/materiel';
            OptionMembers = " ",Materiel,Provision;
            DataClassification = CustomerContent;
        }
        field(50021; "Autoriser livraison>commande"; Boolean)
        {
            Caption = 'Autoriser livraison>commande';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Type, "Group Type", "Relative Group Code", "Code")
        {
            Clustered = true;
        }
    }
}
