pageextension 50048 "PWD SalesLines" extends "Sales Lines"
{
    layout
    {
        addafter("Shipment Date")
        {
            field("PWD PreparedQuantityBase"; Rec."PWD Prepared Quantity (Base)")
            {
                ApplicationArea = all;
            }
        }
    }
}
