page 50080 "PWD Pos Sales Shpt.Sub Update"
{
    Caption = 'Posted Sales Shipment - Update';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Sales Shipment Line";
    SourceTableTemporary = true;
    UsageCategory = None;

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
                Caption = 'Shipping';
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
                field("PWD Certified Origin"; Rec."PWD Certified Origin")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD Origin Area"; Rec."PWD Origin Area")
                {
                    ApplicationArea = Suite;
                    Editable = true;
                }
                field("PWD Provision/materiel"; Rec."PWD Provision/materiel")
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
        xSalesShipmentLine := Rec;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = ACTION::LookupOK then
            if RecordChanged() then
                CODEUNIT.Run(CODEUNIT::"PWD Shipment Line - Edit", Rec);
    end;

    var
        xSalesShipmentLine: Record "Sales Shipment Line";

    local procedure RecordChanged() IsChanged: Boolean
    begin
        IsChanged :=
          (Rec."PWD Provision/materiel" <> xSalesShipmentLine."PWD Provision/materiel") or
          (Rec."PWD National Add. Code" <> xSalesShipmentLine."PWD National Add. Code") or
          (Rec."PWD DCG Tariff No." <> xSalesShipmentLine."PWD DCG Tariff No.") or
          (Rec."PWD Cle (restitution)" <> xSalesShipmentLine."PWD Cle (restitution)") or
          (Rec."PWD Monthly Code" <> xSalesShipmentLine."PWD Monthly Code") or
          (Rec."Net Weight" <> xSalesShipmentLine."Net Weight") or
          (Rec."Gross Weight" <> xSalesShipmentLine."Gross Weight") or
          (Rec."PWD Parcel Nb." <> xSalesShipmentLine."PWD Parcel Nb.") or
          (Rec."PWD Certified Origin" <> xSalesShipmentLine."PWD Certified Origin") or
          (Rec."PWD Origin Area" <> xSalesShipmentLine."PWD Origin Area") or
          (Rec."PWD Valeur douane (correction)" <> xSalesShipmentLine."PWD Valeur douane (correction)");

    end;

    procedure SetRec(SalesShipmentLine: Record "Sales Shipment Line")
    begin
        Rec := SalesShipmentLine;
        Rec.Insert();
    end;
}
