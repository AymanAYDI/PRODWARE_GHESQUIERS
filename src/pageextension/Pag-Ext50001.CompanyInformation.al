pageextension 50001 "PWD CompanyInformation" extends "Company Information"
{
    layout
    {
        addafter("Stock Capital")
        {
            Field("PWD Out Agrement No."; Rec."PWD Out Agrement No.")
            {
                ApplicationArea = All;
            }

            Field("PWD In Agrement No."; Rec."PWD In Agrement No.")
            {
                ApplicationArea = All;
            }

            Group(Logo)
            {
                Caption = 'Logo';

                Field("PWD Logo AVITA facture"; Rec."PWD Logo AVITA facture")
                {
                    ApplicationArea = All;
                }
                Field("PWD Logo ISSA"; Rec."PWD Logo ISSA")
                {
                    ApplicationArea = All;
                }
            }
            Group(Douane)
            {
                Caption = 'Douane';

                Field("PWD Location Rights Acquit Filter"; Rec."PWD LocationRightAcquitFilter")
                {
                    ApplicationArea = All;
                }
                Field("PWD Loc. Rights Suspended Filter"; Rec."PWD Loc.RightSuspendedFilter")
                {
                    ApplicationArea = All;
                }
                Field("PWD Indebted Identification"; Rec."PWD Indebted Identification")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
