page 50047 "Disponibilités Art. / Magasin"
{
    Editable = false;
    PageType = List;
    SourceTable = "Items Available per Location";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Available Inventory"; Rec."Available Inventory")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
