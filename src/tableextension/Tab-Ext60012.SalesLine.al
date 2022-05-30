tableextension 60012 "PWD SalesLine" extends "Sales Line"
{
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Prodware : www.prodware.fr
    // ------------------------------------------------------------------------------------------------------------------------------------
    //
    // //>>MIGRATION2009R2
    //
    // ------------------------------------------------------------------------------------------------------------------------------------
    //
    // *** Contremarque - C2A
    // 03.11.2004    C2A.LLE AddNewFields
    //                  70010 Methode de Calcul (prestation)
    //                  70011 Référence Calcul (prestation)
    // 15.11.2004    C2A.LLE AddNewFields
    //                  70012 N°DOC saisie presta
    //                  70013 Code prestation
    // 06.07.2005    C2A(LLE) modify C/AL code in trigger Prepared Quantity - OnValidate()
    // 01.02.2006    C2A(LLE) cf CDVS004032
    //                        add key Vendor No.,Shelf/Bin No.,Location Code
    // 20.02.06      C2A(LLE) add new fields cf commande CDVN001047
    //                        70015 - preparation to recalculate
    //                        70016 - loc. Code for prepa to recalc.
    //
    // 20.06.06     C2A(LLE)   Modif in trigger Quantity - OnValidate() cf appel 12377
    // 07/06/07     C2A(LLE)   cf appel NAV0016498  suite livraison dev de JRA modif in trigger
    //                                 GetUnitCost()
    // 08/06/07     C2A(LLE)   cf appel NAV0016498  suite livraison dev au client modif in trigger
    //                                 GetUnitCost()
    // 19/06/07     C2A(LLE)   cf appel NAV0016498  suite livraison dev au client modif in trigger
    //                                 GetUnitCost()
    // 04/07/07     C2A(LLE)   cf appel NAV0016773 ajout clé de tri utilisé dans le report 50042
    //                                 Document Type,Document No.,Location Code,Shelf/Bin No.,SEAF Code
    // 12/07/07     C2A(LLE)   cf appel NAV0016498 modif type Code SEAF et trigger
    //                                 No. - OnValidate()
    // 03/10/07     C2A(LE)    cf appel NAV0017476 ajout clé de tri
    //                              Document Type,Document No.,Location Code,Shelf/Bin No.,Family Code,No.
    //
    // -------------------------------------------------
    // Prodware - www.prodware.fr
    // -------------------------------------------------
    // //>>GHES1.01
    // FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009 - SALES ORDER SEAFRANCE
    //                                                     Add Fields ID 50023 "New Item"
    //                                                                ID 50024 "Seafrance Order Line No."
    //
    // //>>GHES1.02
    // FED_ADV_20090827_IMP_CDEVENTE_V2_NEW_DEMANDE :SOBI 05/03/2010 - SALES ORDER SEAFRANCE (NEW DEMANDE)
    //                                                     Add Fields ID 50053 "Coefficient SEAFRANCE"
    //                                                                ID 50054 "Quantity SEAFRANCE"
    //
    // >>GHE-RE1.00:DO 08/04/2011 :
    //   - Ajout d'indicateur
    //   - Retrait commentaire
    //
    // >>GHE-RE1.00:DO 06/05/2011 :
    //   - add field "newpage" for report 50042
    //
    // //>>MODIF HL
    // TI062523.001 DO.ALMI 21/09/2011  : - Add condition item Nonstock function
    //                                      CheckavailforPriorityLocation
    //
    // //>>GHES1.20
    // P3346_0011 DO.ALMI SOBI 12/04/2012 : - Add new key "Document Type","Document No.","Location Code",Family,"No."
    //
    // //>>GHES1.30
    // P3346_0011 DO.ALMI REGIE 22/08/2012:-  Add SEAF Code item to sales line
    //                                        Create new field
    //                                        "Item SEAF Code" Onvalidate,OnlookUp
    //
    // //>>SOBI
    // P3346_0011 RO.LALE REGIE 11/07/2013 : - Modif Trigger Quantity - OnValidate()
    //                                       - add function FctPushVendorAndUnitPriceItem
    //
    // //>>SOBI
    // P3346_0015 RO.LALE REGIE 25/02/2015 : - Add Function FctSetHideMessage
    //                                       - Add C/AL Global BooGHideMessage
    //                                       - Modif C/AL Code in trigger CtrlUnitPrice()
    //
    // //>>NDBI (P25940_001)
    // LALE.RO : 29/05/2018 : cf NDBI ID 258
    //                     - MODIF C/AL Code in trigger No. - OnValidate()
    //
    // //>>NDBI (P25940_001)
    // LALE.RO : 30/05/2018 : cf NDBI ID 580
    //                       Add Fields 50031 - Item SEAF Code 2 - Code20
    //                                  50032 - Item SEAF Code 3 - Code20
    //                       Add C/AL Code in trigger  No. - OnValidate()
    //
    // //>> 14/10/2019 SU-DADE cf appel TI474110
    // //   ctrlunitprice()
    // //<< 14/10/2019 SU-DADE cf appel TI474110
    //
    // //>>NDBI (P27817_002)
    // LALE.PA : 27/01/2021 : cf TDD_SAS GHESQUIERS JPG_Ajout champs_V1 suite TI521553
    //                       Add Fields 50033 - SEAF Code 4 - Code20
    //                                  50034 - SEAF Code 5 - Code20
    //                       Add C/AL Code in trigger  No. - OnValidate()
    //
    //
    // ------------------------------------------------------------------------------------------------------------------------------------

    fields
    {
        field(50000; "PWD Call No."; Code[10])
        {
            Caption = 'Call No.';
            Description = 'PW2009';
            TableRelation = "PWD Call"."Call No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetCallCust();
                VALIDATE("PWD Call Type", RecCall."Call Type");
            end;
        }
        field(50001; "PWD Parcel Nb."; Decimal)
        {
            Caption = 'Parcel Nb.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Unit per Parcel"; Decimal)
        {
            Caption = 'Unit per Parcel';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Output Date"; Date)
        {
            Caption = 'Output Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Health Approval No."; Code[20])
        {
            Caption = 'Health Approval No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Marked"; Code[30])
        {
            Caption = 'Mark';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD Origin Area"; Code[10])
        {
            Caption = 'Origin Area';
            Description = 'PW2009';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Country: Record "Country/Region";
            begin
                IF Country.GET("PWD Origin Area") THEN
                    "PWD Code Continent" := Country."PWD Continental Code" ELSE
                    "PWD Code Continent" := '';
            end;
        }
        field(50007; "PWD Code Continent"; Code[10])
        {
            Caption = 'Continental Code';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(9), "Field ID" = CONST(50001));
            DataClassification = CustomerContent;
        }
        field(50010; "PWD Origin Certified"; Boolean)
        {
            Caption = 'Origin Certified';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50011; "PWD Manifest"; Boolean)
        {
            Caption = 'Manifest';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50012; "PWD Manifest Category"; Option)
        {
            Caption = 'Manifest Category';
            Description = 'PW2009';
            OptionCaption = ' ,alcool,aperitif,tabaco,toilet water';
            OptionMembers = " ",alcool,aperitif,tabaco,"toilet water";
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Document Date"; Date)
        {
            Caption = 'Document Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50014; "PWD Certificate Transit No."; Code[30])
        {
            Caption = 'Certificate Transit No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50015; "PWD Call Type"; Code[10])
        {
            Caption = 'Call Type';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                RecLocPriority.SETCURRENTKEY(RecLocPriority."PWD Call Type Code", RecLocPriority."PWD Location priority");
                RecLocPriority.ASCENDING(TRUE);
                RecLocPriority.SETRANGE(RecLocPriority."PWD Call Type Code", "PWD Call Type");
                IF RecLocPriority.FIND('-') THEN
                    VALIDATE("Location Code", RecLocPriority."PWD Location code");
            end;
        }
        field(50016; "PWD Preparation in Process"; Boolean)
        {
            Caption = 'Preparation in process';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50017; "PWD Prepared Quantity"; Decimal)
        {
            Caption = 'Prepared Quantity';
            DecimalPlaces = 0 : 5;
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                // BEGIN 06-07-05 Ajout C2A(LLE) suite appel 8620  On mémorise "Unit Price" et "Line Discount %" car suite aux
                // validate qui suivent les valeurs saisies se perdaient.
                MemLineDiscount := "Line Discount %";
                SetGetFunctions.SetMemLineDiscount(MemLineDiscount);
                MemUnitPrice := "Unit Price";
                SetGetFunctions.SetMemUnitPrice(MemUnitPrice);
                //ToDo  // "CalcBaseQty": fct local
                //VALIDATE("PWD Prepared Quantity (Base)", CalcBaseQty("PWD Prepared Quantity", FieldCaption("PWD Prepared Quantity"), FieldCaption("PWD Prepared Quantity (Base)")));

                "PWD Adjmt Prepared Qty" := Quantity - "PWD Prepared Quantity";

                IF CurrFieldNo = FIELDNO("PWD Prepared Quantity") THEN
                    IF "PWD Prepared Quantity" <= Quantity THEN
                        VALIDATE(Quantity, "PWD Prepared Quantity")
                    ELSE
                        ERROR(Text1000000026);

                // BEGIN 06-07-05 Ajout C2A(LLE) suite appel 8620  On mémorise "Unit Price" et "Line Discount %" car suite aux
                // validate qui suivent les valeurs saisies se perdaient.
                //VALIDATE("Line Discount %", MemLineDiscount);
                VALIDATE("Line Discount %", SetGetFunctions.GetMemLineDiscount());
                //VALIDATE("Unit Price", MemUnitPrice);
                VALIDATE("Unit Price", SetGetFunctions.GetMemUnitPrice());
                MODIFY(TRUE);
            end;
        }
        field(50018; "PWD Prepared Quantity (Base)"; Decimal)
        {
            Caption = 'Prepared Quantity (Base)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50019; "PWD Order Line Prepared"; Boolean)
        {
            Caption = 'Order Line Prepared';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50020; "PWD Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50023; "PWD New Item"; Boolean)
        {
            Caption = 'New Item';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50024; "PWD Seafrance Order Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Seafrance Order Line No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50030; "PWD Item SEAF Code"; Code[20])
        {
            Caption = 'SEAF Code';
            Description = 'GHES1.30';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                recLItem: Record Item;
            begin
                IF Type = Type::Item THEN BEGIN
                    recLItem.RESET();
                    recLItem.SETFILTER("PWD SEAF Code", '<>%1', '');
                    IF Page.RUNMODAL(0, recLItem) = ACTION::LookupOK THEN
                        VALIDATE("No.", recLItem."No.");
                END;
            end;

            trigger OnValidate()
            var
                recLItem: Record Item;
            begin
                recLItem.RESET();
                recLItem.SETRANGE("PWD SEAF Code", "PWD Item SEAF Code");
                IF recLItem.FINDFIRST() THEN
                    VALIDATE("No.", recLItem."No.");
            end;
        }
        field(50031; "PWD Item SEAF Code 2"; Code[20])
        {
            Caption = 'Item SEAF Code 2';
            Description = 'NDBI';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                recLItem: Record Item;
            begin
                IF Type = Type::Item THEN BEGIN
                    recLItem.RESET();
                    recLItem.SETFILTER("PWD SEAF Code 2", '<>%1', '');
                    IF PAGE.RUNMODAL(0, recLItem) = ACTION::LookupOK THEN
                        VALIDATE("No.", recLItem."No.");
                END;
            end;

            trigger OnValidate()
            var
                recLItem: Record Item;
            begin
                recLItem.RESET();
                recLItem.SETRANGE("PWD SEAF Code 2", "PWD Item SEAF Code 2");
                IF recLItem.FINDFIRST() THEN
                    VALIDATE("No.", recLItem."No.");
            end;
        }
        field(50032; "PWD Item SEAF Code 3"; Code[20])
        {
            Caption = 'Item SEAF Code 3';
            Description = 'NDBI';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                recLItem: Record Item;
            begin
                IF Type = Type::Item THEN BEGIN
                    recLItem.RESET();
                    recLItem.SETFILTER("PWD SEAF Code 3", '<>%1', '');
                    IF PAGE.RUNMODAL(0, recLItem) = ACTION::LookupOK THEN
                        VALIDATE("No.", recLItem."No.");
                END;
            end;

            trigger OnValidate()
            var
                recLItem: Record Item;
            begin
                recLItem.RESET();
                recLItem.SETRANGE("PWD SEAF Code 3", "PWD Item SEAF Code 3");
                IF recLItem.FINDFIRST() THEN
                    VALIDATE("No.", recLItem."No.");
            end;
        }
        field(50033; "PWD Item SEAF Code 4"; Code[20])
        {
            Caption = 'Item SEAF Code 4';
            Description = 'NDBI';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                recLItem: Record Item;
            begin
                IF Type = Type::Item THEN BEGIN
                    recLItem.RESET();
                    recLItem.SETFILTER("PWD SEAF Code 4", '<>%1', '');
                    IF PAGE.RUNMODAL(0, recLItem) = ACTION::LookupOK THEN
                        VALIDATE("No.", recLItem."No.");
                END;
            end;

            trigger OnValidate()
            var
                recLItem: Record Item;
            begin
                recLItem.RESET();
                recLItem.SETRANGE("PWD SEAF Code 4", "PWD Item SEAF Code 4");
                IF recLItem.FINDFIRST() THEN
                    VALIDATE("No.", recLItem."No.");
            end;
        }
        field(50034; "PWD Item SEAF Code 5"; Code[20])
        {
            Caption = 'Item SEAF Code 5';
            Description = 'NDBI';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                recLItem: Record Item;
            begin
                IF Type = Type::Item THEN BEGIN
                    recLItem.RESET();
                    recLItem.SETFILTER("PWD SEAF Code 5", '<>%1', '');
                    IF PAGE.RUNMODAL(0, recLItem) = ACTION::LookupOK THEN
                        VALIDATE("No.", recLItem."No.");
                END;
            end;

            trigger OnValidate()
            var
                recLItem: Record Item;
            begin
                recLItem.RESET();
                recLItem.SETRANGE("PWD SEAF Code 5", "PWD Item SEAF Code 5");
                IF recLItem.FINDFIRST() THEN
                    VALIDATE("No.", recLItem."No.");
            end;
        }
        field(50041; "PWD Shelf/Bin No."; Code[10])
        {
            Caption = 'Shelf/Bin No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50050; "PWD NewPage"; Integer)
        {
            Description = 'RE_GHE1.00';
            DataClassification = CustomerContent;
        }
        field(50052; "PWD Provision/materiel"; Option)
        {
            Caption = 'Provision/matériel';
            Description = 'PW2009';
            OptionMembers = " ",Materiel,Provision;
            DataClassification = CustomerContent;
        }
        field(50053; "PWD Coefficient Seafrance"; Decimal)
        {
            BlankZero = true;
            Caption = 'Coefficient Seafrance';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50054; "PWD Quantity Seafrance"; Decimal)
        {
            BlankZero = true;
            Caption = 'Quantity Seafrance';
            DecimalPlaces = 0 : 2;
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(52002; "PWD Propriete Seafrance"; Boolean)
        {
            Caption = 'Propriété Seafrance';
            Description = 'PW2009';
            InitValue = false;
            DataClassification = CustomerContent;
        }
        field(55001; "Realised profit (LCY)"; Decimal)
        {
            Caption = 'Realised profit (LCY)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55002; "% de marge réalisé"; Decimal)
        {
            Caption = '% de marge réalisé';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55007; "PWD DSA No."; Code[10])
        {
            Caption = 'DSA No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55008; "PWD Family"; Code[10])
        {
            Caption = 'Family';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55009; "PWD Trading Brand"; Boolean)
        {
            Caption = 'Trading Brand';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF ("PWD Trading Brand" = TRUE) THEN BEGIN
                    IF "Drop Shipment" = TRUE THEN
                        ERROR(Text1000000002, FIELDCAPTION("PWD Trading Brand"), FIELDCAPTION("Drop Shipment"), FIELDCAPTION("Special Order"));
                    IF "Special Order" = TRUE THEN
                        ERROR(Text1000000002, FIELDCAPTION("PWD Trading Brand"), FIELDCAPTION("Drop Shipment"), FIELDCAPTION("Special Order"));
                END;
                IF xRec."PWD Trading Brand" <> Rec."PWD Trading Brand" THEN
                    IF "Line No." <> 0 THEN
                        UpdateTradingBrade("PWD Trading Brand")
                    ELSE
                        "PWD Trading Brand" := FALSE;
            end;
        }
        field(55010; "PWD Nb Appeal for tenders"; Integer)
        {
            CalcFormula = Count("PWD Appeal for Tenders" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No. document" = FIELD("Line No."), Detail = CONST(true)));
            Caption = 'Nb Appeal for tenders';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55011; "PWD Nb Purchase Quote"; Integer)
        {
            CalcFormula = Count("Purchase Line" WHERE("PWD Sales Type Doc Appeal tenders" = FIELD("Document Type"), "PWD Sales No. Appeal Tenders" = FIELD("Document No."), "PWD Sales Line No. Appeal Tenders" = FIELD("Line No."), "Document Type" = CONST(Quote)));
            Caption = 'Nb Purchase Quote';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55012; "PWD Order Trading brand"; Boolean)
        {
            Caption = 'Order Trading Brand';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetItem(Item);
            end;
        }
        field(55013; "PWD Trad. Brand Order Purch No."; Code[20])
        {
            Caption = 'Trad. Brand Order Purch No.';
            Description = 'PW2009';
            TableRelation = IF ("PWD Trading Brand" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(55014; "PWD Trad. Br Order Purch. Line No."; Integer)
        {
            Caption = 'Trad. Br Order Purch. Line No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55020; "PWD Quantity Ordered Purch."; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document Type" = CONST(Order), "Document No." = FIELD("PWD Trad. Brand Order Purch No."), "Line No." = FIELD("PWD Trad. Br Order Purch. Line No.")));
            Caption = 'Quantity Ordered Purch.';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55021; "PWD Quantity Receipted Purch."; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purch. Rcpt. Line".Quantity WHERE("PWD Sales Type Doc Appeal tenders" = FIELD("Document Type"), "PWD Sales No. Appeal Tenders" = FIELD("Document No."), "PWD Sales Line No. Appeal Tenders" = FIELD("Line No.")));
            Caption = 'Quantity Receipted Purch.';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55023; "PWD Buffer Qty Available"; Decimal)
        {
            Caption = 'Tampon qté dispo';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55024; "PWD Linked Sales Line"; Integer)
        {
            Caption = 'Ligne vente liée';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55025; "PWD Adjmt Prepared Qty"; Decimal)
        {
            Caption = 'Adjmt Prepared Qty';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55027; "PWD Health Certificate Required"; Boolean)
        {
            Caption = 'Health Certificate Required';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55028; "PWD Conformity Certificate"; Boolean)
        {
            Caption = 'Conformity Certificate';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55029; "PWD Technical Card"; Boolean)
        {
            Caption = 'Technical Card';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55030; "PWD Butchery"; Boolean)
        {
            Caption = 'Butchery';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55031; "PWD Previous Line No"; Integer)
        {
            Caption = 'Previous Line No';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55033; "PWD User Id"; Code[50])
        {
            Caption = 'User Id';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55034; "PWD Quantity to prepare"; Decimal)
        {
            Caption = 'Quantity to prepare';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55035; "PWD Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55036; "PWD Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55037; "PWD Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55038; "PWD Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55039; "PWD Planned Receipt Date"; Date)
        {
            Caption = 'Planned Receipt Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55040; "PWD Countermark Location"; Boolean)
        {
            Caption = 'Countermark Location';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55041; "PWD Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            Description = 'PW2009';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
            DataClassification = CustomerContent;
        }
        field(55042; "PWD Code ventilation article"; Code[10])
        {
            Caption = 'Code ventilation aticle';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55043; "PWD Family Code"; Code[20])
        {
            Caption = 'Code famille';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55044; "PWD Quantity Ordered Sp. Order"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document Type" = CONST(Order), "Special Order Sales No." = FIELD("Document No."), "Special Order Sales Line No." = FIELD("Line No.")));
            Caption = 'Quantity Ordered Purch.';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55046; "PWD Quantity Receipted Sp. Order"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purch. Rcpt. Line".Quantity WHERE("Special Order Sales No." = FIELD("Document No."), "Special Order Sales Line No." = FIELD("Line No.")));
            Caption = 'Quantity Receipted Purch.';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55047; "PWD National Add. Code"; Code[19])
        {
            Caption = 'National Add. Code';
            Description = 'PW2009';
            TableRelation = "PWD National Add. Code";
            DataClassification = CustomerContent;
        }
        field(55048; "PWD Monthly Code"; Code[10])
        {
            Caption = 'Monthly Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55049; "PWD Quantite initiale"; Decimal)
        {
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55050; "Cle (restitution)"; Code[20])
        {
            Caption = 'Restitution Key';
            Description = 'PW2009';
            TableRelation = "PWD Item Restitution".Cle;
            DataClassification = CustomerContent;
        }
        field(55051; "PWD Designation ENU"; Text[50])
        {
            Caption = 'Désignation ENU';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55052; "PWD Sell-to Country Code"; Code[10])
        {
            Caption = 'Sell-to Country Code';
            Description = 'PW2009';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(60000; "PWD DCG Tariff No."; Code[20])
        {
            Caption = 'DCG Tariff No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(61000; "PWD KPI"; BLOB)
        {
            Caption = 'Alerte';
            Description = 'GHE-RE1.00';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(70000; "Valeur douane (correction)"; Decimal)
        {
            Caption = 'Valeur douane (correction)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70010; "Methode de Calcul (prestation)"; Text[30])
        {
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70011; "Reference Calcul (prestation)"; Text[30])
        {
            Caption = 'Référence Calcul (prestation)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70012; "PWD No. DOC saisie presta"; Code[20])
        {
            Caption = 'N°DOC saisie presta';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70013; "PWD Code prestation"; Code[10])
        {
            Caption = 'Code prestation presta';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70014; "PWD Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur presta';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70015; "PWD preparation to recalculate"; Boolean)
        {
            Caption = 'préparation à re-calculer';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70016; "PWD loc. Code for prepa to recalc."; Code[10])
        {
            Caption = 'Code mag. pour prépa recalc.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70017; "PWD Specific Cost"; Boolean)
        {
            Caption = 'Coût spécifique';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70018; "PWD SEAF Code"; Integer)
        {
            BlankZero = true;
            Caption = 'Code SEAF';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key50000; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key50001; "Document Type", "Bill-to Customer No.", "Currency Code")
        {
            SumIndexFields = "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)", "Return Rcd. Not Invd. (LCY)";
        }
        key(Key50002; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Location Code", "Shipment Date")
        {
            Enabled = false;
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key50003; "Document Type", "Bill-to Customer No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Currency Code")
        {
            Enabled = false;
            SumIndexFields = "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
        key(Key50004; "Document Type", "Sell-to Customer No.")
        {
        }
        key(Key50005; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Bin Code", "Shipment Date", "Quantity Shipped")
        {
            //SumIndexFields = "Outstanding Qty. (Base)","PWD Prepared Quantity (Base)";
        }
        key(Key50006; "PWD Manifest Category")
        {
        }
        key(Key50007; "Document Type", "Document No.", "Requested Delivery Date")
        {
        }
        key(Key50008; "PWD SEAF Code")
        {
        }
    }
    procedure VerifChange()
    begin
        IF "PWD Trading Brand" = FALSE THEN
            EXIT;

        IF xRec.Type <> Rec.Type THEN
            ERROR(Text1000000003, FIELDCAPTION(Type));
        IF xRec."No." <> Rec."No." THEN
            ERROR(Text1000000003, FIELDCAPTION("No."));
        IF xRec.Quantity <> Rec.Quantity THEN
            ERROR(Text1000000003, FIELDCAPTION(Quantity));
        IF xRec."Unit of Measure Code" <> Rec."Unit of Measure Code" THEN
            ERROR(Text1000000003, FIELDCAPTION("Unit of Measure Code"));
    end;

    local procedure GetCallCust()
    begin
        IF "PWD Call No." <> '' THEN
            RecCall.GET("PWD Call No.");
    end;

    procedure UpdateTradingBrade(create: Boolean)
    begin
        //ToDo
        /*
        IF create = TRUE THEN
            GetSalesOrder.Create(Rec)
        ELSE
            DeleteAppTenders_quote();*/
    end;

    procedure DeleteAppTenders_quote()
    var
        PurchQuoteHeader: Record "Purchase Header";
        PurchQuoteLine: Record "Purchase Line";
        PurchQuoteLine2: Record "Purchase Line";
        AppTenders: Record "PWD Appeal for Tenders";
    begin

        //------------------------------------------------------------------//
        //*** ajout sca - c2a - Contremarque - suppression appel d'offre et demande de prix.
        AppTenders.SETRANGE("Document Type", "Document Type");
        AppTenders.SETRANGE("Document No.", "Document No.");
        AppTenders.SETRANGE("Line No. document", "Line No.");
        IF AppTenders.FIND('-') THEN
            AppTenders.DELETEALL();

        CALCFIELDS("PWD Nb Purchase Quote");
        IF "PWD Nb Purchase Quote" <> 0 THEN
            ERROR(Text1000000001, "PWD Nb Purchase Quote");

        PurchQuoteLine.SETCURRENTKEY("PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders");
        PurchQuoteLine.SETRANGE("PWD Sales Type Doc Appeal tenders", "Document Type".AsInteger());
        PurchQuoteLine.SETRANGE("PWD Sales No. Appeal Tenders", "Document No.");
        PurchQuoteLine.SETRANGE("PWD Sales Line No. Appeal Tenders", "Line No.");

        IF PurchQuoteLine.COUNT <> 0 THEN BEGIN
            PurchQuoteLine.FIND('-');
            REPEAT

                PurchQuoteLine2.SETRANGE("Document Type", PurchQuoteLine."Document Type");
                PurchQuoteLine2.SETRANGE("Document No.", PurchQuoteLine."Document No.");
                PurchQuoteLine.DELETE();
                //ToDo
                //DimMgt.DeleteDocDim(DATABASE::"Purchase Line", PurchQuoteLine."Document Type", PurchQuoteLine."Document No.",
                // PurchQuoteLine."Line No.");

                //*** si plus de ligne on supprime l'entete
                IF PurchQuoteLine2.COUNT = 0 THEN BEGIN
                    PurchQuoteHeader.GET(PurchQuoteLine."Document Type", PurchQuoteLine."Document No.");
                    PurchQuoteHeader.DELETE();
                END;
            UNTIL PurchQuoteLine.NEXT() = 0;
        END;
    end;

    procedure Delete_Purchquote(From_salesLine: Record "Sales Line")
    var
        PurchQuoteHeader: Record "Purchase Header";
        PurchQuoteLine: Record "Purchase Line";
        PurchQuoteLine2: Record "Purchase Line";
        AppTenders: Record "PWD Appeal for Tenders";
    begin

        //*** ajout sca - Contremarque - c2a - suppression appel d'offre et demande de prix.
        AppTenders.SETRANGE("Document Type", "Document Type");
        AppTenders.SETRANGE("Document No.", "Document No.");
        AppTenders.SETRANGE("Line No. document", "Line No.");
        IF AppTenders.FIND('-') THEN
            AppTenders.DELETEALL();

        PurchQuoteLine.SETCURRENTKEY("PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders");

        PurchQuoteLine.SETRANGE("PWD Sales Type Doc Appeal tenders", From_salesLine."Document Type".AsInteger());
        PurchQuoteLine.SETRANGE("PWD Sales No. Appeal Tenders", From_salesLine."Document No.");
        PurchQuoteLine.SETRANGE("PWD Sales Line No. Appeal Tenders", From_salesLine."Line No.");

        IF PurchQuoteLine.COUNT <> 0 THEN BEGIN
            PurchQuoteLine.FIND('-');
            REPEAT

                PurchQuoteLine2.SETRANGE("Document Type", PurchQuoteLine."Document Type");
                PurchQuoteLine2.SETRANGE("Document No.", PurchQuoteLine."Document No.");

                PurchQuoteLine.DELETE(TRUE);

                //*** si plus de ligne on supprime l'entete
                IF PurchQuoteLine2.COUNT = 0 THEN BEGIN
                    PurchQuoteHeader.GET(PurchQuoteLine."Document Type", PurchQuoteLine."Document No.");
                    PurchQuoteHeader.DELETE(TRUE);
                END;
            UNTIL PurchQuoteLine.NEXT() = 0;
        END;
    end;

    procedure CheckavailforPriorityLocation(CalledbyFieldNo: Integer; SalesLine: Record "Sales Line"; Deletion: Boolean)
    var
        SalesHeader: Record "Sales Header";
        NetChange: Boolean;
        AvailableInventory: Decimal;
        OldItemNetChange: Decimal;
    begin
        GetSalesHeader();
        AvailableInventory := 0;
        IF (Type = Type::Item) AND (Nonstock = FALSE) AND ("No." <> '') THEN BEGIN
            GetItem(Item);

            IF xRec."Outstanding Qty. (Base)" = 0 THEN
                NetChange := FALSE;
            IF NetChange = TRUE THEN
                OldItemNetChange := xRec."Outstanding Qty. (Base)" - "Outstanding Qty. (Base)";
            RecLocPriority.RESET();
            RecLocPriority.SETCURRENTKEY("PWD Call Type Code", "PWD Location priority"); //gte
            RecLocPriority.ASCENDING(TRUE); //gte
            SalesHeader.Get(Rec."Document Type", Rec."Document No.");
            RecLocPriority.SETRANGE(RecLocPriority."PWD Call Type Code", SalesHeader."PWD Call Type");
            IF RecLocPriority.FIND('-') THEN BEGIN
                REPEAT
                    AvailableInventory += CalculateNeed(RecLocPriority."PWD Location code", "Shipment Date");
                UNTIL RecLocPriority.NEXT() = 0;

                IF NetChange = TRUE THEN
                    AvailableInventory := Item."PWD Buffer Qty Available" + OldItemNetChange ELSE
                    AvailableInventory := AvailableInventory - "Outstanding Qty. (Base)";
                IF Deletion = TRUE THEN
                    Item."PWD Buffer Qty Available" := Item."PWD Buffer Qty Available" + "Outstanding Qty. (Base)" ELSE
                    Item."PWD Buffer Qty Available" := AvailableInventory;
                Item.MODIFY();

                IF Deletion = FALSE THEN
                    IF AvailableInventory < 0 THEN
                        IF CalledbyFieldNo = CurrFieldNo THEN
                            MESSAGE(Text1000000004, "No.", Description);
            END;
        END;
    end;

    local procedure CalculateNeed(LocationCode: Code[10]; ShipmentDate: Date): Decimal
    var
        GrossRequirement: Decimal;
        PlannedOrderReceipt: Decimal;
        PlannedOrderReleases: Decimal;
        ScheduledReceipt: Decimal;
    begin
        GetItem(Item);
        Item.SETRANGE("No.", Item."No.");
        Item.SETRANGE("Date Filter", 0D, ShipmentDate);
        Item.SETRANGE("Location Filter", LocationCode);
        Item.CALCFIELDS(
          "Qty. on Purch. Order",
          "Qty. on Sales Order",
          Inventory,
          "Purch. Req. Receipt (Qty.)",
          "Purch. Req. Release (Qty.)");

        GrossRequirement := Item."Qty. on Sales Order";
        PlannedOrderReceipt := Item."Purch. Req. Receipt (Qty.)";
        ScheduledReceipt := Item."Qty. on Purch. Order";
        PlannedOrderReleases := Item."Purch. Req. Release (Qty.)";

        EXIT(Item.Inventory + PlannedOrderReceipt + ScheduledReceipt - GrossRequirement);
    end;

    procedure CtrlUnitPrice()
    var
        Location: Record Location;
        BottomPrice: Decimal;
    begin
        //*** Controle prix unitaire > prix plancher de l'article
        //>>SOBI
        IF BooGHideMessage THEN EXIT;
        //<<SOBI
        IF Type = Type::Item THEN
            IF Item.GET("No.") THEN
                IF Location.GET("Location Code") AND (Location."PWD Controle du prix plancher") THEN BEGIN

                    BottomPrice := Item."PWD Bottom Price";
                    //ToDo
                    /*IF SalesHeader."Currency Code" <> '' THEN
                        BottomPrice :=
                         ROUND(
                           CurrExchRate.ExchangeAmtLCYToFCY(
                             GetDate(), SalesHeader."Currency Code",
                             BottomPrice, SalesHeader."Currency Factor"),
                             Currency."Unit-Amount Rounding Precision");*/
                    IF "Unit Price" < BottomPrice THEN
                        MESSAGE(Text1000000023, "Unit Price", BottomPrice);
                END;
    end;

    procedure CalcRealisedProfit()
    begin
        IF "Currency Code" = '' THEN BEGIN
            "Realised profit (LCY)" := "Line Amount" - Quantity * "Unit Cost (LCY)";
            IF "Line Amount" <> 0 THEN
                "% de marge réalisé" := (("Line Amount" - Quantity * "Unit Cost (LCY)") / "Line Amount") * 100;
        END;
    end;

    procedure GetLinkedSalesLine(): Integer
    begin
        IF Type = Type::" " THEN BEGIN
            LinkedtoCommentSalesLine.RESET();
            LinkedtoCommentSalesLine.SETRANGE(LinkedtoCommentSalesLine."Document Type", LinkedtoCommentSalesLine."Document Type"::Order);
            LinkedtoCommentSalesLine.SETRANGE(LinkedtoCommentSalesLine."Document No.", "Document No.");
            LinkedtoCommentSalesLine.SETFILTER(LinkedtoCommentSalesLine.Type, '<>%1', LinkedtoCommentSalesLine.Type::" ");
            LinkedtoCommentSalesLine.SETFILTER(LinkedtoCommentSalesLine."Line No.", '<%1', "Line No.");
            IF LinkedtoCommentSalesLine.FIND('+') THEN
                EXIT(LinkedtoCommentSalesLine."Line No.");
        END ELSE
            "PWD Previous Line No" := "Line No.";
    end;

    procedure FctPushVendorAndUnitCostItem()
    var
        RecLItem: Record Item;
        RecLPurchasePrice: Record "Purchase Price";
    begin
        TESTFIELD(Type, Type::Item);
        RecLPurchasePrice.RESET();
        RecLPurchasePrice.SETRANGE("Item No.", "No.");
        IF PAGE.RUNMODAL(PAGE::"Get Purchase Price", RecLPurchasePrice) = ACTION::LookupOK THEN BEGIN
            VALIDATE("Unit Cost (LCY)", RecLPurchasePrice."Direct Unit Cost");
            VALIDATE("PWD Vendor No.", RecLPurchasePrice."Vendor No.");
            MODIFY();
            IF RecLItem.GET("No.") THEN BEGIN
                RecLItem.VALIDATE("Vendor No.", RecLPurchasePrice."Vendor No.");
                RecLItem.MODIFY();
            END;
        END;
    end;

    procedure FctSetHideMessage(BooPHideMessage: Boolean)
    begin
        BooGHideMessage := BooPHideMessage;
    end;

    var

        Item: Record Item;
        RecCall: Record "PWD Call";
        RecLocPriority: Record "PWD Location Priority";
        LinkedtoCommentSalesLine: Record "Sales Line";
        SetGetFunctions: codeunit "PWD Set/Get Functions";

        //ToDo
        //  GetSalesOrder: Report "Get Sales Orders/Vendor -TrB";
        BooGHideMessage: Boolean;
        MemLineDiscount: Decimal;
        MemUnitPrice: Decimal;
        Text1000000001: Label 'You can''t delete this line.\There ''re #1###### purchase quote attached.';
        Text1000000002: Label 'Selet 1 option. %1 / %2 / %3';
        Text1000000003: Label 'You can''t modify the field %1 (Trading Brand)';
        Text1000000004: Label 'Available Inventory not sufficient for Item No %1 (%2) :';
        Text1000000023: Label 'Unit price (%1) is smaller than bottom price (%2)';
        Text1000000026: Label 'You cannot prepare a greater quantity than the ordered one !';
}
