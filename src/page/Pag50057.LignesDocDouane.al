page 50057 "PWD Lignes Doc Douane"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "PWD Ligne document Douane";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customs Document Type"; Rec."Customs Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customs Doc. No."; Rec."Customs Doc. No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cle (restitution)"; Rec."Cle (restitution)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. sommier"; Rec."No. sommier")
                {
                    ApplicationArea = All;
                }
                field("No. facture fournisseur"; Rec."No. facture fournisseur")
                {
                    ApplicationArea = All;
                }
                field("Pays d origine"; Rec."Pays d origine")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cle Description"; Rec."Cle Description")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Parcel"; Rec."Total Parcel")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Parcel nb."; Rec."Parcel nb.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Line"; Rec."Total Line")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Stat Value"; Rec."Stat Value")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
