table 70061 "PWD Archived Sales Line"
{
    // Copied from table 5108 (Sales Line Archive)
    //
    // //>>SOBI
    // P3346_0015 RO.LALE REGIE 23/02/2015 : - add field 55041 - Vendor No. - Code20

    Caption = 'Archived Sales Line';
    //TODO Récupérer traduction FRA=Ligne vente archive    DataClassification = CustomerContent;

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
            TableRelation = "PWD Archived Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"),
                                                                "Version No." = FIELD("Version No."));
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
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";
            DataClassification = CustomerContent;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
            DataClassification = CustomerContent;
        }
        field(9; "Quantity Disc. Code"; Code[20])
        {
            Caption = 'Quantity Disc. Code';
            DataClassification = CustomerContent;
        }
        field(10; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(13; "Unit of Measure"; Text[50])
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
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FieldNo("Unit Price"));
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
            DataClassification = CustomerContent;
        }
        field(26; "Quantity Disc. %"; Decimal)
        {
            Caption = 'Quantity Disc. %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
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
            DataClassification = CustomerContent;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
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
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-to Item Entry';
            DataClassification = CustomerContent;
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
        field(42; "Price Group Code"; Code[10])
        {
            Caption = 'Price Group Code';
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(43; "Allow Quantity Disc."; Boolean)
        {
            Caption = 'Allow Quantity Disc.';
            InitValue = true;
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
        field(55; "Cust./Item Disc. %"; Decimal)
        {
            Caption = 'Cust./Item Disc. %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced';
            DataClassification = CustomerContent;
        }
        field(60; "Quantity Shipped"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            DataClassification = CustomerContent;
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            DataClassification = CustomerContent;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            DataClassification = CustomerContent;
        }
        field(71; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(72; "Purch. Order Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                               "Document No." = FIELD("Purchase Order No."));
            DataClassification = CustomerContent;
        }
        field(73; "Drop Shipment"; Boolean)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Drop Shipment';
            DataClassification = CustomerContent;
        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(75; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(77; "VAT Calculation Type"; Enum "Tax Calculation Type")
        {
            Caption = 'VAT Calculation Type';
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
            TableRelation = "PWD Archived Sales Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("Document No."),
                                                                   "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                   "Version No." = FIELD("Version No."));
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
        field(87; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(88; "VAT Clause Code"; Code[20])
        {
            Caption = 'VAT Clause Code';
            TableRelation = "VAT Clause";
            DataClassification = CustomerContent;
        }
        field(89; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(90; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY)';
            DataClassification = CustomerContent;
        }
        field(96; Reserve; Enum "Reserve Method")
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Reserve';
            DataClassification = CustomerContent;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            Caption = 'Blanket Order No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                           "Document No." = FIELD("Blanket Order No."));
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            DataClassification = CustomerContent;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            DataClassification = CustomerContent;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FieldNo("Line Amount"));
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            DataClassification = CustomerContent;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            DataClassification = CustomerContent;
        }
        field(106; "VAT Identifier"; Code[20])
        {
            Caption = 'VAT Identifier';
            DataClassification = CustomerContent;
        }
        field(138; "IC Item Reference No."; Code[50])
        {
            AccessByPermission = TableData "Item Reference" = R;
            Caption = 'IC Item Reference No.';
            DataClassification = CustomerContent;
        }
        field(145; "Pmt. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Pmt. Discount Amount';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
            DataClassification = CustomerContent;
        }
        field(1002; "Job Contract Entry No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            Caption = 'Job Contract Entry No.';
            DataClassification = CustomerContent;
        }
        field(1700; "Deferral Code"; Code[10])
        {
            Caption = 'Deferral Code';
            TableRelation = "Deferral Template"."Deferral Code";
            DataClassification = CustomerContent;
        }
        field(1702; "Returns Deferral Start Date"; Date)
        {
            Caption = 'Returns Deferral Start Date';
            DataClassification = CustomerContent;
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
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
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(5405; Planned; Boolean)
        {
            Caption = 'Planned';
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
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
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            DataClassification = CustomerContent;
        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = Exist("Item Substitution" WHERE(Type = CONST(Item),
                                                           "No." = FIELD("No."),
                                                           "Substitute Type" = CONST(Item)));
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
            ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
#if not CLEAN18
            ObsoleteState = Pending;
            ObsoleteTag = '18.0';
            DataClassification = CustomerContent;
#else
            ObsoleteState = Removed;
            ObsoleteTag = '21.0';
#endif
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
            ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
#if not CLEAN19
            ObsoleteState = Pending;
            ObsoleteTag = '19.0';
            DataClassification = CustomerContent;
#else
            ObsoleteState = Removed;
            ObsoleteTag = '22.0';
#endif
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
            ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
#if not CLEAN19
            ObsoleteState = Pending;
            ObsoleteTag = '19.0';
            DataClassification = CustomerContent;
#else
            ObsoleteState = Removed;
            ObsoleteTag = '22.0';
#endif
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
            ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
#if not CLEAN19
            ObsoleteState = Pending;
            ObsoleteTag = '19.0';
            DataClassification = CustomerContent;
#else
            ObsoleteState = Removed;
            ObsoleteTag = '22.0';
#endif
        }
        field(5709; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code'; //TODO  Récupérer traduction FRA=Code catégorie
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Catalog';
            DataClassification = CustomerContent;
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
            DataClassification = CustomerContent;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            ObsoleteReason = 'Product Groups became first level children of Item Categories.';
            ObsoleteState = Removed;
            ObsoleteTag = '15.0';
            DataClassification = CustomerContent;
        }
        field(5713; "Special Order"; Boolean)
        {
            Caption = 'Special Order';
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
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                               "Document No." = FIELD("Special Order Purchase No."));
            DataClassification = CustomerContent;
        }
        field(5725; "Item Reference No."; Code[50])
        {
            Caption = 'Item Reference No.';
            DataClassification = CustomerContent;
        }
        field(5726; "Item Reference Unit of Measure"; Code[10])
        {
            Caption = 'Reference Unit of Measure';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(5727; "Item Reference Type"; Enum "Item Reference Type")
        {
            Caption = 'Item Reference Type';
            DataClassification = CustomerContent;
        }
        field(5728; "Item Reference Type No."; Code[30])
        {
            Caption = 'Item Reference Type No.';
            DataClassification = CustomerContent;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
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
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Time';
            DataClassification = CustomerContent;
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location = R;
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
            AccessByPermission = TableData "Shipping Agent Services" = R;
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
            AccessByPermission = TableData "Item Charge" = R;
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5807; "Return Amt. Rcd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Amt. Rcd. Not Invd.';
            DataClassification = CustomerContent;
        }
        field(5808; "Ret. Amt. Rcd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Ret. Amt. Rcd. Not Invd. (LCY)';
            DataClassification = CustomerContent;
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
            Caption = 'Return Qty. Received';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
            Caption = 'Return Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5900; "Service Contract No."; Code[20])
        {
            Caption = 'Service Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
                                                                            "Customer No." = FIELD("Sell-to Customer No."),
                                                                            "Bill-to Customer No." = FIELD("Bill-to Customer No."));
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
            DataClassification = CustomerContent;
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            Caption = 'Return Receipt Line No.';
            DataClassification = CustomerContent;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
            DataClassification = CustomerContent;
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
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
        field(50005; Mark; Code[30])
        {
            Caption = 'Mark';
            DataClassification = CustomerContent;
        }
        field(50006; "Origin Area"; Code[10])
        {
            Caption = 'Origin Area';
            DataClassification = CustomerContent;
        }
        field(50013; "Document Date"; Date)
        {
            Caption = 'Date Document';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(50020; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(50052; "Provision/matériel"; Option)
        {
            OptionMembers = " ",Materiel,Provision;
            DataClassification = CustomerContent;
        }
        field(55041; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            Description = 'SOBI';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
            DataClassification = CustomerContent;
        }
        field(55042; "Code ventilation article"; Code[10])
        {
            DataClassification = CustomerContent;
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
        field(70060; "Last Version"; Boolean)
        {
            Caption = 'Last Version';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key6; "Document No.", "Document Type", "Doc. No. Occurrence", "Version No.")
        {
            MaintainSqlIndex = false;
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
    }

    fieldgroups
    {
    }
    var
        DeferralUtilities: Codeunit "Deferral Utilities";
        DimMgt: Codeunit DimensionManagement;

    procedure GetCaptionClass(FieldNumber: Integer): Text[80]
    var
        SalesHeaderArchive: Record "PWD Archived Sales Header";
    begin
        if not SalesHeaderArchive.Get("Document Type", "Document No.") then begin
            SalesHeaderArchive."No." := '';
            SalesHeaderArchive.Init();
        end;
        if SalesHeaderArchive."Prices Including VAT" then
            exit('2,1,' + GetFieldCaption(FieldNumber));

        exit('2,0,' + GetFieldCaption(FieldNumber));
    end;

    local procedure GetFieldCaption(FieldNumber: Integer): Text[100]
    var
        "Field": Record "Field";
    begin
        Field.Get(DATABASE::"Sales Line", FieldNumber);
        exit(Field."Field Caption");
    end;

    procedure ShowDimensions()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', "Document Type", "Document No."));
    end;

    procedure ShowDeferrals()
    begin
        DeferralUtilities.OpenLineScheduleArchive(
            "Deferral Code", "Deferral Document Type"::Sales.AsInteger(),
            "Document Type".AsInteger(), "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.");
    end;

    procedure CopyTempLines(SalesHeaderArchive: Record "PWD Archived Sales Header"; var TempSalesLine: Record "Sales Line" temporary)
    var
        SalesLineArchive: Record "PWD Archived Sales Line";
    begin
        DeleteAll();

        SalesLineArchive.SetRange("Document Type", SalesHeaderArchive."Document Type");
        SalesLineArchive.SetRange("Document No.", SalesHeaderArchive."No.");
        SalesLineArchive.SetRange("Version No.", SalesHeaderArchive."Version No.");
        OnCopyTempLinesOnAfterSalesLineArchiveSetFilters(SalesLineArchive, SalesHeaderArchive);
        if SalesLineArchive.FindSet() then
            repeat
                Init();
                Rec := SalesLineArchive;
                Insert();
                TempSalesLine.TransferFields(SalesLineArchive);
                TempSalesLine.Insert();
            until SalesLineArchive.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCopyTempLinesOnAfterSalesLineArchiveSetFilters(var SalesLineArchive: Record "PWD Archived Sales Line"; SalesHeaderArchive: Record "PWD Archived Sales Header")
    begin
    end;
}
