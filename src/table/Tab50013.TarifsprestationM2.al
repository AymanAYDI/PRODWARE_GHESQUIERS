table 50013 "PWD Tarifs prestation M2"
{
    DrillDownPageID = "PWD Tarifs préstation";
    LookupPageID = "PWD Tarifs préstation";
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Code prestation"; Code[10])
        {
            Caption = 'Code prestation';
            TableRelation = "PWD Prestations";
            DataClassification = CustomerContent;
        }
        field(20; "Code article"; Code[20])
        {
            Caption = 'Code article';
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CALCFIELDS("Designation article");
                Item.GET("Code article");
                VALIDATE("Code fournisseur", Item."Vendor No.");
            end;
        }
        field(25; "Designation article"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Code article")));
            Caption = 'Désignation article';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Code unite"; Code[10])
        {
            Caption = 'Code unité';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Code article"));
            DataClassification = CustomerContent;
        }
        field(40; "Code client"; Code[20])
        {
            Caption = 'Code client';
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CALCFIELDS("Nom du client");
            end;
        }
        field(45; "Nom du client"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Code client")));
            Caption = 'Nom du client';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Date de debut"; Date)
        {
            Caption = 'Date de début';
            DataClassification = CustomerContent;
        }
        field(70; "Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur';
            TableRelation = Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CALCFIELDS("Nom du fournisseur");
            end;
        }
        field(75; "Nom du fournisseur"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Code fournisseur")));
            Caption = 'Nom du fournisseur';
            FieldClass = FlowField;
        }
        field(80; "Ressource prestation"; Code[20])
        {
            Caption = 'Ressource prestation';
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
        field(90; "Methode de Calcul"; Enum "PWD Calcul Methode")
        {
            Caption = 'Méthode de Calcul';
            DataClassification = CustomerContent;
        }
        field(100; Valeur; Decimal)
        {
            Caption = 'Valeur';
            DataClassification = CustomerContent;
        }
        field(110; "Reference Calcul"; Enum "Calcul Reference")
        {
            Caption = 'Référence Calcul';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code prestation", "Code client", "Code fournisseur", "Date de debut", "Ressource prestation")
        {
            Clustered = true;
        }
        key(Key2; "Code prestation", "Code article", "Code unite", "Code client", "Date de debut", "Code fournisseur", "Ressource prestation")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD("Ressource prestation");
    end;

    var
        Item: Record Item;
}

