tableextension 60058 "PWD LotNoInformation" extends "Lot No. Information"
{
    fields
    {
        field(50023; "PWD Lot Reserved Qty"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = FIELD("Item No."), "Lot No." = FIELD("Lot No."), "Source Type" = CONST(37), "Source Subtype" = CONST(1)));
            Caption = 'Lot Reserved Qty';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
