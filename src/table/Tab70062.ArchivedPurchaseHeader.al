table 70062 "PWD Archived Purchase Header"
{
    // Copied from table 5109 (Purchase Header Archive)

    Caption = 'Archived Purchase Header';
    DataCaptionFields = "No.", "Buy-from Vendor Name", "Version No.";
    DrillDownPageID = "PWD Archived Purchase List";
    LookupPageID = "PWD Archived Purchase List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(4; "Pay-to Vendor No."; Code[20])
        {
            Caption = 'Pay-to Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(5; "Pay-to Name"; Text[100])
        {
            Caption = 'Pay-to Name';
            DataClassification = CustomerContent;
        }
        field(6; "Pay-to Name 2"; Text[50])
        {
            Caption = 'Pay-to Name 2';
            DataClassification = CustomerContent;
        }
        field(7; "Pay-to Address"; Text[100])
        {
            Caption = 'Pay-to Address';
            DataClassification = CustomerContent;
        }
        field(8; "Pay-to Address 2"; Text[50])
        {
            Caption = 'Pay-to Address 2';
            DataClassification = CustomerContent;
        }
        field(9; "Pay-to City"; Text[30])
        {
            Caption = 'Pay-to City';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(10; "Pay-to Contact"; Text[100])
        {
            Caption = 'Pay-to Contact';
            DataClassification = CustomerContent;
        }
        field(11; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;
        }
        field(13; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = CustomerContent;
        }
        field(15; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(18; "Ship-to Contact"; Text[100])
        {
            Caption = 'Ship-to Contact';
            DataClassification = CustomerContent;
        }
        field(19; "Order Date"; Date)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(21; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            DataClassification = CustomerContent;
        }
        field(22; "Posting Description"; Text[100])
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
            MaxValue = 100;
            MinValue = 0;
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
        field(31; "Vendor Posting Group"; Code[20])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
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
            MinValue = 0;
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
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
            DataClassification = CustomerContent;
        }
        field(43; "Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
            DataClassification = CustomerContent;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
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
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
            DataClassification = CustomerContent;
        }
        field(56; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(57; Receive; Boolean)
        {
            Caption = 'Receive';
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
            CalcFormula = Sum("PWD Archived Purchase Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                                    "Document No." = FIELD("No."),
                                                                    "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                    "Version No." = FIELD("Version No.")));
            Caption = 'Amount';
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("PWD Archived Purchase Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"),
                                                                                    "Document No." = FIELD("No."),
                                                                                    "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                                    "Version No." = FIELD("Version No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Receiving No."; Code[20])
        {
            Caption = 'Receiving No.';
            DataClassification = CustomerContent;
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = CustomerContent;
        }
        field(64; "Last Receiving No."; Code[20])
        {
            Caption = 'Last Receiving No.';
            TableRelation = "Purch. Rcpt. Header";
            DataClassification = CustomerContent;
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            TableRelation = "Purch. Inv. Header";
            DataClassification = CustomerContent;
        }
        field(66; "Vendor Order No."; Code[35])
        {
            Caption = 'Vendor Order No.';
            DataClassification = CustomerContent;
        }
        field(67; "Vendor Shipment No."; Code[35])
        {
            Caption = 'Vendor Shipment No.';
            DataClassification = CustomerContent;
        }
        field(68; "Vendor Invoice No."; Code[35])
        {
            Caption = 'Vendor Invoice No.';
            DataClassification = CustomerContent;
        }
        field(69; "Vendor Cr. Memo No."; Code[35])
        {
            Caption = 'Vendor Cr. Memo No.';
            DataClassification = CustomerContent;
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = CustomerContent;
        }
        field(72; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
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
        field(79; "Buy-from Vendor Name"; Text[100])
        {
            Caption = 'Buy-from Vendor Name';
            DataClassification = CustomerContent;
        }
        field(80; "Buy-from Vendor Name 2"; Text[50])
        {
            Caption = 'Buy-from Vendor Name 2';
            DataClassification = CustomerContent;
        }
        field(81; "Buy-from Address"; Text[100])
        {
            Caption = 'Buy-from Address';
            DataClassification = CustomerContent;
        }
        field(82; "Buy-from Address 2"; Text[50])
        {
            Caption = 'Buy-from Address 2';
            DataClassification = CustomerContent;
        }
        field(83; "Buy-from City"; Text[30])
        {
            Caption = 'Buy-from City';
            TableRelation = "Post Code".City;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(84; "Buy-from Contact"; Text[100])
        {
            Caption = 'Buy-from Contact';
            DataClassification = CustomerContent;
        }
        field(85; "Pay-to Post Code"; Code[20])
        {
            Caption = 'Pay-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(86; "Pay-to County"; Text[30])
        {
            CaptionClass = '5,1,' + "Pay-to Country Code";
            Caption = 'Pay-to County';
            DataClassification = CustomerContent;
        }
        field(87; "Pay-to Country Code"; Code[10])
        {
            Caption = 'Pay-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(88; "Buy-from Post Code"; Code[20])
        {
            Caption = 'Buy-from Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(89; "Buy-from County"; Text[30])
        {
            CaptionClass = '5,1,' + "Buy-from Country Code";
            Caption = 'Buy-from County';
            DataClassification = CustomerContent;
        }
        field(90; "Buy-from Country Code"; Code[10])
        {
            Caption = 'Buy-from Country Code';
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
            CaptionClass = '5,1,' + "Ship-to Country Code";
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
        field(95; "Order Address Code"; Code[10])
        {
            Caption = 'Order Address Code';
            TableRelation = "Order Address".Code WHERE("Vendor No." = FIELD("Buy-from Vendor No."));
            DataClassification = CustomerContent;
        }
        field(97; "Entry Point"; Code[10])
        {
            Caption = 'Entry Point';
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
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(108; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(109; "Receiving No. Series"; Code[20])
        {
            Caption = 'Receiving No. Series';
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
        field(116; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(118; "Applies-to ID"; Code[50])
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
        field(120; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            DataClassification = CustomerContent;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
            DataClassification = CustomerContent;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
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
        field(3998; "Source Doc. Exists"; Boolean)
        {
            FieldClass = Flowfield;
            CalcFormula = Exist("Purchase Header" WHERE("Document Type" = FIELD("Document Type"),
                                                            "No." = FIELD("No.")));
            Caption = 'Source Doc. Exists';
            Editable = false;
        }
        field(3999; "Last Archived Date"; DateTime)
        {
            Caption = 'Last Archived Date';
            FieldClass = FlowField;
            CalcFormula = Max("Purchase Header Archive".SystemCreatedAt where("Document Type" = FIELD("Document Type"),
                                                            "No." = FIELD("No."),
                                                            "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
            Editable = false;
        }
        field(5043; "Interaction Exist"; Boolean)
        {
            Caption = 'Interaction Exist';
            DataClassification = CustomerContent;
        }
        field(5044; "Time Archived"; Time)
        {
            Caption = 'Time Archived';
            DataClassification = CustomerContent;
        }
        field(5045; "Date Archived"; Date)
        {
            Caption = 'Date Archived';
            DataClassification = CustomerContent;
        }
        field(5046; "Archived By"; Code[50])
        {
            Caption = 'Archived By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
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
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
            DataClassification = CustomerContent;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(5752; "Completely Received"; Boolean)
        {
            CalcFormula = Min("PWD Archived Purchase Line"."Completely Received" WHERE("Document Type" = FIELD("Document Type"),
                                                                                   "Document No." = FIELD("No."),
                                                                                   "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                                   "Version No." = FIELD("Version No."),
                                                                                   "Expected Receipt Date" = FIELD("Date Filter"),
                                                                                   "Location Code" = FIELD("Location Filter")));
            Caption = 'Completely Received';
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
        field(5790; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            DataClassification = CustomerContent;
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
            DataClassification = CustomerContent;
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Lead Time Calculation';
            DataClassification = CustomerContent;
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Inbound Whse. Handling Time';
            DataClassification = CustomerContent;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; "Vendor Authorization No."; Code[35])
        {
            Caption = 'Vendor Authorization No.';
            DataClassification = CustomerContent;
        }
        field(5801; "Return Shipment No."; Code[20])
        {
            Caption = 'Return Shipment No.';
            DataClassification = CustomerContent;
        }
        field(5802; "Return Shipment No. Series"; Code[20])
        {
            Caption = 'Return Shipment No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(5803; Ship; Boolean)
        {
            Caption = 'Ship';
            DataClassification = CustomerContent;
        }
        field(5804; "Last Return Shipment No."; Code[20])
        {
            Caption = 'Last Return Shipment No.';
            TableRelation = "Return Shipment Header";
            DataClassification = CustomerContent;
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
            DataClassification = CustomerContent;
        }
        field(50000; Sealing; Text[30])
        {
            Caption = 'Sealing';
            DataClassification = CustomerContent;
        }
        field(50001; "Attachment 1"; Text[50])
        {
            Caption = 'Attachment 1';
            DataClassification = CustomerContent;
        }
        field(50002; "Attachment 2"; Text[50])
        {
            Caption = 'Attachment 2';
            DataClassification = CustomerContent;
        }
        field(50003; "Attachment 3"; Text[50])
        {
            Caption = 'Attachment 3';
            DataClassification = CustomerContent;
        }
        field(50004; "Attachment 4"; Text[50])
        {
            Caption = 'Attachment 4';
            DataClassification = CustomerContent;
        }
        field(55018; Reference; Text[100])
        {
            Caption = 'Reference';
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
        key(Key1; "Document Type", "No.", "Doc. No. Occurrence", "Version No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Buy-from Vendor No.")
        {
        }
        key(Key3; "Document Type", "Pay-to Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        DeferralHeaderArchive: Record "Deferral Header Archive";
        PurchaseLineArchive: Record "PWD Archived Purchase Line";
    begin
        PurchaseLineArchive.SetRange("Document Type", "Document Type");
        PurchaseLineArchive.SetRange("Document No.", "No.");
        PurchaseLineArchive.SetRange("Doc. No. Occurrence", "Doc. No. Occurrence");
        PurchaseLineArchive.SetRange("Version No.", "Version No.");
        PurchaseLineArchive.DeleteAll();

        DeferralHeaderArchive.SetRange("Deferral Doc. Type", "Deferral Document Type"::Purchase);
        DeferralHeaderArchive.SetRange("Document Type", "Document Type");
        DeferralHeaderArchive.SetRange("Document No.", "No.");
        DeferralHeaderArchive.SetRange("Doc. No. Occurrence", "Doc. No. Occurrence");
        DeferralHeaderArchive.SetRange("Version No.", "Version No.");
        DeferralHeaderArchive.DeleteAll(true);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        UserSetupMgt: Codeunit "User Setup Management";

    procedure ShowDimensions()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', "Document Type", "No."));
    end;

    procedure SetSecurityFilterOnRespCenter()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeSetSecurityFilterOnRespCenter(Rec, IsHandled);
        if IsHandled then
            exit;

        if UserSetupMgt.GetPurchasesFilter() <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Center", UserSetupMgt.GetPurchasesFilter());
            FilterGroup(0);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetSecurityFilterOnRespCenter(var PurchaseHeaderArchive: Record "PWD Archived Purchase Header"; var IsHandled: Boolean)
    begin
    end;
}
