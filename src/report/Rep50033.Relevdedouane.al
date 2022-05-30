report 50033 "PWD Relevé de douane"
{
    // --------------------------------------------
    // Prodware - www.prodware.com
    // --------------------------------------------
    // >>GHE-RE1.00:DO 08/04/2011 :
    //   - Migration2009 changement cle
    // --------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/Relevédedouane.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter", "Location Filter", "PWD No. sommier hors CEE";
            column(StartDate_EndDate; STRSUBSTNO(Text1000000002, StartDate, EndDate))
            {
            }
            column(NosommierHorsCEE; "PWD No. sommier hors CEE")
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CODE_LocationFilter; 'CODE ' + LocationFilter)
            {
            }
            column(location_Name; location.Name)
            {
            }
            column(Item_Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
            {
            }
            column(Item_Item_Description; Item.Description)
            {
            }
            column(Item_Item__No__; Item."No.")
            {
            }
            column(SommierDouanier; SommierDouanier)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(Page_N_______FORMAT_CurrReport_PAGENO_; 'Page N°. : ')
            {
            }
            column(COMPTABILITE_MATIERESCaption; COMPTABILITE_MATIERESCaptionLbl)
            {
            }
            column(InventoryCaption; InventoryCaptionLbl)
            {
            }
            column(OutCaption; OutCaptionLbl)
            {
            }
            column(InCaption; InCaptionLbl)
            {
            }
            column(Item_Location_Filter; "Location Filter")
            {
            }
            column(Item_Date_Filter; "Date Filter")
            {
            }
            dataitem(PreviousInventory; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Location Code" = FIELD("Location Filter");
                DataItemTableView = SORTING("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.") WHERE(Positive = CONST(true));
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Item__No__; Item."No.")
                {
                }
                column(SommierDouanier_Control1000000050; SommierDouanier)
                {
                }
                column(PreviousInventory__Location_Code_; "Location Code")
                {
                }
                column(PreviousInventory__Posting_Date_; "Posting Date")
                {
                }
                column(RemainingQty; RemainingQty)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(FinalInventory; FinalInventory)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(PreviousInventory_Quantity; Quantity)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(PreviousInventory__Cetificate_Transit_No__; "PWD Cetificate Transit No.")
                {
                }
                column(InventoryCaption_Control1000000042; InventoryCaption_Control1000000042Lbl)
                {
                }
                column(OutCaption_Control1000000044; OutCaption_Control1000000044Lbl)
                {
                }
                column(InCaption_Control1000000047; InCaption_Control1000000047Lbl)
                {
                }
                column(ReportCaption; ReportCaptionLbl)
                {
                }
                column(Init_Caption; Init_CaptionLbl)
                {
                }
                column(PreviousInventory_Entry_No_; "Entry No.")
                {
                }
                column(PreviousInventory_Item_No_; "Item No.")
                {
                }
                column(HeaderShown; HeaderShown)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CLEAR(TempItemEntry);
                    TempItemEntry.DELETEALL();
                    CLEAR(PreviousSalesQty);
                    CLEAR(RemainingQty);
                    FindAppliedEntry(PreviousInventory);
                    TempItemEntry.SETCURRENTKEY("Item No.");
                    IF TempItemEntry.FIND('-') THEN BEGIN
                        TempItemEntry.SETRANGE("Posting Date", 0D, StartDate - 1);
                        TempItemEntry.CALCSUMS(Quantity);
                        PreviousSalesQty := TempItemEntry.Quantity;
                    END;

                    RemainingQty := Quantity + PreviousSalesQty;

                    IF RemainingQty = 0 THEN CurrReport.SKIP();
                    FinalInventory += RemainingQty;
                    GetAvisPlc(PreviousInventory);

                    HeaderShown := TRUE;

                    IF "Location Code" <> '9HCEE' THEN
                        SommierDouanier := Item."PWD Base Customs No." ELSE
                        SommierDouanier := Item."PWD No. sommier hors CEE";
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", 0D, StartDate - 1);
                    HeaderShown := FALSE;
                end;
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Location Code" = FIELD("Location Filter"), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Item No.", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                column(Item__Base_Unit_of_Measure__Control1000000009; Item."Base Unit of Measure")
                {
                }
                column(Item_Description_Control1000000010; Item.Description)
                {
                }
                column(Item__No___Control1000000022; Item."No.")
                {
                }
                column(SommierDouanier_Control1000000035; SommierDouanier)
                {
                }
                column(Item_Ledger_Entry__Location_Code_; "Location Code")
                {
                }
                column(Item_Ledger_Entry_Quantity; Quantity)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(FinalInventory_Control1000000001; FinalInventory)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Certificate; Certificate)
                {
                }
                column(Item_Ledger_Entry__Posting_Date__Control1000000013; "Posting Date")
                {
                }
                column(Item_Ledger_Entry_Quantity_Control1000000016; Quantity)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(FinalInventory_Control1000000017; FinalInventory)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Item_Ledger_Entry__Cetificate_Transit_No__; "PWD Cetificate Transit No.")
                {
                }
                column(Quantity; -Quantity)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(Positive; Positive)
                {
                }
                column(Item_Ledger_Entry__Posting_Date__Control1000000026; "Posting Date")
                {
                }
                column(DSANo; DSANo)
                {
                }
                column(ShipName______Notice_Series_No__; ShipName + ' ' + "PWD Notice Series No.")
                {
                }
                column(FinalInventory_Control1000000003; FinalInventory)
                {
                    DecimalPlaces = 3 : 3;
                }
                column(BL_N_______Document_No_______du_____FORMAT__Document_Date__; ' BL N° ' + "Document No." + ' du ' + FORMAT("Document Date"))
                {
                }
                column(InventoryCaption_Control1000000039; InventoryCaption_Control1000000039Lbl)
                {
                }
                column(OutCaption_Control1000000053; OutCaption_Control1000000053Lbl)
                {
                }
                column(InCaption_Control1000000054; InCaption_Control1000000054Lbl)
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Item_Ledger_Entry_Item_No_; "Item No.")
                {
                }
                column(PWDShowOuTPUT; PWDShowOuTPUT)
                {
                }
                column(PWDShowOutPUT2; PWDShowOutPUT2)
                {
                }
                trigger OnAfterGetRecord()
                var
                    PurchRcptLine: Record "Purch. Rcpt. Line";
                begin
                    CLEAR(DSANo);
                    CLEAR(ShipName);
                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Sale THEN BEGIN
                        IF NOT Cust.GET("Item Ledger Entry"."Source No.") THEN Cust.INIT();
                        ShipName := Cust.Name;
                        IF NOT SalesShipHeader.GET("Item Ledger Entry"."Document No.") THEN SalesShipHeader.INIT();
                        DSANo := SalesShipHeader."PWD DSA No.";
                        IF Positive THEN BEGIN
                            IF NOT SalesCRMemoHeader.GET("Item Ledger Entry"."Document No.") THEN SalesCRMemoHeader.INIT();
                            DSANo := SalesCRMemoHeader."PWD DSA No.";
                        END;
                    END ELSE
                        GetAvisPlc("Item Ledger Entry");

                    FinalInventory += Quantity;

                    IF ((Positive = TRUE) AND ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Sale)) THEN BEGIN
                        CLEAR(DescSalePos);
                        IF "PWD Notice Series No." = '' THEN
                            DescSalePos := DSANo + ' ' ELSE
                            DescSalePos := "PWD Notice Series No.";
                    END;

                    IF "Location Code" <> '9HCEE' THEN
                        SommierDouanier := Item."PWD Base Customs No." ELSE
                        SommierDouanier := Item."PWD No. sommier hors CEE";

                    if ("Item Ledger Entry".Positive = true) and ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Sale) then
                        PWDShowOuTPUT := true
                    else
                        PWDShowOuTPUT := false;
                    if (("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Positive Adjmt.") or ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase))
                        and ("Item Ledger Entry".Positive) then
                        PWDShowOuTPUT2 := true
                    else
                        PWDShowOuTPUT2 := false;

                    Certificate := "Item Ledger Entry"."PWD Cetificate Transit No.";

                    IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Purchase THEN BEGIN
                        PurchRcptLine.RESET();
                        PurchRcptLine.SETCURRENTKEY("Document No.", Type, "Location Code", "PWD Cle (restitution)", Quantity);
                        PurchRcptLine.SETFILTER("Document No.", "Item Ledger Entry"."Document No.");
                        PurchRcptLine.SETFILTER("Location Code", "Item Ledger Entry"."Location Code");
                        PurchRcptLine.SETRANGE(Quantity, "Item Ledger Entry".Quantity);
                        PurchRcptLine.SETFILTER("No.", "Item Ledger Entry"."Item No.");
                        IF PurchRcptLine.FindFirst() THEN Certificate := PurchRcptLine."PWD Cetificate Transit No.";
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(FinalInventory);
                CLEAR(PreviousSalesQty);
                CLEAR(TempItemEntry);
                TempItemEntry.DELETEALL();
                CLEAR(RemainingQty);
                CLEAR(SommierDouanier);

                IF LocationFilter <> '9HCEE' THEN
                    SommierDouanier := Item."PWD Base Customs No." ELSE
                    SommierDouanier := Item."PWD No. sommier hors CEE";

                IF NOT location.GET(LocationFilter) THEN
                    location.INIT();
            end;

            trigger OnPreDataItem()
            begin
                StartDate := Item.GETRANGEMIN("Date Filter");
                EndDate := Item.GETRANGEMAX("Date Filter");

                LocationFilter := GETFILTER("Location Filter");
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Cust: Record Customer;
        TempItemEntry: Record "Item Ledger Entry" temporary;
        location: Record Location;
        SalesCRMemoHeader: Record "Sales Cr.Memo Header";
        SalesShipHeader: Record "Sales Shipment Header";
        HeaderShown: Boolean;
        PWDShowOutPUT: Boolean;
        PWDShowOutPUT2: Boolean;
        DSANo: Code[20];
        NumAvisPlc: Code[20];
        SommierDouanier: Code[20];
        Certificate: Code[50];
        EndDate: Date;
        StartDate: Date;
        FinalInventory: Decimal;
        PreviousSalesQty: Decimal;
        RemainingQty: Decimal;
        COMPTABILITE_MATIERESCaptionLbl: Label 'COMPTABILITE-MATIERES';
        InCaption_Control1000000047Lbl: Label 'In';
        InCaption_Control1000000054Lbl: Label 'In';
        InCaptionLbl: Label 'In';
        Init_CaptionLbl: Label 'Init=';
        InventoryCaption_Control1000000039Lbl: Label 'Inventory';
        InventoryCaption_Control1000000042Lbl: Label 'Inventory';
        InventoryCaptionLbl: Label 'Inventory';
        OutCaption_Control1000000044Lbl: Label 'Out';
        OutCaption_Control1000000053Lbl: Label 'Out';
        OutCaptionLbl: Label 'Out';
        ReportCaptionLbl: Label 'Report';
        Text1000000002: Label 'Relevé de douane du %1 au %2';
        Com7Desc: Text[30];
        LocationFilter: Text[30];
        ShipName: Text[30];
        DescSalePos: Text[50];

    local procedure FindAppliedEntry(ItemLedgEntry: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        IF ItemLedgEntry.Positive THEN BEGIN
            ItemApplnEntry.RESET();
            ItemApplnEntry.SETCURRENTKEY(
              "Inbound Item Entry No.", "Cost Application", "Outbound Item Entry No.");
            ItemApplnEntry.SETRANGE("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Cost Application", TRUE);
            ItemApplnEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    IF (ItemLedgEntry."Entry Type" <> ItemLedgEntry."Entry Type"::Transfer) OR
                       (ItemApplnEntry."Item Ledger Entry No." <> ItemLedgEntry."Entry No.")
                    THEN
                        InsertTempEntry(ItemApplnEntry."Item Ledger Entry No.", ItemApplnEntry.Quantity);
                UNTIL ItemApplnEntry.NEXT() = 0;
            ItemApplnEntry.RESET();
            ItemApplnEntry.SETCURRENTKEY("Transferred-from Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Transferred-from Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Cost Application", TRUE);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    InsertTempEntry(ItemApplnEntry."Item Ledger Entry No.", ItemApplnEntry.Quantity);
                UNTIL ItemApplnEntry.NEXT() = 0;
        END ELSE BEGIN
            ItemApplnEntry.RESET();
            ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SETRANGE("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SETRANGE("Cost Application", TRUE);
            IF ItemApplnEntry.FIND('-') THEN
                REPEAT
                    InsertTempEntry(ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                UNTIL ItemApplnEntry.NEXT() = 0;
        END;
    end;

    local procedure InsertTempEntry(EntryNo: Integer; AppliedQty: Decimal)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        IF NOT TempItemEntry.GET(EntryNo) THEN BEGIN
            ItemLedgEntry.GET(EntryNo);
            TempItemEntry.INIT();
            TempItemEntry := ItemLedgEntry;
            TempItemEntry.Quantity := AppliedQty;
            TempItemEntry.INSERT();
        END ELSE BEGIN
            TempItemEntry.Quantity := TempItemEntry.Quantity + AppliedQty;
            TempItemEntry.MODIFY();
        END;
    end;

    procedure GetAvisPlc(FromItemLedgEntry: Record "Item Ledger Entry")
    var
        PurchReceiptLine: Record "Purch. Rcpt. Line";
    begin
        CLEAR(Com7Desc);
        CLEAR(NumAvisPlc);
        IF FromItemLedgEntry."PWD Notice Series No." <> '' THEN BEGIN
            NumAvisPlc := FromItemLedgEntry."PWD Notice Series No.";
            Com7Desc := GetCom7Desc(FromItemLedgEntry);
            EXIT;
        END;
        IF FromItemLedgEntry."Entry Type" = FromItemLedgEntry."Entry Type"::"Positive Adjmt." THEN BEGIN
            NumAvisPlc := FromItemLedgEntry."PWD Notice Series No.";
            Com7Desc := GetCom7Desc(FromItemLedgEntry);
            EXIT;
        END;
        IF (FromItemLedgEntry."Entry Type" = FromItemLedgEntry."Entry Type"::Purchase) AND
           (FromItemLedgEntry."PWD Notice Series No." = '') THEN BEGIN
            CLEAR(PurchReceiptLine);
            PurchReceiptLine.SETCURRENTKEY("Document No.", Type, "No.");
            PurchReceiptLine.SETRANGE("Document No.", FromItemLedgEntry."Document No.");
            PurchReceiptLine.SETRANGE(Type, PurchReceiptLine.Type::Item);
            PurchReceiptLine.SETRANGE("No.", FromItemLedgEntry."Item No.");
            IF PurchReceiptLine.FindFirst() THEN BEGIN
                NumAvisPlc := PurchReceiptLine."PWD No. avis de placement";
                Com7Desc := GetCom7Desc(FromItemLedgEntry);
            END ELSE BEGIN
                NumAvisPlc := 'NC';
                Com7Desc := '';
            END;
            EXIT;
        END;
    end;

    procedure GetCom7Desc(FromItemLedgEntry: Record "Item Ledger Entry"): Text[30]
    begin
        IF FromItemLedgEntry."Location Code" IN ['1', '5', 'CML'] THEN
            EXIT('COM 7 AFD') ELSE
            IF FromItemLedgEntry."Location Code" IN ['9', '9HCEE'] THEN
                EXIT('IM7') ELSE
                EXIT('COM7');
    end;
}
