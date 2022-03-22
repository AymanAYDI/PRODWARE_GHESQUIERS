pageextension 50002 "PWD PaymentTerms" extends "Payment Terms"
{
    layout
    {
        addafter(Description)
        {
            field("PWD PWDInternational Description"; Rec."PWD International Description")
            {
                ApplicationArea = All;
            }
        }
    }
}
