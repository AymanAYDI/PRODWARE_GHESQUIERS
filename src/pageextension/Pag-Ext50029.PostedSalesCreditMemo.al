pageextension 50029 "PWD PostedSalesCreditMemo" extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Pre-Assigned No.")
        {
            field("PWD Call No."; Rec."PWD Call No.")
            {
                ApplicationArea = all;
            }
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = all;
            }
            field("PWD DSA No."; Rec."PWD DSA No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bill-to Contact No.")
        {
            field("PWD Bill-to Additional name"; Rec."PWD Bill-to Additional name")
            {
                ApplicationArea = all;
            }
            field("PWD Bill-to C/O"; Rec."PWD Bill-to C/O")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bill-to Name")
        {
            field("PWD Bill-to Name 2"; Rec."Bill-to Name 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Applies-to Doc. No.")
        {
            field("PWD Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
