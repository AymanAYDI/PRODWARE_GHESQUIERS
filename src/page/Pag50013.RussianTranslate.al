page 50013 "PWD Russian Translate"
{
    Caption = 'Russian Translate';
    PageType = List;
    SourceTable = "PWD Russian translate";
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
                field(T1; Rec.T1)
                {
                    ApplicationArea = all;
                }
                field(T2; Rec.T2)
                {
                    ApplicationArea = all;
                }
                field(Family; Rec.Family)
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
