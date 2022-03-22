page 50077 "PWD User Item Ledger Entries"
{
    Caption = 'User Item Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                }
                field(Positive; Rec.Positive)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                }
                field("Cetificate Transit No."; Rec."PWD Cetificate Transit No.")
                {
                    ApplicationArea = All;
                }
                field("Code fournisseur"; Rec."PWD Code fournisseur")
                {
                    ApplicationArea = All;
                }
                field("Seafrance Order No."; Rec."PWD Seafrance Order No.")
                {
                    ApplicationArea = All;
                }
                field("Seafrance Order Line No."; Rec."PWD Seafrance Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."PWD Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."PWD Net Weight")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec."PWD Comments")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    procedure Fct_ProhibitDisplay()
    var
        CstL001: Label 'Access denied.';
    begin
        ERROR(CstL001);
    end;
}

