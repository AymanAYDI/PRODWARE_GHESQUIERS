pageextension 50077 "PWD PhysInventoryJournal" extends "Phys. Inventory Journal"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("PWD Line No."; Rec."Line No.")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Item No.")
        {
            field("PWD OldNo"; OldNo)
            {
                caption = 'Ancien code';
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("PWD Notice Series No."; Rec."PWD Notice Series No.")
            {
                ApplicationArea = All;
            }
            field("PWD COM7 No."; Rec."PWD COM7 No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Salespers./Purch. Code")
        {
            visible = false;
        }
    }
    trigger OnAfterGetRecord()
    begin
        OldNo := '';
        IF Item.GET(Rec."Item No.") THEN OldNo := Item."PWD Ancien Code Article";
    end;

    var
        Item: Record Item;
        OldNo: Code[20];
}
