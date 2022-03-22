page 50054 "PWD Codes Add. National"
{
    PageType = List;
    SourceTable = "PWD National Add. Code";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("National Add. Code"; Rec."National Add. Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

