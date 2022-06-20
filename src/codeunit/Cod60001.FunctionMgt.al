codeunit 60001 "PWD Function Mgt"
{
    var
        PurchPrice: Record "Purchase Price";

    //---TAB36---
    procedure FctT36_OnBeforeSalesLineInsert_SalesHeader(var SalesLine: Record "Sales Line"; var SalesLineTmp: Record "Sales Line" temporary; SalesHeader: Record "Sales Header")
    var
        vconf: Boolean;
        CstG004: Label 'Voulez vous garder les valeurs actuelles des lignes';

    begin
        vconf := CONFIRM(CstG004, TRUE);
        if (SalesLineTmp."No." <> '') and vconf then BEGIN
            SalesLine.VALIDATE(SalesLine."Unit Price", SalesLineTmp."Unit Price");
            SalesLine.VALIDATE(SalesLine."Line Discount %", SalesLineTmp."Line Discount %");
            SalesLine.VALIDATE(SalesLine.Description, SalesLineTmp.Description);
            SalesLine.VALIDATE(SalesLine."Description 2", SalesLineTmp."Description 2");
            SalesLine.VALIDATE(SalesLine."PWD Designation ENU", SalesLineTmp."PWD Designation ENU");
            IF SalesLineTmp.Type <> SalesLineTmp.Type::Resource THEN
                SalesLine.VALIDATE(SalesLine."Purchasing Code", SalesLineTmp."Purchasing Code");
            IF SalesLineTmp.Type <> SalesLineTmp.Type::Resource THEN
                SalesLine.VALIDATE(SalesLine."PWD Order Trading brand", SalesLineTmp."PWD Order Trading brand");
            SalesLine.VALIDATE(SalesLine."Special Order", SalesLineTmp."Special Order");
            SalesLine.VALIDATE(SalesLine."Special Order Purchase No.", SalesLineTmp."Special Order Purchase No.");
            SalesLine.VALIDATE(SalesLine."Unit Cost (LCY)", SalesLineTmp."Unit Cost (LCY)");
            SalesLine.VALIDATE(SalesLine."Location Code", SalesLineTmp."Location Code");
            SalesLine.VALIDATE(SalesLine."PWD Vendor No.", SalesLineTmp."PWD Vendor No.");
            SalesLine.VALIDATE(SalesLine."Unit Price", SalesLineTmp."Unit Price");
            SalesLine.VALIDATE(SalesLine."Line Discount %", SalesLineTmp."Line Discount %");
        END;
    end;

    procedure FctT36_OnUpdateSalesLineByChangedFieldName_SalesHeader(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; ChangedFieldName: Text[100]; ChangedFieldNo: Integer)
    begin
        case ChangedFieldNo of
            SalesLine.FieldNo("PWD DSA No."):
                IF SalesLine."No." <> '' THEN
                    SalesLine.VALIDATE("PWD DSA No.", SalesHeader."PWD DSA No.");
            SalesLine.FieldNo("PWD Document Date"):
                IF SalesLine."No." <> '' THEN
                    SalesLine.VALIDATE("PWD Document Date", SalesHeader."Document Date");
            SalesLine.FieldNo("Posting Date"):
                IF SalesLine."No." <> '' THEN
                    SalesLine.VALIDATE("Posting Date", SalesHeader."Posting Date");
        end;
    end;

    //---TAB37---
    procedure FctT37_OnBeforeModifyEvent_SalesLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean)
    var
        Memberof: Record "Access Control";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        Text1000000007: label 'You can''t modify the line if the order has already been prepared';
    begin
        SalesSetup.GET();
        //Rec.GetSalesHeader();
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        //Memberof.SETRANGE(Memberof."User ID", USERID);
        Memberof.SETRANGE("User Security ID", UserSecurityId());
        Memberof.SetFilter("Role ID", '<>%1', SalesSetup."PWD Sales Order User Group");//Code amélioré
        IF Not Memberof.IsEmpty THEN
            //IF Memberof."Role ID" <> SalesSetup."PWD Sales Order User Group" THEN
                IF SalesHeader."PWD Order Prepared" = TRUE THEN
                IF Rec."Location Code" <> '' THEN
                    IF (Rec."Location Code" <> xRec."Location Code") OR
                       (Rec.Quantity <> xRec.Quantity) OR
                       (Rec."Qty. to Ship" <> xRec."Qty. to Ship")
                       THEN
                        ERROR(Text1000000007);
    end;

    procedure FctT37_OnCopyFromItemOnAfterCheck_SalesLine(var SalesLine: Record "Sales Line"; Item: Record Item)
    var
        Familly: Record "PWD Family & Sub Family";
        SalesHeader: Record "Sales Header";
    begin
        SalesLine."PWD Designation ENU" := Item."PWD Translation";
        SalesLine."PWD Family Code" := Item."PWD Family";
        SalesLine."PWD Item SEAF Code" := Item."PWD SEAF Code";

        SalesLine."PWD Item SEAF Code 2" := Item."PWD SEAF Code 2";
        SalesLine."PWD Item SEAF Code 3" := Item."PWD SEAF Code 3";

        SalesLine."PWD Item SEAF Code 4" := Item."PWD SEAF Code 4";
        SalesLine."PWD Item SEAF Code 5" := Item."PWD SEAF Code 5";

        IF EVALUATE(SalesLine."PWD SEAF Code", Item."PWD SEAF Code") THEN;

        SalesLine."PWD Propriete Seafrance" := Item."PWD Propriete Seafrance";
        SalesLine."PWD Cle (restitution)" := Item."PWD Restitution Key";
        SalesLine."PWD Family" := Item."PWD Family";
        SalesLine."PWD Code Continent" := Item."PWD Continental Code";
        SalesLine."PWD Origin Certified" := Item."PWD Origin Certified";
        SalesLine."PWD Manifest" := Item."PWD Manifest";
        SalesLine."PWD Manifest Category" := Item."PWD Manifest Category";
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        IF SalesHeader."Document Date" <> 0D THEN
            SalesLine."PWD Document Date" := SalesHeader."Document Date";
        SalesLine."PWD Code ventilation article" := Item."PWD Ventilation code";
        SalesLine."PWD Provision/materiel" := 0;

        SalesLine."PWD Coefficient Seafrance" := Item."PWD Coefficient Seafrance";

        IF Item."PWD Family" <> 'SE' THEN BEGIN
            IF Familly.GET(Familly.Type::Item, Familly."Group Type"::Family, '', Item."PWD Family") THEN
                SalesLine."PWD Provision/materiel" := Familly."Provision/materiel";
        END ELSE
            IF Familly.GET(Familly.Type::Item, Familly."Group Type"::Family, '', Item."PWD Family (Sea France)") THEN
                SalesLine."PWD Provision/materiel" := Familly."Provision/materiel";

        IF Item."PWD Trading Brand" THEN SalesLine.VALIDATE("Purchasing Code", 'CONTREMARK');
        SalesLine.VALIDATE("PWD Butchery", Item."PWD Butchery");
        SalesLine.VALIDATE("PWD National Add. Code", Item."PWD National Add. Code");
        SalesLine.VALIDATE("PWD Shelf/Bin No.", Item."Shelf No.");
        SalesLine.VALIDATE("PWD Vendor No.", Item."Vendor No.");
        IF SalesLine."PWD Provision/materiel" = SalesLine."PWD Provision/materiel"::Provision THEN
            SalesLine."PWD DCG Tariff No." := '9930 24 00 00 00C'
        ELSE
            IF SalesLine."PWD Provision/materiel" = SalesLine."PWD Provision/materiel"::Materiel THEN
                SalesLine."PWD DCG Tariff No." := '9930 99 00 00 00Z';
    end;

    procedure FctT37_OnAfterCopyFromItem_SalesLine(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer)
    var
        ItemComment: Record "Comment Line";
        PageComment: Page "Comment Sheet";
    begin
        IF (CurrentFieldNo = SalesLine.FIELDNO("No.")) OR
           (CurrentFieldNo = SalesLine.FIELDNO("PWD Item SEAF Code")) OR
           (CurrentFieldNo = SalesLine.FIELDNO("PWD Item SEAF Code 2")) OR
           (CurrentFieldNo = SalesLine.FIELDNO("PWD Item SEAF Code 3")) OR
           (CurrentFieldNo = SalesLine.FIELDNO("PWD Item SEAF Code 4")) OR
           (CurrentFieldNo = SalesLine.FIELDNO("PWD Item SEAF Code 5")) THEN BEGIN
            SalesLine.GetItem(Item);
            Item.CALCFIELDS(Comment);
            IF Item.Comment = TRUE THEN BEGIN
                ItemComment.SETRANGE("Table Name", ItemComment."Table Name"::Item);
                ItemComment.SETRANGE("No.", Item."No.");
                IF ItemComment.FindFirst() THEN BEGIN
                    PageComment.SETTABLEVIEW(ItemComment);
                    PageComment.EDITABLE(FALSE);
                    PageComment.LOOKUPMODE(TRUE);
                    PageComment.RUN();
                END;
            END;
        END;
    end;

    procedure FctT37_OnValidateNoOnAfterUpdateUnitPrice_SalesLine(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    var
        Cust: record Customer;
        Item: Record Item;
        SalesHeader: record "Sales Header";
    begin
        //SalesLine.GetSalesHeader(SalesHeader, Currency);
        SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
        SalesLine."PWD DSA No." := SalesHeader."PWD DSA No.";
        IF Item.GET(SalesLine."No.") THEN
            IF Cust.GET(SalesHeader."Sell-to Customer No.") THEN BEGIN
                IF (Item."PWD Origin Certified" = TRUE) AND (Cust."PWD Origin Certified" = TRUE) THEN
                    SalesLine."PWD Origin Certified" := TRUE;
                IF (Item."PWD Health Certif Required" = TRUE) AND (Cust."PWD Health Certif Required" = TRUE) THEN
                    SalesLine."PWD Health Certif. Required" := TRUE;
                IF (Item."PWD Conformity Certificate" = TRUE) AND (Cust."PWD Conformity Certificate" = TRUE) THEN
                    SalesLine."PWD Conformity Certificate" := TRUE;
                IF (Item."PWD Technical Card" = TRUE) AND (Cust."PWD Technical Card" = TRUE) THEN
                    SalesLine."PWD Technical Card" := TRUE;
            END;
    end;

    procedure FctT37_OnBeforeValidateEvent_SalesLine_LocationCode(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        Memberof: Record "Access Control";
        Location: Record Location;
        RecLocPriority: Record "PWD Location Priority";
        RecSalesHeader: Record "Sales Header";
        Text1000000005: label 'This call type is not allowed for the location %1';
        Text1000000025: label 'Vous n''êtes pas autorisé à saisir des mouvements sur le magasin %1.;';
    begin
        IF Location.GET(Rec."Location Code") THEN BEGIN
            Rec."PWD Countermark Location" := Location."PWD CounterMark Location";
            IF Location."PWD Groupe autorise" <> '' THEN
                IF NOT Memberof.GET(USERID, Location."PWD Groupe autorise") THEN
                    ERROR(Text1000000025, Location.Code);
        END;

        RecSalesHeader.SETRANGE(RecSalesHeader."Document Type", Rec."Document Type");
        RecSalesHeader.SETRANGE(RecSalesHeader."No.", Rec."Document No.");
        IF RecSalesHeader.FindFirst() THEN BEGIN
            RecLocPriority.SETCURRENTKEY("PWD Call Type Code", "PWD Location priority");
            RecLocPriority.ASCENDING(TRUE);
            RecLocPriority.SETRANGE(RecLocPriority."PWD Call Type Code", RecSalesHeader."PWD Call Type");
            RecLocPriority.SETRANGE(RecLocPriority."PWD Location code", Rec."Location Code"); //GTE test sur sales header

            IF RecLocPriority.IsEmpty() AND (Rec."Location Code" <> '') THEN
                ERROR(Text1000000005, Rec."Location Code");
        END
    end;

    procedure FctT37_OnValidateQuantityOnBeforeSalesLineVerifyChange_SalesLine(var SalesLine: Record "Sales Line"; StatusCheckSuspended: Boolean; var IsHandled: Boolean)
    var
        SalesHeader: record "Sales Header";
        SetGetFunctions: codeunit "PWD Set/Get Functions";
    begin
        IF NOT StatusCheckSuspended THEN
            SalesLine.VerifChange();

        IF SalesLine."Document Type".AsInteger() > 0 THEN
            SalesLine.CheckavailforPriorityLocation(SalesLine.FIELDNO(Quantity), SalesLine, FALSE);
        SalesLine."PWD Adjmt Prepared Qty" := SalesLine.Quantity - SalesLine."PWD Prepared Quantity";
        //SalesLine.GetSalesHeader;
        SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
        IF SalesHeader."PWD Order Prepared" = TRUE THEN BEGIN
            SalesHeader.CALCFIELDS(SalesHeader."PWD Order to adjust");
            IF SalesHeader."PWD Order to adjust" = FALSE THEN BEGIN
                SalesHeader."PWD Ready to ship" := TRUE;
                SalesHeader."PWD Preparation Status" := SalesHeader."PWD Preparation Status"::"Ready to ship";
                SalesHeader.MODIFY();
            END ELSE BEGIN
                SalesHeader."PWD Ready to ship" := FALSE;
                SalesHeader."PWD Preparation Status" := SalesHeader."PWD Preparation Status"::Prepared;
                SalesHeader.MODIFY();
            END;
        END;

        //IF MemLineDiscount <> 0 THEN BEGIN
        IF SetGetFunctions.GetMemLineDiscount() <> 0 THEN BEGIN
            //SalesLine."Line Discount %" := MemLineDiscount;
            SalesLine."Line Discount %" := SetGetFunctions.GetMemLineDiscount();
            SalesLine.MODIFY();
        END;
        //IF (MemUnitPrice <> 0) AND (SalesLine."Unit Price" <> MemUnitPrice) THEN BEGIN
        IF (SetGetFunctions.GetMemUnitPrice() <> 0) AND (SalesLine."Unit Price" <> SetGetFunctions.GetMemUnitPrice()) THEN BEGIN
            //SalesLine.VALIDATE("Unit Price", MemUnitPrice);
            SalesLine.VALIDATE("Unit Price", SetGetFunctions.GetMemUnitPrice());
            SalesLine.MODIFY();
        END;
        IF SalesLine.Type = SalesLine.Type::Item THEN
            IF SalesLine."PWD Coefficient Seafrance" = 0 THEN
                SalesLine."PWD Quantity Seafrance" := SalesLine.Quantity
            ELSE
                SalesLine."PWD Quantity Seafrance" := ROUND(SalesLine.Quantity * SalesLine."PWD Coefficient Seafrance", 0.01, '=');
    end;

    procedure FctT37_OnBeforeGetUnitCost_SalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    var
        Item: Record Item;
        SalesPrice: Record "Sales Price";
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        IsHandled := true;
        SalesLine.TestField(Type, SalesLine.Type::Item);
        SalesLine.TestField("No.");
        SalesLine.GetItem(Item);
        SalesPrice.SETRANGE("Item No.", Item."No.");
        SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::"All Customers");
        SalesPrice.SETFILTER("Sales Code", '%1', '');

        IF SalesPrice.FindFirst() THEN BEGIN
            IF ((SalesPrice."Starting Date" = 0D) OR (SalesPrice."Starting Date" <= WORKDATE())) AND
               ((SalesPrice."Ending Date" = 0D) OR (SalesPrice."Ending Date" >= WORKDATE())) THEN BEGIN
                SalesLine."PWD Specific Cost" := TRUE;
                SalesLine.VALIDATE("Unit Cost (LCY)", SalesPrice."PWD Purch. Cost");
            END;
        END ELSE BEGIN
            SalesLine."Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, SalesLine."Unit of Measure Code");
            SalesLine.ValidateUnitCostLCYOnGetUnitCost(Item);
        END;
    end;

    //---TAB39---
    procedure FctOnBeforeUpdateSpecialSalesOrderLineFromOnDeleteT39(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line")
    var
        AppTenders: Record "PWD Appeal for Tenders";
        SalesTypeDocAppealtenders: enum "PWD Sales TypeDocAppealtenders";
    begin
        IF (PurchaseLine."PWD SalesLineNoAppealTenders" <> 0) THEN BEGIN
            PurchaseLine.LOCKTABLE();
            SalesOrderLine.LOCKTABLE();
            SalesOrderLine.GET(
              PurchaseLine."PWD SalesTypeDocAppealTend.", PurchaseLine."PWD Sales No. Appeal Tenders", PurchaseLine."PWD SalesLineNoAppealTenders");

            SalesOrderLine.CALCFIELDS("PWD Nb Purchase Quote");
            IF SalesOrderLine."PWD Nb Purchase Quote" = 1 THEN BEGIN

                SalesOrderLine."PWD Order Trading brand" := FALSE;
                SalesOrderLine.MODIFY();

                AppTenders.SETRANGE("Document Type", PurchaseLine."PWD SalesTypeDocAppealTend.");
                AppTenders.SETRANGE("Document No.", PurchaseLine."PWD Sales No. Appeal Tenders");
                AppTenders.SETRANGE("Line No. document", PurchaseLine."PWD SalesLineNoAppealTenders");
                IF AppTenders.FindSet() THEN
                    AppTenders.DELETEALL();
            END;

            IF SalesOrderLine."PWD Order Trading brand" = TRUE THEN BEGIN
                PurchaseLine."PWD SalesTypeDocAppealTend." := SalesTypeDocAppealtenders::Quote;
                SalesOrderLine."PWD Trad.BrandOrderPurchNo." := '';
                SalesOrderLine."PWD Trad.BrOrderPurch.LineNo." := 0;
                SalesOrderLine."PWD Trading Brand" := FALSE;
                SalesOrderLine.MODIFY();

                AppTenders.SETRANGE("Document Type", PurchaseLine."PWD SalesTypeDocAppealTend.");
                AppTenders.SETRANGE("Document No.", PurchaseLine."PWD Sales No. Appeal Tenders");
                AppTenders.SETRANGE("Line No. document", PurchaseLine."PWD SalesLineNoAppealTenders");
                IF AppTenders.FindSet() THEN
                    AppTenders.DELETEALL();
            END;
        END;
    end;

    procedure FctOnAfterValidateLocationCodeT39(var Rec: Record "Purchase Line")
    var
        Location: Record Location;
        PurchHeader: Record "Purchase Header";
    begin
        IF Location.GET(Rec."Location Code") THEN BEGIN
            IF Location."PWD Shortcut Dimension 1 Code" <> '' THEN
                Rec.VALIDATE("Shortcut Dimension 1 Code", Location."PWD Shortcut Dimension 1 Code");
            IF Location."PWD Shortcut Dimension 2 Code" <> '' THEN
                Rec.VALIDATE("Shortcut Dimension 2 Code", Location."PWD Shortcut Dimension 2 Code");
        END;

        PurchHeader.GET(Rec."Document Type", Rec."Document No.");
        IF Location.GET(Rec."Location Code") THEN BEGIN
            IF Location."PWD PurchGenBusPostingGroup" <> '' THEN
                Rec.VALIDATE("Gen. Bus. Posting Group", Location."PWD PurchGenBusPostingGroup")
            ELSE BEGIN
                Rec.GetPurchHeader();
                Rec.VALIDATE("Gen. Bus. Posting Group", PurchHeader."Gen. Bus. Posting Group");
            END;
        END ELSE BEGIN
            Rec.GetPurchHeader();
            Rec.VALIDATE("Gen. Bus. Posting Group", PurchHeader."Gen. Bus. Posting Group");
        END;
    end;

    procedure FctOnValidateQuantityOnBeforeDropShptCheckT39(var PurchaseLine: Record "Purchase Line")
    var
        SalesLineSpeciale: Record "Sales Line";
    begin
        IF PurchaseLine."Special Order" = TRUE THEN BEGIN
            SalesLineSpeciale.RESET();
            SalesLineSpeciale.SETRANGE("Document No.", PurchaseLine."Special Order Sales No.");
            SalesLineSpeciale.SETRANGE("Line No.", PurchaseLine."Special Order Sales Line No.");
            IF SalesLineSpeciale.FindFirst() THEN BEGIN
                SalesLineSpeciale.SuspendStatusCheck(TRUE);
                SalesLineSpeciale.VALIDATE(Quantity, PurchaseLine.Quantity);
                SalesLineSpeciale.SuspendStatusCheck(FALSE);
                SalesLineSpeciale.MODIFY();
            END;
        END;
        IF PurchaseLine."PWD Sales No. Appeal Tenders" <> '' THEN BEGIN
            SalesLineSpeciale.RESET();
            SalesLineSpeciale.SETRANGE("Document Type", PurchaseLine."PWD SalesTypeDocAppealTend.");
            SalesLineSpeciale.SETRANGE("Document No.", PurchaseLine."PWD Sales No. Appeal Tenders");
            SalesLineSpeciale.SETRANGE("Line No.", PurchaseLine."PWD SalesLineNoAppealTenders");
            IF SalesLineSpeciale.FindFirst() THEN BEGIN
                SalesLineSpeciale.SuspendStatusCheck(TRUE);
                SalesLineSpeciale.VALIDATE(Quantity, PurchaseLine.Quantity);
                SalesLineSpeciale.SuspendStatusCheck(FALSE);
                SalesLineSpeciale.MODIFY();
            END;
        END;
    end;

    procedure FctOnAfterValidateQtytoInvoiceT39(var PurchaseLine: Record "Purchase Line")
    var
        SalesLineSpeciale: Record "Sales Line";
    begin
        IF PurchaseLine."Special Order" = TRUE THEN BEGIN
            SalesLineSpeciale.RESET();
            SalesLineSpeciale.SETRANGE("Document No.", PurchaseLine."Special Order Sales No.");
            SalesLineSpeciale.SETRANGE("Line No.", PurchaseLine."Special Order Sales Line No.");
            IF SalesLineSpeciale.FINDFirst() THEN BEGIN
                SalesLineSpeciale.SuspendStatusCheck(TRUE);
                SalesLineSpeciale.VALIDATE("Qty. to Ship", PurchaseLine."Qty. to Receive");
                SalesLineSpeciale.SuspendStatusCheck(FALSE);
                SalesLineSpeciale.MODIFY();
            END;
        END;
        IF PurchaseLine."PWD Sales No. Appeal Tenders" <> '' THEN BEGIN
            SalesLineSpeciale.RESET();
            SalesLineSpeciale.SETRANGE("Document Type", PurchaseLine."PWD SalesTypeDocAppealTend.");
            SalesLineSpeciale.SETRANGE("Document No.", PurchaseLine."PWD Sales No. Appeal Tenders");
            SalesLineSpeciale.SETRANGE("Line No.", PurchaseLine."PWD SalesLineNoAppealTenders");
            IF SalesLineSpeciale.FINDFirst() THEN BEGIN
                SalesLineSpeciale.SuspendStatusCheck(TRUE);
                SalesLineSpeciale.VALIDATE("Qty. to Ship", PurchaseLine."Qty. to Receive");
                SalesLineSpeciale.SuspendStatusCheck(FALSE);
                SalesLineSpeciale.MODIFY();
            END;
        END;
    end;

    //---CDU22---
    procedure FctCDU22_OnAfterInitItemLedgEntry_ItemJnlPostLine(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJnlLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."PWD Montant douane" := ItemJnlLine."PWD Montant douane";
        NewItemLedgEntry."PWD Notice Series No." := ItemJnlLine."PWD Notice Series No.";
        NewItemLedgEntry."PWD Origin" := ItemJnlLine."PWD Origin";
        NewItemLedgEntry."PWD Cetificate Transit No." := ItemJnlLine."PWD Cetificate Transit No.";
        NewItemLedgEntry."PWD Origin Lot No." := ItemJnlLine."PWD Origin Lot No.";
        NewItemLedgEntry."PWD Meat Family" := ItemJnlLine."PWD Meat Family";
        NewItemLedgEntry."PWD Meat Type" := ItemJnlLine."PWD Meat Type";
        NewItemLedgEntry."PWD COM 7 No." := ItemJnlLine."PWD COM7 No.";
        NewItemLedgEntry."PWD Code prestation" := ItemJnlLine."PWD Code prestation";
        NewItemLedgEntry."PWD Code fournisseur" := ItemJnlLine."PWD Code fournisseur";
        NewItemLedgEntry."PWD Code client" := ItemJnlLine."PWD Code client";
        NewItemLedgEntry."PWD Family Code" := ItemJnlLine."PWD Family Code";
        NewItemLedgEntry."PWD Nb. unite" := ItemJnlLine."PWD Nb. unite";
        NewItemLedgEntry."PWD Comments" := ItemJnlLine."PWD Comments";
        NewItemLedgEntry."PWD Gross Weight" := ItemJnlLine."PWD Gross Weight";
        NewItemLedgEntry."PWD Net Weight" := ItemJnlLine."PWD Net Weight";
        NewItemLedgEntry."PWD Seafrance Order No." := ItemJnlLine."PWD Seafrance Order No.";
        NewItemLedgEntry."PWD Seafrance Order Line No." := ItemJnlLine."PWD Seafrance Order Line No.";
        NewItemLedgEntry."PWD Seafrance Quantity" := ItemJnlLine."PWD Seafrance Quantity";
        NewItemLedgEntry.Description := ItemJnlLine.Description;
    end;

    PROCEDURE TestExpirationDate(ItemJnlLine: Record "Item Journal Line");
    VAR
        Item: Record Item;
        Text1000000000: Label 'Expiration date is required for item %1';
    BEGIN
        Item.GET(ItemJnlLine."Item No.");
        IF Item."PWD Butchery" THEN
            IF ItemJnlLine."Expiration Date" = 0D THEN ERROR(Text1000000000, Item."No.");
    END;

    PROCEDURE InsertInventoryPerLocation(JournalLine: Record "Item Journal Line");
    VAR
        InventoryPerLocation: Record "Items Available per Location";
        Quantitytoadjust: Decimal;
    BEGIN
        IF JournalLine."Entry Type" <> JournalLine."Entry Type"::Transfer THEN BEGIN
            IF JournalLine."Entry Type" IN
               [JournalLine."Entry Type"::Sale,
                JournalLine."Entry Type"::"Negative Adjmt.",
                JournalLine."Entry Type"::Consumption] THEN
                Quantitytoadjust := -JournalLine."Quantity (Base)" ELSE
                Quantitytoadjust := JournalLine."Quantity (Base)";
            IF JournalLine."Location Code" <> '' THEN
                IF InventoryPerLocation.GET(JournalLine."Item No.", JournalLine."Location Code") THEN BEGIN
                    InventoryPerLocation."Available Inventory" += Quantitytoadjust;
                    InventoryPerLocation.VALIDATE("Available Inventory");
                    InventoryPerLocation.MODIFY();
                END ELSE BEGIN
                    InventoryPerLocation.INIT();
                    InventoryPerLocation.VALIDATE("Item No.", JournalLine."Item No.");
                    InventoryPerLocation.VALIDATE("Location Code", JournalLine."Location Code");
                    InventoryPerLocation.VALIDATE("Available Inventory", Quantitytoadjust);
                    InventoryPerLocation.INSERT();
                END;
        END ELSE BEGIN
            IF JournalLine."New Location Code" <> '' THEN
                IF InventoryPerLocation.GET(JournalLine."Item No.", JournalLine."New Location Code") THEN BEGIN
                    InventoryPerLocation."Available Inventory" += JournalLine."Quantity (Base)";
                    InventoryPerLocation.VALIDATE("Available Inventory");
                    InventoryPerLocation.MODIFY();
                END ELSE BEGIN
                    InventoryPerLocation.INIT();
                    InventoryPerLocation.VALIDATE("Item No.", JournalLine."Item No.");
                    InventoryPerLocation.VALIDATE("Location Code", JournalLine."New Location Code");
                    InventoryPerLocation.VALIDATE("Available Inventory", JournalLine."Quantity (Base)");
                    InventoryPerLocation.INSERT();
                END;
            IF JournalLine."Location Code" <> '' THEN
                IF InventoryPerLocation.GET(JournalLine."Item No.", JournalLine."Location Code") THEN BEGIN
                    InventoryPerLocation."Available Inventory" += -JournalLine."Quantity (Base)";
                    InventoryPerLocation.VALIDATE("Available Inventory");
                    InventoryPerLocation.MODIFY();
                END ELSE BEGIN
                    InventoryPerLocation.INIT();
                    InventoryPerLocation.VALIDATE("Item No.", JournalLine."Item No.");
                    InventoryPerLocation.VALIDATE("Location Code", JournalLine."Location Code");
                    InventoryPerLocation."Available Inventory" := -JournalLine."Quantity (Base)";
                    InventoryPerLocation.VALIDATE("Available Inventory");
                    InventoryPerLocation.INSERT();
                END;
        END;
    END;
    //---CDU23---
    PROCEDURE CtrlButchery(VAR ItemJnlLine: Record "Item Journal Line");
    VAR
        Item: Record Item;
        Item2: Record Item;
        ItemJnlLineCtrl: Record "Item Journal Line";
        ItemJnlLineCtrl2: Record "Item Journal Line";
        MeatFamily: Record "PWD Meat Family";
        ReservEntry: Record "Reservation Entry";
        CtrlFamily: Boolean;
        InverseControlItemInput: Boolean;
        MemoFamily: Code[10];
        LotNoOrigin: Code[20];
        MemoDocNo: Code[20];
        QuantityInput: Decimal;
        QuantityOutput: Decimal;
        NbItemInPut: Integer;
        NbLineDoc: Integer;
        NbLot: Integer;
        Text1000000004: Label 'You can''t have many lot no for a butchery item. Line %1 Item %2.';
        Text1000000016: Label 'Inbound an Outbaound quantity must be equal.';
        Text1000000017: Label 'Butchery Family must all be the same for document %1.';
    BEGIN
        ItemJnlLineCtrl.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
        ItemJnlLineCtrl.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
        ItemJnlLineCtrl.SETRANGE("PWD Butchery", TRUE);
        MemoDocNo := '';
        IF ItemJnlLineCtrl.FindSet() THEN
            REPEAT
                //*** controle du type d'article  - si aticle boucherie : 1 seul lot
                IF Item.GET(ItemJnlLineCtrl."Item No.") THEN
                    IF Item."PWD Butchery" = TRUE THEN BEGIN
                        ReservEntry.RESET();

                        ReservEntry.SETCURRENTKEY("Reservation Status", "Item No.", "Variant Code", "Location Code",
                                       "Source Type", "Source Subtype", "Expected Receipt Date");
                        ReservEntry.SETRANGE("Item No.", ItemJnlLineCtrl."Item No.");
                        ReservEntry.SETFILTER("Source Type", '%1', 83);

                        ReservEntry.SETRANGE("Source ID", ItemJnlLineCtrl."Journal Template Name");      //  ARTICLE
                        ReservEntry.SETRANGE("Source Batch Name", ItemJnlLineCtrl."Journal Batch Name"); //  DEFAUT
                        ReservEntry.SETRANGE("Source Ref. No.", ItemJnlLineCtrl."Line No.");             //  20000
                        NbLot := ReservEntry.COUNT;
                        IF NbLot > 1 THEN
                            ERROR(Text1000000004, ItemJnlLineCtrl."Line No.", ItemJnlLineCtrl."Item No.");
                        IF MemoDocNo <> ItemJnlLineCtrl."Document No." THEN BEGIN
                            MemoDocNo := ItemJnlLineCtrl."Document No.";
                            //--- Controle des lignes avec document
                            //MESSAGE('ctrl document %1',MemoDocNo);
                            ItemJnlLineCtrl2.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
                            ItemJnlLineCtrl2.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                            ItemJnlLineCtrl2.SETRANGE("PWD Butchery", TRUE);
                            ItemJnlLineCtrl2.SETRANGE("Document No.", ItemJnlLineCtrl."Document No.");
                            NbLineDoc := ItemJnlLineCtrl2.COUNT;

                            MemoFamily := '';
                            CtrlFamily := TRUE;
                            NbItemInPut := 0;
                            QuantityInput := 0;
                            QuantityOutput := 0;
                            InverseControlItemInput := FALSE;
                            IF ItemJnlLineCtrl2.FindSet() THEN BEGIN
                                REPEAT
                                    Item2.GET(ItemJnlLineCtrl2."Item No.");

                                    //*** Controle des familles
                                    IF NOT MeatFamily.GET(Item2."PWD Meat Family") THEN
                                        MeatFamily.Control := FALSE;

                                    IF MeatFamily.Control = TRUE THEN BEGIN
                                        IF MemoFamily = '' THEN
                                            MemoFamily := Item2."PWD Meat Family";
                                        IF (MemoFamily <> Item2."PWD Meat Family") AND (MemoFamily <> '') THEN
                                            CtrlFamily := FALSE;
                                    END;

                                    //*** Controle des kg entr‚e et des kg sorties
                                    IF ItemJnlLineCtrl2."Entry Type" = ItemJnlLineCtrl2."Entry Type"::"Negative Adjmt." THEN
                                        ItemJnlLineCtrl2.Quantity := -ItemJnlLineCtrl2.Quantity;
                                    IF Item2."PWD Meat Type" = Item2."PWD Meat Type"::"Entrée" THEN BEGIN
                                        NbItemInPut := NbItemInPut + 1;
                                        IF ItemJnlLineCtrl2."Entry Type" <> ItemJnlLineCtrl2."Entry Type"::"Negative Adjmt." THEN
                                            InverseControlItemInput := TRUE;
                                        QuantityInput := QuantityInput + ItemJnlLineCtrl2.Quantity;
                                    END ELSE
                                        QuantityOutput := QuantityOutput + ItemJnlLineCtrl2.Quantity;
                                UNTIL ItemJnlLineCtrl2.NEXT() = 0;

                                IF CtrlFamily = FALSE THEN
                                    ERROR(Text1000000017, MemoDocNo);
                                IF NbLineDoc > 1 THEN BEGIN   // si 1 seule ligne on ne controle pas !
                                    IF InverseControlItemInput = TRUE THEN BEGIN
                                        QuantityInput := -QuantityInput;
                                        QuantityOutput := -QuantityOutput;
                                    END;
                                    IF (QuantityOutput + QuantityInput) > 0 THEN
                                        ERROR(Text1000000016)
                                END;
                            END;
                        END;
                    END;
            UNTIL ItemJnlLineCtrl.NEXT() = 0;

        //*** MAJ du champ nø lot origine
        IF ItemJnlLine.FindSet() THEN BEGIN
            MemoDocNo := '';
            REPEAT
                IF MemoDocNo <> ItemJnlLineCtrl."Document No." THEN BEGIN
                    MemoDocNo := ItemJnlLineCtrl."Document No.";
                    LotNoOrigin := '';
                    //--- Controle des lignes avec document
                    ItemJnlLineCtrl2.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
                    ItemJnlLineCtrl2.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                    ItemJnlLineCtrl2.SETRANGE("PWD Butchery", TRUE);
                    ItemJnlLineCtrl2.SETRANGE("Document No.", ItemJnlLineCtrl."Document No.");
                    NbLineDoc := ItemJnlLineCtrl2.COUNT;
                    //--- Recherche de l'article de type Entr‚e
                    IF ItemJnlLineCtrl2.FindSet() THEN
                        REPEAT
                            Item2.GET(ItemJnlLineCtrl2."Item No.");
                            IF Item2."PWD Meat Type" = Item2."PWD Meat Type"::"Entrée" THEN BEGIN
                                //*** Recherche du nø de lot
                                ReservEntry.RESET();
                                ReservEntry.SETCURRENTKEY("Reservation Status", "Item No.", "Variant Code", "Location Code",
                                    "Source Type", "Source Subtype", "Expected Receipt Date");
                                ReservEntry.SETRANGE("Item No.", ItemJnlLineCtrl2."Item No.");
                                ReservEntry.SETFILTER("Source Type", '%1', 83);
                                ReservEntry.SETRANGE("Source ID", ItemJnlLineCtrl2."Journal Template Name");      //  ARTICLE
                                ReservEntry.SETRANGE("Source Batch Name", ItemJnlLineCtrl."Journal Batch Name"); //  DEFAUT
                                ReservEntry.SETRANGE("Source Ref. No.", ItemJnlLineCtrl."Line No.");             //  20000
                                IF ReservEntry.FINDFirst() THEN
                                    LotNoOrigin := ItemJnlLineCtrl2."Lot No.";
                            END;
                        UNTIL ItemJnlLineCtrl2.NEXT() = 0;
                    IF ItemJnlLineCtrl2.FindSet() THEN
                        REPEAT
                            Item2.GET(ItemJnlLineCtrl2."Item No.");
                            IF Item2."PWD Meat Type" <> Item2."PWD Meat Type"::"Entrée" THEN BEGIN
                                //*** Recherche du nø de lot
                                ReservEntry.SETRANGE("Item No.", ItemJnlLineCtrl2."Item No.");
                                ReservEntry.SETFILTER("Source Type", '%1', 83);
                                ReservEntry.SETRANGE("Source ID", ItemJnlLineCtrl2."Journal Template Name");
                                ReservEntry.SETRANGE("Source Batch Name", ItemJnlLineCtrl."Journal Batch Name");
                                ReservEntry.SETRANGE("Source Ref. No.", ItemJnlLineCtrl."Line No.");
                            END;
                        UNTIL ItemJnlLineCtrl2.NEXT() = 0;
                END;
            UNTIL ItemJnlLineCtrl.NEXT() = 0;
        END;
    END;

    //---CDU80---
    procedure FctCDU80_OnBeforeCalcInvoice_SalesPost(SalesHeader: Record "Sales Header"; TempSalesLineGlobal: Record "Sales Line" temporary; var NewInvoice: Boolean; var IsHandled: Boolean)
    var
        SalesLineCtrl: Record "Sales Line";
        Text1000000003: Label 'Trading Brand. \Line %1 : Shipped quantity (%2) can''t be superior than receipted quantity (%3)';
        Text1000000004: Label 'Trading Brand. \Line %1 : Invoiced quantity (%2) can''t be superior than receipted quantity (%3)';
    begin
        SalesLineCtrl.RESET();
        SalesLineCtrl.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLineCtrl.SETRANGE("Document No.", SalesHeader."No.");
        SalesLineCtrl.SETRANGE("PWD Trading Brand", TRUE);
        IF SalesLineCtrl.FindSet() THEN
            REPEAT
                SalesLineCtrl.CALCFIELDS("PWD Quantity Receipted Purch.");
                IF (SalesLineCtrl."Qty. to Ship" + SalesLineCtrl."Quantity Shipped") > SalesLineCtrl."PWD Quantity Receipted Purch." THEN
                    ERROR(Text1000000003, SalesLineCtrl."Line No.", SalesLineCtrl."Qty. to Ship" + SalesLineCtrl."Quantity Shipped",
                       SalesLineCtrl."PWD Quantity Receipted Purch.");
                IF (SalesLineCtrl."Qty. to Invoice" + SalesLineCtrl."Quantity Invoiced") > SalesLineCtrl."PWD Quantity Receipted Purch."
      THEN
                    ERROR(Text1000000004, SalesLineCtrl."Line No.", SalesLineCtrl."Qty. to Invoice" + SalesLineCtrl."Quantity Invoiced",
                       SalesLineCtrl."PWD Quantity Receipted Purch.");
            UNTIL SalesLineCtrl.NEXT() = 0;
    end;

    PROCEDURE CalcAvailability(SalesHeader: Record "Sales Header");
    VAR
        Item: Record Item;
        RecLSalesLine: Record "Sales Line";
        ToSalesLine2: Record "Sales Line";
        DecLOtherLineQty: Decimal;
        Text1000000002: Label 'Le stock de l''article %1 dans le magasin %2 est insuffisant pour couvrir la demande de la ligne %3 du document %4.';
    BEGIN
        ToSalesLine2.RESET();
        ToSalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
        ToSalesLine2.SETRANGE("Document No.", SalesHeader."No.");
        ToSalesLine2.SETRANGE(Type, ToSalesLine2.Type::Item);
        ToSalesLine2.SETFILTER("Qty. to Ship", '<>0');
        ToSalesLine2.SETFILTER("Location Code", '<>%1', '');
        IF ToSalesLine2.FindSet() THEN
            REPEAT
                Item.RESET();
                Item.GET(ToSalesLine2."No.");
                Item.SETFILTER("Location Filter", ToSalesLine2."Location Code");
                Item.CALCFIELDS(Inventory);
                DecLOtherLineQty := 0;
                RecLSalesLine.RESET();
                RecLSalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                RecLSalesLine.SETRANGE("Document No.", SalesHeader."No.");
                RecLSalesLine.SETRANGE(Type, RecLSalesLine.Type::Item);
                RecLSalesLine.SETRANGE("No.", ToSalesLine2."No.");
                RecLSalesLine.SETFILTER("Qty. to Ship", '<>0');
                RecLSalesLine.SETRANGE("Location Code", ToSalesLine2."Location Code");
                RecLSalesLine.SETFILTER("Line No.", '<%1', ToSalesLine2."Line No.");
                IF RecLSalesLine.FindSet() THEN
                    REPEAT
                        DecLOtherLineQty += RecLSalesLine."Qty. to Ship (Base)";
                    UNTIL RecLSalesLine.NEXT() = 0;
                IF Item.Inventory - (ToSalesLine2."Qty. to Ship (Base)" + DecLOtherLineQty) < 0 THEN
                    ERROR(STRSUBSTNO(Text1000000002, ToSalesLine2."No.", ToSalesLine2."Location Code", ToSalesLine2."Line No.",
                                     ToSalesLine2."Document No."));
            UNTIL ToSalesLine2.NEXT() = 0;
    END;

    //--CDU81--
    //TODO 2 Fcts existent aussi dans CDU82
    /*PROCEDURE ControlProfit(var SalesHeader: Record "Sales Header")
    VAR
        MemberOf: Record "Access Control";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        GenLedSetUp: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" TEMPORARY;
        TotalSalesLine: Record "Sales Line";
        TotalSalesLineLCY: Record "Sales Line";
        TempVATAmountLine: Record "VAT Amount Line" TEMPORARY;
        SalesPost: Codeunit "Sales-Post";
        UseDate: Date;
        CreditLimitLCYExpendedPct: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        TotalAdjCostLCY: Decimal;
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        Text1000000000: Label 'Profit (%1 %3) is inferior than Discount profit (%2 %3) \Would you like to post the document ?';
        Text1000000001: Label 'Profit (%1 %3) is inferior than Discount profit (%2 %3).';
        VATAmountText: Text[30];
    BEGIN
        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        CLEAR(SalesPost);

        SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 0);
        CLEAR(SalesPost);
        SalesPost.SumSalesLinesTemp(
          SalesHeader, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
          VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);

        IF SalesHeader."Prices Including VAT" THEN BEGIN
            TotalAmount2 := TotalSalesLine.Amount;
            TotalAmount1 := TotalAmount2 + VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount1 := TotalSalesLine.Amount;
            TotalAmount2 := TotalSalesLine."Amount Including VAT";
        END;

        IF Cust.GET(SalesHeader."Bill-to Customer No.") THEN
            Cust.CALCFIELDS("Balance (LCY)")
        ELSE
            CLEAR(Cust);
        IF Cust."Credit Limit (LCY)" = 0 THEN
            CreditLimitLCYExpendedPct := 0
        ELSE
            IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 THEN
                CreditLimitLCYExpendedPct := 0
            ELSE
                IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 THEN
                    CreditLimitLCYExpendedPct := 10000
                ELSE
                    CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        SalesLine.CalcVATAmountLines(1, SalesHeader, TempSalesLine, TempVATAmountLine);
        TempVATAmountLine.MODIFYALL(Modified, FALSE);

        TotalSalesLine."Inv. Discount Amount" := TempVATAmountLine.GetTotalInvDiscAmount();
        TotalAmount1 :=
          TotalSalesLine."Line Amount" - TotalSalesLine."Inv. Discount Amount";
        VATAmount := TempVATAmountLine.GetTotalVATAmount();

        IF SalesHeader."Prices Including VAT" THEN BEGIN
            TotalAmount1 := TempVATAmountLine.GetTotalAmountInclVAT();
            TotalAmount2 := TotalAmount1 - VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE
            TotalAmount2 := TotalAmount1 + VATAmount;

        IF SalesHeader."Prices Including VAT" THEN
            TotalSalesLineLCY.Amount := TotalAmount2
        ELSE
            TotalSalesLineLCY.Amount := TotalAmount1;
        IF SalesHeader."Currency Code" <> '' THEN BEGIN
            IF (SalesHeader."Document Type" IN [SalesHeader."Document Type"::"Blanket Order", SalesHeader."Document Type"::Quote]) AND
               (SalesHeader."Posting Date" = 0D)
            THEN
                UseDate := WORKDATE()
            ELSE
                UseDate := SalesHeader."Posting Date";

            TotalSalesLineLCY.Amount :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                UseDate, SalesHeader."Currency Code", TotalSalesLineLCY.Amount, SalesHeader."Currency Factor");
        END;
        ProfitLCY := TotalSalesLineLCY.Amount - TotalSalesLineLCY."Unit Cost (LCY)";
        IF TotalSalesLineLCY.Amount = 0 THEN
            ProfitPct := 0
        ELSE
            ProfitPct := ROUND(100 * ProfitLCY / TotalSalesLineLCY.Amount, 0.01);

        //*** Controle de la marge / marge escompt‚e client
        GenLedSetUp.GET();
        IF Cust."Discount Profit %" > ProfitPct THEN
            ;
        //*** Recherche si userid appartient au role direction
        MemberOf.SETRANGE("User Security ID", UserSecurityId());
        MemberOf.SETRANGE("Role ID", GenLedSetUp."PWD Direction Role ID");
        IF MemberOf.FINDFirst() THEN BEGIN
            IF CONFIRM(Text1000000000, TRUE, ProfitPct, Cust."Discount Profit %", '%') = FALSE THEN
                ERROR(Text1000000001, ProfitPct, Cust."Discount Profit %", '%');
        END ELSE
            ERROR(Text1000000001, ProfitPct, Cust."Discount Profit %", '%');
    END;

    PROCEDURE CtrlUnitPrice()
    VAR
        MemberOf: Record "Access Control";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Item: Record Item;
        Location: Record Location;
        SalesHeader: Record "Sales Header";  
        SalesLineCtrl: Record "Sales Line";
        Avertissement: Boolean;
        BottomPrice: Decimal;
        CstG001: Label 'Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5) \Continuer';
        CstG002: Label 'Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5)';
        CstG003: Label 'Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5)';

    BEGIN
        MemberOf.SETRANGE("User Security ID", UserSecurityId());
        MemberOf.SETRANGE("Role ID", 'DIRECTION');
        IF MemberOf.FINDFirst() THEN
            Avertissement := TRUE
        ELSE
            Avertissement := FALSE;

        SalesLineCtrl.RESET();
        SalesLineCtrl.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLineCtrl.SETRANGE("Document No.", SalesHeader."No.");
        SalesLineCtrl.SETRANGE(Type, SalesLineCtrl.Type::Item);
        IF SalesLineCtrl.FindSet() THEN
            REPEAT

                //*** Controle prix unitaire > prix plancher de l'article
                IF Item.GET(SalesLineCtrl."No.") THEN
                    IF Location.GET(SalesLineCtrl."Location Code") AND (Location."PWD Controle du prix plancher") THEN BEGIN
                        BottomPrice := Item."PWD Bottom Price";
                        IF SalesHeader."Currency Code" <> '' THEN BEGIN
                            Currency.GET(SalesHeader."Currency Code");
                            BottomPrice :=
                               ROUND(
                                     CurrExchRate.ExchangeAmtLCYToFCY(
                                     SalesLineCtrl.GetDate(), SalesHeader."Currency Code",
                                     BottomPrice, SalesHeader."Currency Factor"),
                                     Currency."Unit-Amount Rounding Precision")
                        END;
                        IF (SalesLineCtrl."Unit Price" < BottomPrice) OR (SalesLineCtrl."Unit Price" = 0) THEN
                            IF Avertissement = FALSE THEN
                                ERROR(CstG002,
                                       SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                       SalesLineCtrl."Unit Price", BottomPrice)
                            ELSE
                                IF CONFIRM(
                                      CstG001,
                                      TRUE,
                                      SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                      SalesLineCtrl."Unit Price", BottomPrice) = FALSE THEN
                                    ERROR(CstG003,
                                           SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                           SalesLineCtrl."Unit Price", BottomPrice);
                    END;
            UNTIL SalesLineCtrl.NEXT() = 0;
    END;*/

    //---CDU82---
    PROCEDURE ControlProfit(var SalesHeader: Record "Sales Header");
    VAR
        MemberOf: Record "Access Control";
        CurrExchRate: Record "Currency Exchange Rate";
        Cust: Record Customer;
        GenLedSetUp: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" TEMPORARY;
        TotalSalesLine: Record "Sales Line";
        TotalSalesLineLCY: Record "Sales Line";
        TempVATAmountLine: Record "VAT Amount Line" TEMPORARY;
        SalesPost: Codeunit "Sales-Post";
        UseDate: Date;
        CreditLimitLCYExpendedPct: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        TotalAdjCostLCY: Decimal;
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        VATAmount: Decimal;
        Text1000000000: Label 'Profit (%1 %3) is inferior than Discount profit (%2 %3) \Would you like to post the document ?';
        Text1000000001: Label 'Profit (%1 %3) is inferior than Discount profit (%2 %3).';
        VATAmountText: Text[30];
    BEGIN
        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);
        CLEAR(SalesPost);

        SalesPost.GetSalesLines(SalesHeader, TempSalesLine, 0);
        SalesPost.SumSalesLinesTemp(
          SalesHeader, TempSalesLine, 0, TotalSalesLine, TotalSalesLineLCY,
          VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);
        CLEAR(SalesPost);

        IF SalesHeader."Prices Including VAT" THEN BEGIN
            TotalAmount2 := TotalSalesLine.Amount;
            TotalAmount1 := TotalAmount2 + VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE BEGIN
            TotalAmount1 := TotalSalesLine.Amount;
            TotalAmount2 := TotalSalesLine."Amount Including VAT";
        END;

        IF Cust.GET(SalesHeader."Bill-to Customer No.") THEN
            Cust.CALCFIELDS("Balance (LCY)")
        ELSE
            CLEAR(Cust);
        IF Cust."Credit Limit (LCY)" = 0 THEN
            CreditLimitLCYExpendedPct := 0
        ELSE
            IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 THEN
                CreditLimitLCYExpendedPct := 0
            ELSE
                IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 THEN
                    CreditLimitLCYExpendedPct := 10000
                ELSE
                    CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        SalesLine.CalcVATAmountLines(1, SalesHeader, TempSalesLine, TempVATAmountLine);
        TempVATAmountLine.MODIFYALL(Modified, FALSE);

        TotalSalesLine."Inv. Discount Amount" := TempVATAmountLine.GetTotalInvDiscAmount();
        TotalAmount1 :=
          TotalSalesLine."Line Amount" - TotalSalesLine."Inv. Discount Amount";
        VATAmount := TempVATAmountLine.GetTotalVATAmount();

        IF SalesHeader."Prices Including VAT" THEN BEGIN
            TotalAmount1 := TempVATAmountLine.GetTotalAmountInclVAT();
            TotalAmount2 := TotalAmount1 - VATAmount;
            TotalSalesLine."Line Amount" := TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
        END ELSE
            TotalAmount2 := TotalAmount1 + VATAmount;

        IF SalesHeader."Prices Including VAT" THEN
            TotalSalesLineLCY.Amount := TotalAmount2
        ELSE
            TotalSalesLineLCY.Amount := TotalAmount1;
        IF SalesHeader."Currency Code" <> '' THEN BEGIN
            IF (SalesHeader."Document Type" IN [SalesHeader."Document Type"::"Blanket Order", SalesHeader."Document Type"::Quote]) AND
               (SalesHeader."Posting Date" = 0D)
            THEN
                UseDate := WORKDATE()
            ELSE
                UseDate := SalesHeader."Posting Date";

            TotalSalesLineLCY.Amount :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                UseDate, SalesHeader."Currency Code", TotalSalesLineLCY.Amount, SalesHeader."Currency Factor");
        END;
        ProfitLCY := TotalSalesLineLCY.Amount - TotalSalesLineLCY."Unit Cost (LCY)";
        IF TotalSalesLineLCY.Amount = 0 THEN
            ProfitPct := 0
        ELSE
            ProfitPct := ROUND(100 * ProfitLCY / TotalSalesLineLCY.Amount, 0.01);

        //*** Controle de la marge / marge escomptée client
        GenLedSetUp.GET();
        IF Cust."PWD Discount Profit %" > ProfitPct THEN BEGIN
            //*** Recherche si userid appartient au role direction
            MemberOf.SETRANGE("User Security ID", UserSecurityId());
            MemberOf.SETRANGE("Role ID", GenLedSetUp."PWD Direction Role ID");
            IF Not MemberOf.IsEmpty THEN BEGIN
                IF CONFIRM(Text1000000000, TRUE, ProfitPct, Cust."PWD Discount Profit %", '%') = FALSE THEN
                    ERROR(Text1000000001, ProfitPct, Cust."PWD Discount Profit %", '%');
            END ELSE
                ERROR(Text1000000001, ProfitPct, Cust."PWD Discount Profit %", '%');
        END;
    END;

    PROCEDURE CtrlUnitPrice(var SalesHeader: Record "Sales Header");
    VAR
        MemberOf: Record "Access Control";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        Item: Record Item;
        Location: Record Location;
        SalesLineCtrl: Record "Sales Line";
        Avertissement: Boolean;
        BottomPrice: Decimal;
        CstG001: label 'Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5)';
        CstG002: label 'Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5)';
        CstG003: label 'Document %1 Ligne %2 Article %3 \Le prix unitaire de vente (%4) est inferieur au prix plancher (%5) \Continuer ';
    BEGIN
        MemberOf.SETRANGE("User Security ID", UserSecurityId());
        MemberOf.SETRANGE("Role ID", 'DIRECTION');
        IF Not MemberOf.IsEmpty THEN
            Avertissement := TRUE
        ELSE
            Avertissement := FALSE;

        SalesLineCtrl.RESET();
        SalesLineCtrl.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLineCtrl.SETRANGE("Document No.", SalesHeader."No.");
        SalesLineCtrl.SETRANGE(Type, SalesLineCtrl.Type::Item);
        IF SalesLineCtrl.FINDSet() THEN
            REPEAT
                //*** Controle prix unitaire > prix plancher de l'article
                IF Item.GET(SalesLineCtrl."No.") THEN
                    IF Location.GET(SalesLineCtrl."Location Code") AND (Location."PWD Controle du prix plancher") THEN BEGIN
                        BottomPrice := Item."PWD Bottom Price";
                        IF SalesHeader."Currency Code" <> '' THEN BEGIN
                            Currency.GET(SalesHeader."Currency Code");
                            BottomPrice :=
                               ROUND(
                                     CurrExchRate.ExchangeAmtLCYToFCY(
                                     SalesLineCtrl.GetDate(), SalesHeader."Currency Code",
                                     BottomPrice, SalesHeader."Currency Factor"),
                                     Currency."Unit-Amount Rounding Precision")
                        END;
                        IF (SalesLineCtrl."Unit Price" < BottomPrice) OR (SalesLineCtrl."Unit Price" = 0) THEN
                            IF Avertissement = FALSE THEN
                                ERROR(CstG001,
                                       SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                       SalesLineCtrl."Unit Price", BottomPrice)
                            ELSE
                                IF CONFIRM(
                                      CstG003,
                                      TRUE,
                                      SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                      SalesLineCtrl."Unit Price", BottomPrice) = FALSE THEN
                                    ERROR(CstG002,
                                           SalesLineCtrl."Document No.", SalesLineCtrl."Line No.", SalesLineCtrl."No.",
                                           SalesLineCtrl."Unit Price", BottomPrice);
                    END;
            UNTIL SalesLineCtrl.NEXT() = 0;
    END;

    //---CDU86---
    procedure Fct_OnBeforeInsertSalesOrderLine_SalesQuotetoOrder(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    var
        PurchQuoteLine: Record "Purchase Line";
        AppTenders: Record "PWD Appeal for Tenders";
        AppTendersOrder: Record "PWD Appeal for Tenders";
        i: Integer;
    begin
        SalesQuoteLine.CALCFIELDS(SalesQuoteLine."PWD Nb Appeal for tenders", SalesQuoteLine."PWD Nb Purchase Quote");
        IF SalesQuoteLine."PWD Nb Appeal for tenders" > 0 THEN BEGIN
            AppTenders.SETRANGE("Document Type", SalesQuoteLine."Document Type");
            AppTenders.SETRANGE("Document No.", SalesQuoteLine."Document No.");
            AppTenders.SETRANGE("Line No. document", SalesQuoteLine."Line No.");
            AppTenders.FindSet();
            REPEAT
                AppTendersOrder := AppTenders;
                AppTendersOrder."Document Type" := SalesOrderHeader."Document Type";
                AppTendersOrder."Document No." := SalesOrderHeader."No.";
                AppTendersOrder."Line No. document" := SalesOrderLine."Line No.";
                AppTendersOrder.INSERT();
            UNTIL AppTenders.NEXT() = 0;
        END;
        IF SalesQuoteLine."PWD Nb Purchase Quote" > 0 THEN BEGIN
            PurchQuoteLine.SETCURRENTKEY("PWD SalesTypeDocAppealTend.", "PWD Sales No. Appeal Tenders", "PWD SalesLineNoAppealTenders");
            FOR i := 1 TO SalesQuoteLine."PWD Nb Purchase Quote" DO BEGIN
                PurchQuoteLine.SETRANGE("PWD SalesTypeDocAppealTend.", SalesQuoteLine."Document Type".AsInteger());
                PurchQuoteLine.SETRANGE("PWD Sales No. Appeal Tenders", SalesQuoteLine."Document No.");
                PurchQuoteLine.SETRANGE("PWD SalesLineNoAppealTenders", SalesQuoteLine."Line No.");
                PurchQuoteLine.FindFirst();
                PurchQuoteLine."PWD SalesTypeDocAppealTend." := SalesOrderHeader."Document Type".AsInteger();
                PurchQuoteLine."PWD Sales No. Appeal Tenders" := SalesOrderHeader."No.";
                PurchQuoteLine."PWD SalesLineNoAppealTenders" := SalesOrderLine."Line No.";

                PurchQuoteLine.MODIFY();
            END;
        END;
    end;

    //---CDU90---
    PROCEDURE AllReceive(ReceivePurchHeader: Record "Purchase Header"): Boolean;
    VAR
        FromPurchLine: Record "Purchase Line";
    BEGIN
        CLEAR(FromPurchLine);
        FromPurchLine.SETRANGE("Document Type", ReceivePurchHeader."Document Type");
        FromPurchLine.SETRANGE("Document No.", ReceivePurchHeader."No.");
        FromPurchLine.SETFILTER(Type, '<>%1', 0);
        IF FromPurchLine.FindSet() THEN BEGIN
            REPEAT
                IF FromPurchLine.Quantity <> FromPurchLine."Quantity Received" THEN EXIT(FALSE);
            UNTIL FromPurchLine.NEXT() = 0;
            EXIT(TRUE);
        END
        ELSE
            EXIT(FALSE);
    END;
    //---CDU92---
    procedure PrintDocumentsWithCheckDialogCommon(ReportUsage: Enum "Report Selection Usage"; RecordVariant: Variant; IsGUI: Boolean; AccountNoFieldNo: Integer; WithCheck: Boolean; TableNo: Integer)
    var
        ReportSelection: Record "Report Selections";
        ReportLayoutSelection: Record "Report Layout Selection";
        TempReportSelections: Record "Report Selections" temporary;
        TempNameValueBuffer: Record "Name/Value Buffer" temporary;
        RecRef: RecordRef;
        RecRefToPrint: RecordRef;
        RecVarToPrint: Variant;
        AccountNoFilter: Text;
        IsHandled: Boolean;
    begin

        RecRef.GetTable(RecordVariant);
        ReportSelection.GetUniqueAccountNos(TempNameValueBuffer, RecRef, AccountNoFieldNo);

        ReportSelection.SelectTempReportSelectionsToPrint(TempReportSelections, TempNameValueBuffer, WithCheck, ReportUsage, TableNo);
        if TempReportSelections.FindSet() then
            repeat
                if TempReportSelections."Custom Report Layout Code" <> '' then
                    ReportLayoutSelection.SetTempLayoutSelected(TempReportSelections."Custom Report Layout Code")
                else
                    ReportLayoutSelection.SetTempLayoutSelected('');

                TempNameValueBuffer.FindSet();
                AccountNoFilter := ReportSelection.GetAccountNoFilterForCustomReportLayout(TempReportSelections, TempNameValueBuffer, TableNo);
                GetFilteredRecordRef(RecRefToPrint, RecRef, AccountNoFieldNo, AccountNoFilter);
                RecVarToPrint := RecRefToPrint;

                IsHandled := false;
                if not IsHandled then
                    REPORT.RunModal(TempReportSelections."Report ID", IsGUI, false, RecVarToPrint);


                ReportLayoutSelection.SetTempLayoutSelected('');
            until TempReportSelections.Next() = 0;

    end;

    local procedure GetFilteredRecordRef(var RecRefToPrint: RecordRef; RecRefSource: RecordRef; AccountNoFieldNo: Integer; AccountNoFilter: Text)
    var
        AccountNoFieldRef: FieldRef;
    begin
        RecRefToPrint := RecRefSource.Duplicate();

        if (AccountNoFieldNo <> 0) and (AccountNoFilter <> '') then begin
            AccountNoFieldRef := RecRefToPrint.Field(AccountNoFieldNo);
            AccountNoFieldRef.SetFilter(AccountNoFilter);
        end;

        if RecRefToPrint.FindSet() then;
    end;


    //---CDU 229---
    PROCEDURE PrintT5(SalesShipmentHeader: Record "Sales Shipment Header");
    VAR
        ReportSelection: Record "Report Selections";
        CalcT5: Codeunit "PWD Edit T5";
    BEGIN
        SalesShipmentHeader.SETRECFILTER();
        CLEAR(CalcT5);
        CalcT5.RUN(SalesShipmentHeader);
        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::T5);
        ReportSelection.SETFILTER("Report ID", '<>0');
        ReportSelection.ASCENDING := FALSE;
        ReportSelection.FindSet();
        REPEAT
            REPORT.RUN(ReportSelection."Report ID", TRUE, FALSE, SalesShipmentHeader);
        UNTIL ReportSelection.NEXT() = 0;
    END;

    PROCEDURE PrintT1(SalesShipmentHeader: Record "Sales Shipment Header");
    VAR
        ReportSelection: Record "Report Selections";
        ShipmentLine: Record "Sales Shipment Line";
        Text1000000057: Label 'Pas de document à imprimer.';
    BEGIN
        TestLoadingList(SalesShipmentHeader);
        CLEAR(ShipmentLine);
        ShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        ShipmentLine.SETFILTER("Location Code", '6|9|9HCEE');
        IF ShipmentLine.IsEmpty THEN ERROR(Text1000000057);

        SalesShipmentHeader.SETRECFILTER();
        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::T1);
        ReportSelection.SETFILTER("Report ID", '<>0');
        ReportSelection.ASCENDING := FALSE;
        ReportSelection.FindSet();
        REPEAT
            REPORT.RUN(ReportSelection."Report ID", TRUE, FALSE, SalesShipmentHeader);
        UNTIL ReportSelection.NEXT() = 0;
    END;

    PROCEDURE PrintTM(SalesShipmentHeader: Record "Sales Shipment Header");
    VAR
        ReportSelection: Record "Report Selections";
        ShipmentLine: Record "Sales Shipment Line";
        Text1000000057: Label 'Pas de document à imprimer.';
    BEGIN
        TestLoadingList(SalesShipmentHeader);
        CLEAR(ShipmentLine);
        ShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        ShipmentLine.SETFILTER("Location Code", '8|9');
        IF ShipmentLine.IsEmpty THEN ERROR(Text1000000057);

        SalesShipmentHeader.SETRECFILTER();
        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::TM);
        ReportSelection.SETFILTER("Report ID", '<>0');
        ReportSelection.ASCENDING := FALSE;
        ReportSelection.FindSet();
        REPEAT
            REPORT.RUN(ReportSelection."Report ID", TRUE, FALSE, SalesShipmentHeader);
        UNTIL ReportSelection.NEXT() = 0;
    END;

    PROCEDURE PrintEX1(SalesShipmentHeader: Record "Sales Shipment Header");
    VAR
        SalesShptLine: Record "Sales Shipment Line";
        //ReportEX1: Report 50087;   //TODO
        i: Integer;
        Text1000000057: Label 'Pas de document à imprimer.';
        LocationList: ARRAY[10, 2] OF Text[30];
    BEGIN
        TestLoadingList(SalesShipmentHeader);
        CLEAR(SalesShptLine);
        SalesShptLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        SalesShptLine.SETFILTER("Location Code", '3|5|CML|1');
        IF NOT SalesShptLine.FindFirst() THEN ERROR(Text1000000057);

        SalesShipmentHeader.SETRECFILTER();

        LocationList[1] [1] := '5';
        LocationList[2] [1] := '3';
        LocationList[3] [1] := 'CML|1';

        LocationList[1] [2] := 'AFD';
        LocationList[2] [2] := 'AFD';
        LocationList[3] [2] := '';

        FOR i := 1 TO 3 DO BEGIN
            CLEAR(SalesShptLine);
            SalesShptLine.SETCURRENTKEY("Document No.", "Location Code");
            SalesShptLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
            SalesShptLine.SETFILTER("Location Code", LocationList[i] [1]);
            IF Not SalesShptLine.IsEmpty THEN
                NumberEx3(SalesShipmentHeader, LocationList[i] [1], 5);
            /*     //TODO
            CLEAR(ReportEX1);
            ReportEX1.SetLocationFilter(LocationList[i] [1], LocationList[i] [2]);
            SalesShipmentHeader.SETFILTER("PWD Location Filter", LocationList[i] [1]);
            ReportEX1.SETTABLEVIEW(SalesShipmentHeader);
            ReportEX1.RUN;*/
        END;
    END;

    PROCEDURE PrintEX9(SalesShipmentHeader: Record "Sales Shipment Header");
    VAR
        SalesShptLine: Record "Sales Shipment Line";
        //ReportEX9: Report 50088;  //TODO
        i: Integer;
        Text1000000057: Label 'Pas de document à imprimer.';
        LocationList: ARRAY[10, 2] OF Text[30];
    BEGIN
        TestLoadingList(SalesShipmentHeader);
        CLEAR(SalesShptLine);
        SalesShptLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        SalesShptLine.SETFILTER("Location Code", '3|5|CML|1');
        IF NOT SalesShptLine.FindFirst() THEN ERROR(Text1000000057);

        SalesShipmentHeader.SETRECFILTER();
        LocationList[1] [1] := '5';
        LocationList[2] [1] := '3';
        LocationList[3] [1] := 'CML|1';

        LocationList[1] [2] := 'AFD';
        LocationList[2] [2] := 'AFD';
        LocationList[3] [2] := '';

        FOR i := 1 TO 3 DO BEGIN
            CLEAR(SalesShptLine);
            SalesShptLine.SETCURRENTKEY("Document No.", "Location Code");
            SalesShptLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
            SalesShptLine.SETFILTER("Location Code", LocationList[i] [1]);
            IF Not SalesShptLine.IsEmpty THEN
                NumberEx3(SalesShipmentHeader, LocationList[i] [1], 7);
            /*   //TODO
            CLEAR(ReportEX9);
            ReportEX9.SetLocationFilter(LocationList[i] [1], LocationList[i] [2]);
            SalesShipmentHeader.SETFILTER("PWD Location Filter", LocationList[i] [1]);
            ReportEX9.SETTABLEVIEW(SalesShipmentHeader);
            ReportEX9.RUN;*/
        END;
    END;

    PROCEDURE PrintCOM9(SalesShipmentHeader: Record "Sales Shipment Header");
    VAR
        SalesShptLine: Record "Sales Shipment Line";
        //ReportCOM9: Report 50089;  //TODO
        i: Integer;
        Text1000000057: Label 'Pas de document à imprimer.';
        LocationList: ARRAY[10, 2] OF Text[30];
    BEGIN
        TestLoadingList(SalesShipmentHeader);
        CLEAR(SalesShptLine);
        SalesShptLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        SalesShptLine.SETFILTER("Location Code", '3|5|CML|1');
        IF NOT SalesShptLine.FindFirst() THEN ERROR(Text1000000057);

        SalesShipmentHeader.SETRECFILTER();
        LocationList[1] [1] := '5';
        LocationList[2] [1] := '3';
        LocationList[3] [1] := 'CML|1';

        LocationList[1] [2] := 'AFD';
        LocationList[2] [2] := 'AFD';
        LocationList[3] [2] := '';

        FOR i := 1 TO 3 DO BEGIN
            CLEAR(SalesShptLine);
            SalesShptLine.SETCURRENTKEY("Document No.", "Location Code");
            SalesShptLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
            SalesShptLine.SETFILTER("Location Code", LocationList[i] [1]);
            IF not SalesShptLine.IsEmpty THEN
                NumberEx3(SalesShipmentHeader, LocationList[i] [1], 6);
            /*           //TODO
            CLEAR(ReportCOM9);
            ReportCOM9.SetLocationFilter(LocationList[i] [1], LocationList[i] [2]);
            SalesShipmentHeader.SETFILTER("PWD Location Filter", LocationList[i] [1]);
            ReportCOM9.SETTABLEVIEW(SalesShipmentHeader);
            ReportCOM9.RUN;*/
        END;
    END;

    PROCEDURE PrintCOM7(PurchReceiptHeader: Record "Purch. Rcpt. Header");
    VAR
        ReportSelection: Record "Report Selections";
        CalcCom7: Codeunit "PWD Edit COM7";
    BEGIN
        PurchReceiptHeader.SETRECFILTER();
        CLEAR(CalcCom7);
        CalcCom7.RUN(PurchReceiptHeader);
        ReportSelection.SETRANGE(Usage, ReportSelection.Usage::COM7);
        ReportSelection.SETFILTER("Report ID", '<>0');
        ReportSelection.ASCENDING := FALSE;
        ReportSelection.FindSet();
        REPEAT
            REPORT.RUN(ReportSelection."Report ID", TRUE, FALSE, PurchReceiptHeader);
        UNTIL ReportSelection.NEXT() = 0;
    END;

    PROCEDURE TestLoadingList(SalesShipmentHeader: Record "Sales Shipment Header");
    VAR
        LoadingList: Record "PWD Listes de chargement";
        Text1000000002: Label 'Vous devez d''abord éditer les listes de chargement pour l''expédition %1.';
    BEGIN
        CLEAR(LoadingList);
        LoadingList.SETRANGE("Sales Ship. No.", SalesShipmentHeader."No.");
        IF LoadingList.IsEmpty THEN ERROR(Text1000000002, SalesShipmentHeader."No.");
    END;

    PROCEDURE NumberEx3(SalesShipHeader: Record "Sales Shipment Header"; FromLocationCode: Code[20]; Ex3DocType: Option " ","T5","T1","TM","COM7","EX1","COM9","EX9");
    VAR
        CustomsLine: Record "PWD Ligne document Douane";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMngt: Codeunit NoSeriesManagement;
    BEGIN
        // ** Test éxistence ligne doc douane
        TestEX3(SalesShipHeader);

        CLEAR(CustomsLine);
        CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"S.Shipment");
        CustomsLine.SETRANGE("Document No.", SalesShipHeader."No.");
        CustomsLine.SETRANGE("Customs Document Type", Ex3DocType);
        CustomsLine.SETRANGE("Location Filter", FromLocationCode);
        IF CustomsLine.FindFirst() THEN EXIT;

        //** Insérer ligne doc douane
        SalesSetup.GET();
        CLEAR(CustomsLine);
        IF CustomsLine.FindLast() THEN
            CustomsLine."Entry No." += 1 ELSE
            CustomsLine."Entry No." := 1;
        CustomsLine.INIT();
        CustomsLine."Document Type" := CustomsLine."Document Type"::"S.Shipment";
        CustomsLine."Document No." := SalesShipHeader."No.";
        CustomsLine."Location Filter" := FromLocationCode;
        CASE Ex3DocType OF
            Ex3DocType::EX1:
                BEGIN
                    CustomsLine."Customs Document Type" := CustomsLine."Customs Document Type"::EX1;
                    SalesSetup.TESTFIELD("PWD Souche EX1");
                    CLEAR(NoSeriesMngt);
                    CustomsLine."Customs Doc. No." :=
                      NoSeriesMngt.GetNextNo(SalesSetup."PWD Souche EX1", TODAY, TRUE);
                END;
            Ex3DocType::EX9:
                BEGIN
                    CustomsLine."Customs Document Type" := CustomsLine."Customs Document Type"::EX9;
                    SalesSetup.TESTFIELD("PWD Souche EX9");
                    CustomsLine."Customs Doc. No." :=
                      NoSeriesMngt.GetNextNo(SalesSetup."PWD Souche EX9", TODAY, TRUE);
                END;
            Ex3DocType::COM9:
                BEGIN
                    CustomsLine."Customs Document Type" := CustomsLine."Customs Document Type"::COM9;
                    SalesSetup.TESTFIELD("PWD Souche COM9");
                    CLEAR(NoSeriesMngt);
                    CustomsLine."Customs Doc. No." :=
                      NoSeriesMngt.GetNextNo(SalesSetup."PWD Souche COM9", TODAY, TRUE);
                END;
        END;

        CustomsLine.INSERT();
    END;

    PROCEDURE TestEX3(VAR SalesShipHeader: Record "Sales Shipment Header");
    VAR
        CustomsLine: Record "PWD Ligne document Douane";
        CstG001: Label 'Un exemplaire 3 a déjà été édité pour cette livraison';
    BEGIN
        CLEAR(CustomsLine);
        CustomsLine.SETRANGE("Document Type", CustomsLine."Document Type"::"S.Shipment");
        CustomsLine.SETRANGE("Document No.", SalesShipHeader."No.");
        CustomsLine.SETFILTER("Customs Document Type", 'EX1|COM9|EX9');
        IF Not CustomsLine.IsEmpty THEN MESSAGE(CstG001);
    END;

    //---CDU240---
    PROCEDURE RunPrestation();
    VAR
        InvSetup: Record "Inventory Setup";
        ItemJnlLine: Record "Item Journal Line";
        ItemJnlTemplate: Record "Item Journal Template";
    BEGIN
        InvSetup.GET();
        InvSetup.TESTFIELD("PWD Nom modele prestation");
        ItemJnlTemplate.GET(InvSetup."PWD Nom modele prestation");
        ItemJnlLine.FILTERGROUP := 2;
        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.FILTERGROUP := 0;
        Page.RUN(ItemJnlTemplate."Page ID", ItemJnlLine);
    END;

    PROCEDURE MAJPrest(VAR CurrentJnlBatchName: Code[20]; VAR VendorNo: Code[20]; VAR CustNo: Code[20]; VAR TypePresta: Code[20]);
    VAR
        InvSetup: Record "Inventory Setup";
        ItemJnlBatch: Record "Item Journal Batch";
    BEGIN
        InvSetup.GET();
        IF ItemJnlBatch.GET(InvSetup."PWD Nom modele prestation", CurrentJnlBatchName) THEN BEGIN
            ItemJnlBatch.TESTFIELD("PWD Code préstation");
            ItemJnlBatch.TESTFIELD("PWD Code client");
            VendorNo := ItemJnlBatch."PWD Code fournisseur";
            TypePresta := ItemJnlBatch."PWD Code préstation";
            CustNo := ItemJnlBatch."PWD Code client";
        END;
    END;

    //--CDU311---
    PROCEDURE CalculateNeed(SalesLine: Record "Sales Line"; LocationCode: Code[10]): Decimal;
    VAR
        Item: Record Item;
        ItemSalesLine: Record Item;
        GrossRequirement: Decimal;
        PlannedOrderReceipt: Decimal;
        PlannedOrderReleases: Decimal;
        ScheduledReceipt: Decimal;
    BEGIN
        ItemSalesLine.RESET();
        ItemSalesLine.SETRANGE("No.", SalesLine."No.");
        ItemSalesLine.SETRANGE("Date Filter", 0D, SalesLine."Shipment Date");
        ItemSalesLine.SETRANGE("Location Filter", LocationCode);
        ItemSalesLine.SETRANGE("PWD Preparation Filter", SalesLine."PWD Preparation in Process");
        IF ItemSalesLine.FindFirst() THEN
            ItemSalesLine.CALCFIELDS("Qty. on Sales Order");

        Item.SETRANGE("No.", SalesLine."No.");
        Item.SETRANGE("Date Filter", 0D, SalesLine."Shipment Date");
        Item.SETRANGE(Item."Location Filter", LocationCode);
        IF Item.FindFirst() THEN BEGIN
            Item.CALCFIELDS(
              "Qty. on Purch. Order",
              "Qty. on Service Order",
              Inventory,
              "Scheduled Receipt (Qty.)",
              "Qty. on Component Lines",
              "Planning Issues (Qty.)",
              "Planned Order Receipt (Qty.)",
              "FP Order Receipt (Qty.)",
              "Rel. Order Receipt (Qty.)",
              "Planned Order Release (Qty.)",
              "Purch. Req. Receipt (Qty.)",
              "Purch. Req. Release (Qty.)",
              "Qty. in Transit",
              "Trans. Ord. Shipment (Qty.)",
              "Trans. Ord. Receipt (Qty.)");
            GrossRequirement :=
              //Item."Qty. on Sales Order" +
              ItemSalesLine."Qty. on Sales Order" +
              Item."Qty. on Service Order" +
              Item."Qty. on Component Lines" +
              Item."Trans. Ord. Shipment (Qty.)" +
              Item."Planning Issues (Qty.)";
            PlannedOrderReceipt :=
              Item."Planned Order Receipt (Qty.)" +
              Item."Purch. Req. Receipt (Qty.)";
            ScheduledReceipt :=
              Item."FP Order Receipt (Qty.)" +
              Item."Rel. Order Receipt (Qty.)" +
              Item."Qty. on Purch. Order" +
              Item."Qty. in Transit" +
              Item."Trans. Ord. Receipt (Qty.)";
            PlannedOrderReleases :=
              Item."Planned Order Release (Qty.)" +
              Item."Purch. Req. Release (Qty.)";

            EXIT(Item.Inventory + PlannedOrderReceipt + ScheduledReceipt - GrossRequirement);
        END;
    END;

    PROCEDURE CheckItemAvailability(SalesLine: Record "Sales Line") OldItemNetChange: Boolean;
    VAR
        OldsalesLine: Record "Sales Line";
    BEGIN
        OldItemNetChange := FALSE;
        OldsalesLine := SalesLine;
        IF OldsalesLine.FindFirst() THEN // Find previous quantity
            IF (OldsalesLine."Document Type" = OldsalesLine."Document Type"::Order) AND
               (OldsalesLine."No." = SalesLine."No.") AND
               (OldsalesLine."Variant Code" = SalesLine."Variant Code") AND
               (OldsalesLine."Location Code" = SalesLine."Location Code") AND
               (OldsalesLine."Bin Code" = SalesLine."Bin Code") AND
               NOT OldsalesLine."Drop Shipment"
            THEN
                IF SalesLine.Quantity <> 0 THEN
                    OldItemNetChange := TRUE;

        EXIT(OldItemNetChange);
    END;
    //---CDU333---
    procedure FCT_CDU333OnAfterInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; var RequisitionLine: Record "Requisition Line")
    var
        SalesOrderLine: Record "Sales Line";
    begin
        PurchOrderLine."Special Order Sales No." := '';
        PurchOrderLine."Special Order Sales Line No." := 0;
        PurchOrderLine."Special Order" := FALSE;
        PurchOrderLine.MODIFY();
        SalesOrderLine.Get(SalesOrderLine."Document Type"::Order, RequisitionLine."Sales Order No.", RequisitionLine."Sales Order Line No.");
        SalesOrderLine."Special Order" := FALSE;
        SalesOrderLine."Special Order Purchase No." := '';
        SalesOrderLine."Special Order Purch. Line No." := 0;
        SalesOrderLine.MODIFY();
    end;
    //---CDU365---
    PROCEDURE SeafranceSalesHeaderBillTo(VAR AddrArray: ARRAY[8] OF Text[50]; VAR SalesHeader: Record "PWD Seafrance Sales Header");
    var
        FormatAddress: Codeunit "Format Address";
    BEGIN
        //>>MIGRATION2009R2
        FormatAddress.FormatAddr(
  AddrArray, SalesHeader."Sell-to Customer Name", SalesHeader."Sell-to Customer Name 2", SalesHeader."Sell-to Contact", SalesHeader."Sell-to Address", SalesHeader."Sell-to Address 2",
  SalesHeader."Sell-to City", SalesHeader."Sell-to Post Code", SalesHeader."Sell-to County", SalesHeader."Sell-to Country Code");
        //<<MIGRATION2009R2
    END;

    PROCEDURE SeafranceSalesHeaderShipTo(VAR AddrArray: ARRAY[8] OF Text[50]; VAR SalesHeader: Record "PWD Seafrance Sales Header");
    var
        FormatAddress: Codeunit "Format Address";
    BEGIN
        //>>MIGRATION2009R2
        FormatAddress.FormatAddr(
  AddrArray, SalesHeader."Ship-to Name", SalesHeader."Ship-to Name 2", SalesHeader."Ship-to Contact", SalesHeader."Ship-to Address", SalesHeader."Ship-to Address 2",
  SalesHeader."Ship-to City", SalesHeader."Ship-to Post Code", SalesHeader."Ship-to County", SalesHeader."Ship-to Country Code");
        //<<MIGRATION2009R2
    END;

    PROCEDURE FormatAddrInvoiceGHES(VAR AddrArray: ARRAY[8] OF Text[90]; Name: Text[90]; Name2: Text[90]; Contact: Text[90]; Addr: Text[50]; Addr2: Text[50]; City: Text[50]; PostCode: Code[20]; County: Text[50]; CountryCode: Code[10]);
    VAR
        Country: Record "Country/Region";
        GLSetup: Record "General Ledger Setup";
        Addr2LineNo: Integer;
        AddrLineNo: Integer;
        ContLineNo: Integer;
        CountryLineNo: Integer;
        CountyLineNo: Integer;
        Index: Integer;
        InsertText: Integer;
        Name2LineNo: Integer;
        NameLineNo: Integer;
        PostCodeCityLineNo: Integer;
        Dummy: Text[50];
    BEGIN
        //>>SOBI
        // Le code r‚gion est plac‚ avant le code postal + ville
        // Par rapport … la fonction standard on a invers‚ les affectations de PostCodeCityLineNo et CountyLineNo

        CLEAR(AddrArray);

        IF CountryCode = '' THEN BEGIN
            GLSetup.GET();
            CLEAR(Country);
            Country."Address Format" := GLSetup."Local Address Format";
            Country."Contact Address Format" := GLSetup."Local Cont. Addr. Format";
        END ELSE
            Country.GET(CountryCode);

        CASE Country."Contact Address Format" OF
            Country."Contact Address Format"::First:
                BEGIN
                    NameLineNo := 2;
                    Name2LineNo := 3;
                    ContLineNo := 1;
                    AddrLineNo := 4;
                    Addr2LineNo := 5;
                    PostCodeCityLineNo := 7;
                    CountyLineNo := 6;
                    CountryLineNo := 8;
                END;
            Country."Contact Address Format"::"After Company Name":
                BEGIN
                    NameLineNo := 1;
                    Name2LineNo := 2;
                    ContLineNo := 3;
                    AddrLineNo := 4;
                    Addr2LineNo := 5;
                    PostCodeCityLineNo := 7;
                    CountyLineNo := 6;
                    CountryLineNo := 8;
                END;
            Country."Contact Address Format"::Last:
                BEGIN
                    NameLineNo := 1;
                    Name2LineNo := 2;
                    ContLineNo := 8;
                    AddrLineNo := 3;
                    Addr2LineNo := 4;
                    PostCodeCityLineNo := 6;
                    CountyLineNo := 5;
                    CountryLineNo := 7;
                END;
        END;

        IF Country."Address Format" = Country."Address Format"::"County/Post Code+City" THEN BEGIN
            CountyLineNo := PostCodeCityLineNo;
            PostCodeCityLineNo := CountyLineNo + 1;
        END;

        AddrArray[NameLineNo] := Name;
        AddrArray[Name2LineNo] := Name2;
        AddrArray[AddrLineNo] := Addr;
        AddrArray[Addr2LineNo] := Addr2;

        CASE Country."Address Format" OF
            Country."Address Format"::"Post Code+City",
              Country."Address Format"::"City+County+Post Code",
              Country."Address Format"::"City+Post Code",
              Country."Address Format"::"Post Code+City/County",
              Country."Address Format"::"County/Post Code+City":
                BEGIN
                    AddrArray[ContLineNo] := Contact;
                    //TODO: GeneratePostCodeCity Fonction local dans le codeunit "Format Address"
                    GeneratePostCodeCity(AddrArray[PostCodeCityLineNo], AddrArray[CountyLineNo], City, PostCode, County, Country);
                    AddrArray[CountryLineNo] := Country.Name;
                    COMPRESSARRAY(AddrArray);
                END;
            Country."Address Format"::"Blank Line+Post Code+City":
                BEGIN
                    IF ContLineNo < PostCodeCityLineNo THEN
                        AddrArray[ContLineNo] := Contact;
                    COMPRESSARRAY(AddrArray);

                    Index := 1;
                    InsertText := 1;
                    REPEAT
                        IF AddrArray[Index] = '' THEN BEGIN
                            CASE InsertText OF
                                2:
                                    GeneratePostCodeCity(AddrArray[Index], Dummy, City, PostCode, County, Country);
                                3:
                                    AddrArray[Index] := Country.Name;
                                4:
                                    IF ContLineNo > PostCodeCityLineNo THEN
                                        AddrArray[Index] := Contact;
                            END;
                            InsertText := InsertText + 1;
                        END;
                        Index := Index + 1;
                    UNTIL Index = 9;
                END;
        END;
        //<<SOBI
    END;

    PROCEDURE SalesInvBillToGHES(VAR AddrArray: ARRAY[8] OF Text[50]; VAR SalesInvHeader: Record "Sales Invoice Header");
    BEGIN
        //>>SOBI
        FormatAddrInvoiceGHES(
  AddrArray, SalesInvHeader."Bill-to Name", SalesInvHeader."Bill-to Name 2", SalesInvHeader."Bill-to Contact", SalesInvHeader."Bill-to Address", SalesInvHeader."Bill-to Address 2",
  SalesInvHeader."Bill-to City", SalesInvHeader."Bill-to Post Code", SalesInvHeader."Bill-to County", SalesInvHeader."Bill-to Country/Region Code");
        //<<SOBI
    END;

    local procedure GeneratePostCodeCity(var PostCodeCityText: Text[100]; var CountyText: Text[50]; City: Text[50]; PostCode: Code[20]; County: Text[50]; Country: Record "Country/Region")
    var
        OverMaxStrLen: Integer;
        DummyString: Text;
    begin
        DummyString := '';
        OverMaxStrLen := MaxStrLen(PostCodeCityText);
        if OverMaxStrLen < MaxStrLen(DummyString) then
            OverMaxStrLen += 1;

        case Country."Address Format" of
            Country."Address Format"::"Post Code+City":
                begin
                    if PostCode <> '' then
                        PostCodeCityText := DelStr(PostCode + ' ' + City, OverMaxStrLen)
                    else
                        PostCodeCityText := City;
                    CountyText := County;
                end;
            Country."Address Format"::"City+County+Post Code":

                if (County <> '') and (PostCode <> '') then
                    PostCodeCityText :=
                      DelStr(City, MaxStrLen(PostCodeCityText) - StrLen(PostCode) - StrLen(County) - 3) +
                      ', ' + County + ' ' + PostCode
                else
                    if PostCode = '' then begin
                        PostCodeCityText := City;
                        CountyText := County;
                    end else
                        if (County = '') and (PostCode <> '') then
                            PostCodeCityText := DelStr(City, MaxStrLen(PostCodeCityText) - StrLen(PostCode) - 1) + ', ' + PostCode;
            Country."Address Format"::"City+Post Code":
                begin
                    if PostCode <> '' then
                        PostCodeCityText := DelStr(City, MaxStrLen(PostCodeCityText) - StrLen(PostCode) - 1) + ', ' + PostCode
                    else
                        PostCodeCityText := City;
                    CountyText := County;
                end;
            Country."Address Format"::"Blank Line+Post Code+City":
                begin
                    if PostCode <> '' then
                        PostCodeCityText := DelStr(PostCode + ' ' + City, OverMaxStrLen)
                    else
                        PostCodeCityText := City;
                    CountyText := County;
                end;
            Country."Address Format"::"Post Code+City/County", Country."Address Format"::"County/Post Code+City":
                begin
                    if PostCode <> '' then
                        PostCodeCityText := DelStr(PostCode + ' ' + City, OverMaxStrLen)
                    else
                        PostCodeCityText := City;
                    CountyText := County;
                end;
        end;
    end;

    //---CDU391---
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", 'OnBeforeSalesShptHeaderModify', '', false, false)]
    local procedure FctOnBeforeSalesShptHeaderModify_ShipmentHeaderEdit(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader."PWD DSA No." := FromSalesShptHeader."PWD DSA No.";
        SalesShptHeader."PWD Liste de chargement" := FromSalesShptHeader."PWD Liste de chargement";
        SalesShptHeader."Shipping Time" := FromSalesShptHeader."Shipping Time";
    end;
    //---CDU414---
    procedure FCT_CDU414OnBeforeReleaseSalesDocEvent(var SalesHeader: Record "Sales Header")
    var
        AccessControl: Record "Access Control";
        SetGetFunction: Codeunit "PWD Set/Get Functions";
        CstG002: label 'DIRECTION';
    begin
        IF SalesHeader."PWD Preparation Status" = SalesHeader."PWD Preparation Status"::" " THEN
            SalesHeader."PWD Preparation Status" := SalesHeader."PWD Preparation Status"::"Ready to prepare";
        IF NOT SetGetFunction.GetProcessing() THEN begin
            AccessControl.SETRANGE(AccessControl."User Security ID", UserSecurityId());
            AccessControl.SETRANGE(AccessControl."Role ID", CstG002);
            IF AccessControl.IsEmpty() THEN
                SalesHeaderCheckError(SalesHeader)
            ELSE
                SalesHeaderCheckMessage(SalesHeader);
        end;
    end;

    procedure FCT_CDU414OnAfterReleaseSalesDocEvent(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        Txt50000: Label 'une ou plusieur(s) ligne(s) ne possède(nt) pas de quantitéé à expédier.Souhaitez-vous effectuer leur(s) mise à jours?';

    begin
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            SalesLine.SETFILTER(Quantity, '<>0');
            SalesLine.SETFILTER("Qty. to Ship", '%1', 0);
            IF SalesLine.FINDFIRST() THEN
                IF CONFIRM(Txt50000, TRUE) THEN
                    REPEAT
                        SalesLine.VALIDATE("Qty. to Ship", SalesLine.Quantity);
                        SalesLine.MODIFY();
                    UNTIL SalesLine.NEXT() = 0;
        END;
    end;

    procedure TestDocumentAvita(VAR SalesHeader: Record "Sales Header")
    VAR
        Item: Record Item;
        SalesLine: Record "Sales Line";
        Txt1000000004: Label 'Les poids doivent être renseignés sur la ligne %1 .';
    begin
        TestDocProfit(SalesHeader);
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, 2);
        IF SalesLine.FindSet() THEN
            REPEAT
                Item.GET(SalesLine."No.");
                IF (SalesLine."Net Weight" = 0) OR (SalesLine."Gross Weight" = 0) THEN
                    ERROR(Txt1000000004, SalesLine."Line No.");

            UNTIL SalesLine.NEXT() = 0;
    end;

    procedure TestDocProfit(VAR Rec: Record "Sales Header");
    VAR
        Cust: Record Customer;
        SalesLine: Record "Sales Line";
        TempSalesLine: Record "Sales Line" TEMPORARY;
        TotalSalesLine: ARRAY[3] OF Record "Sales Line";
        TotalSalesLineLCY: ARRAY[3] OF Record "Sales Line";
        TempVATAmountLine1: Record "VAT Amount Line" TEMPORARY;
        TempVATAmountLine2: Record "VAT Amount Line" TEMPORARY;
        TempVATAmountLine3: Record "VAT Amount Line" TEMPORARY;
        SalesPost: Codeunit "Sales-Post";
        CreditLimitLCYExpendedPct: Decimal;
        DecLTotalAdjCostLCY: Decimal;
        ProfitLCY: ARRAY[3] OF Decimal;
        ProfitPct: ARRAY[3] OF Decimal;
        TotalAmount1: ARRAY[3] OF Decimal;
        TotalAmount2: ARRAY[3] OF Decimal;
        VATAmount: ARRAY[3] OF Decimal;
        i: Integer;
        Text1000000004: Label 'La marge sur la commande %1 doit être au minimum de  %2 %3.';
        VATAmountText: ARRAY[3] OF Text[30];
    BEGIN
        CLEAR(SalesLine);
        CLEAR(TotalSalesLine);
        CLEAR(TotalSalesLineLCY);

        FOR i := 1 TO 3 DO BEGIN
            TempSalesLine.DELETEALL();
            CLEAR(TempSalesLine);
            CLEAR(SalesPost);
            SalesPost.GetSalesLines(Rec, TempSalesLine, i - 1);
            CLEAR(SalesPost);
            CASE i OF
                1:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine1);
                2:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine2);
                3:
                    SalesLine.CalcVATAmountLines(0, Rec, TempSalesLine, TempVATAmountLine3);
            END;
            //add a specific parameter : DecLTotalAdjCostLCY
            SalesPost.SumSalesLinesTemp(
              Rec, TempSalesLine, i - 1, TotalSalesLine[i], TotalSalesLineLCY[i],
              VATAmount[i], VATAmountText[i], ProfitLCY[i], ProfitPct[i], DecLTotalAdjCostLCY);
            IF Rec."Prices Including VAT" THEN BEGIN
                TotalAmount2[i] := TotalSalesLine[i].Amount;
                TotalAmount1[i] := TotalAmount2[i] + VATAmount[i];
                TotalSalesLine[i]."Line Amount" := TotalAmount1[i] + TotalSalesLine[i]."Inv. Discount Amount";
            END ELSE BEGIN
                TotalAmount1[i] := TotalSalesLine[i].Amount;
                TotalAmount2[i] := TotalSalesLine[i]."Amount Including VAT";
            END;
        END;

        IF Cust.GET(Rec."Bill-to Customer No.") THEN
            Cust.CALCFIELDS("Balance (LCY)")
        ELSE
            CLEAR(Cust);
        IF Cust."Credit Limit (LCY)" = 0 THEN
            CreditLimitLCYExpendedPct := 0
        ELSE
            IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" < 0 THEN
                CreditLimitLCYExpendedPct := 0
            ELSE
                IF Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" > 1 THEN
                    CreditLimitLCYExpendedPct := 10000
                ELSE
                    CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000, 1);

        TempVATAmountLine1.MODIFYALL(Modified, FALSE);
        TempVATAmountLine2.MODIFYALL(Modified, FALSE);
        TempVATAmountLine3.MODIFYALL(Modified, FALSE);
        Cust.GET(Rec."Bill-to Customer No.");
        IF ProfitPct[1] < Cust."PWD Discount Profit %" THEN MESSAGE(Text1000000004, Rec."No.", Cust."PWD Discount Profit %", '%');
    END;

    procedure SalesHeaderCheckError(SalesHeader: Record "Sales Header");
    VAR
        CustCheckCreditLimit: Page "PWD Check Credit Limit Release";
        Text000: Label 'The update has been interrupted to respect the warning.', Comment = 'FRA="La mise à jour a été interrompue pour respecter l''alerte."';
    BEGIN
        IF CustCheckCreditLimit.SalesHeaderShowWarning(SalesHeader) THEN BEGIN
            CustCheckCreditLimit.LOOKUPMODE := TRUE;
            CustCheckCreditLimit.RUNMODAL();
            CLEAR(CustCheckCreditLimit);
            ERROR(Text000);
        END;
    END;

    procedure SalesHeaderCheckMessage(SalesHeader: Record "Sales Header");
    VAR
        CustCheckCreditLimit: Page "PWD Check Credit Limit Release";
        OK: Boolean;
        Text000: label 'The update has been interrupted to respect the warning.', Comment = 'FRA="La mise à jour a été interrompue pour respecter l''alerte."';
    BEGIN
        IF CustCheckCreditLimit.SalesHeaderShowWarning(SalesHeader) THEN BEGIN
            OK := CustCheckCreditLimit.RUNMODAL() = ACTION::Yes;
            CLEAR(CustCheckCreditLimit);
            IF NOT OK THEN
                ERROR(Text000);
        END;
    END;
    //---CDU419---
    procedure Path(Filename: Text[1024]) Path: Text[1024]
    begin
        Filename := DELCHR(Filename, '<');
        Path := Filename;
        WHILE STRPOS(Filename, '\') <> 0 DO
            Filename := COPYSTR(Filename, STRPOS(Filename, '\') + 1);
        IF STRLEN(Path) > STRLEN(Filename) THEN
            EXIT(COPYSTR(Path, 1, STRLEN(Path) - STRLEN(Filename)))
        ELSE
            EXIT('');
    end;
    //---CDU5063---
    PROCEDURE FctRestoreSalesQuoteDeleted(VAR SalesHeaderArchive: Record "Sales Header Archive")
    VAR
        SalesCommentLine: Record "Sales Comment Line";
        SalesCommentLineArchive: Record "Sales Comment Line Archive";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesLineArchive: Record "Sales Line Archive";
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        RestoreDocument: Boolean;
        CodLQuoteNo: Code[20];
        NextLine: Integer;
        CstG002: Label 'Do you want to create a new Quote based on %1 %2 Version %3?';
        Text003: Label '%1 %2 has been restored.';
        Text004: Label 'Document restored from Version %1.';
    BEGIN
        SalesHeaderArchive.TESTFIELD("Document Type", SalesHeaderArchive."Document Type"::Quote);

        RestoreDocument := FALSE;
        IF CONFIRM(
          CstG002, TRUE, SalesHeaderArchive."Document Type",
          SalesHeaderArchive."No.", SalesHeaderArchive."Version No.")
        THEN
            RestoreDocument := TRUE;
        IF RestoreDocument THEN BEGIN

            SalesHeader.SetHideValidationDialog(TRUE);
            SalesHeader."Document Type" := SalesHeaderArchive."Document Type";

            SalesHeader.INSERT(TRUE);
            CodLQuoteNo := SalesHeader."No.";
            SalesHeader.TRANSFERFIELDS(SalesHeaderArchive);
            SalesHeader."No." := CodLQuoteNo;
            SalesHeader.Status := SalesHeader.Status::Open;

            IF SalesHeaderArchive."Sell-to Contact No." <> '' THEN
                SalesHeader.VALIDATE("Sell-to Contact No.", SalesHeaderArchive."Sell-to Contact No.")
            ELSE
                SalesHeader.VALIDATE("Sell-to Customer No.", SalesHeaderArchive."Sell-to Customer No.");
            IF SalesHeaderArchive."Bill-to Contact No." <> '' THEN
                SalesHeader.VALIDATE("Bill-to Contact No.", SalesHeaderArchive."Bill-to Contact No.")
            ELSE
                SalesHeader.VALIDATE("Bill-to Customer No.", SalesHeaderArchive."Bill-to Customer No.");
            SalesHeader.VALIDATE("Salesperson Code", SalesHeaderArchive."Salesperson Code");
            SalesHeader.VALIDATE("Payment Terms Code", SalesHeaderArchive."Payment Terms Code");
            SalesHeader.VALIDATE("Payment Discount %", SalesHeaderArchive."Payment Discount %");
            SalesHeader."Shortcut Dimension 1 Code" := SalesHeaderArchive."Shortcut Dimension 1 Code";
            SalesHeader."Shortcut Dimension 2 Code" := SalesHeaderArchive."Shortcut Dimension 2 Code";

            SalesHeader."Dimension Set ID" := SalesHeaderArchive."Dimension Set ID";

            //>>SOBI
            SalesHeader.VALIDATE("PWD Call Type", 'SHIPPING');
            //<<SOBI

            SalesHeader.MODIFY(TRUE);

            SalesCommentLineArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type");
            SalesCommentLineArchive.SETRANGE("No.", SalesHeaderArchive."No.");
            SalesCommentLineArchive.SETRANGE("Doc. No. Occurrence", SalesHeaderArchive."Doc. No. Occurrence");
            SalesCommentLineArchive.SETRANGE("Version No.", SalesHeaderArchive."Version No.");
            IF SalesCommentLineArchive.FINDSET() THEN
                REPEAT
                    SalesCommentLine.INIT();
                    SalesCommentLine.TRANSFERFIELDS(SalesCommentLineArchive);
                    SalesCommentLine.INSERT();
                UNTIL SalesCommentLineArchive.NEXT() = 0;

            SalesCommentLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesCommentLine.SETRANGE("No.", SalesHeader."No.");
            SalesCommentLine.SETRANGE("Document Line No.", 0);
            IF SalesCommentLine.FINDLAST() THEN
                NextLine := SalesCommentLine."Line No.";
            NextLine += 10000;
            SalesCommentLine.INIT();
            SalesCommentLine."Document Type" := SalesHeader."Document Type";
            SalesCommentLine."No." := SalesHeader."No.";
            SalesCommentLine."Document Line No." := 0;
            SalesCommentLine."Line No." := NextLine;
            SalesCommentLine.Date := WORKDATE();
            SalesCommentLine.Comment := STRSUBSTNO(Text004, FORMAT(SalesHeaderArchive."Version No."));
            SalesCommentLine.INSERT();

            SalesLineArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type");
            SalesLineArchive.SETRANGE("Document No.", SalesHeaderArchive."No.");
            SalesLineArchive.SETRANGE("Doc. No. Occurrence", SalesHeaderArchive."Doc. No. Occurrence");
            SalesLineArchive.SETRANGE("Version No.", SalesHeaderArchive."Version No.");
            IF SalesLineArchive.FINDSET() THEN
                REPEAT
                    SalesLine.INIT();
                    SalesLine.TRANSFERFIELDS(SalesLineArchive);
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine.INSERT(TRUE);
                    SalesLine.FctSetHideMessage(TRUE);
                    IF SalesLine.Type <> SalesLine.Type::" " THEN BEGIN
                        SalesLine.VALIDATE("No.");
                        IF SalesLineArchive."Variant Code" <> '' THEN
                            SalesLine.VALIDATE("Variant Code", SalesLineArchive."Variant Code");
                        IF SalesLineArchive."Unit of Measure Code" <> '' THEN
                            SalesLine.VALIDATE("Unit of Measure Code", SalesLineArchive."Unit of Measure Code");
                        IF SalesLine.Quantity <> 0 THEN
                            SalesLine.VALIDATE(Quantity, SalesLineArchive.Quantity);
                        SalesLine.VALIDATE("Unit Price", SalesLineArchive."Unit Price");
                        SalesLine.VALIDATE("Line Discount %", SalesLineArchive."Line Discount %");
                        IF SalesLineArchive."Inv. Discount Amount" <> 0 THEN
                            SalesLine.VALIDATE("Inv. Discount Amount", SalesLineArchive."Inv. Discount Amount");
                        IF SalesLine.Amount <> SalesLineArchive.Amount THEN
                            SalesLine.VALIDATE(Amount, SalesLineArchive.Amount);
                        SalesLine.VALIDATE(Description, SalesLineArchive.Description);
                    END;
                    SalesLine."Shortcut Dimension 1 Code" := SalesLineArchive."Shortcut Dimension 1 Code";
                    SalesLine."Shortcut Dimension 2 Code" := SalesLineArchive."Shortcut Dimension 2 Code";
                    SalesLine."Dimension Set ID" := SalesLineArchive."Dimension Set ID";
                    SalesLine.MODIFY(TRUE);
                UNTIL SalesLineArchive.NEXT() = 0;
            SalesHeader.Status := SalesHeader.Status::Released;
            ReleaseSalesDoc.Reopen(SalesHeader);
            MESSAGE(Text003, SalesHeader."Document Type", SalesHeader."No.");
        END;
    END;

    //---CDU5402---
    PROCEDURE GetQtyPerFromUnitToUnit(Item2: Record Item; FromUnit: Code[10]; ToUnit: Code[10]): Decimal;
    BEGIN
        IF GetQtyPerUnitOfMeasure(Item2, ToUnit) <> 0 THEN
            EXIT(GetQtyPerUnitOfMeasure(Item2, FromUnit) / GetQtyPerUnitOfMeasure(Item2, ToUnit));
    END;
    //---CDU5703---
    procedure FCT_CDU5703OnCreateNewItemOnBeforeItemInsert(var Item: Record Item)
    var
        NonStock: Record "Nonstock Item";
    begin
        Item.VALIDATE("Tariff No.", NonStock."PWD Tariff No.");
        Item."Description 2" := NonStock."PWD Description 2";
        Item.VALIDATE("Shelf No.", NonStock."PWD Shelf No.");
        Item.VALIDATE("PWD Family", NonStock."PWD Family");
        Item.VALIDATE("PWD National Add. Code", NonStock."PWD National Add. Code");
        Item.VALIDATE("PWD IMPA Code", NonStock."PWD IMPA Code");
        Item.VALIDATE("PWD Trading Brand", TRUE);
    end;

    //---CDU5790---
    PROCEDURE PrepQtyAvailabletoPromise(VAR Item: Record Item; VAR GrossRequirement: Decimal; VAR ScheduledReceipt: Decimal; AvailabilityDate: Date; PeriodType: Option "Day","Week","Month","Quarter","Year"; LookaheadDateFormula: DateFormula): Decimal;
    VAR
        PurchLine: Record "Purchase Line";
        ReservationEntry: Record "Reservation Entry";
        SalesLine: Record "Sales Line";
        CduLAvailabletoPromise: Codeunit "Available to Promise";
        QtyOnPurchReturn: Decimal;
        QtyOnSalesReturn: Decimal;
    BEGIN
        Item.CALCFIELDS(
          Inventory, "Reserved Qty. on Inventory",
          "Scheduled Receipt (Qty.)", "Reserved Qty. on Prod. Order",
          "Purch. Req. Receipt (Qty.)", "Res. Qty. on Req. Line", "Planning Issues (Qty.)",
          "Qty. on Purch. Order", "Reserved Qty. on Purch. Orders",
          "Trans. Ord. Receipt (Qty.)", "Res. Qty. on Inbound Transfer",
          "Qty. on Component Lines", "Res. Qty. on Prod. Order Comp.",
          "Qty. on Sales Order", "Reserved Qty. on Sales Orders",
          "Qty. on Service Order", "Res. Qty. on Service Orders",
          "Trans. Ord. Shipment (Qty.)", "Res. Qty. on Outbound Transfer");

        Item.CALCFIELDS("PWD Qty. on Sales Order Prep");

        // Qty. on Sales Return
        SalesLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Bin Code", "Shipment Date");
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", Item."No.");
        SalesLine.SETFILTER("Location Code", Item."Location Filter");
        SalesLine.SETRANGE("Drop Shipment", Item."Drop Shipment Filter");
        SalesLine.SETFILTER("Variant Code", Item."Variant Filter");
        SalesLine.SETFILTER("Bin Code", Item."Bin Filter");
        SalesLine.SETRANGE("Shipment Date", Item.GETRANGEMIN(Item."Date Filter"), Item.GETRANGEMAX(Item."Date Filter"));
        SalesLine.CALCSUMS("Outstanding Qty. (Base)");
        QtyOnSalesReturn := SalesLine."Outstanding Qty. (Base)";
        SalesLine.RESET();
        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        ReservationEntry.SETRANGE("Item No.", Item."No.");
        ReservationEntry.SETFILTER("Location Code", Item."Location Filter");
        ReservationEntry.SETFILTER("Variant Code", Item."Variant Filter");
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Sales Line");
        ReservationEntry.SETRANGE("Source Subtype", 5);
        ReservationEntry.SETRANGE("Shipment Date", Item.GETRANGEMIN(Item."Date Filter"), Item.GETRANGEMAX(Item."Date Filter"));
        ReservationEntry.CALCSUMS("Quantity (Base)");
        QtyOnSalesReturn -= ReservationEntry."Quantity (Base)";
        ReservationEntry.RESET();
        // Qty. on Purchase Return
        PurchLine.SETCURRENTKEY("Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Bin Code", "Expected Receipt Date");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Return Order");
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchLine.SETRANGE("No.", Item."No.");
        PurchLine.SETFILTER("Location Code", Item."Location Filter");
        PurchLine.SETRANGE("Drop Shipment", Item."Drop Shipment Filter");
        PurchLine.SETFILTER("Variant Code", Item."Variant Filter");
        PurchLine.SETFILTER("Bin Code", Item."Bin Filter");
        PurchLine.SETRANGE("Expected Receipt Date", Item.GETRANGEMIN(Item."Date Filter"), Item.GETRANGEMAX(Item."Date Filter"));
        PurchLine.CALCSUMS("Outstanding Qty. (Base)");
        QtyOnPurchReturn := PurchLine."Outstanding Qty. (Base)";
        PurchLine.RESET();
        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Reservation);
        ReservationEntry.SETRANGE("Item No.", Item."No.");
        ReservationEntry.SETFILTER("Location Code", Item."Location Filter");
        ReservationEntry.SETFILTER("Variant Code", Item."Variant Filter");
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Purchase Line");
        ReservationEntry.SETRANGE("Source Subtype", 5);
        ReservationEntry.SETRANGE("Expected Receipt Date", Item.GETRANGEMIN(Item."Date Filter"), Item.GETRANGEMAX(Item."Date Filter"));
        ReservationEntry.CALCSUMS("Quantity (Base)");
        QtyOnPurchReturn += ReservationEntry."Quantity (Base)";
        ReservationEntry.RESET();

        ScheduledReceipt :=
          (Item."Scheduled Receipt (Qty.)" - Item."Reserved Qty. on Prod. Order") +
          (Item."Purch. Req. Receipt (Qty.)" - Item."Res. Qty. on Req. Line") +
          (Item."Qty. on Purch. Order" - Item."Reserved Qty. on Purch. Orders") +
          (Item."Trans. Ord. Receipt (Qty.)" - Item."Res. Qty. on Inbound Transfer") +
          QtyOnSalesReturn;

        GrossRequirement :=
          (Item."Qty. on Component Lines" - Item."Res. Qty. on Prod. Order Comp.") +
          Item."Planning Issues (Qty.)" +
          (Item."PWD Qty. on Sales Order Prep" - Item."Reserved Qty. on Sales Orders") +
          (Item."Qty. on Service Order" - Item."Res. Qty. on Service Orders") +
          (Item."Trans. Ord. Shipment (Qty.)" - Item."Res. Qty. on Outbound Transfer") +
          QtyOnPurchReturn;

        IF FORMAT(LookaheadDateFormula) <> '' THEN
            GrossRequirement :=
              GrossRequirement +
              CduLAvailabletoPromise.CalculateLookahead(
                Item, PeriodType,
                AvailabilityDate + 1,
                CduLAvailabletoPromise.AdjustedEndingDate(CALCDATE(LookaheadDateFormula, AvailabilityDate), PeriodType));
        EXIT(Item.Inventory - Item."Reserved Qty. on Inventory" + ScheduledReceipt - GrossRequirement);
    END;

    //---CDU 6500---
    PROCEDURE CallItemTrackingEntryFormUser(SourceType: Option " ","Customer","Vendor","Item"; SourceNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[20]; SerialNo: Code[20]; LotNo: Code[20]);
    VAR
        Item: Record Item;
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgEntry: Record "Item Ledger Entry" TEMPORARY;
        Window: Dialog;
        Text004: Label 'Counting records...';
    BEGIN
        // Used when calling Item Tracking from Item, Customer, Vendor and information card:
        Window.OPEN(Text004);
        IF NOT ItemLedgEntry.SETCURRENTKEY("Source Type", "Source No.", "Entry Type", "Item No.") THEN
            ItemLedgEntry.SETCURRENTKEY("Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.");
        IF SourceNo <> '' THEN BEGIN
            ItemLedgEntry.SETRANGE("Source No.", SourceNo);
            ItemLedgEntry.SETRANGE("Source Type", SourceType);
        END;

        IF ItemNo <> '' THEN BEGIN
            Item.GET(ItemNo);
            Item.TESTFIELD("Item Tracking Code");
            ItemLedgEntry.SETRANGE("Item No.", ItemNo);
        END;
        IF SourceType = 0 THEN
            ItemLedgEntry.SETRANGE("Variant Code", VariantCode);
        IF SerialNo <> '' THEN
            ItemLedgEntry.SETRANGE("Serial No.", SerialNo);
        IF LotNo <> '' THEN
            ItemLedgEntry.SETRANGE("Lot No.", LotNo);

        IF ItemLedgEntry.FindSet() THEN
            REPEAT
                IF (ItemLedgEntry."Serial No." <> '') OR (ItemLedgEntry."Lot No." <> '') THEN BEGIN
                    TempItemLedgEntry := ItemLedgEntry;
                    TempItemLedgEntry.INSERT();
                END
            UNTIL ItemLedgEntry.NEXT() = 0;
        Window.CLOSE();
        Page.RUNMODAL(Page::"PWD User Item Tracking Entries", TempItemLedgEntry);
    END;

    //---CDU 7010---
    procedure FindItemPurchPrice(VAR ToPurchPrice: Record "Purchase Price"; ItemNo: Code[20]; StartingDate: Date; ShowAll: Boolean)
    var
        FromPurchPrice: Record "Purchase Price";
    begin

        FromPurchPrice.SETRANGE("Item No.", ItemNo);
        FromPurchPrice.SETFILTER("Ending Date", '%1|>=%2', 0D, StartingDate);
        IF NOT ShowAll THEN
            FromPurchPrice.SETRANGE("Starting Date", 0D, StartingDate);

        ToPurchPrice.RESET();
        ToPurchPrice.DELETEALL();
        IF FromPurchPrice.FindSet() THEN
            REPEAT
                IF FromPurchPrice."Direct Unit Cost" <> 0 THEN BEGIN
                    ToPurchPrice := FromPurchPrice;
                    ToPurchPrice.INSERT();
                END;
            UNTIL FromPurchPrice.NEXT() = 0;
    end;

    procedure NoOfItemPurchLinePrice(ItemNo: Code[20]; OrderDate: Date; ShowAll: Boolean): Integer
    var
    begin
        IF ItemPurchLinePriceExists(ItemNo, OrderDate, ShowAll) THEN
            EXIT(PurchPrice.COUNT);
    end;

    procedure ItemPurchLinePriceExists(ItemNo: Code[20]; OrderDate: date; ShowAll: Boolean): Boolean
    var
        Item: Record Item;
    begin
        IF ItemNo <> '' THEN
            IF Item.GET(ItemNo) THEN BEGIN
                FindItemPurchPrice(
                  PurchPrice, ItemNo, OrderDate, ShowAll);
                EXIT(PurchPrice.FindFirst());
            END;
        EXIT(FALSE);
    end;

    procedure GetItemPurchLinePrice(ItemNo: Code[20]; OrderDate: Date)
    var
    begin
        ItemPurchLinePriceExists(ItemNo, OrderDate, TRUE);
        IF Page.RUNMODAL(Page::"Get Purchase Price", PurchPrice) = ACTION::OK THEN;
    end;

    procedure CalcNoOfPurchasePrices(SalesLine: Record "Sales Line"): Integer
    var
        Item: Record Item;
        RecLSalesHeader: Record "Sales Header";
    begin
        IF (SalesLine.Type = SalesLine.Type::Item) AND Item.GET(SalesLine."No.") THEN
            IF RecLSalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.") THEN
                EXIT(NoOfItemPurchLinePrice(SalesLine."No.", RecLSalesHeader."Order Date", TRUE));
        EXIT(0);
    end;

    procedure CalcNoOfPurchPricesFromPurchLi(RecPPurchaseLine: Record "Purchase Line"): Integer
    var
        Item: Record Item;
        RecLPurchaseHeader: Record "Purchase Header";
    begin
        IF (RecPPurchaseLine.Type = RecPPurchaseLine.Type::Item) AND Item.GET(RecPPurchaseLine."No.") THEN
            IF RecLPurchaseHeader.GET(RecPPurchaseLine."Document Type", RecPPurchaseLine."Document No.") THEN
                EXIT(NoOfItemPurchLinePrice(RecPPurchaseLine."No.", RecLPurchaseHeader."Order Date", TRUE));
        EXIT(0);
    end;

    //---CDU99000830---
    PROCEDURE FctOnCreateEntryOnBeforeSurplusCondition_CDU99000830(var ReservEntry: Record "Reservation Entry"; QtyToHandleAndInvoiceIsSet: Boolean)
    var
        PWDSetGetFunctions: codeunit "PWD Set/Get Functions";
    BEGIN
        ReservEntry."PWD Country Origin" := PWDSetGetFunctions.GetOriginArea();
        ReservEntry."PWD Certificate Transit No." := PWDSetGetFunctions.GetCertifTransit();
        ReservEntry."PWD Stocking Advice No." := PWDSetGetFunctions.GetStockingAdvice();
        ReservEntry."Location Code" := PWDSetGetFunctions.GetLocationCode();
        ReservEntry."PWD Lot No. Origin" := PWDSetGetFunctions.GetButcheryOriginLot();
        IF PWDSetGetFunctions.GetButchery2() <> 0D THEN
            ReservEntry."Expiration Date" := PWDSetGetFunctions.GetButchery2();

        PWDSetGetFunctions.SetOriginArea('');
        PWDSetGetFunctions.SetCertifTransit('');
        PWDSetGetFunctions.SetStockingAdvice('');
        PWDSetGetFunctions.SetLocationCode('');
        PWDSetGetFunctions.SetButcheryOriginLot('');
        PWDSetGetFunctions.SetButchery2(0D);
    END;

    //---CDU99000832---
    PROCEDURE CodePaysOrigin(Salesline2: Record "Sales Line"; VAR OriginArea2: Code[10]);
    BEGIN
        OriginArea2 := Salesline2."PWD Origin Area";
    END;

    //---CDU99000835---
    PROCEDURE CallItemTrackingButch(VAR ItemJnlLine: Record "Item Journal Line"; IsReclass: Boolean; VAR OriginbutchEntry: Record "Reservation Entry");
    VAR
        ReservEntry: Record "Reservation Entry";
        TrackingSpecification: Record "Tracking Specification";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ItemTrackingLines: Page "Item Tracking Lines";
        Text006: Label 'You cannot define item tracking on %1 %2';
    BEGIN
        IF NOT ItemJnlLine.ItemPosting() THEN BEGIN
            ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, FALSE);
            //FilterReservFor(ReservEntry,ItemJnlLine);
            ItemJnlLine.SetReservationFilters(ReservEntry); //TODO: Vérifier Code adapté
            ReservEntry.SETRANGE("Serial No.");
            ReservEntry.SETRANGE("Lot No.");
            IF ReservEntry.IsEmpty THEN
                ERROR(Text006, ItemJnlLine.FIELDCAPTION("Operation No."), ItemJnlLine."Operation No.");
        END;
        //InitTrackingSpecification(ItemJnlLine,TrackingSpecification);
        TrackingSpecification.InitFromItemJnlLine(ItemJnlLine);//TODO: Vérifier Code adapté
        IF IsReclass THEN
            //ItemTrackingPage.SetFormRunMode(1);
            ItemTrackingLines.SetRunMode("Item Tracking Run Mode"::Reclass);//TODO: Vérifier Code adapté
                                                                            //ItemTrackingPage.SetSource(TrackingSpecification,ItemJnlLine."Posting Date");
        ItemTrackingLines.SetSourceSpec(TrackingSpecification, ItemJnlLine."Posting Date");//TODO: Vérifier Code adapté

        ItemTrackingLines.SetOrigineButcheryEntry(OriginbutchEntry, TRUE);   //MIGRATION2009R2 Function dont exist
        ItemTrackingLines.RUNMODAL();
    END;

    //------
    procedure GetQtyPerUnitOfMeasure(Item: Record Item; UnitOfMeasureCode: Code[10]): Decimal
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
    begin

        IF UnitOfMeasureCode IN [Item."Base Unit of Measure", ''] THEN
            EXIT(1);
        IF (Item."No." <> ItemUnitOfMeasure."Item No.") OR
           (UnitOfMeasureCode <> ItemUnitOfMeasure.Code)
        THEN
            ItemUnitOfMeasure.GET(Item."No.", UnitOfMeasureCode);
        ItemUnitOfMeasure.TESTFIELD("Qty. per Unit of Measure");
        EXIT(ItemUnitOfMeasure."Qty. per Unit of Measure");
    end;

    //--Page508--
    PROCEDURE UnitPriceOnFormat();
    var
        ParamsVente: Record "Sales & Receivables Setup";
        CoefPrixUnitaire: Decimal;
    BEGIN
        ParamsVente.GET();
        CoefPrixUnitaire := ParamsVente."PWD Coef Ctrl Prix Unit";
    END;
}
