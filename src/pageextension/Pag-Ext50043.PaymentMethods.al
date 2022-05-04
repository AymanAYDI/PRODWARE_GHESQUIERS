pageextension 50043 "PWD PaymentMethods" extends "Payment Methods"
{
    layout
    {
        addafter(Description)
        {
            field("PWD International Description"; Rec."PWD International Description")
            {
                ApplicationArea = all;
            }
        }
    }
}
