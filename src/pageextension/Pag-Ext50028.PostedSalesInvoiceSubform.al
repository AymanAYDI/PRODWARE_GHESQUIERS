pageextension 50028 "PWD PostedSalesInvoiceSubform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter(Type)
        {
            field("PWD Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("PWD Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
