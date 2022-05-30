tableextension 60037 "PWD RequisitionLine" extends "Requisition Line"
{
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Prodware : www.prodware.fr
    // ------------------------------------------------------------------------------------------------------------------------------------
    //
    // //>>MIGRATION2009R2
    //
    // ------------------------------------------------------------------------------------------------------------------------------------
    //
    // >>GHE-RE1.00:DO 08/04/2011 :
    //   - MAJ description
    //   - retait MAJ description si update fournisseur
    // ------------------------------------------------------------------------------------------------------------------------------------
    DataCaptionFields = "Journal Batch Name", "Line No.";
    LookupPageID = "Requisition Lines";
    DrillDownPageID = "Requisition Lines";
    fields
    {
        field(50000; "PWD Specific cost"; Boolean)
        {
            Caption = 'Cout Spécifique';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55000; "PWD Suppl. lines"; Boolean)
        {
            Caption = 'Suppl. lines';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55001; "PWD Number of Suppl. lines"; Integer)
        {
            CalcFormula = Count("Requisition Line" WHERE("Worksheet Template Name" = FIELD("Worksheet Template Name"), "Journal Batch Name" = FIELD("Journal Batch Name"), Type = FIELD(Type), "No." = FIELD("No."), "Sales Order No." = FIELD("Sales Order No."), "Sales Order Line No." = FIELD("Sales Order Line No."), "PWD Suppl. lines" = CONST(true)));
            Caption = 'Number of Suppl. lines';
            Description = 'PW2009';
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key14; "Worksheet Template Name", "Journal Batch Name", "Vendor No.", "Sell-to Customer No.", "Ship-to Code", "Order Address Code", "Currency Code", "Location Code", "Transfer-from Code")
        {
            MaintainSQLIndex = false;
        }
        key(Key15; Type, "No.", "Variant Code", "Transfer-from Code", "Transfer Shipment Date")
        {
            MaintainSQLIndex = false;
        }
    }
}
