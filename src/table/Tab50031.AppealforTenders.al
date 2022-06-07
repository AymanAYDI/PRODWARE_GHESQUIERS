table 50031 "PWD Appeal for Tenders"
{
    // *** Contremarque - C2A
    // Appel d'offre fournisseur

    Caption = 'Appeal for Tenders';
    DrillDownPageID = "PWD Appeal for tenders -TrB";
    LookupPageID = "PWD Appeal for tenders -TrB";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;
        }
        field(3; "Line No. document"; Integer)
        {
            Caption = 'Line No. Document';
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetItem();
                Item.TESTFIELD(Blocked, FALSE);
                Description := Item.Description;
                "Description 2" := Item."Description 2";

                Item.TESTFIELD("Base Unit of Measure");
                VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
            end;
        }
        field(6; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(7; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(9; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                IF ItemVend.READPERMISSION THEN BEGIN
                    ItemVend.INIT();
                    ItemVend.SETRANGE("Item No.", "No.");
                    ItemVend.SETRANGE("Vendor No.", "Vendor No.");
                    IF NOT ItemVend.FindLast() THEN BEGIN
                        ItemVend."Item No." := "No.";
                        ItemVend."Vendor No." := "Vendor No.";
                    END;
                    ItemVend.SETRANGE("Vendor No.");
                    IF Page.RUNMODAL(0, ItemVend) = ACTION::LookupOK THEN
                        VALIDATE("Vendor No.", ItemVend."Vendor No.");
                END;
            end;

            trigger OnValidate()
            begin
                IF NOT Vendor.GET("Vendor No.") THEN
                    Vendor.INIT();
                "Vendor Name" := Vendor.Name;
            end;
        }
        field(10; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
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
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
                IF "Unit of Measure Code" <> '' THEN BEGIN
                    "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
                    "Unit Cost" := ROUND(Item."Unit Cost" * "Qty. per Unit of Measure", 0.00001);
                END;
            end;
        }
        field(55000; Detail; Boolean)
        {
            Caption = 'Detail';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55001; "Vendor Name"; Text[30])
        {
            Caption = 'Vendor Name';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55002; "Numb. of detail line"; Integer)
        {
            CalcFormula = Count("PWD Appeal for Tenders" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No. document" = FIELD("Line No. document"), "Vendor No." = FILTER(<> '')));
            Caption = 'Numb. of detail line';
            Description = 'PW2009';
            FieldClass = FlowField;
        }
        field(55003; Exclude; Boolean)
        {
            Caption = 'Exclude';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55004; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55005; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55006; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55007; "Inbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Inbound Whse. Handling Time';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55008; "Planned Receipt Date"; Date)
        {
            Caption = 'Planned Receipt Date';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No. document", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Vendor No.")
        {
        }
        key(Key3; "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //*** Si pas ligne détail on supprime les lignes de détails rattachées.
        IF Detail = FALSE THEN BEGIN
            AppTenders.RESET();
            AppTenders.SETRANGE("Document Type", "Document Type");
            AppTenders.SETRANGE("Document No.", "Document No.");
            AppTenders.SETRANGE("Line No. document", "Line No. document");
            AppTenders.SETRANGE(Detail, TRUE);
            AppTenders.DELETEALL();
        END;
    end;

    var
        Item: Record Item;
        ItemVend: Record "Item Vendor";
        AppTenders: Record "PWD Appeal for Tenders";
        Vendor: Record Vendor;
        UOMMgt: Codeunit "Unit of Measure Management";

    local procedure GetItem()
    begin
        TESTFIELD("No.");
        IF "No." <> Item."No." THEN
            Item.GET("No.");
    end;
}
