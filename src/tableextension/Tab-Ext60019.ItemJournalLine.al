tableextension 60019 "PWD ItemJournalLine" extends "Item Journal Line"
{
    LookupPageID = "Item Journal Lines";
    DrillDownPageID = "Item Journal Lines";
    fields
    {
        modify("Item No.")
        {
            TableRelation = Item;
        }
        field(50000; "PWD Notice Series No."; Code[20])
        {
            Caption = 'Notice Series No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Origin"; Code[10])
        {
            Caption = 'Origin';
            Description = 'PW2009';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Cetificate Transit No."; Code[50])
        {
            Caption = 'Cetificate Transit No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50010; "PWD Code prestation"; Code[10])
        {
            Description = 'PW2009';
            TableRelation = "PWD Prestations";
            DataClassification = CustomerContent;
        }
        field(50011; "PWD Code fournisseur"; Code[20])
        {
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50012; "PWD Code client"; Code[20])
        {
            Description = 'PW2009';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(50013; "PWD Family Code"; Code[20])
        {
            Caption = 'Family Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50015; "PWD Reference"; Text[100])
        {
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50016; "PWD Seafrance Order No."; Code[30])
        {
            Caption = 'Seafrance Order No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50017; "PWD Seafrance Order Line No."; Integer)
        {
            BlankZero = true;
            Caption = 'Seafrance Order Line No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50018; "PWD Vendor Item No."; Text[50])
        {
            CalcFormula = Lookup(Item."Vendor Item No." WHERE("No." = FIELD("Item No.")));
            Caption = 'Vendor Item No.';
            Description = 'PW2009';
            FieldClass = FlowField;
        }
        field(50019; "PWD Seafrance Quantity"; Decimal)
        {
            Caption = 'Seafrance Quantity';
            DecimalPlaces = 0 : 2;
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55000; "PWD Butchery"; Boolean)
        {
            Caption = 'Butchery';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55001; "PWD Relative Entry Line No"; Integer)
        {
            Caption = 'Relative Entry Line No';
            Description = 'PW2009';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(55002; "PWD Origin Lot No."; Code[20])
        {
            Caption = 'Origin Lot No.';
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
        field(55103; "PWD Gross Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids brut';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55104; "PWD Net Weight"; Decimal)
        {
            BlankZero = true;
            Caption = 'Poids net';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55106; "PWD Parcel Nb."; Decimal)
        {
            BlankZero = true;
            Caption = 'Nombre de colis';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55107; "PWD COM7 No."; Code[20])
        {
            Caption = 'N° de COM 7';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55108; "PWD Nb. unite"; Decimal)
        {
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55109; "PWD Montant douane"; Decimal)
        {
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Item."No." <> "Item No." then
                    Item.Get("Item No.");
                IF "PWD Montant douane" <> Item."PWD Customs Price" THEN
                    IF CONFIRM(STRSUBSTNO(CstG002, Item."No."), FALSE) THEN BEGIN
                        Item.VALIDATE(Item."PWD Customs Price", "PWD Montant douane");
                        Item.MODIFY();
                    END;
            end;
        }
        field(55200; "PWD Comments"; Text[30])
        {
            Caption = 'Comments';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key6; "Location Code")
        {
            SumIndexFields = "Quantity (Base)";
        }
    }
    procedure GetRelativeEntry()
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        IF "Entry Type" = "Entry Type"::"Positive Adjmt." THEN BEGIN
            ItemJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
            ItemJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
            ItemJnlLine.SETRANGE("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");
            ItemJnlLine.SETFILTER("Line No.", '<%1', "Line No.");

            IF ItemJnlLine.FindFirst() THEN "PWD Relative Entry Line No" := ItemJnlLine."Line No.";
        END;
    end;

    procedure OpenItemTrackingLinesButch(IsReclass: Boolean; var OriginButchEntry: Record "Reservation Entry")
    var
        PWDFunctionMget: Codeunit "PWD Function Mgt";
    begin
        PWDFunctionMget.CallItemTrackingButch(Rec, IsReclass, OriginButchEntry);
    end;

    procedure SetUpNewLinePrest(LastItemJnlLine: Record "Item Journal Line")
    var
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
    begin
        MfgSetup.GET();
        ItemJnlTemplate.GET("Journal Template Name");
        ItemJnlBatch.GET("Journal Template Name", "Journal Batch Name");
        ItemJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
        ItemJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
        IF ItemJnlLine.FIND('-') THEN BEGIN
            "Posting Date" := LastItemJnlLine."Posting Date";
            "Document Date" := LastItemJnlLine."Posting Date";
            IF (ItemJnlTemplate.Type IN
                [ItemJnlTemplate.Type::Consumption, ItemJnlTemplate.Type::Output])
            THEN BEGIN
                IF NOT MfgSetup."Doc. No. Is Prod. Order No." THEN
                    "Document No." := LastItemJnlLine."Document No."
            END ELSE
                "Document No." := LastItemJnlLine."Document No.";
        END ELSE BEGIN
            "Posting Date" := WORKDATE();
            "Document Date" := WORKDATE();
            IF ItemJnlBatch."No. Series" <> '' THEN BEGIN
                CLEAR(NoSeriesMgt);
                "Document No." := NoSeriesMgt.TryGetNextNo(ItemJnlBatch."No. Series", "Posting Date");
            END;
            IF (ItemJnlTemplate.Type IN
                [ItemJnlTemplate.Type::Consumption, ItemJnlTemplate.Type::Output]) AND
               NOT MfgSetup."Doc. No. Is Prod. Order No."
            THEN
                IF ItemJnlBatch."No. Series" <> '' THEN BEGIN
                    CLEAR(NoSeriesMgt);
                    "Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", "Posting Date", FALSE);
                END;
        END;
        "Recurring Method" := LastItemJnlLine."Recurring Method";
        "Entry Type" := LastItemJnlLine."Entry Type";
        "Source Code" := ItemJnlTemplate."Source Code";
        "Reason Code" := ItemJnlBatch."Reason Code";
        "Posting No. Series" := ItemJnlBatch."Posting No. Series";
        IF ItemJnlTemplate.Type = ItemJnlTemplate.Type::Revaluation THEN BEGIN
            "Value Entry Type" := "Value Entry Type"::Revaluation;
            "Entry Type" := "Entry Type"::"Positive Adjmt.";
        END;

        "Entry Type" := "Entry Type"::"Positive Adjmt.";
        "PWD Code prestation" := ItemJnlBatch."PWD Code préstation";
        "PWD Code fournisseur" := ItemJnlBatch."PWD Code fournisseur";
        "PWD Code client" := ItemJnlBatch."PWD Code client";

        CASE "Entry Type" OF
            "Entry Type"::Purchase:
                "Location Code" := UserMgt.GetLocation(1, '', UserMgt.GetPurchasesFilter());
            "Entry Type"::Sale:
                "Location Code" := UserMgt.GetLocation(0, '', UserMgt.GetSalesFilter());
        END;
    end;

    var
        Item: Record Item;
        MfgSetup: Record "Manufacturing Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserMgt: Codeunit "User Setup Management";
        CstG002: Label 'Voulez-vous mettre à jour le prix douane dans la fiche de l''article %1  ?';
}
