page 50039 "PWD Family & Sub Family"
{
    Caption = 'Family & Sub Family';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "PWD Family & Sub Family";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Group Type"; Rec."Group Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Relative Group Code"; Rec."Relative Group Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Type famille"; Rec."Type famille")
                {
                    ApplicationArea = all;
                }
                field("Mode de calcul AT"; Rec."Mode de calcul AT")
                {
                    ApplicationArea = all;
                }
                field("Fruit and Vegetable"; Rec."Fruit and Vegetable")
                {
                    ApplicationArea = all;
                }
                field("Autoriser livraison>commande"; Rec."Autoriser livraison>commande")
                {
                    ApplicationArea = all;
                }
                field("Provision/materiel"; Rec."Provision/materiel")
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

