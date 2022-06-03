tableextension 60043 "PWD PurchasesPayablesSetup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "PWD Souche COM 7"; Code[20])
        {
            Caption = 'Souche COM 7';
            Description = 'PW2009';
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(50001; "PWD No. Exportateur"; Code[20])
        {
            Caption = 'N° Exportateur';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Regime"; Code[10])
        {
            Caption = 'Régime';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Donnees financieres"; Code[10])
        {
            Caption = 'Données financières';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Souche Declar. Sommaire"; Code[10])
        {
            Caption = 'Souche déclaration sommaire';
            Description = 'PW2009';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Fournis. Fruit/Legume"; Code[20])
        {
            Caption = 'Fournisseur fruits et légumes';
            Description = 'PW2009';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(70060; "PWD Archive Quotes"; Boolean)
        {
            Caption = 'Archive Quotes';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70061; "PWD Archive Orders"; Boolean)
        {
            Caption = 'Archive Orders';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}
