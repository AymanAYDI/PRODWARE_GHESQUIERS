page 50017 "PWD Call Type"
{
    Caption = 'Call Type';
    PageType = List;
    SourceTable = "PWD Call Type";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Shipping No. Series"; Rec."Shipping No. Series")
                {
                    ApplicationArea = all;
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = all;
                }
                field("Message EXO"; Rec."Message EXO")
                {
                    ApplicationArea = all;
                }
                field("Tri sur code SEAF"; Rec."Tri sur code SEAF")
                {
                    ApplicationArea = all;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Pas de saut de page sur BP"; Rec."Pas de saut de page sur BP")
                {
                    ApplicationArea = all;
                }
                field("Ne pas imprimer DLC sur BP"; Rec."Ne pas imprimer DLC sur BP")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Type escale")
            {
                Caption = 'Type escale';
                action("Magasins autorisés")
                {
                    Caption = 'Magasins autorisés';
                    Image = SetPriorities;
                    RunObject = Page "PWD Priority Location";
                    RunPageLink = "PWD Call Type Code" = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;
}
