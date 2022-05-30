page 50066 "PWD KPI Card"
{
    PageType = Card;
    SourceTable = "PWD KPI Rules Setup";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group("Général")
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Rule; Rec.Rule)
                {
                    ApplicationArea = All;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                }
                field(Indicator; Rec.Indicator)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(KPI; Rec.KPI)
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
