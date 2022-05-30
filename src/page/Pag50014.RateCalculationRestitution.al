page 50014 "PWD RateCalculationRestitution"
{
    AutoSplitKey = false;
    Caption = 'Rate for Calculation Restitution';
    PageType = List;
    SourceTable = "PWD RateRestitutionCalculation";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Restitution Code"; Rec."Restitution Code")
                {
                    ApplicationArea = all;
                }
                field("Valid Until"; Rec."Valid Until")
                {
                    ApplicationArea = all;
                }
                field("Rate (%)"; Rec."Rate (%)")
                {
                    ApplicationArea = all;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
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
