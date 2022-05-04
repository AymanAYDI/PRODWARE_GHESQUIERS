page 50016 "PWD Priority Location"
{
    Caption = 'Priority Location';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "PWD Location Priority";
    SourceTableView = SORTING("PWD Call Type Code", "PWD Location priority") ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Call Type Code"; Rec."PWD Call Type Code")
                {
                    ApplicationArea = all;
                }
                field("Location code"; Rec."PWD Location code")
                {
                    ApplicationArea = all;
                }
                field("Location priority"; Rec."PWD Location priority")
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

