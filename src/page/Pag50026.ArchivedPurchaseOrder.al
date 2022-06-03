page 50026 "PWD Archived Purchase Order"
{
    Caption = 'Archived Purchase Order';
    Editable = false;
    PageType = Card;
    SourceTable = "PWD Archived Purchase Header";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = all;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = all;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
            part(PurchLinesArchive; "Archived Purch. Order Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"), "Version No." = FIELD("Version No.");
            }
            group(Facturation)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = all;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = all;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = all;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = all;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = all;
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = all;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = all;
                }
            }
            group(Livraison)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = all;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = all;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = all;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = all;
                }
            }
            group(International)
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = all;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = all;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = all;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = all;
                }
            }
            group(Version)
            {
                Caption = 'Version';
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = all;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ApplicationArea = all;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ApplicationArea = all;
                }
                field("Time Archived"; Rec."Time Archived")
                {
                    ApplicationArea = all;
                }
                field("Interaction Exist"; Rec."Interaction Exist")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ver&sion")
            {
                Caption = 'Ver&sion';
                action(Action121)
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    RunObject = Page "PWD Archived Purchase List";
                    RunPageMode = Edit;
                    ShortCutKey = 'F5';
                    Image = Card;
                }
                action("<Action130>")
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    RunPageMode = Edit;
                    ShortCutKey = 'Shift+F5';
                    Image = Card;
                }
                action("<Action119>")
                {
                    ApplicationArea = all;
                    Caption = 'Card';
                    Ellipsis = true;
                    Promoted = false;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                    Image = Card;
                }
                action("Axes analytiques")
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //ToDo
                    /*
                    RunObject = Page "Document Dimensions Archive";
                    RunPageLink = "Table ID" = CONST(38), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Line No." = CONST(0), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"), "Version No." = FIELD("Version No.");
                */
                }
            }
            group("<Action122>")
            {
                Caption = 'Ver&sion';
                action("<Action123>")
                {
                    ApplicationArea = all;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //ToDo
                    /*
                                        RunObject = Page "Document Dimensions Archive";
                                        RunPageLink = "Table ID" = CONST(38), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Line No." = CONST(0), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"), "Version No." = FIELD("Version No.");
                                    */
                }
            }
        }
    }
}
