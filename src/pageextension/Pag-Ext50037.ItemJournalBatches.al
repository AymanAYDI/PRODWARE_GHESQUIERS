pageextension 50037 "PWD ItemJournalBatches" extends "Item Journal Batches"
{
    layout
    {
        addafter(Description)
        {
            field("PWD Code client"; Rec."PWD Code client")
            {
                ApplicationArea = All;
            }
            field("PWD Code fournisseur"; Rec."PWD Code fournisseur")
            {
                ApplicationArea = All;
            }
            field("PWD Code préstation"; Rec."PWD Code préstation")
            {
                ApplicationArea = All;
            }
        }
        addafter("Reason Code")
        {
            field("PWD First Purch. Ord. Seafrance No"; Rec."PWD First Purch. Ord. Seafrance No")
            {
                ApplicationArea = All;
            }
        }
    }
}
