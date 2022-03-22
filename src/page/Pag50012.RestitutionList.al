page 50012 "PWD Restitution List"
{
    Caption = 'Restitution List';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "PWD Item Restitution";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Cle; Rec.Cle)
                {
                    ApplicationArea = all;
                }
                field(Groupe; Rec.Groupe)
                {
                    ApplicationArea = all;
                }
                field(Nomenclature; Rec.Nomenclature)
                {
                    ApplicationArea = all;
                }
                field("Code restitution"; Rec."Code restitution")
                {
                    ApplicationArea = all;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = all;
                }
                field(Tableau; Rec.Tableau)
                {
                    ApplicationArea = all;
                }
                field("Taux aide avitaillement"; Rec."Taux aide avitaillement")
                {
                    ApplicationArea = all;
                }
                field(Organisme; Rec.Organisme)
                {
                    ApplicationArea = all;
                }
                field("Taux aide export"; Rec."Taux aide export")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Mémo")
            {
                ApplicationArea = all;
                Caption = 'Mémo';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table name" = CONST(Restitution), "No." = FIELD(Cle);
            }
        }
    }
}

