pageextension 50040 "PWD TariffNumbers" extends "Tariff Numbers"
{
    layout
    {
        addafter("No.")
        {
            field("PWD Description 2"; Rec."PWD Description 2")
            {
                ApplicationArea = all;
            }
        }
        modify(Description)
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("PWD Relative Comment"; Rec."PWD Relative Comment")
            {
                ApplicationArea = All;
            }
        }
        addafter("Supplementary Units")
        {
            field("PWD Calcul Method"; Rec."PWD Calcul Method")
            {
                ApplicationArea = All;
            }
        }
    }
}
