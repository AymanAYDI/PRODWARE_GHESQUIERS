pageextension 50070 "PWD ItemRegisters" extends "Item Registers"
{
    layout
    {
        modify("No.")
        {
            Enabled = false;
        }
        modify("Creation Date")
        {
            Editable = false;
        }
        modify("User ID")
        {
            Editable = false;
        }
        modify("Source Code")
        {
            Editable = false;
        }
        modify("Journal Batch Name")
        {
            Editable = false;
        }
        modify("From Entry No.")
        {
            Editable = false;
        }
        modify("To Entry No.")
        {
            Editable = false;
        }
        modify("From Phys. Inventory Entry No.")
        {
            Editable = false;
        }
        modify("To Phys. Inventory Entry No.")
        {
            Editable = false;
        }
        modify("From Value Entry No.")
        {
            Editable = false;
        }
        modify("To Value Entry No.")
        {
            Editable = false;
        }
        modify("From Capacity Entry No.")
        {
            Editable = false;
        }
        modify("To Capacity Entry No.")
        {
            Editable = false;
        }
        addafter("To Capacity Entry No.")
        {
            field("PWD Generate Export File"; Rec."PWD Generate Export File")
            {
                ApplicationArea = All;
            }
        }
    }
}
