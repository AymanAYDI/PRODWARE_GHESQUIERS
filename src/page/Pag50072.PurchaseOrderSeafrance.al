page 50072 "PWD Purchase Order Seafrance"
{
    Caption = 'Purchase Order Seafrance';
    PageType = List;
    SourceTable = "PWD Purchase Order Seafrance";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Purchase Order Seafrance No."; Rec."Purchase Order Seafrance No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Seafrance Quantity"; Rec."Seafrance Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Seafrance Unit"; Rec."Seafrance Unit")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Encode Performance"; Rec."Encode Performance")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Controlled line"; Rec."Controlled line")
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
            group("Fonction&s")
            {
                Caption = 'Function&s';
                action("<Action1000000001>")
                {
                    Caption = 'Controle Unitaire';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //>-> GHE-RE.1.00
                        Fct_ControlLinesUnit();
                        //<-< GHE-RE.1.00
                    end;
                }
                action("Contrôler les lignes sélectionnées")
                {
                    Caption = 'Control the marked lines';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //>>FED_ADV_20090909_IMP_CDEACHAT_V3 :SOBI
                        Fct_ControlLines();
                        //<<FED_ADV_20090909_IMP_CDEACHAT_V3 :SOBI
                    end;
                }
                action("Intégrer dans les feuilles les lignes contrôlées")
                {
                    Caption = 'Insert the controlled lines into leaves';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CstL009: Label 'Please insert indeed lines proved in Item Journal Line ?';
                        CstL010: Label 'Cancelled treatment.';
                    begin
                        //>>FED_ADV_20090909_IMP_CDEACHAT_V3 :SOBI
                        IF CONFIRM(CstL009, FALSE) THEN
                            Fct_CreateItemJournalLine()
                        ELSE
                            ERROR(CstL010);
                        //<<FED_ADV_20090909_IMP_CDEACHAT_V3 :SOBI
                    end;
                }
            }
        }
    }

    var
        // "--MIGRATION2009R2--": ;
        CstG001: Label 'Ok';


    procedure Fct_UptdateRecord()
    var
        RecLItem: Record Item;
        RecLPurchOrderSeafrance: Record "PWD Purchase Order Seafrance";
    begin
        RecLPurchOrderSeafrance.RESET();
        RecLPurchOrderSeafrance.SETCURRENTKEY(RecLPurchOrderSeafrance."Controlled line");
        RecLPurchOrderSeafrance.SETRANGE(RecLPurchOrderSeafrance."Controlled line", FALSE);
        IF RecLPurchOrderSeafrance.FIND('-') THEN
            REPEAT
                IF RecLItem.GET(RecLPurchOrderSeafrance."Item No.") THEN BEGIN
                    RecLPurchOrderSeafrance."Vendor No." := RecLItem."Vendor No.";
                    RecLPurchOrderSeafrance."Base Unit of Measure" := RecLItem."Base Unit of Measure";
                    RecLPurchOrderSeafrance.MODIFY();
                END;
            UNTIL RecLPurchOrderSeafrance.NEXT() = 0;
    end;


    procedure Fct_ControlLines()
    var
        RecLItem: Record Item;
        BoolLCheckRecord: Boolean;
        BoolLFirstTime: Boolean;
        CodLEncodePerformance: Code[10];
        CodLCustomerNum: Code[20];
        CodLVendorNum: Code[20];
        CodLOrderNum: Code[30];
        CstL001: Label 'The article %1 of the line %2 of order %3 does not exist in the foundation Navision. Please create it to you?';
        CstL002: Label 'For the same order he can have there only an only one encodes purveyor, an only one encodes performance, an only one encodes customer. See Order %1.';
        CstL003: Label 'Vendor code it does not give information to it for the line %1 of order %2.';
        CstL004: Label 'Prestation code it does not give information to it for the line %1 of order %2.';
        CstL005: Label 'Customer code it does not give information to it for the line %1 of order %2.';
        CstL006: Label 'Location code it does not give information to it for the line %1 of order %2.';
        CstL007: Label 'No line selected. ';
        CstL008: Label 'Check on the  lines selected ended.';
        CstL011: Label 'Cancelled treatment. It is necessary you to change code article of the line %1 of order %2 and to throw the check on lines once again.';
    begin
        BoolLCheckRecord := TRUE;
        CodLVendorNum := '';
        CodLEncodePerformance := '';
        CodLCustomerNum := '';
        CodLOrderNum := '';
        Rec.RESET();
        CurrPage.SETSELECTIONFILTER(Rec);
        Rec.MARKEDONLY(TRUE);
        IF Rec.FIND('-') THEN BEGIN
            REPEAT
                Rec.CALCFIELDS("Vendor No.");

                IF Rec."Purchase Order Seafrance No." <> CodLOrderNum THEN
                    BoolLFirstTime := TRUE;

                IF Rec."Encode Performance" = '' THEN BEGIN
                    Rec.CLEARMARKS();
                    Rec.MARKEDONLY(FALSE);
                    ERROR(CstL004, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");
                END;
                IF Rec."Customer No." = '' THEN BEGIN
                    Rec.CLEARMARKS();
                    Rec.MARKEDONLY(FALSE);
                    ERROR(CstL005, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");
                END;
                IF Rec."Location Code" = '' THEN BEGIN
                    Rec.CLEARMARKS();
                    Rec.MARKEDONLY(FALSE);
                    ERROR(CstL006, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");
                END;

                IF NOT RecLItem.GET(Rec."Item No.") THEN
                    IF CONFIRM(CstL001, FALSE, Rec."Item No.", Rec."Order Line No.", Rec."Purchase Order Seafrance No.") THEN BEGIN
                        Fct_CreateItem(Rec."Item No.");
                        BoolLCheckRecord := FALSE;
                    END ELSE
                        ERROR(CstL011, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");

                IF BoolLCheckRecord THEN
                    IF Rec."Vendor No." = '' THEN BEGIN
                        Rec.CLEARMARKS();
                        Rec.MARKEDONLY(FALSE);
                        ERROR(CstL003, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");
                    END;

                IF NOT BoolLFirstTime THEN
                    IF (CodLVendorNum <> Rec."Vendor No.") OR (CodLEncodePerformance <> Rec."Encode Performance")
                                                           OR (CodLCustomerNum <> Rec."Customer No.") THEN BEGIN
                        Rec.CLEARMARKS();
                        Rec.MARKEDONLY(FALSE);
                        ERROR(CstL002, Rec."Purchase Order Seafrance No.");
                    END;

                BoolLFirstTime := FALSE;
                CodLVendorNum := Rec."Vendor No.";
                CodLEncodePerformance := Rec."Encode Performance";
                CodLCustomerNum := Rec."Customer No.";
                CodLOrderNum := Rec."Purchase Order Seafrance No.";

                IF BoolLCheckRecord THEN BEGIN
                    Rec."Controlled line" := TRUE;

                    Rec."Seafrance Quantity" := Rec.Quantity;

                    Rec.MODIFY();
                END;

            UNTIL Rec.NEXT() = 0;
            Rec.CLEARMARKS();
            Rec.MARKEDONLY(FALSE);
            MESSAGE(CstL008);
        END ELSE
            MESSAGE(CstL007);
        Rec.RESET();

    end;


    procedure Fct_CreateItem(P_ItemCode: Code[20])
    var
        RecLItem: Record Item;
    begin
        RecLItem.INIT();
        RecLItem."No." := P_ItemCode;
        RecLItem.Blocked := TRUE;
        RecLItem.INSERT();
    end;


    procedure Fct_CreateItemJournalLine()
    var
        RecLInventorySetup: Record "Inventory Setup";
        RecLItemJournalBatch: Record "Item Journal Batch";
        RecLItemJournalLine: Record "Item Journal Line";
        RecLItemJournalLineInsert: Record "Item Journal Line";
        RecLItemJournalTemplate: Record "Item Journal Template";
        RecLPurchaseOrderSeafrance: Record "PWD Purchase Order Seafrance";
        IntLLineNumber: Integer;
        CstL010: Label 'No line to be validated.';
        CstL011: Label 'There is not leaf for crossroads Customer Code %1, Vendor Code %2, Performance Code %3.';
    begin
        RecLPurchaseOrderSeafrance.RESET();
        RecLPurchaseOrderSeafrance.SETCURRENTKEY(RecLPurchaseOrderSeafrance."Controlled line");
        RecLPurchaseOrderSeafrance.SETRANGE(RecLPurchaseOrderSeafrance."Controlled line", TRUE);
        IF NOT RecLPurchaseOrderSeafrance.FIND('-') THEN
            ERROR(CstL010)
        ELSE BEGIN
            RecLInventorySetup.GET();
            RecLInventorySetup.TESTFIELD(RecLInventorySetup."PWD Nom modele prestation");
            RecLItemJournalTemplate.GET(RecLInventorySetup."PWD Nom modele prestation");
            REPEAT
                RecLPurchaseOrderSeafrance.CALCFIELDS(RecLPurchaseOrderSeafrance."Vendor No.",
                          RecLPurchaseOrderSeafrance."Base Unit of Measure");

                RecLItemJournalBatch.RESET();
                RecLItemJournalBatch.SETRANGE(RecLItemJournalBatch."Journal Template Name", RecLInventorySetup."PWD Nom modele prestation");
                RecLItemJournalBatch.SETRANGE(RecLItemJournalBatch."PWD Code fournisseur", RecLPurchaseOrderSeafrance."Vendor No.");
                RecLItemJournalBatch.SETRANGE(RecLItemJournalBatch."PWD Code préstation", RecLPurchaseOrderSeafrance."Encode Performance");
                RecLItemJournalBatch.SETRANGE(RecLItemJournalBatch."PWD Code client", RecLPurchaseOrderSeafrance."Customer No.");
                IF NOT RecLItemJournalBatch.FIND('-') THEN
                    ERROR(CstL011, RecLPurchaseOrderSeafrance."Customer No.", RecLPurchaseOrderSeafrance."Vendor No.",
                          RecLPurchaseOrderSeafrance."Encode Performance")
                ELSE BEGIN

                    RecLItemJournalLine.RESET();
                    RecLItemJournalLine.SETRANGE(RecLItemJournalLine."Journal Template Name", RecLInventorySetup."PWD Nom modele prestation");
                    RecLItemJournalLine.SETRANGE(RecLItemJournalLine."Journal Batch Name", RecLItemJournalBatch.Name);
                    IF RecLItemJournalLine.FIND('-') THEN
                        IF RecLItemJournalLine."Item No." = '' THEN
                            RecLItemJournalLine.DELETE();

                    IF NOT RecLItemJournalLine.FIND('+') THEN
                        IntLLineNumber := 10000
                    ELSE
                        IntLLineNumber := RecLItemJournalLine."Line No." + 10000;

                    RecLItemJournalLineInsert.INIT();
                    RecLItemJournalLineInsert."Journal Template Name" := RecLInventorySetup."PWD Nom modele prestation";
                    RecLItemJournalLineInsert."Journal Batch Name" := RecLItemJournalBatch.Name;
                    RecLItemJournalLineInsert."Line No." := IntLLineNumber;
                    RecLItemJournalLineInsert.VALIDATE("Posting Date", RecLPurchaseOrderSeafrance."Posting Date");
                    RecLItemJournalLineInsert.VALIDATE("Document Date", RecLPurchaseOrderSeafrance."Document Date");
                    RecLItemJournalLineInsert."Entry Type" := RecLItemJournalLineInsert."Entry Type"::"Positive Adjmt.";
                    RecLItemJournalLineInsert.VALIDATE("Item No.", RecLPurchaseOrderSeafrance."Item No.");
                    RecLItemJournalLineInsert.VALIDATE(RecLItemJournalLineInsert.Quantity, RecLPurchaseOrderSeafrance.Quantity);
                    RecLItemJournalLineInsert.VALIDATE(RecLItemJournalLineInsert."Location Code", RecLPurchaseOrderSeafrance."Location Code");
                    RecLItemJournalLineInsert.VALIDATE(RecLItemJournalLineInsert."Unit of Measure Code",
                                                       RecLPurchaseOrderSeafrance."Base Unit of Measure");
                    RecLItemJournalLineInsert."PWD Seafrance Order No." := RecLPurchaseOrderSeafrance."Purchase Order Seafrance No.";
                    RecLItemJournalLineInsert."PWD Seafrance Order Line No." := RecLPurchaseOrderSeafrance."Order Line No.";

                    RecLItemJournalLineInsert."PWD Code prestation" := RecLItemJournalBatch."PWD Code préstation";
                    RecLItemJournalLineInsert."PWD Code fournisseur" := RecLItemJournalBatch."PWD Code fournisseur";
                    RecLItemJournalLineInsert."PWD Code client" := RecLItemJournalBatch."PWD Code client";
                    RecLItemJournalLineInsert."Source Code" := RecLItemJournalTemplate."Source Code";

                    //>>FED_ADV_2010_04_28_QTESEAF: SOBI 14/10/2010
                    RecLItemJournalLineInsert."PWD Seafrance Quantity" := RecLPurchaseOrderSeafrance."Seafrance Quantity";
                    //<<FED_ADV_2010_04_28_QTESEAF: SOBI 14/10/2010

                    RecLItemJournalLineInsert.INSERT();

                    RecLPurchaseOrderSeafrance.DELETE();

                END;

            UNTIL RecLPurchaseOrderSeafrance.NEXT() = 0;
            MESSAGE(CstG001);
        END;
    end;


    procedure Fct_ControlLinesUnit()
    var
        RecLItem: Record Item;
        BoolLCheckRecord: Boolean;
        BoolLFirstTime: Boolean;
        CodLEncodePerformance: Code[10];
        CodLCustomerNum: Code[20];
        CodLVendorNum: Code[20];
        CodLOrderNum: Code[30];
        CstL001: Label 'The article %1 of the line %2 of order %3 does not exist in the foundation Navision. Please create it to you?';
        CstL002: Label 'For the same order he can have there only an only one encodes purveyor, an only one encodes performance, an only one encodes customer. See Order %1.';
        CstL003: Label 'Vendor code it does not give information to it for the line %1 of order %2.';
        CstL004: Label 'Prestation code it does not give information to it for the line %1 of order %2.';
        CstL005: Label 'Customer code it does not give information to it for the line %1 of order %2.';
        CstL006: Label 'Location code it does not give information to it for the line %1 of order %2.';
        CstL007: Label 'No line selected. ';
        CstL008: Label 'Check on the  lines selected ended.';
        CstL011: Label 'Cancelled treatment. It is necessary you to change code article of the line %1 of order %2 and to throw the check on lines once again.';
    begin
        BoolLCheckRecord := TRUE;
        CodLVendorNum := '';
        CodLEncodePerformance := '';
        CodLCustomerNum := '';
        CodLOrderNum := '';
        Rec.RESET();
        //>-> GHE-RE.1.00
        Rec.SETRECFILTER();
        //CurrPage.SETSELECTIONFILTER(Rec);
        //MARKEDONLY(TRUE);
        //<-< GHE-RE.1.00

        IF Rec.FIND('-') THEN BEGIN
            REPEAT
                Rec.CALCFIELDS("Vendor No.");

                IF Rec."Purchase Order Seafrance No." <> CodLOrderNum THEN
                    BoolLFirstTime := TRUE;

                IF Rec."Encode Performance" = '' THEN BEGIN
                    Rec.CLEARMARKS();
                    Rec.MARKEDONLY(FALSE);
                    ERROR(CstL004, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");
                END;
                IF Rec."Customer No." = '' THEN BEGIN
                    Rec.CLEARMARKS();
                    Rec.MARKEDONLY(FALSE);
                    ERROR(CstL005, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");
                END;
                IF Rec."Location Code" = '' THEN BEGIN
                    Rec.CLEARMARKS();
                    Rec.MARKEDONLY(FALSE);
                    ERROR(CstL006, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");
                END;

                IF NOT RecLItem.GET(Rec."Item No.") THEN
                    IF CONFIRM(CstL001, FALSE, Rec."Item No.", Rec."Order Line No.", Rec."Purchase Order Seafrance No.") THEN BEGIN
                        Fct_CreateItem(Rec."Item No.");
                        BoolLCheckRecord := FALSE;
                    END ELSE
                        ERROR(CstL011, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");

                IF BoolLCheckRecord THEN
                    IF Rec."Vendor No." = '' THEN BEGIN
                        Rec.CLEARMARKS();
                        Rec.MARKEDONLY(FALSE);
                        ERROR(CstL003, Rec."Order Line No.", Rec."Purchase Order Seafrance No.");
                    END;

                IF NOT BoolLFirstTime THEN
                    IF (CodLVendorNum <> Rec."Vendor No.") OR (CodLEncodePerformance <> Rec."Encode Performance")
                                                           OR (CodLCustomerNum <> Rec."Customer No.") THEN BEGIN
                        Rec.CLEARMARKS();
                        Rec.MARKEDONLY(FALSE);
                        ERROR(CstL002, Rec."Purchase Order Seafrance No.");
                    END;

                BoolLFirstTime := FALSE;
                CodLVendorNum := Rec."Vendor No.";
                CodLEncodePerformance := Rec."Encode Performance";
                CodLCustomerNum := Rec."Customer No.";
                CodLOrderNum := Rec."Purchase Order Seafrance No.";

                IF BoolLCheckRecord THEN BEGIN
                    Rec."Controlled line" := TRUE;

                    Rec."Seafrance Quantity" := Rec.Quantity;

                    Rec.MODIFY();
                END;

            UNTIL Rec.NEXT() = 0;
            Rec.CLEARMARKS();
            Rec.MARKEDONLY(FALSE);
            MESSAGE(CstL008);
        END ELSE
            MESSAGE(CstL007);
        Rec.RESET();

    end;
}

