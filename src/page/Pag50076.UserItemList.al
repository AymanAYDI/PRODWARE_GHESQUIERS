page 50076 "PWD User Item List"
{
    // //>>GHES1.05
    // FED_STOCK_20101105_VISU_STOCK_SEAFRANCE: SOBI 22/11/2010 SEAFRANCE INVENTORY VIEW
    //                                                          - Create

    Caption = 'User Item List';
    Editable = false;
    PageType = List;
    SourceTable = Item;
    SourceTableView = SORTING("No.") WHERE("No." = FILTER('S*'));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Fct_ProhibitDisplay();
                    end;
                }
                field("Alcool %"; Rec."PWD Alcool %")
                {
                    ApplicationArea = All;
                }
                field("Customs Price"; Rec."PWD Customs Price")
                {
                    ApplicationArea = All;
                }
                field("SEAF E price"; Rec."PWD SEAF E price")
                {
                    ApplicationArea = All;
                }
                field("SEAF Code"; Rec."PWD SEAF Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Ecritures)
            {
                Caption = 'Ledger';
                Image= Ledger;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "PWD User Item Ledger Entries";
                RunPageLink = "Item No." = FIELD("No.");
                RunPageView = SORTING("Item No.");
                ApplicationArea = All;
            }
            action("Traçabilité")
            {
                Caption = 'Tracking';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = ItemTracing;

                trigger OnAction()
                var
                    PWDFunctionMgt: Codeunit "PWD Function Mgt";
                begin
                    PWDFunctionMgt.CallItemTrackingEntryFormUser(0, '', Rec."No.", '', '', '');
                end;
            }
        }
    }

    procedure Fct_ProhibitDisplay()
    var
        CstL001: Label 'Access denied.';
    begin
        ERROR(CstL001);
    end;
}
