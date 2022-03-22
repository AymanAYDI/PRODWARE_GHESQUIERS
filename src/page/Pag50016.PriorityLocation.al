page 50016 "PWD Priority Location"
{
    Caption = 'Priority Location';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "PWD Location Priority";
    SourceTableView = SORTING("Call Type Code", "Location priority") ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Call Type Code"; Rec."Call Type Code")
                {
                    ApplicationArea = all;
                }
                field("Location code"; Rec."Location code")
                {
                    ApplicationArea = all;
                }
                field("Location priority"; Rec."Location priority")
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

