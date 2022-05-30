page 50006 "PWD Tarifs prestation M2"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "PWD Tarifs prestation M2";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code prestation"; Rec."Code prestation")
                {
                    ApplicationArea = all;
                }
                field("Code client"; Rec."Code client")
                {
                    ApplicationArea = all;
                }
                field("Nom du client"; Rec."Nom du client")
                {
                    ApplicationArea = all;
                }
                field("Code article"; Rec."Code article")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Designation article"; Rec."Designation article")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Code unite"; Rec."Code unite")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Code fournisseur"; Rec."Code fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Nom du fournisseur"; Rec."Nom du fournisseur")
                {
                    ApplicationArea = all;
                }
                field("Date de debut"; Rec."Date de debut")
                {
                    ApplicationArea = all;
                }
                field("Ressource prestation"; Rec."Ressource prestation")
                {
                    ApplicationArea = all;
                }
                field("Methode de Calcul"; Rec."Methode de Calcul")
                {
                    ApplicationArea = all;
                }
                field(Valeur; Rec.Valeur)
                {
                    ApplicationArea = all;
                }
                field("Reference Calcul"; Rec."Reference Calcul")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}
