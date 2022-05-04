page 50073 "Seatfance Sales Orders List"
{
    // -------------------------------------------------
    // Prodware - www.prodware.fr
    // -------------------------------------------------
    // //>>GHES1.01
    // FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009 - SALES ORDER SEAFRANCE
    //                                                     Create
    // 
    //  >>GHE1.00:DO 18/07/2011 :
    //    - type --> List

    Caption = 'WEB Sales Orders List';
    PageType = List;
    SourceTable = "PWD Seafrance Sales Header";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Initial order No."; Rec."Initial order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field(Reference; Rec.Reference)
                {
                    ApplicationArea = All;
                }
                field("Call Type"; Rec."Call Type")
                {
                    ApplicationArea = All;
                }
                field("Controlled Order"; Rec."Controlled Order")
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
            group("&Ligne")
            {
                Caption = '&Line';
                action("&Fiche")
                {
                    Caption = '&Fiche';
                    RunObject = Page "PWD Seafrance Sales Order";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
            }
        }
    }
}

