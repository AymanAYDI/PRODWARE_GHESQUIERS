tableextension 60014 "PWD PurchaseLine" extends "Purchase Line"
{
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Prodware : www.prodware.fr
    // ------------------------------------------------------------------------------------------------------------------------------------
    //
    // //>>MIGRATION2009R2
    //
    // ------------------------------------------------------------------------------------------------------------------------------------
    // *** Contremarque - C2A
    // 12.07.2007    C2A(LLE) cf appel NAV0016854 AddNewFields
    //                           70017 - Specific Cost
    //                        Modif in trigger UpdateUnitCost()
    // 19.07.2007    C2A(LLE) cf appel NAV0016904 Modif in trigger UpdateUnitCost()
    //
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
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
        field(50003; "PWD Origin"; Code[10])
        {
            Caption = 'Origin';
            Description = 'PW2009';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Cetificate Transit No."; Code[50])
        {
            Caption = 'Cetificate Transit No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Family"; Code[10])
        {
            Caption = 'Family';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55000; "PWD Sales Type Doc Appeal tenders"; Enum "PWD Sales TypeDocAppealtenders")
        {
            Caption = 'Sales Type Doc Appeal tenders';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55001; "PWD Sales No. Appeal Tenders"; Code[20])
        {
            Caption = 'Sales No. Appeal Tenders';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55002; "PWD Sales Line No. Appeal Tenders"; Integer)
        {
            Caption = 'Sales Line No. Appeal Tenders';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55010; "PWD Appeal for tenders"; Integer)
        {
            CalcFormula = Count("Sales Line" WHERE("Document Type" = FIELD("PWD Sales Type Doc Appeal tenders"), "Document No." = FIELD("PWD Sales No. Appeal Tenders"), "Line No." = FIELD("PWD Sales Line No. Appeal Tenders")));
            Caption = 'Appeal for tenders';
            Description = 'PW2009';
            FieldClass = FlowField;
        }
        field(55011; "PWD Selected Quote"; Boolean)
        {
            Caption = 'Selected Quote';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55012; "PWD Lead Time Calculation Import"; Text[50])
        {
            Caption = 'Délai de réappro. Import';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55043; "PWD Family Code"; Code[20])
        {
            Caption = 'Family Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55044; "PWD Purchaser code"; Code[20])
        {
            Caption = 'Purchaser code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55045; "PWD Quantite initiale"; Decimal)
        {
            Caption = 'Quantite initiale';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55050; "PWD Cle (restitution)"; Code[20])
        {
            Caption = 'Restitution Key';
            Description = 'PW2009';
            TableRelation = "PWD Item Restitution".Cle;
            DataClassification = CustomerContent;
        }
        field(55051; "PWD Designation FR"; Text[50])
        {
            Caption = 'Designation FR';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(70017; "PWD Specific Cost"; Boolean)
        {
            Caption = 'Specific Cost';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key50000; "PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders")
        {
        }
        key(Key50001; "Document No.", "Line No.")
        {
            Enabled = false;
        }
        key(Key50002; "Line No.")
        {
        }
        key(Key50003; "Document Type", "Special Order Sales No.", "Special Order Sales Line No.")
        {
            SumIndexFields = Quantity;
        }
    }

    procedure VerifUnitCost()
    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        PurchHeader: Record "Purchase Header";
        MaxPrice: Decimal;
    begin
        //*** Controle Cout unitaire > prix plafond de l'article
        IF Type = Type::Item THEN
            IF Item.GET("No.") THEN BEGIN

                MaxPrice := Item."PWD Maximum Price";
                PurchHeader.GET("Document Type", "Document No.");
                IF PurchHeader."Currency Code" <> '' THEN begin
                    Currency.GET(PurchHeader."Currency Code");
                    MaxPrice :=
                     ROUND(
                       CurrExchRate.ExchangeAmtLCYToFCY(
                         GetDate(), PurchHeader."Currency Code",
                         MaxPrice, PurchHeader."Currency Factor"),
                         Currency."Unit-Amount Rounding Precision");
                end;
                IF ("Direct Unit Cost" > MaxPrice) AND (MaxPrice <> 0) THEN
                    ERROR(Text1000000000, "Direct Unit Cost", MaxPrice);
            END;
    end;

    procedure VerifChange()
    begin
        IF "PWD Sales No. Appeal Tenders" = '' THEN
            EXIT;

        IF xRec.Type <> Rec.Type THEN
            ERROR(Text1000000001, FIELDCAPTION(Type));
        IF xRec."No." <> Rec."No." THEN
            ERROR(Text1000000001, FIELDCAPTION("No."));
        IF "Document Type" <> "Document Type"::Order THEN
            IF xRec.Quantity <> Rec.Quantity THEN
                ERROR(Text1000000001, FIELDCAPTION(Quantity));
        IF xRec."Unit of Measure Code" <> Rec."Unit of Measure Code" THEN
            ERROR(Text1000000001, FIELDCAPTION("Unit of Measure Code"));
    end;

    procedure MAJSalesDoc(TypeWeight: Text[1]; Weight: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        //*** Recherche du document de vente Special Order

        IF SalesLine.GET(SalesLine."Document Type"::Order, "Special Order Sales No.", "Special Order Sales Line No.") THEN BEGIN
            IF TypeWeight = 'G' THEN
                SalesLine."Gross Weight" := Weight
            ELSE
                SalesLine."Net Weight" := Weight;
            SalesLine.MODIFY();
        END;

        //*** Recherche du document de vente Appeal Tenders

        IF SalesLine.GET("PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders") THEN BEGIN
            IF TypeWeight = 'G' THEN
                SalesLine."Gross Weight" := Weight
            ELSE
                SalesLine."Net Weight" := Weight;
            SalesLine.MODIFY();
        END;
    end;

    var
        Item: Record Item;
        Text1000000000: Label 'Unit cost (%1) can''t be greatest than maximum price (%2)';
        Text1000000001: Label 'You can''t modify the field %1 (Appeal for tenders)';
}
