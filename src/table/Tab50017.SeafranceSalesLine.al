table 50017 "PWD Seafrance Sales Line"
{
    Caption = 'Sales Line';
    DrillDownPageID = "Sales Lines";
    LookupPageID = "Sales Lines";
    PasteIsValid = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "PWD Seafrance Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RecLSeafranceSalesHeader: Record "PWD Seafrance Sales Header";
                CstL001: Label 'It is not possible to top up lines.';
                CstL002: Label 'Warning, this order is already controlled. The modification of the article will cancel the control of this last. Do you like to go on?';
                CstL003: Label 'Cancelled treatment.';
            begin
                //>>FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009
                IF Type = Type::" " THEN
                    ERROR(CstL001);

                IF xRec."No." <> "No." THEN BEGIN
                    "SF Description" := '';
                    "SF Unit of Measure" := '';
                    IF "New Item" THEN
                        "New Item" := FALSE;
                    IF NOT Rec.MODIFY() THEN;
                    RecLSeafranceSalesHeader.GET("Document Type", "Document No.");
                    IF RecLSeafranceSalesHeader."Controlled Order" THEN
                        IF CONFIRM(CstL002, FALSE) THEN BEGIN
                            RecLSeafranceSalesHeader."Controlled Order" := FALSE;
                            RecLSeafranceSalesHeader.MODIFY();
                        END ELSE
                            ERROR(CstL003);
                END;
                //<<FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009
            end;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group" ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
            DataClassification = CustomerContent;
        }
        field(10; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
            begin
            end;
        }
        field(11; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(12; "Description 2"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("No.")));
            Caption = 'Description 2';
            FieldClass = FlowField;
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(18; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            DataClassification = CustomerContent;
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
            DataClassification = CustomerContent;
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
            begin
            end;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(42; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            Editable = false;
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(46; "Appl.-to Job Entry"; Integer)
        {
            Caption = 'Appl.-to Job Entry';
            DataClassification = CustomerContent;
        }
        field(47; "Phase Code"; Code[10])
        {
            Caption = 'Phase Code';
            DataClassification = CustomerContent;
        }
        field(48; "Task Code"; Code[10])
        {
            Caption = 'Task Code';
            DataClassification = CustomerContent;
        }
        field(49; "Step Code"; Code[10])
        {
            Caption = 'Step Code';
            DataClassification = CustomerContent;
        }
        field(50; "Job Applies-to ID"; Code[20])
        {
            Caption = 'Job Applies-to ID';
            DataClassification = CustomerContent;
        }
        field(51; "Apply and Close (Job)"; Boolean)
        {
            Caption = 'Apply and Close (Job)';
            DataClassification = CustomerContent;
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
            DataClassification = CustomerContent;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
            begin
            end;
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
            begin
            end;
        }
        field(60; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(71; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(72; "Purch. Order Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order), "Document No." = FIELD("Purchase Order No."));
            DataClassification = CustomerContent;
        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(77; "VAT Calculation Type"; Enum "Tax Calculation Type")
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."));
            DataClassification = CustomerContent;
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(95; "Reserved Quantity"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No."), "Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Reservation Status" = CONST("Reservation")));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
            end;
        }
        field(96; Reserve; Enum "Reserve Method")
        {
            Caption = 'Reserve';
            DataClassification = CustomerContent;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            Caption = 'Blanket Order No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            DataClassification = CustomerContent;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"), "Document No." = FIELD("Blanket Order No."));
            DataClassification = CustomerContent;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            DataClassification = CustomerContent;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(5405; Planned; Boolean)
        {
            Caption = 'Planned';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            CalcFormula = Lookup(Item."Sales Unit of Measure" WHERE("No." = FIELD("No.")));
            Caption = 'Unit of Measure Code';
            FieldClass = FlowField;

            trigger OnValidate()
            var
            begin
            end;
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Document No."), "Source Ref. No." = FIELD("Line No."), "Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
            DataClassification = CustomerContent;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
            DataClassification = CustomerContent;
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
            DataClassification = CustomerContent;
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
            DataClassification = CustomerContent;
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
            DataClassification = CustomerContent;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = Exist("Item Substitution" WHERE(Type = CONST(Item), "No." = FIELD("No."), "Substitute Type" = CONST(Item)));
            Caption = 'Substitution Available';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5703; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            TableRelation = IF (Type = CONST(Item)) Item;
            DataClassification = CustomerContent;
        }
        field(5704; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
            DataClassification = CustomerContent;
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = CustomerContent;
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
            DataClassification = CustomerContent;
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
            DataClassification = CustomerContent;
        }
        field(5709; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
            DataClassification = CustomerContent;
        }
        // field(5712; "Product Group Code"; Code[10])
        // {
        //     Caption = 'Product Group Code';
        //     TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        //     DataClassification = CustomerContent;
        // }
        field(5713; "Special Order"; Boolean)
        {
            Caption = 'Special Order';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5714; "Special Order Purchase No."; Code[20])
        {
            Caption = 'Special Order Purchase No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(5715; "Special Order Purch. Line No."; Integer)
        {
            Caption = 'Special Order Purch. Line No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order), "Document No." = FIELD("Special Order Purchase No."));
            DataClassification = CustomerContent;
        }
        field(5750; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("Document No."), "Source Line No." = FIELD("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
            DataClassification = CustomerContent;
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';
            DataClassification = CustomerContent;
        }
        field(5794; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5795; "Planned Shipment Date"; Date)
        {
            Caption = 'Planned Shipment Date';
            DataClassification = CustomerContent;
        }
        field(5796; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
            DataClassification = CustomerContent;
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(5801; "Qty. to Assign"; Decimal)
        {
            CalcFormula = Sum("Item Charge Assignment (Sales)"."Qty. to Assign" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.")));
            Caption = 'Qty. to Assign';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5802; "Qty. Assigned"; Decimal)
        {
            CalcFormula = Sum("Item Charge Assignment (Sales)"."Qty. Assigned" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.")));
            Caption = 'Qty. Assigned';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5803; "Return Qty. to Receive"; Decimal)
        {
            Caption = 'Return Qty. to Receive';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5804; "Return Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5805; "Return Qty. Rcd. Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Rcd. Not Invd.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5807; "Return Rcd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Rcd. Not Invd.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5808; "Return Rcd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Return Rcd. Not Invd. (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
            Caption = 'Return Qty. Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
            Caption = 'Return Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5900; "Service Contract No."; Code[20])
        {
            Caption = 'Service Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));
            DataClassification = CustomerContent;
        }
        field(5901; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            DataClassification = CustomerContent;
        }
        field(5902; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No." WHERE("Customer No." = FIELD("Sell-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
            Caption = 'Appl.-to Service Entry';
            DataClassification = CustomerContent;
        }
        field(5904; "Service Item Line No."; Integer)
        {
            Caption = 'Service Item Line No.';
            DataClassification = CustomerContent;
        }
        field(5907; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            Editable = false;
            TableRelation = "Service Price Adjustment Group";
            DataClassification = CustomerContent;
        }
        field(5909; "BOM Item No."; Code[20])
        {
            Caption = 'BOM Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(6600; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            Caption = 'Return Receipt Line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
            DataClassification = CustomerContent;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
            DataClassification = CustomerContent;
        }
        field(50000; "Call No."; Code[10])
        {
            Caption = 'Call No.';
            TableRelation = "PWD Call"."Call No.";
            DataClassification = CustomerContent;
        }
        field(50001; "Parcel Nb."; Decimal)
        {
            Caption = 'Parcel Nb.';
            DataClassification = CustomerContent;
        }
        field(50002; "Unit per Parcel"; Decimal)
        {
            Caption = 'Unit per Parcel';
            DataClassification = CustomerContent;
        }
        field(50003; "Output Date"; Date)
        {
            Caption = 'Output Date';
            DataClassification = CustomerContent;
        }
        field(50004; "Health Approval No."; Code[20])
        {
            Caption = 'Health Approval No.';
            DataClassification = CustomerContent;
        }
        field(50005; Marked; Code[30])
        {
            Caption = 'Mark';
            DataClassification = CustomerContent;
        }
        field(50006; "Origin Area"; Code[10])
        {
            Caption = 'Origin Area';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50007; "Code Continent"; Code[10])
        {
            Caption = 'Continental Code';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(9), "Field ID" = CONST(50001));
            DataClassification = CustomerContent;
        }
        field(50010; "Origin Certified"; Boolean)
        {
            Caption = 'Origin Certified';
            DataClassification = CustomerContent;
        }
        field(50011; Manifest; Boolean)
        {
            Caption = 'Manifest';
            DataClassification = CustomerContent;
        }
        field(50012; "Manifest Category"; Enum "Manifest Category")
        {
            Caption = 'Manifest Category';
            DataClassification = CustomerContent;
        }
        field(50013; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(50014; "Certificate Transit No."; Code[30])
        {
            Caption = 'Certificate Transit No.';
            DataClassification = CustomerContent;
        }
        field(50015; "Call Type"; Code[10])
        {
            Caption = 'Call Type';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(50016; "Preparation in Process"; Boolean)
        {
            Caption = 'Preparation in process';
            DataClassification = CustomerContent;
        }
        field(50017; "Prepared Quantity"; Decimal)
        {
            Caption = 'Prepared Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(50018; "Prepared Quantity (Base)"; Decimal)
        {
            Caption = 'Prepared Quantity (Base)';
            DataClassification = CustomerContent;
        }
        field(50019; "Order Line Prepared"; Boolean)
        {
            Caption = 'Order Line Prepared';
            DataClassification = CustomerContent;
        }
        field(50020; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(50021; "SF Description"; Text[50])
        {
            Caption = 'SF Description';
            Description = 'GHES1.01';
            DataClassification = CustomerContent;
        }
        field(50022; "SF Unit of Measure"; Code[10])
        {
            Caption = 'SF Unit of Measure';
            Description = 'GHES1.01';
            DataClassification = CustomerContent;
        }
        field(50023; "New Item"; Boolean)
        {
            Caption = 'New Item';
            Description = 'GHES1.01';
            DataClassification = CustomerContent;
        }
        field(50024; "Seafrance Order Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Seafrance Order Line No.';
            Description = 'GHES1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50041; "Shelf/Bin No."; Code[10])
        {
            Caption = 'Shelf/Bin No.';
            DataClassification = CustomerContent;
        }
        field(50052; "Provision/materiel"; enum "Provision/materiel")
        {
            Caption = 'Provision/materiel';
            DataClassification = CustomerContent;
        }
        field(52002; "Propriete Seafrance"; Boolean)
        {
            Caption = 'Propriete Seafrance';
            InitValue = false;
            DataClassification = CustomerContent;
        }
        field(55001; "Realised profit (LCY)"; Decimal)
        {
            Caption = 'Realised profit (LCY)';
            DataClassification = CustomerContent;
        }
        field(55002; "% de marge realise"; Decimal)
        {
            Caption = '% de marge realise';
            DataClassification = CustomerContent;
        }
        field(55007; "DSA No."; Code[10])
        {
            Caption = 'DSA No.';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(55008; Family; Code[10])
        {
            Caption = 'Family';
            DataClassification = CustomerContent;
        }
        field(55009; "Trading Brand"; Boolean)
        {
            Caption = 'Trading Brand';
            Description = 'Contremarque - Contremarque';
            DataClassification = CustomerContent;
        }
        field(55010; "Nb Appeal for tenders"; Integer)
        {
            CalcFormula = Count("PWD Appeal for Tenders" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No. document" = FIELD("Line No."), Detail = CONST(True)));
            Caption = 'Nb Appeal for tenders';
            Description = 'Contremarque - Nb Appel d''offre';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55011; "Nb Purchase Quote"; Integer)
        {
            CalcFormula = Count("Purchase Line" WHERE("PWD SalesTypeDocAppealTend." = FIELD("Document Type"), "PWD Sales No. Appeal Tenders" = FIELD("Document No."), "PWD SalesLineNoAppealTenders" = FIELD("Line No."), "Document Type" = CONST(Quote)));
            Caption = 'Nb Purchase Quote';
            Description = 'Contremarque';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55012; "Order Trading brand"; Boolean)
        {
            Caption = 'Order Trading Brand';
            DataClassification = CustomerContent;
        }
        field(55013; "Trad. Brand Order Purch No."; Code[20])
        {
            Caption = 'Trad. Brand Order Purch No.';
            Description = 'Contremarque';
            TableRelation = IF ("Trading Brand" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(55014; "Trad. Br Order Purch. Line No."; Integer)
        {
            Caption = 'Trad. Br Order Purch. Line No.';
            Description = 'Contremarque';
            DataClassification = CustomerContent;
        }
        field(55020; "Quantity Ordered Purch."; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document Type" = CONST(Order), "Document No." = FIELD("Trad. Brand Order Purch No."), "Line No." = FIELD("Trad. Br Order Purch. Line No.")));
            Caption = 'Quantity Ordered Purch.';
            Description = 'Contremarque';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55021; "Quantity Receipted Purch."; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purch. Rcpt. Line".Quantity WHERE("PWD SalesTypeDocAppealTend" = FIELD("Document Type"), "PWD Sales No. Appeal Tenders" = FIELD("Document No."), "PWD SalesLineNoAppealTenders" = FIELD("Line No.")));
            Caption = 'Quantity Receipted Purch.';
            Description = 'Contremarque';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55023; "Buffer Qty Available"; Decimal)
        {
            Caption = 'Buffer Qty Available';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55024; "Linked Sales Line"; Integer)
        {
            Caption = 'Linked Sales Line';
            Description = 'Ligne Vente Rattachée à la ligne de type commentaire';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55025; "Adjmt Prepared Qty"; Decimal)
        {
            Caption = 'Adjmt Prepared Qty';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55027; "Health Certificate Required"; Boolean)
        {
            Caption = 'Health Certificate Required';
            DataClassification = CustomerContent;
        }
        field(55028; "Conformity Certificate"; Boolean)
        {
            Caption = 'Conformity Certificate';
            DataClassification = CustomerContent;
        }
        field(55029; "Technical Card"; Boolean)
        {
            Caption = 'Technical Card';
            DataClassification = CustomerContent;
        }
        field(55030; Butchery; Boolean)
        {
            Caption = 'Butchery';
            DataClassification = CustomerContent;
        }
        field(55031; "Previous Line No"; Integer)
        {
            Caption = 'Previous Line No';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55033; "User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
        field(55034; "Quantity to prepare"; Decimal)
        {
            Caption = 'Quantity to prepare';
            Description = 'Champ servant à lancer le validate du champ quantité';
            DataClassification = CustomerContent;
        }
        field(55035; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            DataClassification = CustomerContent;
        }
        field(55036; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
            DataClassification = CustomerContent;
        }
        field(55037; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            DataClassification = CustomerContent;
        }
        field(55038; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
            DataClassification = CustomerContent;
        }
        field(55039; "Planned Receipt Date"; Date)
        {
            Caption = 'Planned Receipt Date';
            DataClassification = CustomerContent;
        }
        field(55040; "Countermark Location"; Boolean)
        {
            Caption = 'Countermark Location';
            DataClassification = CustomerContent;
        }
        field(55041; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
            DataClassification = CustomerContent;
        }
        field(55042; "Code ventilation article"; Code[10])
        {
            Caption = 'Code ventilation article';
            DataClassification = CustomerContent;
        }
        field(55043; "Family Code"; Code[20])
        {
            Caption = 'Family Code';
            DataClassification = CustomerContent;
        }
        field(55044; "Quantity Ordered Sp. Order"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document Type" = CONST(Order), "Special Order Sales No." = FIELD("Document No."), "Special Order Sales Line No." = FIELD("Line No.")));
            Caption = 'Quantity Ordered Purch.';
            Description = 'Contremarque';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55046; "Quantity Receipted Sp. Order"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Purch. Rcpt. Line".Quantity WHERE("Special Order Sales No." = FIELD("Document No."), "Special Order Sales Line No." = FIELD("Line No.")));
            Caption = 'Quantity Receipted Purch.';
            Description = 'Contremarque';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55047; "National Add. Code"; Code[19])
        {
            Caption = 'National Add. Code';
            Description = 'Navita360';
            TableRelation = "PWD National Add. Code";
            DataClassification = CustomerContent;
        }
        field(55048; "Monthly Code"; Code[10])
        {
            Caption = 'Monthly Code';
            Description = 'Flag and country Table';
            DataClassification = CustomerContent;
        }
        field(55049; "Quantite initiale"; Decimal)
        {
            Caption = 'Quantite initiale';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55050; "Cle (restitution)"; Code[20])
        {
            Caption = 'Restitution Key';
            Description = 'Navita360';
            TableRelation = "PWD Item Restitution".Cle;
            DataClassification = CustomerContent;
        }
        field(55051; "Designation ENU"; Text[50])
        {
            Caption = 'Designation ENU';
            DataClassification = CustomerContent;
        }
        field(55052; "Sell-to Country Code"; Code[10])
        {
            Caption = 'Sell-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(60000; "DCG Tariff No."; Code[20])
        {
            Caption = 'DCG Tariff No.';
            DataClassification = CustomerContent;
        }
        field(70000; "Valeur douane (correction)"; Decimal)
        {
            Caption = 'Valeur douane (correction)';
            DataClassification = CustomerContent;
        }
        field(70010; "Methode de Calcul (prestation)"; Text[30])
        {
            Caption = 'Methode de Calcul (prestation)';
            DataClassification = CustomerContent;
        }
        field(70011; "Reference Calcul (prestation)"; Text[30])
        {
            Caption = 'Reference Calcul (prestation)';
            DataClassification = CustomerContent;
        }
        field(70012; "No.DOC saisie presta"; Code[20])
        {
            Caption = 'No.DOC saisie presta';
            DataClassification = CustomerContent;
        }
        field(70013; "Code prestation"; Code[10])
        {
            Caption = 'Code prestation';
            DataClassification = CustomerContent;
        }
        field(70014; "Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur';
            DataClassification = CustomerContent;
        }
        field(70015; "preparation to recalculate"; Boolean)
        {
            Caption = 'preparation to recalculate';
            DataClassification = CustomerContent;
        }
        field(70016; "loc. Code for prepa to recalc."; Code[10])
        {
            Caption = 'loc. Code for prepa to recalc.';
            DataClassification = CustomerContent;
        }
        field(70017; "Specific Cost"; Boolean)
        {
            Caption = 'Specific Cost';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70018; "SEAF Code"; Integer)
        {
            BlankZero = true;
            Caption = 'SEAF Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
        key(Key2; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key3; "Document Type", "Bill-to Customer No.", "Currency Code")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)", "Return Rcd. Not Invd. (LCY)";
        }
        key(Key4; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Shipment Date")
        {
        }
        key(Key5; "Document Type", "Blanket Order No.", "Blanket Order Line No.")
        {
        }
        key(Key6; "Document Type", "Document No.", "Location Code")
        {
        }
        key(Key7; "Document Type", "Shipment No.", "Shipment Line No.")
        {
        }
        key(Key8; Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type", "Shipment Date")
        {
        }
        key(Key9; "Document Type", "Sell-to Customer No.")
        {
        }
        key(Key10; "Document Type", "Bill-to Customer No.")
        {
            SumIndexFields = "Line Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        RecLSeafranceSalesHeader: Record "PWD Seafrance Sales Header";
        CstL003: Label 'Attention, cette commande est déjà contrôlée. Confirmez-vous la suppression de la ligne ?';
        CstL004: Label 'Traitement annulé.';
    begin
        RecLSeafranceSalesHeader.GET(xRec."Document Type", xRec."Document No.");
        IF RecLSeafranceSalesHeader."Controlled Order" THEN
            IF NOT CONFIRM(CstL003) THEN
                ERROR(CstL004);
    end;
}
