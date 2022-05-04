page 50064 "PWD Modify Item Ledger Entries"
{
    Caption = 'Item Ledger Entries';
    DataCaptionExpression = GetCaption();
    DataCaptionFields = "Item No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Item Ledger Entry" = rm;
    SourceTable = "Item Ledger Entry";
    SourceTableView = SORTING("Item No.", Positive, "Completely Invoiced", "Last Invoice Date", "Location Code", "Variant Code");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Notice Series No."; Rec."PWD Notice Series No.")
                {
                    ApplicationArea = All;
                }
                field("COM 7 No."; Rec."PWD COM 7 No.")
                {
                    ApplicationArea = All;
                }
                field(Origin; Rec."PWD Origin")
                {
                    ApplicationArea = All;
                }
                field("Cetificate Transit No."; Rec."PWD Cetificate Transit No.")
                {
                    ApplicationArea = All;
                }
                field("Code fournisseur"; Rec."PWD Code fournisseur")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Code client"; Rec."PWD Code client")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&criture")
            {
                Caption = 'Ent&ry';
                action("A&xe analytique")
                {
                    Caption = 'Dimensions';
                    RunObject = Page "Ledger Entry Dimensions";
                    RunPageLink = "Table ID" = CONST(32), "Entry No." = FIELD("Entry No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("Ecritures &valeur")
                {
                    Caption = '&Value Entries';
                    RunObject = Page "Value Entries";
                    RunPageLink = "Item Ledger Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Item Ledger Entry No.");
                    ShortCutKey = 'Ctrl+F5';
                    ApplicationArea = All;
                }
            }
            group("&Lettrage")
            {
                Caption = '&Application';
                action("Ecritures &lettrage article")
                {
                    Caption = 'Applied E&ntries';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Show Applied Entries", Rec);
                    end;
                }
                action("Ecritures réservation")
                {
                    Caption = 'Reservation Entries';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(TRUE);
                    end;
                }
            }
            group("Fonction&s")
            {
                Caption = 'F&unctions';
                action("Chaînage")
                {
                    Caption = 'Order &Tracking';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TrackingForm: Page "Order Tracking";
                    begin
                        TrackingForm.SetItemLedgEntry(Rec);
                        TrackingForm.RUNMODAL();
                    end;
                }
            }
        }
        area(processing)
        {
            action("Na&viguer")
            {
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN();
                end;
            }
        }
    }


    procedure GetCaption(): Text[250]
    var
        ObjTransl: Record "Object Translation";
        CurrOrderNo: Code[20];
        ItemNo: Code[20];
        SourceTableName: Text[100];
    begin
        CASE TRUE OF
            Rec.GETFILTER("Item No.") <> '':
                IF Rec.GETRANGEMIN("Item No.") = Rec.GETRANGEMAX("Item No.") THEN BEGIN
                    ItemNo := Rec.GETRANGEMIN("Item No.");
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    EXIT(STRSUBSTNO('%1 %2', SourceTableName, ItemNo));
                END;
            Rec.GETFILTER("Prod. Order No.") <> '':
                IF Rec.GETRANGEMIN("Prod. Order No.") = Rec.GETRANGEMAX("Prod. Order No.") THEN BEGIN
                    CurrOrderNo := Rec.GETRANGEMIN("Prod. Order No.");
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5405);
                    EXIT(STRSUBSTNO('%1 %2', SourceTableName, CurrOrderNo));
                END;
        END;
    end;
}

