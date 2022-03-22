page 50053 "PWD Feuille saisie prestation"
{
    AutoSplitKey = true;
    Caption = 'Item Journal';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = "Item Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD();
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    MAJ();
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate()
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    MAJ();
                    CurrentJnlBatchNameOnAfterVali();
                end;
            }
            field(VendorNo; VendorNo)
            {
                Caption = 'Fournisseur';
                Editable = false;
                ApplicationArea = All;
            }
            field(VendorName; VendorName)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(TypePresta; TypePresta)
            {
                Caption = 'Prestation';
                Editable = false;
                ApplicationArea = All;
            }
            field(PrestaName; PrestaName)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(CustNo; CustNo)
            {
                Caption = 'Client';
                Editable = false;
                ApplicationArea = All;
            }
            field(CustName; CustName)
            {
                Editable = false;
                ApplicationArea = All;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Code fournisseur"; Rec."PWD Code fournisseur")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Code client"; Rec."PWD Code client")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec."PWD Comments")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Seafrance Quantity"; Rec."PWD Seafrance Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Montant douane"; Rec."PWD Montant douane")
                {
                    Caption = 'Montant douane unitaire';
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."PWD Gross Weight")
                {
                    Caption = 'Poids brut unitaire';
                    DecimalPlaces = 2 : 3;
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."PWD Net Weight")
                {
                    Caption = 'Poids net unitaire';
                    DecimalPlaces = 2 : 3;
                    ApplicationArea = All;
                }
                field("Parcel Nb."; Rec."PWD Parcel Nb.")
                {
                    ApplicationArea = All;
                }
                field("Nb. unite"; Rec."PWD Nb. unite")
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
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    ApplicationArea = All;
                }
                field("Applies-from Entry"; Rec."Applies-from Entry")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Seafrance Order No."; Rec."PWD Seafrance Order No.")
                {
                    ApplicationArea = All;
                }
                field("Seafrance Order Line No."; Rec."PWD Seafrance Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."PWD Vendor Item No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Control22)
            {
                ShowCaption = false;
                field(ItemDescription; ItemDescription)
                {
                    Caption = 'Item Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                label(Control1000000017)
                {
                    CaptionClass = Text19036003;
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field(PJ1; PJ1)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PJ1OnAfterValidate();
                    end;
                }
                field(PJ2; PJ2)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PJ2OnAfterValidate();
                    end;
                }
                field(PJ3; PJ3)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PJ3OnAfterValidate();
                    end;
                }
                field(PJ4; PJ4)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PJ4OnAfterValidate();
                    end;
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
                action("A&xe analytique")
                { //ToDo
                    Caption = 'Dimensions';
                    RunObject = Page "Journal Line Dimensions";
                    RunPageLink = "Table ID" = CONST(83), "Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD("Journal Batch Name"), "Journal Line No." = FIELD("Line No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("Lignes traçabilité")
                {
                    Caption = 'Item &Tracking Lines';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines(FALSE);
                    end;
                }
            }
            group("Arti&cle")
            {
                Caption = '&Item';
                action(Fiche)
                {
                    Caption = 'Card';
                    RunObject = Page "Item Card";
                    RunPageLink = "No." = FIELD("Item No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action(Ecritures)
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F5';
                    ApplicationArea = All;
                }
                group("Disponibilité article par")
                {
                    Caption = 'Item Availability by';
                    action("Période")
                    {
                        Caption = 'Period';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailability(0);
                        end;
                    }
                    action(Variante)
                    {
                        Caption = 'Variant';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailability(1);
                        end;
                    }
                    action(Magasin)
                    {
                        Caption = 'Location';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailability(2);
                        end;
                    }
                    action(Emplacement)
                    {
                        Caption = 'Bin';
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            ItemAvailability(3);
                        end;
                    }
                }
            }
            group("Fonction&s")
            {
                Caption = 'F&unctions';
                action("&Eclater nomenclature")
                {
                    Caption = 'E&xplode BOM';
                    RunObject = Codeunit "Item Jnl.-Explode BOM";
                    ApplicationArea = All;
                }
                action("&Calculer ajustement magasin")
                {
                    Caption = '&Calculate Whse. Adjustment';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL();
                        CLEAR(CalcWhseAdjmt);
                    end;
                }
                separator(Action1000000021)
                {
                }
                action("Mettre à jour Magasin/reservation")
                {
                    Caption = 'Mettre à jour Magasin/reservation';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        UpdateTrackinLines();
                    end;
                }
            }
            group("&Imprimer")
            {
                Caption = '&Imprimer';
                action("Bon de commande")
                {
                    Caption = 'Bon de commande';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ItemJnlLine: Record "Item Journal Line";
                    begin
                        CurrPage.SETSELECTIONFILTER(ItemJnlLine);
                        ItemJnlLine.SETRANGE("Line No.");
                        REPORT.RUNMODAL(REPORT::"Bon de commande prestation", TRUE, TRUE, ItemJnlLine);
                    end;
                }
                action("Avis de placement")
                {
                    Caption = 'Avis de placement';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        InvSetup.GET();
                        ItemJnlBatch.GET(InvSetup."PWD Nom modele prestation", CurrentJnlBatchName);
                        ItemJnlBatch.SETRECFILTER();
                        REPORT.RUNMODAL(REPORT::"Avis placement prestation", TRUE, TRUE, ItemJnlBatch);
                    end;
                }
            }
            group("&Validation")
            {
                Caption = 'P&osting';
                action("Impression test")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action("&Valider")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F11';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM(Text1000000014, FALSE) THEN EXIT;

                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Valider et i&mprimer")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF NOT CONFIRM(Text1000000014, FALSE) THEN EXIT;

                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := Rec.GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF Rec."Entry Type" > Rec."Entry Type"::"Negative Adjmt." THEN
            ERROR(Text000, Rec."Entry Type");
        Rec.TESTFIELD("Location Code");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLinePrest(xRec);
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
        MAJ();
    end;

    var
        Text000: Label 'You cannot use entry type %1 in this journal.';
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        CalcWhseAdjmt: Report "Calculate Whse. Adjustment";
        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        "--": Integer;
        VendorNo: Code[20];
        TypePresta: Code[10];
        CustNo: Code[20];
        VendorName: Text[50];
        CustName: Text[50];
        PrestaName: Text[50];
        Scellement: Text[50];
        PJ1: Text[50];
        PJ2: Text[50];
        PJ3: Text[50];
        PJ4: Text[50];
        ItemJnlBatch: Record "Item Journal Batch";
        InvSetup: Record "Inventory Setup";
        Text1000000014: Label 'Attention, après validation vous ne pourrez plus rééditer les document (avis de placement ou bon de commande). Continuer ?';
        Text19036003: Label 'Pièces jointes';


    procedure MAJ()
    var
        ItemJnlBatch: Record "Item Journal Batch";
        Vendor: Record Vendor;
        Cust: Record Customer;
        Presta: Record "PWD Prestations";
    begin
        ItemJnlMgt.MAJPrest(CurrentJnlBatchName, VendorNo, CustNo, TypePresta);
        IF Vendor.GET(VendorNo) THEN VendorName := Vendor.Name ELSE VendorName := '';
        IF Cust.GET(CustNo) THEN CustName := Cust.Name ELSE CustName := '';
        IF Presta.GET(TypePresta) THEN PrestaName := Presta.Designation ELSE PrestaName := '';
        InvSetup.GET();
        IF NOT ItemJnlBatch.GET(InvSetup."PWD Nom modele prestation", CurrentJnlBatchName) THEN
            ItemJnlBatch.INIT() ELSE BEGIN
            Scellement := ItemJnlBatch."PWD Sealing";
            PJ1 := ItemJnlBatch."PWD Attachment 1";
            PJ2 := ItemJnlBatch."PWD Attachment 2";
            PJ3 := ItemJnlBatch."PWD Attachment 3";
            PJ4 := ItemJnlBatch."PWD Attachment 4";
        END;
    end;


    procedure GetJnlBatch()
    begin
        InvSetup.GET();
        ItemJnlBatch.GET(InvSetup."PWD Nom modele prestation", CurrentJnlBatchName);
        ItemJnlBatch."PWD Sealing" := Scellement;
        ItemJnlBatch."PWD Attachment 1" := PJ1;
        ItemJnlBatch."PWD Attachment 2" := PJ2;
        ItemJnlBatch."PWD Attachment 3" := PJ3;
        ItemJnlBatch."PWD Attachment 4" := PJ4;
        ItemJnlBatch.MODIFY();
    end;

    procedure UpdateTrackinLines()
    var
        FromItemJnlLine: Record "Item Journal Line";
        ReservEntry: Record "Reservation Entry";
    begin
        FromItemJnlLine.COPY(Rec);
        FromItemJnlLine.FIND('-');
        REPEAT
            CLEAR(ReservEntry);
            ReservEntry.SETCURRENTKEY("Source ID", "Source Batch Name", "Source Ref. No.");
            ReservEntry.SETRANGE("Source ID", FromItemJnlLine."Journal Template Name");
            ReservEntry.SETRANGE("Source Batch Name", FromItemJnlLine."Journal Batch Name");
            ReservEntry.SETRANGE("Source Ref. No.", FromItemJnlLine."Line No.");
            IF (ReservEntry.FIND('-')) AND (FromItemJnlLine."Location Code" <> ReservEntry."Location Code") THEN BEGIN
                ReservEntry."Location Code" := FromItemJnlLine."Location Code";
                ReservEntry.MODIFY();
            END;
        UNTIL FromItemJnlLine.NEXT() = 0;
    end;

    local procedure PJ1OnAfterValidate()
    begin
        GetJnlBatch();
    end;

    local procedure PJ2OnAfterValidate()
    begin
        GetJnlBatch();
    end;

    local procedure PJ3OnAfterValidate()
    begin
        GetJnlBatch();
    end;

    local procedure PJ4OnAfterValidate()
    begin
        GetJnlBatch();
    end;

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD();
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        MAJ();
        CurrPage.UPDATE(FALSE);
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
    end;
}

