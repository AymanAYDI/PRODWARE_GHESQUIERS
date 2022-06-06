page 50078 "PWD User Item Tracking Entries"
{
    // //>>GHES1.05
    // FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010 SEAFRANCE INVENTORY VIEW
    //                                                          - Create

    Caption = 'Item Tracking Entries';
    Editable = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Item Ledger Entry";
    UsageCategory = None;
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
                        //>>FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010
                        Fct_ProhibitDisplay();
                        //<<FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010
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
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //>>FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010
                        Fct_ProhibitDisplay();
                        //<<FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010
                    end;
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
                        //>>FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010
                        Fct_ProhibitDisplay();
                        //<<FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Positive; Rec.Positive)
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //>>FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010
                        Fct_ProhibitDisplay();
                        //<<FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010
                    end;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ecr. &traç.")
            {
                Caption = '&Item Tracking Entry';
                Visible = false;
                action("Fiche information n° de série")
                {
                    Caption = 'Serial No. Information Card';
                    RunObject = Page "Serial No. Information Card";
                    Image = Card;
                    RunPageLink = "Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code"), "Serial No." = FIELD("Serial No.");
                    ApplicationArea = All;
                }
                action("F&iche information n° lot")
                {
                    Caption = 'Lot No. Information Card';
                    Image = Card;
                    RunObject = Page "Lot No. Information Card";
                    RunPageLink = "Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code"), "Lot No." = FIELD("Lot No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("Na&viguer")
            {
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;
                Image = Navigate;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN();
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;

    procedure Fct_ProhibitDisplay()
    var
        CstL001: Label 'Access denied.';
    begin
        ERROR(CstL001);
    end;
}
