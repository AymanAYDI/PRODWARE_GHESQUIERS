page 50003 "Appeal for tenders/Vendor det"
{
    // *** Contremarque - C2A

    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "PWD Appeal for Tenders";
    SourceTableView = WHERE(Detail = CONST(true));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Exclude; Rec.Exclude)
                {
                    ApplicationArea = all;
                    Caption = 'Exclure';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Line No. document"; Rec."Line No. document")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Detail; Rec.Detail)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        VendorNoOnFormat();
    end;

    local procedure GetItemVendor(): Boolean
    var
        Item: Record Item;
    begin
        IF Item.GET(Rec."No.") THEN
            IF Rec."Vendor No." = Item."Vendor No." THEN EXIT(TRUE) ELSE EXIT(FALSE);
    end;

    local procedure VendorNoOnFormat()
    begin
        IF GetItemVendor() THEN;
    end;
}
