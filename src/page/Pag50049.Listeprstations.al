page 50049 "PWD Liste préstations"
{
    DelayedInsert = true;
    PageType = List;
    SourceTable = "PWD Prestations";
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
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Type de prestation"; Rec."Type de prestation")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Tarifs")
            {
                Caption = '&Tarifs';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "PWD Tarifs préstation";
                RunPageLink = "Code prestation" = FIELD(Code);
                ApplicationArea = All;
            }
        }
    }
}
