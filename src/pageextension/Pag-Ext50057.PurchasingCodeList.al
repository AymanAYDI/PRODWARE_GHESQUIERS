pageextension 50057 "PWD PurchasingCodeList" extends "Purchasing Code List"
{
    layout
    {
        addafter("Drop Shipment")
        {
            field("PWD Location Code"; Rec."PWD Location Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
