pageextension 50045 "PWD PurchasesPayablesSetup" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Archive Orders")
        {
            field("PWD Fournisseur fruits et legumes"; Rec."PWD Fournis. Fruit/Legume")
            {
                ApplicationArea = All;
            }
        }
        addafter("Number Series")
        {
            group("PWD COM 7")
            {
                Caption = 'COM 7';
                field("PWD Souche COM 7"; Rec."PWD Souche COM 7")
                {
                    ApplicationArea = All;
                }
                field("PWD No. Exportateur"; Rec."PWD No. Exportateur")
                {
                    ApplicationArea = All;
                }
                field("PWD Regime"; Rec."PWD Regime")
                {
                    ApplicationArea = All;
                }
                field("PWD Donnees financieres"; Rec."PWD Donnees financieres")
                {
                    ApplicationArea = All;
                }
                field("PWD Souche declaration sommaire"; Rec."PWD Souche Declar. Sommaire")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}