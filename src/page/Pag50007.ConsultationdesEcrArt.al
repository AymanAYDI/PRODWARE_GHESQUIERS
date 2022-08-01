page 50007 "PWD Consultation des Ecr Art"
{
    // 02/11/06   C2A(LLE)   Nouveau FORM cf Cde CDVN001307

    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    caption = 'Consultation des Ecr Art';

    layout
    {
        area(content)
        {
            label(Control1000000000)
            {
                CaptionClass = Text19074687;
                ShowCaption = false;
                ApplicationArea = all;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Code prestation"; Rec."PWD Code prestation")
                {
                    ApplicationArea = all;
                }
                field("Code client"; Rec."PWD Code client")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Cetificate Transit No."; Rec."PWD Cetificate Transit No.")
                {
                    ApplicationArea = all;
                }
                field("Montant douane"; Rec."PWD Montant douane")
                {
                    ApplicationArea = all;
                }
                field("Gross Weight"; Rec."PWD Gross Weight")
                {
                    ApplicationArea = all;
                }
                field("Net Weight"; Rec."PWD Net Weight")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Text19074687: Label 'Pour les écritures liées à la prestation, filtrer sur Code prestation <> ''''';
}
