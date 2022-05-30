page 50062 "PWD Listes de chargement"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "PWD Listes de chargement";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Sales Ship. No."; Rec."Sales Ship. No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Filter"; Rec."Location Filter")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Nb. Loading List"; Rec."Nb. Loading List")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Parcel Nb"; Rec."Parcel Nb")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Stat. Value"; Rec."Stat. Value")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Nb"; Rec."Item Nb")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. DAS"; Rec."No. DAS")
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
