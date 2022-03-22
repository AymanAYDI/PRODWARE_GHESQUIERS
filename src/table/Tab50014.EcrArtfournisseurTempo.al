table 50014 "PWD EcrArt/fournisseur Tempo"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(4; "Entry Type"; Enum "Entry Type")
        {
            Caption = 'Entry Type';
            DataClassification = CustomerContent;
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor ELSE
            IF ("Source Type" = CONST(Item)) Item;
            DataClassification = CustomerContent;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(13; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            DataClassification = CustomerContent;
        }
        field(29; Open; Boolean)
        {
            Caption = 'Open';
            DataClassification = CustomerContent;
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(36; Positive; Boolean)
        {
            Caption = 'Positive';
            DataClassification = CustomerContent;
        }
        field(41; "Source Type"; Enum "Source Type")
        {
            Caption = 'Source Type';
            DataClassification = CustomerContent;
        }
        field(47; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            DataClassification = CustomerContent;
        }
        field(50; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(51; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(52; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(61; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(62; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(63; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(64; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(70; "Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Reservation Status" = CONST(Reservation), "Source Type" = CONST(32), "Source Subtype" = CONST(0), "Source ID" = CONST(), "Source Batch Name" = CONST(), "Source Prod. Order Line" = CONST(0), "Source Ref. No." = FIELD("Entry No.")));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            DataClassification = CustomerContent;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
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
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;
        }
        field(5408; "Derived from Blanket Order"; Boolean)
        {
            Caption = 'Derived from Blanket Order';
            DataClassification = CustomerContent;
        }
        field(5700; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = CustomerContent;
        }
        field(5701; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(5702; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
            DataClassification = CustomerContent;
        }
        field(5703; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            DataClassification = CustomerContent;
        }
        field(5704; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5705; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            DataClassification = CustomerContent;
        }
        field(5706; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
            DataClassification = CustomerContent;
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(5740; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5800; "Completely Invoiced"; Boolean)
        {
            Caption = 'Completely Invoiced';
            DataClassification = CustomerContent;
        }
        field(5801; "Last Invoice Date"; Date)
        {
            Caption = 'Last Invoice Date';
            DataClassification = CustomerContent;
        }
        field(5802; "Applied Entry to Adjust"; Boolean)
        {
            Caption = 'Applied Entry to Adjust';
            DataClassification = CustomerContent;
        }
        field(5803; "Cost Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Expected)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Expected)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5804; "Cost Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Actual)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5805; "Cost Amount (Non-Invtbl.)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Non-Invtbl.)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Total coût (non-invt.)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5806; "Cost Amount (Expected) (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Expected) (ACY)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Expected) (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5807; "Cost Amount (Actual) (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual) (ACY)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Actual) (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5808; "Cost Amount (Non-Invt.) (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Non-Invtbl.)(ACY)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Non-Invt.) (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5815; "Sales Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Amount (Expected)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Sales Amount (Expected)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5816; "Sales Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Amount (Actual)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Sales Amount (Actual)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(5832; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            DataClassification = CustomerContent;
        }
        field(5833; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            DataClassification = CustomerContent;
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            DataClassification = CustomerContent;
        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = CustomerContent;
        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            DataClassification = CustomerContent;
        }
        field(6503; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(6602; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
            DataClassification = CustomerContent;
        }
        field(10800; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
        field(50000; "Notice Series No."; Code[20])
        {
            Caption = 'Notice Series No.';
            DataClassification = CustomerContent;
        }
        field(50001; Origin; Code[10])
        {
            Caption = 'Origin';
            DataClassification = CustomerContent;
        }
        field(50002; "Cetificate Transit No."; Code[50])
        {
            Caption = 'Cetificate Transit No.';
            DataClassification = CustomerContent;
        }
        field(50003; "Origin Lot No."; Code[20])
        {
            Caption = 'Origin Lot No.';
            DataClassification = CustomerContent;
        }
        field(50004; "Meat Family"; Code[10])
        {
            Caption = 'Meat Family';
            Description = 'Boucherie';
            TableRelation = "PWD Meat Family";
            DataClassification = CustomerContent;
        }
        field(50005; "Meat Type"; Enum "Meat Type")
        {
            Caption = 'Meat Type';
            Description = 'Boucherie';
            DataClassification = CustomerContent;
        }
        field(50010; "Code prestation"; Code[10])
        {
            Caption = 'Code prestation';
            TableRelation = "PWD Prestations";
            DataClassification = CustomerContent;
        }
        field(50011; "Code fournisseur"; Code[20])
        {
            Caption = 'Code fournisseur';
            DataClassification = CustomerContent;
        }
        field(50012; "Code client"; Code[20])
        {
            Caption = 'Code client';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(50013; "Family Code"; Code[20])
        {
            Caption = 'Family Code';
            DataClassification = CustomerContent;
        }
        field(50014; "Date facturation prestation"; Date)
        {
            Caption = 'Date facturation prestation';
            DataClassification = CustomerContent;
        }
        field(50015; "Magasin DEB"; Boolean)
        {
            Caption = 'Magasin DEB';
            DataClassification = CustomerContent;
        }
        field(50016; "Type Escale"; Code[10])
        {
            Caption = 'Type Escale';
            TableRelation = "PWD Call Type".Code;
            DataClassification = CustomerContent;
        }
        field(50017; "Prest Entree Fact"; Boolean)
        {
            Caption = 'Prest Entree Fact';
            DataClassification = CustomerContent;
        }
        field(50018; "Prest Sortie Fact"; Boolean)
        {
            Caption = 'Prest Sortie Fact';
            DataClassification = CustomerContent;
        }
        field(50019; "Parcel Nb"; Decimal)
        {
            BlankZero = true;
            Caption = 'Parcel Nb';
            DataClassification = CustomerContent;
        }
        field(50020; "COM 7 No."; Code[20])
        {
            Caption = 'COM 7 No.';
            DataClassification = CustomerContent;
        }
        field(50021; "Nb. unite"; Decimal)
        {
            Caption = 'Nb. unite';
            DataClassification = CustomerContent;
        }
        field(50022; "Montant douane"; Decimal)
        {
            Caption = 'Montant douane';
            DataClassification = CustomerContent;
        }
        field(50023; "Lot Reserved Qty"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = FIELD("Item No."), "Lot No." = FIELD("Lot No."), "Source Type" = CONST(37), "Source Subtype" = CONST(1)));
            Caption = 'Lot Reserved Qty';
            Description = 'Somme des reservations sur commande vente pour le lot';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55103; "Gross Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
        }
        field(55104; "Net Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Variant Code", "Drop Shipment", "Location Code", "Bin Code", "Posting Date")
        {
            Enabled = false;
            SumIndexFields = Quantity, "Invoiced Quantity";
        }
        key(Key3; "Entry Type", "Item No.", "Variant Code", "Drop Shipment", "Location Code", "Bin Code", "Posting Date")
        {
            Enabled = false;
            SumIndexFields = Quantity, "Invoiced Quantity";
        }
        key(Key4; "Entry Type", "Item No.", "Variant Code", "Source Type", "Source No.", "Posting Date")
        {
            Enabled = false;
        }
        key(Key5; "Source Type", "Source No.", "Entry Type", "Item No.", "Variant Code", "Posting Date")
        {
            Enabled = false;
        }
        key(Key6; "Item No.", "Variant Code", Open, Positive, "Location Code", "Bin Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.")
        {
            Enabled = false;
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key7; "Country Code", "Entry Type", "Posting Date")
        {
            Enabled = false;
        }
        key(Key8; "Document No.", "Posting Date")
        {
            Enabled = false;
        }
        key(Key9; "Item No.", "Variant Code", "Drop Shipment", "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Bin Code", "Posting Date")
        {
            Enabled = false;
            SumIndexFields = Quantity, "Invoiced Quantity";
        }
        key(Key10; "Entry Type", "Item No.", "Variant Code", "Drop Shipment", "Global Dimension 1 Code", "Global Dimension 2 Code", "Location Code", "Bin Code", "Posting Date")
        {
            Enabled = false;
            SumIndexFields = "Invoiced Quantity";
        }
        key(Key11; "Prod. Order No.", "Prod. Order Line No.", "Prod. Order Comp. Line No.", "Entry Type")
        {
            Enabled = false;
            MaintainSIFTIndex = false;
            SumIndexFields = Quantity;
        }
        key(Key12; "Item No.", Positive, "Completely Invoiced", "Last Invoice Date", "Location Code", "Variant Code", "Bin Code")
        {
            Enabled = false;
        }
        key(Key13; "Applied Entry to Adjust", "Item No.", "Location Code", "Variant Code", "Posting Date")
        {
            Enabled = false;
        }
        key(Key14; "Entry Type", Nonstock, "Item No.", "Posting Date")
        {
            Enabled = false;
        }
        key(Key15; "Expiration Date", "Location Code", "Item No.", "Lot No.", "Remaining Quantity", Positive)
        {
            Enabled = false;
        }
        key(Key16; "Meat Family", "Meat Type")
        {
            Enabled = false;
        }
        key(Key17; "Lot No.")
        {
            Enabled = false;
        }
        key(Key18; "Origin Lot No.")
        {
            Enabled = false;
        }
        key(Key19; "Meat Family", "Lot No.")
        {
            Enabled = false;
        }
        key(Key20; "Code client", "Code prestation", "Item No.", "Unit of Measure Code", "Posting Date")
        {
            Enabled = false;
            SumIndexFields = "Qty. per Unit of Measure", Quantity;
        }
        key(Key21; "Source No.", "Item No.")
        {
            Enabled = false;
        }
        key(Key22; "Country Code", "Entry Type", "Posting Date", "Magasin DEB", "Type Escale")
        {
            Enabled = false;
        }
        key(Key23; "Country Code", "Entry Type", "Posting Date", "Location Code")
        {
            Enabled = false;
        }
        key(Key24; "Code client", "Code fournisseur", "Code prestation", "Document No.", "Item No.", "Unit of Measure Code", "Posting Date")
        {
            SumIndexFields = "Qty. per Unit of Measure", Quantity;
        }
    }

    fieldgroups
    {
    }

    procedure GetCurrencyCode(): Code[10]
    begin
    end;
}

