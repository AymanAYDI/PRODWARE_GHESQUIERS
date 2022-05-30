page 50055 "PWD Famille / sous-famille"
{
    PageType = List;
    SourceTable = "PWD Family & Sub Family";
    ApplicationArea = all;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = All;
                }
                field("Relative Group Code"; Rec."Relative Group Code")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Fruit and Vegetable"; Rec."Fruit and Vegetable")
                {
                    ApplicationArea = All;
                }
                field("Type famille"; Rec."Type famille")
                {
                    ApplicationArea = All;
                }
                field("Autoriser livraison>commande"; Rec."Autoriser livraison>commande")
                {
                    ApplicationArea = All;
                }
                field("Mode de calcul AT"; Rec."Mode de calcul AT")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
