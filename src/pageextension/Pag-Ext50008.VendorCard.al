pageextension 50008 "PWD VendorCard" extends "Vendor Card"
{
    layout
    {
        addafter("Primary Contact No.")
        {
            field("PWD Family"; Rec."PWD Family")
            {
                ApplicationArea = all;
            }
            field("PWD Sub Family"; Rec."PWD Sub Family")
            {
                ApplicationArea = all;
            }
            field("PWD County"; Rec."County")
            {
                ApplicationArea = all;
            }
        }
        addafter("Base Calendar Code")
        {
            field("PWD DeliveryTimeRating"; Rec."PWD Delivery Time Rating")
            {
                ApplicationArea = all;
            }
            field("PWD DeliveredQuantityRating"; Rec."PWD Delivered Quantity Rating")
            {
                ApplicationArea = all;
            }
            field("PWD Technical Rating"; Rec."PWD Technical Rating")
            {
                ApplicationArea = all;
            }
            field("PWD Documentation Rating"; Rec."PWD Documentation Rating")
            {
                ApplicationArea = all;
            }
        }
        addafter("VAT Registration No.")
        {
            field("PWD Transport Method"; Rec."PWD Transport Method")
            {
                ApplicationArea = all;
            }
            field("PWD Shipment Method"; Rec."PWD Shipment Method")
            {
                ApplicationArea = all;
            }
            field("PWD Shipment Method Code"; Rec."Shipment Method Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
