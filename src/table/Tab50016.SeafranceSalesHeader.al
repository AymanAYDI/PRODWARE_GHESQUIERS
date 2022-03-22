table 50016 "PWD Seafrance Sales Header"
{
    Caption = 'Seafrance Sales Header';
    DataCaptionFields = "No.", "Sell-to Customer Name";
    LookupPageID = "Seatfance Sales Orders List";
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
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(5; "Bill-to Name"; Text[30])
        {
            Caption = 'Bill-to Name';
            DataClassification = CustomerContent;
        }
        field(6; "Bill-to Name 2"; Text[30])
        {
            Caption = 'Bill-to Name 2';
            DataClassification = CustomerContent;
        }
        field(7; "Bill-to Address"; Text[30])
        {
            Caption = 'Bill-to Address';
            DataClassification = CustomerContent;
        }
        field(8; "Bill-to Address 2"; Text[30])
        {
            Caption = 'Bill-to Address 2';
            DataClassification = CustomerContent;
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            DataClassification = CustomerContent;
        }
        field(10; "Bill-to Contact"; Text[30])
        {
            Caption = 'Bill-to Contact';
            DataClassification = CustomerContent;
        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(13; "Ship-to Name"; Text[30])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(14; "Ship-to Name 2"; Text[30])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = CustomerContent;
        }
        field(15; "Ship-to Address"; Text[30])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(16; "Ship-to Address 2"; Text[30])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;
        }
        field(18; "Ship-to Contact"; Text[30])
        {
            Caption = 'Ship-to Contact';
            DataClassification = CustomerContent;
        }
        field(19; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
            DataClassification = CustomerContent;
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            DataClassification = CustomerContent;
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
            DataClassification = CustomerContent;
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Editable = false;
            TableRelation = "Customer Posting Group";
            DataClassification = CustomerContent;
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(34; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
            DataClassification = CustomerContent;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            DataClassification = CustomerContent;
        }
        field(40; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
            DataClassification = CustomerContent;
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
            DataClassification = CustomerContent;
        }
        field(43; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
            DataClassification = CustomerContent;
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
            DataClassification = CustomerContent;
        }
        field(52; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
            DataClassification = CustomerContent;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = CustomerContent;
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account" ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
            DataClassification = CustomerContent;
        }
        field(56; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(57; Ship; Boolean)
        {
            Caption = 'Ship';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
            DataClassification = CustomerContent;
        }
        field(60; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Shipping No."; Code[20])
        {
            Caption = 'Shipping No.';
            DataClassification = CustomerContent;
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = CustomerContent;
        }
        field(64; "Last Shipping No."; Code[20])
        {
            Caption = 'Last Shipping No.';
            Editable = false;
            TableRelation = "Sales Shipment Header";
            DataClassification = CustomerContent;
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Sales Invoice Header";
            DataClassification = CustomerContent;
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = CustomerContent;
        }
        field(71; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
            DataClassification = CustomerContent;
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
            DataClassification = CustomerContent;
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(78; "VAT Country Code"; Code[10])
        {
            Caption = 'VAT Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(79; "Sell-to Customer Name"; Text[30])
        {
            Caption = 'Sell-to Customer Name';
            DataClassification = CustomerContent;
        }
        field(80; "Sell-to Customer Name 2"; Text[30])
        {
            Caption = 'Sell-to Customer Name 2';
            DataClassification = CustomerContent;
        }
        field(81; "Sell-to Address"; Text[30])
        {
            Caption = 'Sell-to Address';
            DataClassification = CustomerContent;
        }
        field(82; "Sell-to Address 2"; Text[30])
        {
            Caption = 'Sell-to Address 2';
            DataClassification = CustomerContent;
        }
        field(83; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
            DataClassification = CustomerContent;
        }
        field(84; "Sell-to Contact"; Text[30])
        {
            Caption = 'Sell-to Contact';
            DataClassification = CustomerContent;
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(86; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
            DataClassification = CustomerContent;
        }
        field(87; "Bill-to Country Code"; Code[10])
        {
            Caption = 'Bill-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            Caption = 'Sell-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(89; "Sell-to County"; Text[30])
        {
            Caption = 'Sell-to County';
            DataClassification = CustomerContent;
        }
        field(90; "Sell-to Country Code"; Code[10])
        {
            Caption = 'Sell-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
            DataClassification = CustomerContent;
        }
        field(93; "Ship-to Country Code"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(94; "Bal. Account Type"; enum "Payment Balance Account Type")
        {
            Caption = 'Bal. Account Type';
            DataClassification = CustomerContent;
        }
        field(97; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(100; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
            DataClassification = CustomerContent;
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Caption = 'Package Tracking No.';
            DataClassification = CustomerContent;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(108; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(109; "Shipping No. Series"; Code[10])
        {
            Caption = 'Shipping No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(117; Reserve; Enum "Reserve Method")
        {
            Caption = 'Reserve';
            DataClassification = CustomerContent;
        }
        field(118; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = CustomerContent;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(120; Status; Enum "Sales Document Status")
        {
            Caption = 'Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
            DataClassification = CustomerContent;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = Max("Sales Header Archive"."Version No." WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            DataClassification = CustomerContent;
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
            DataClassification = CustomerContent;
        }
        field(5051; "Sell-to Customer Template Code"; Code[10])
        {
            Caption = 'Sell-to Customer Template Code';
            TableRelation = "Customer Templ.";
            DataClassification = CustomerContent;
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';
            TableRelation = Contact;
            DataClassification = CustomerContent;
        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;
            DataClassification = CustomerContent;
        }
        field(5054; "Bill-to Customer Template Code"; Code[10])
        {
            Caption = 'Bill-to Customer Template Code';
            TableRelation = "Customer Templ.";
            DataClassification = CustomerContent;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(5750; "Shipping Advice"; Enum "Sales Header Shipping Advice")
        {
            Caption = 'Shipping Advice';
            DataClassification = CustomerContent;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = Min("Sales Line"."Completely Shipped" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), Type = FILTER(<> ' '), "Location Code" = FIELD("Location Filter")));
            Caption = 'Completely Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
            DataClassification = CustomerContent;
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
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
        field(5794; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
            DataClassification = CustomerContent;
        }
        field(5795; "Late Order Shipping"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Sell-to Customer No." = FIELD("Sell-to Customer No."), "Document No." = FIELD("No."), "Shipment Date" = FIELD("Date Filter"), "Outstanding Quantity" = FILTER(<> 0)));
            Caption = 'Late Order Shipping';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; Receive; Boolean)
        {
            Caption = 'Receive';
            DataClassification = CustomerContent;
        }
        field(5801; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
            DataClassification = CustomerContent;
        }
        field(5802; "Return Receipt No. Series"; Code[10])
        {
            Caption = 'Return Receipt No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(5803; "Last Return Receipt No."; Code[20])
        {
            Caption = 'Last Return Receipt No.';
            Editable = false;
            TableRelation = "Return Receipt Header";
            DataClassification = CustomerContent;
        }
        field(5900; "Service Mgt. Document"; Boolean)
        {
            Caption = 'Service Mgt. Document';
            DataClassification = CustomerContent;
        }
        field(6201; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(6202; "CP Status"; Enum "CP Status")
        {
            Caption = 'CP Status';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6203; "Auto Created"; Boolean)
        {
            Caption = 'Auto Created';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6210; "Login ID"; Code[30])
        {
            Caption = 'Login ID';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6211; "Web Site Code"; Code[20])
        {
            Caption = 'Web Site Code';
            DataClassification = CustomerContent;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            DataClassification = CustomerContent;
        }
        field(50000; "Call No."; Code[10])
        {
            Caption = 'Call No.';
            Description = 'Navita360';
            TableRelation = "PWD Call"."Call No.";
            DataClassification = CustomerContent;
        }
        field(50001; "Call Type"; Code[10])
        {
            Caption = 'Call Type';
            Description = 'Navita360';
            TableRelation = "PWD Call Type";
            DataClassification = CustomerContent;
        }
        field(50002; "Delivery time"; Time)
        {
            Caption = 'Delivery time';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(50003; "DSA No."; Code[10])
        {
            Caption = 'DSA No.';
            Description = 'Navita360';
            DataClassification = CustomerContent;
        }
        field(50004; "Person Number"; Integer)
        {
            Caption = 'Person Number';
            DataClassification = CustomerContent;
        }
        field(50005; "Preparation in process"; Boolean)
        {
            Caption = 'Preparation in process';
            DataClassification = CustomerContent;
        }
        field(50006; "Order Prepared"; Boolean)
        {
            Caption = 'Order Prepared';
            DataClassification = CustomerContent;
        }
        field(50021; "Controlled Order"; Boolean)
        {
            Caption = ' Controlled Order';
            Description = 'GHES1.01';
            DataClassification = CustomerContent;
        }
        field(50022; "Initial order No."; Code[10])
        {
            Caption = 'Initial order No.';
            Description = 'GHES1.01';
            DataClassification = CustomerContent;
        }
        field(55000; "Filing Reason"; Code[10])
        {
            Caption = 'Filing Reason';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(36), "Field ID" = CONST(55000));
            DataClassification = CustomerContent;
        }
        field(55009; "Trading Brand"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "PWD Trading Brand" = CONST(true)));
            Caption = 'Trading Brand';
            Description = 'Contremarque';
            FieldClass = FlowField;
        }
        field(55010; "Discount Profit %"; Decimal)
        {
            Caption = 'Discount Profit %';
            DataClassification = CustomerContent;
        }
        field(55012; "Order Trading Brand"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "PWD Order Trading brand" = CONST(true)));
            Caption = 'Order Trading Brand';
            Description = 'Contremarque';
            FieldClass = FlowField;
        }
        field(55013; "User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
        }
        field(55014; "Order to adjust"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("PWD Adjmt Prepared Qty" = FILTER(<> 0), "PWD Butchery" = FILTER(false), "PWD Countermark Location" = FILTER(false), "PWD Order Line Prepared" = FILTER(true)));
            Caption = 'Order to adjust';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55015; "Ready to ship"; Boolean)
        {
            Caption = 'Ready to ship';
            DataClassification = CustomerContent;
        }
        field(55016; "Preparation Status"; Enum "Preparation Status")
        {
            Caption = 'Preparation Status';
            Editable = false;
            // OptionMembers = ,"Ready to prepare","In process",Prepared,"Ready to ship";
            // OptionCaption = ',"Ready to prepare","In process",Prepared,"Ready to ship"';
            DataClassification = CustomerContent;
        }
        field(55017; "Ne pas utiliser No. de DSA"; Boolean)
        {
            Caption = 'Ne pas utiliser No. de DSA';
            DataClassification = CustomerContent;
        }
        field(55018; "Livraison OK"; Boolean)
        {
            Caption = 'Livraison OK';
            DataClassification = CustomerContent;
        }
        field(55019; Reference; Text[100])
        {
            Caption = 'Reference';
            DataClassification = CustomerContent;
        }
        field(55048; "Monthly Code"; Code[10])
        {
            Caption = 'Monthly Code';
            Description = 'code mensuel escale';
            DataClassification = CustomerContent;
        }
        field(55050; "Presta Facturable par fourniss"; Boolean)
        {
            Caption = 'Presta Facturable par fourniss';
            DataClassification = CustomerContent;
        }
        field(60001; "Commentaire 1"; Text[50])
        {
            Caption = 'Commentaire 1';
            DataClassification = CustomerContent;
        }
        field(60002; "Commentaire 2"; Text[50])
        {
            Caption = 'Commentaire 2';
            DataClassification = CustomerContent;
        }
        field(60003; "Commentaire 3"; Text[50])
        {
            Caption = 'Commentaire 3';
            DataClassification = CustomerContent;
        }
        field(60004; "Commentaire 4"; Text[50])
        {
            Caption = 'Commentaire 4';
            DataClassification = CustomerContent;
        }
        field(60005; "Commentaire 5"; Text[50])
        {
            Caption = 'Commentaire 5';
            DataClassification = CustomerContent;
        }
        field(99008500; "Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = CustomerContent;
        }
        field(99008501; "Time Received"; Time)
        {
            Caption = 'Time Received';
            DataClassification = CustomerContent;
        }
        field(99008502; "BizTalk Request for Sales Qte."; Boolean)
        {
            Caption = 'BizTalk Request for Sales Qte.';
            DataClassification = CustomerContent;
        }
        field(99008503; "BizTalk Sales Order"; Boolean)
        {
            Caption = 'BizTalk Sales Order';
            DataClassification = CustomerContent;
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
            DataClassification = CustomerContent;
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
            DataClassification = CustomerContent;
        }
        field(99008513; "BizTalk Sales Quote"; Boolean)
        {
            Caption = 'BizTalk Sales Quote';
            DataClassification = CustomerContent;
        }
        field(99008514; "BizTalk Sales Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Sales Order Cnfmn.';
            DataClassification = CustomerContent;
        }
        field(99008518; "Customer Quote No."; Code[20])
        {
            Caption = 'Customer Quote No.';
            DataClassification = CustomerContent;
        }
        field(99008519; "Customer Order No."; Code[20])
        {
            Caption = 'Customer Order No.';
            DataClassification = CustomerContent;
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Sell-to Customer No.", "No.")
        {
        }
        key(Key3; "Document Type", "Combine Shipments", "Bill-to Customer No.", "Currency Code")
        {
        }
        key(Key4; "Document Type", "Service Mgt. Document")
        {
        }
        key(Key5; "Sell-to Customer No.", "External Document No.")
        {
        }
        key(Key6; "Document Type", "Sell-to Contact No.")
        {
        }
        key(Key7; "Bill-to Contact No.")
        {
        }
        key(Key8; "Document Type", Status, "No.")
        {
        }
        key(Key9; "Document Type", Status, "Shipment Date")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        RecLSalesLinSeafrance: Record "PWD Seafrance Sales Line";
    begin
        RecLSalesLinSeafrance.RESET();
        RecLSalesLinSeafrance.SETRANGE(RecLSalesLinSeafrance."Document Type", "Document Type");
        RecLSalesLinSeafrance.SETRANGE(RecLSalesLinSeafrance."Document No.", "No.");
        RecLSalesLinSeafrance.DELETEALL();
    end;

    trigger OnRename()
    begin
    end;
}

