tableextension 60038 "PWD TariffNumber" extends "Tariff Number"
{
    fields
    {
        field(50000; "PWD Relative Comment"; Text[80])
        {
            Caption = 'Relative Comment';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70000; "PWD Description 2"; Text[250])
        {
            Caption = 'Description 2';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70001; "PWD Calcul Method"; Option)
        {
            Caption = 'Méthode de Calcul';
            Description = 'SOBI';
            OptionCaption = ' ,POIDS NET * QUANTITE,POIDS NET * QUANTITE / 1000,POIDS NET * QUANTITE * ALCOOL %,QUANTITE,QUANTITE / 100,QUANTITE / 1000';
            OptionMembers = " ","POIDS NET * QUANTITE","POIDS NET * QUANTITE / 1000","POIDS NET * QUANTITE * ALCOOL %",QUANTITE,"QUANTITE / 100","QUANTITE / 1000";
            DataClassification = CustomerContent;
        }
    }
}
