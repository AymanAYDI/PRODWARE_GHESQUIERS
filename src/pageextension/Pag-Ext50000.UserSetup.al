pageextension 50000 "PWD UserSetup" extends "User Setup"
{
    layout
    {
        addafter(PhoneNo)
        {
            field("PWD Signing"; Rec."PWD Signing")
            {
                ApplicationArea = all;

            }
        }
    }
}
