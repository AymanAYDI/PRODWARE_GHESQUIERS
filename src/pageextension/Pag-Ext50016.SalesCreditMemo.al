pageextension 50016 "PWD SalesCreditMemo" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Sell-to Contact")
        {
            field("PWD Call Type"; Rec."PWD Call Type")
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
        modify("Document Date")
        {
            Enabled = FALSE;
        }
        addafter("Bill-to Contact No.")
        {
            field("PWD Preparation Status"; Rec."PWD Preparation Status")
            {
                ApplicationArea = all;
            }
            field("PWD Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = all;
            }
            field("PWD Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = all;
            }
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
                ApplicationArea = all;
            }
        }
        modify("Your Reference")
        {
            visible = false;
        }
    }
}
