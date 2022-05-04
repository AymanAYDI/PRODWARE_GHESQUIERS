pageextension 50056 "PWD PurchasingCodes" extends "Purchasing Codes"
{
    layout
    {
        addafter(Description)
        {
            field("PWD Location Code"; Rec."PWD Location Code")
            {
                ApplicationArea = All;
            }

        }
    }
}
