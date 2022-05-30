page 50015 "Result Restitution Calculation"
{
    AutoSplitKey = false;
    Caption = 'Result Restitution Calculation';
    PageType = List;
    SourceTable = "Result Restitution Calculation";
    SourceTableView = SORTING("Shipment No.", "NDP 13") ORDER(Ascending);
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = all;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("NDP 13"; Rec."NDP 13")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                }
                field("Unit (Base)"; Rec."Unit (Base)")
                {
                    ApplicationArea = all;
                }
                field("Restitution Quantity"; Rec."Restitution Quantity")
                {
                    ApplicationArea = all;
                }
                field("Restitution Unit"; Rec."Restitution Unit")
                {
                    ApplicationArea = all;
                }
                field("Rate (%)"; Rec."Rate (%)")
                {
                    ApplicationArea = all;
                }
                field("Restitution Amount"; Rec."Restitution Amount")
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
