tableextension 60008 "PWD Item" extends Item
{
    fields
    {
        modify("Shelf No.")
        {
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(27), "Field ID" = CONST(12));
        }
        field(50000; "PWD National Add. Code"; Code[19])
        {
            Caption = 'National Add. Code';
            Description = 'PW2009';
            TableRelation = "PWD National Add. Code";
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Dimension"; Text[20])
        {
            Caption = 'Dimension';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Marginal Tax"; Decimal)
        {
            Caption = 'Marginal Tax';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Restitution Key"; Code[20])
        {
            Caption = 'Restitution Key';
            Description = 'PW2009';
            TableRelation = "PWD Item Restitution".Cle;
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Product %"; Decimal)
        {
            Caption = 'Product %';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Restitution Amount"; Decimal)
        {
            Caption = 'Restitution Amount';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD Butchery"; Boolean)
        {
            Caption = 'Butchery';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50007; "PWD Alcool %"; Decimal)
        {
            Caption = 'Alcool %';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50008; "PWD Base Customs No."; Text[20])
        {
            Caption = 'Base Customs No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50009; "PWD Tariff Regrouping code"; Code[1])
        {
            Caption = 'Tarrif Regrouping code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50010; "PWD IMPA Code"; Code[10])
        {
            Caption = 'IMPA Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50011; "PWD ISSA Code"; Code[10])
        {
            Caption = 'ISSA Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50012; "ISSA Code (Old Version)"; Code[10])
        {
            Caption = 'ISSA Code (Old Version)';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Professional Description"; Code[30])
        {
            Caption = 'Professional Description';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50014; "PWD Family"; Code[10])
        {
            Caption = 'Family';
            Description = 'PW2009';
            TableRelation = "PWD Family & Sub Family".Code WHERE(Type = CONST(Item), "Group Type" = CONST(Family));
            DataClassification = CustomerContent;
        }
        field(50015; "PWD Sub Family"; Code[10])
        {
            Caption = 'Sub Family';
            Description = 'PW2009';
            TableRelation = "PWD Family & Sub Family".Code WHERE(Type = CONST(Item), "Group Type" = CONST("Sub Family"), "Relative Group Code" = FIELD("PWD Family"));
            DataClassification = CustomerContent;
        }
        field(50016; "PWD Continental Code"; Code[10])
        {
            Caption = 'Continental Code';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(9), "Field ID" = CONST(50001));
            DataClassification = CustomerContent;
        }
        field(50017; "PWD Origin Certified"; Boolean)
        {
            Caption = 'Origin Certified';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50018; "PWD Manifest"; Boolean)
        {
            Caption = 'Manifest';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50019; "PWD Manifest Category"; Option)
        {
            Caption = 'Manifest Category';
            Description = 'PW2009';
            OptionCaption = ' ,alcool,aperitif,tabaco,toilet water';
            OptionMembers = " ",alcool,aperitif,tabaco,"toilet water";
            DataClassification = CustomerContent;
        }
        field(50020; "PWD No. sommier hors CEE"; Text[20])
        {
            Caption = 'N° sommier hors CEE';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50021; "PWD Family (Sea France)"; Code[10])
        {
            Caption = 'Family (Sea France)';
            Description = 'PW2009';
            TableRelation = "PWD Family & Sub Family".Code WHERE(Type = CONST(Item), "Group Type" = CONST(Family));
            DataClassification = CustomerContent;
        }
        field(50022; "PWD Sub Family (Sea France)"; Code[10])
        {
            Caption = 'Sub Family (Sea France)';
            Description = 'PW2009';
            TableRelation = "PWD Family & Sub Family".Code WHERE(Type = CONST(Item), "Group Type" = CONST("Sub Family"), "Relative Group Code" = FIELD("PWD Family (Sea France)"));
            DataClassification = CustomerContent;
        }
        field(50023; "PWD Coefficient Seafrance"; Decimal)
        {
            BlankZero = true;
            Caption = 'Coefficient Seafrance';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50024; "PWD Qty. on Quote Order"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Quote), Type = CONST(Item), "No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Shipment Date" = FIELD("Date Filter"), "PWD Preparation in Process" = FIELD("PWD Preparation Filter")));
            Caption = 'Qty. on Sales Order';
            DecimalPlaces = 0 : 5;
            Description = 'GHE1.10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52000; "PWD Gere en stock"; Boolean)
        {
            Caption = 'Géré en stock';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(52001; "PWD Ancien Code Article"; Code[10])
        {
            Caption = 'Ancien Code Article';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(52002; "PWD Propriete Seafrance"; Boolean)
        {
            Caption = 'Propriété Seafrance';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(52003; "PWD Alcool/Tabac"; Code[1])
        {
            Caption = 'Alcool/Tabac';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55000; "PWD Bottom Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Bottom Price';
            Description = 'PW2009';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(55001; "PWD Maximum Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Maximum Price';
            Description = 'PW2009';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(55002; "PWD Conserving Temperature"; Decimal)
        {
            Caption = 'Conserving Temperature';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55003; "PWD Transport Temperature"; Decimal)
        {
            Caption = 'Transport Temperature';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55004; "PWD Health Certificate Required"; Boolean)
        {
            Caption = 'Health Certificate Required';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55005; "PWD Translation"; Text[30])
        {
            Caption = 'Translation';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55010; "PWD Customs Price"; Decimal)
        {
            Caption = 'Customs Price';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55011; "PWD Prestation SEAF Price"; Decimal)
        {
            Caption = 'Prestation SEAF Price';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55012; "PWD SEAF E price"; Decimal)
        {
            Caption = 'SEAF £ price';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55013; "PWD Trading Brand"; Boolean)
        {
            Caption = 'Trading Brand';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55014; "PWD GCM Code"; Code[20])
        {
            Caption = 'CGM Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55015; "PWD SEAF Code"; Code[20])
        {
            Caption = 'SEAF Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55016; "PWD Conformity Certificate"; Boolean)
        {
            Caption = 'Conformity Certificate';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55017; "PWD Technical Card"; Boolean)
        {
            Caption = 'Technical Card';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55018; "PWD Ventilation code"; Code[10])
        {
            Caption = 'Ventilation code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55019; "PWD Purchase blocked"; Boolean)
        {
            Caption = 'Purchase blocked';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55101; "PWD Meat Family"; Code[10])
        {
            Caption = 'Meat Family';
            Description = 'PW2009';
            TableRelation = "PWD Meat Family";
            DataClassification = CustomerContent;
        }
        field(55102; "PWD Meat Type"; Option)
        {
            Caption = 'Meat Type';
            Description = 'PW2009';
            OptionCaption = 'InPut,OutPut';
            OptionMembers = "Entrée",Sortie;
            DataClassification = CustomerContent;
        }
        field(55103; "PWD Call Type Filter"; Code[20])
        {
            Caption = 'Call Type Filter';
            Description = 'PW2009';
            FieldClass = FlowFilter;
        }
        field(55104; "PWD Preparation Filter"; Boolean)
        {
            Caption = 'Preparation Filter';
            Description = 'PW2009';
            FieldClass = FlowFilter;
        }
        field(55105; "PWD Buffer Qty Available"; Decimal)
        {
            Caption = 'Buffer Qty Available';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55106; "PWD Qty. on Sales Order Prep"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."PWD Prepared Quantity (Base)" WHERE("Document Type" = CONST(Order), Type = CONST(Item), "No." = FIELD("No."), "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"), "Bin Code" = FIELD("Bin Filter"), "Shipment Date" = FIELD("Date Filter"), "PWD Preparation in Process" = FIELD("PWD Preparation Filter"), "Quantity Shipped" = CONST(0)));
            Caption = 'Qty. on Sales Order Prep';
            DecimalPlaces = 0 : 5;
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55200; "PWD SEAF Code 2"; Code[20])
        {
            Caption = 'SEAF Code 2';
            Description = 'NDBI';
            DataClassification = CustomerContent;
        }
        field(55201; "PWD SEAF Code 3"; Code[20])
        {
            Caption = 'SEAF Code 3';
            Description = 'NDBI';
            DataClassification = CustomerContent;
        }
        field(55202; "PWD SEAF Code 4"; Code[20])
        {
            Caption = 'SEAF Code 4';
            Description = 'NDBI';
            DataClassification = CustomerContent;
        }
        field(55203; "PWD SEAF Code 5"; Code[20])
        {
            Caption = 'SEAF Code 5';
            Description = 'NDBI';
            DataClassification = CustomerContent;
        }
        field(55300; "PWD CIEL Personal Caption"; Text[50])
        {
            Caption = 'CIEL Personal Caption';
            Description = 'NDBI';
            TableRelation = "PWD Personal Caption";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key21; "Tariff No.", "No.")
        {
        }
        key(Key22; "PWD CIEL Personal Caption")
        {
        }
    }

    procedure GetDefaultTranslation(var DefaultTranslation: Text[30])
    var
        InvSetup: Record "Inventory Setup";
        ItemTranslation: Record "Item Translation";
    begin
        InvSetup.GET();
        IF InvSetup."PWD Default Translation Language" <> '' THEN BEGIN
            ItemTranslation.SETRANGE("Item No.", "No.");
            ItemTranslation.SETRANGE("Language Code", InvSetup."PWD Default Translation Language");
            IF ItemTranslation.FIND('-') THEN
                DefaultTranslation := ItemTranslation.Description ELSE
                DefaultTranslation := Description;
        END ELSE
            DefaultTranslation := Description;
    end;
}

