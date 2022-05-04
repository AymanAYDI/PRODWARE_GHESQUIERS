pageextension 50046 "PWD InventorySetup" extends "Inventory Setup"
{
    layout
    {
        addafter("Inbound Whse. Handling Time")
        {
            field("PWD Default Translation Language"; Rec."PWD Default Translation Language")
            {
                ApplicationArea = All;
            }
            field("PWD Whse Responsible Role Id"; Rec."PWD Whse Responsible Role Id")
            {
                ApplicationArea = All;
            }
            field("PWD Nom modele prestation"; Rec."PWD Nom modele prestation")
            {
                ApplicationArea = All;
            }

        }
    }
}
