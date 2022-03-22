page 50051 "PWD En-tête saisie préstation"
{
    PageType = Card;
    SourceTable = "PWD En-tête saisie prestation";

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Code fournisseur"; Rec."Code fournisseur")
                {
                    ApplicationArea = All;
                }
                field("Date comptabilisation"; Rec."Date comptabilisation")
                {
                    ApplicationArea = All;
                }
                field("Type de prestation"; Rec."Type de prestation")
                {
                    ApplicationArea = All;
                }
            }
            part(Prestation; "PWD Sous form prestation")
            {
                Caption = 'Prestation';
                SubPageLink = "Journal Template Name" = FIELD("Nom modele feuille"), "Journal Batch Name" = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

