pageextension 50073 "PWD PostedSalesCrMemoSubform" extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        modify(Type)
        {
            Editable = false;
        }
        modify("No.")
        {
            Enabled = false;
            Editable = false;
        }
        modify("Item Reference No.")
        {
            Editable = false;
        }
        addafter("Item Reference No.")
        {
            field("PWD Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
        modify("IC Partner Code")
        {
            Editable = false;
        }
        modify("Variant Code")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Return Reason Code")
        {
            Editable = false;
        }
        modify(Quantity)
        {
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Unit of Measure")
        {
            Editable = false;
        }
        modify("Unit Cost (LCY)")
        {
            Editable = false;
        }
        modify("Unit Price")
        {
            Editable = false;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Line Discount %")
        {
            Editable = false;
        }
        modify("Line Discount Amount")
        {
            Editable = false;
        }
        modify("Allow Invoice Disc.")
        {
            Editable = false;
        }
        modify("Job No.")
        {
            Editable = false;
        }
        modify("Appl.-from Item Entry")
        {
            Editable = false;
        }
        modify("Appl.-to Item Entry")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Editable = false;
        }
        addafter("Shortcut Dimension 1 Code")
        {
            field("PWD National Add. Code"; Rec."PWD National Add. Code")
            {
                ApplicationArea = All;
            }
            field("PWD Monthly Code"; Rec."PWD Monthly Code")
            {
                ApplicationArea = All;
            }
            field("PWD Valeur douane (correction)"; Rec."PWD Valeur douane (correction)")
            {
                ApplicationArea = All;
            }
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = false;
        }
    }
    actions
    {
        addafter(DeferralSchedule)
        {
            action("PWD Update Document")
            {
                ApplicationArea = Suite;
                Caption = 'Update Document Line';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    PostedSalesCrMemoUpdate: Page "PWD Pos Sales CrMemo.Su Update";
                begin
                    PostedSalesCrMemoUpdate.LookupMode := true;
                    PostedSalesCrMemoUpdate.SetRec(Rec);
                    PostedSalesCrMemoUpdate.RunModal();
                end;
            }
        }
    }
    trigger OnModifyRecord(): Boolean
    BEGIN
        CODEUNIT.RUN(CODEUNIT::"PWD Cr.Memo Line - Edit", Rec);
        EXIT(FALSE);
    END;
}
