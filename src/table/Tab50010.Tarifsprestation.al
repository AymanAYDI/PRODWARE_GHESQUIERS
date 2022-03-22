table 50010 "PWD Tarifs prestation"
{
    DrillDownPageID = "PWD Tarifs préstation";
    LookupPageID = "PWD Tarifs préstation";
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Code prestation"; Code[10])
        {
            Caption = 'Code préstation';
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
        field(60; "Prix unitaire"; Decimal)
        {
            Caption = 'Prix unitaire';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code prestation", "Code article", "Code unite", "Code client", "Date de debut")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

