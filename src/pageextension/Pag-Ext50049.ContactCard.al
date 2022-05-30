pageextension 50049 "PWD ContactCard" extends "Contact Card"
{
    layout
    {
        addafter("Foreign Trade")
        {
            group("PWD Specific")
            {
                caption = 'Specific';
                field("PWD Business Initiator"; Rec."PWD Business Initiator")
                {
                    applicationarea = all;
                }
                field("PWD Payback Commission Rate"; Rec."PWD Payback Commission Rate")
                {
                    applicationarea = all;
                }
            }
        }
    }
}
