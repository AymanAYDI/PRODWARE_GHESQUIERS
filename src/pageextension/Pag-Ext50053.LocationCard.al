pageextension 50053 "PWD LocationCard" extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field("PWD Restitution Location"; Rec."PWD Restitution Location")
            {
                ApplicationArea = all;
            }
            field("PWD CounterMark Location"; Rec."PWD CounterMark Location")
            {
                ApplicationArea = all;
            }
            field("PWD Shortcut Dimension 1 Code"; Rec."PWD Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("PWD Shortcut Dimension 2 Code"; Rec."PWD Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("PWD Controle du prix plancher"; Rec."PWD Controle du prix plancher")
            {
                ApplicationArea = All;
            }
            field("PWD Groupe autorise"; Rec."PWD Groupe autorise")
            {
                ApplicationArea = All;
            }
        }
        addafter("Cross-Dock Due Date Calc.")
        {
            field("PWD Valorisation mvts periode"; Rec."PWD Valorisation mvts periode")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bin Policies")
        {
            group("PWD Customs")
            {
                Caption = 'Customs';
                field("PWD Regime"; Rec."PWD Regime")
                {
                    ApplicationArea = All;
                }
                field("PWD Placement Series No."; Rec."PWD Placement Series No.")
                {
                    ApplicationArea = All;
                }
                field("PWD Location ID"; Rec."PWD Location ID")
                {
                    ApplicationArea = All;
                }
                field("PWD Magasin libre"; Rec."PWD Magasin libre")
                {
                    ApplicationArea = All;
                }
                field("PWD COM 7"; Rec."PWD COM 7")
                {
                    ApplicationArea = All;
                }
                field("PWD T5 ou T1"; Rec."PWD T5 ou T1")
                {
                    ApplicationArea = All;
                }
                field("PWD Purch. Gen. Bus. Posting Group"; Rec."PWD PurchGenBusPostingGroup")
                {
                    ApplicationArea = All;
                }
                field("PWD Sales Gen. Bus. Posting Group"; Rec."PWD SalesGenBusPostingGroup")
                {
                    ApplicationArea = All;
                }
                field("PWD SEAF Placement Series No."; Rec."PWD SEAF Placement Series No.")
                {
                    ApplicationArea = All;
                }
                field("PWD Régime sortie"; Rec."PWD Régime sortie")
                {
                    ApplicationArea = All;
                }
                field("PWD Souche de DCG"; Rec."PWD Souche de DCG")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
