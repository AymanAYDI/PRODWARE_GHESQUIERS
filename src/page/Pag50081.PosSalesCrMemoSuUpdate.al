page 50081 "PWD Pos Sales CrMemo.Su Update"
{
    Caption = 'Posted Sales Cr. Memo Subform - Update';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Sales Cr.Memo Line";
    SourceTableTemporary = true;
    UsageCategory = None;
    Permissions = TableData "Sales Cr.Memo Line" = rm;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            group(Shipping)
            {
                Caption = 'Invoice Details';
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD Parcel Nb."; Rec."PWD Parcel Nb.")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD Origin Area"; Rec."PWD Origin Area")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD National Add. Code"; Rec."PWD National Add. Code")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD DCG Tariff No."; Rec."PWD DCG Tariff No.")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD Cle (restitution)"; Rec."PWD Cle (restitution)")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD Monthly Code"; Rec."PWD Monthly Code")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD Valeur douane (correction)"; Rec."PWD Valeur douane (correction)")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        xSalesCrMemoLine := Rec;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = ACTION::LookupOK then
            if RecordChanged() then
                CODEUNIT.Run(CODEUNIT::"PWD Cr.Memo Line - Edit", Rec);
    end;

    var
        xSalesCrMemoLine: Record "Sales Cr.Memo Line";

    local procedure RecordChanged() IsChanged: Boolean
    begin
        IsChanged :=
          (Rec."PWD National Add. Code" <> xSalesCrMemoLine."PWD National Add. Code") or
          (Rec."PWD DCG Tariff No." <> xSalesCrMemoLine."PWD DCG Tariff No.") or
          (Rec."PWD Cle (restitution)" <> xSalesCrMemoLine."PWD Cle (restitution)") or
          (Rec."PWD Monthly Code" <> xSalesCrMemoLine."PWD Monthly Code") or
          (Rec."Net Weight" <> xSalesCrMemoLine."Net Weight") or
          (Rec."Gross Weight" <> xSalesCrMemoLine."Gross Weight") or
          (Rec."PWD Parcel Nb." <> xSalesCrMemoLine."PWD Parcel Nb.") or
          (Rec."PWD Origin Area" <> xSalesCrMemoLine."PWD Origin Area") or
          (Rec."PWD Valeur douane (correction)" <> xSalesCrMemoLine."PWD Valeur douane (correction)");

    end;

    procedure SetRec(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    begin
        Rec := SalesCrMemoLine;
        Rec.Insert();
    end;
}
