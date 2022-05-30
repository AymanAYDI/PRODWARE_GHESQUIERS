page 50019 "PWD consultation DLC"
{
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    SourceTableView = SORTING("Item No.", "Variant Code", "Drop Shipment", "Location Code", "Posting Date") WHERE("Expiration Date" = FILTER(<> ''), "Remaining Quantity" = FILTER(<> 0));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Lot No."; Rec."Lot No.")
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
