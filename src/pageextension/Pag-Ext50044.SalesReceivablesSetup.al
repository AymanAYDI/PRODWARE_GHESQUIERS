pageextension 50044 "PWD SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Check Prepmt. when Posting")
        {
            field("PWD Archive Quotes"; Rec."Archive Quotes")
            {
                ApplicationArea = All;
            }
            field("PWD Archive Orders"; Rec."Archive Orders")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("PWD Call No. Series"; Rec."PWD Call No. Series")
            {
                ApplicationArea = all;
            }
            field("PWD Prestation M2 Invoice Nos."; Rec."PWD Prestation M2 Invoice Nos.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Dimensions)
        {
            group("PWD Custom")
            {
                Caption = 'Custom';
                group("PWD TenderPath")
                {
                    caption = 'Chemin des appels d''offres au format Excel';
                    field("PWD Path xls File Export"; Rec."PWD Path xls File Export")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD Sales Order User Group"; Rec."PWD Sales Order User Group")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD Ressource prestation"; Rec."PWD Ressource prestation")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD Coef Controle prix unitaire"; Rec."PWD Coef Controle prix unitaire")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD DSA Location Filter"; Rec."PWD DSA Location Filter")
                    {
                        ApplicationArea = All;
                    }

                }
            }
            group("PWD Customs")
            {
                Caption = 'Customs';
                group("PWD Numerotation")
                {
                    Caption = 'Numerotation';
                    field("PWD Souche de T1"; Rec."PWD Souche de T1")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD Souche de TM"; Rec."PWD Souche de TM")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD Souche de T5"; Rec."PWD Souche de T5")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD Souche EX9"; Rec."PWD Souche EX9")
                    {
                        ApplicationArea = All;
                    }
                    field("PWD Souche COM9"; Rec."PWD Souche COM9")
                    {
                        ApplicationArea = All;
                    }
                    field("PWD Souche EX1"; Rec."PWD Souche EX1")
                    {
                        ApplicationArea = All;
                    }

                }
                group("PWD T1")
                {
                    Caption = 'T1';
                    field("PWD Certif de cautionnement T1"; Rec."PWD Certif de cautionnement T1")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD Date du certificat T1"; Rec."PWD Date du certificat T1")
                    {
                        ApplicationArea = all;
                    }
                }
                group("PWD TM")
                {
                    Caption = 'TM';
                    field("PWD Certif de cautionnement TM"; Rec."PWD Certif de cautionnement TM")
                    {
                        ApplicationArea = all;
                    }
                    field("PWD Date du certificat TM"; Rec."PWD Date du certificat TM")
                    {
                        ApplicationArea = all;
                    }
                }

            }
        }
    }
}