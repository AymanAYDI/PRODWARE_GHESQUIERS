page 50040 "PWD Meat Family"
{
    Caption = 'Meat Family';
    PageType = List;
    SourceTable = "PWD Meat Family";
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
                field(Control; Rec.Control)
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
