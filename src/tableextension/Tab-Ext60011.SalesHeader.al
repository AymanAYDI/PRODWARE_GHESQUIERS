tableextension 60011 "PWD SalesHeader" extends "Sales Header"
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
    // 30/10/06   C2A(LLE)   modif in trigger Bill-to Customer No. - OnValidate()
    // 
    // 14/05/07   C2A JRA DDT 16105 Validate Client facturé Fonction RecreateSalesLine>>>>
    // 
    // 16/05/07   C2A LLE suite DDT 16105 on modifie le message du Text048 dans la fonction RecreateSalesLines
    // 
    // -------------------------------------------------
    // Prodware - www.prodware.fr
    // -------------------------------------------------
    // //>>GHES1.01
    // FED_ADV_20090827_IMP_CDEVENTE_V2 :SOBI 19/10/2009 - SALES ORDER SEAFRANCE
    //                                                     Add Fields ID 50021 "Seafrance Order No."
    // 
    // >>GHE-RE1.00:DO 04/04/2011 :
    //   - ajout d'un oubli de code (No serie)
    // 
    // >>GHE-RE1.00:DO 08/04/2011 :
    //   - Ajout d'indicateur
    // >>GHE-RE1.00:DO 12/04/2011 :
    //   - On conserve uniquement le staut "qté expedié"
    // 
    // //>>SOBI
    // P3346_0011 RO.LALE REGIE 04/07/2013 : - Modif fonction RecreateSalesLines
    // 
    // CF TI238802 : RO : 2014/09/04  - Demande de développemnt sur Ressources dans lignes ventes
    //                                  Modif fonction RecreateSalesLines
    // 
    // //>>SOBI
    // P3346_0015 RO.LALE REGIE 18/03/2015 : point 10-11
    //                                - add fields
    //                                   50110 - Bill-to C/O - Boolean
    //                                   50111 - Bill-to Additional name - Text50
    //                                - Add C/AL Code in trigger Bill-to Customer No. - OnValidate()
    // ------------------------------------------------------------------------------------------------------------------------------------
    fields
    {
        //modify("Shipment Method Code")
        //{
        //InitValue = 'DDU'; //a vérifier
        //}
        field(50000; "PWD Call No."; Code[10])
        {
            Caption = 'Call No.';
            Description = 'PW2009';
            TableRelation = "PWD Call"."Call No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CallType: Record "PWD Call Type";
            begin
                GetCallCust("PWD Call No.");
                VALIDATE("Sell-to Customer No.", RecCall."Customer No.");
                VALIDATE("PWD Call Type", RecCall."Call Type");
                "PWD Commentaire 1" := RecCall."Commentaire 1";
                "PWD Commentaire 2" := RecCall."Commentaire 2";
                "PWD Commentaire 3" := RecCall."Commentaire 3";
                "PWD Commentaire 4" := RecCall."Commentaire 4";
                "PWD Commentaire 5" := RecCall."Commentaire 5";
                "PWD Monthly Code" := RecCall."Monthly Code";

                IF NOT CallType.GET("PWD Call Type") THEN CallType.INIT();
                "Shipment Method Code" := CallType."Shipment Method Code";
            end;
        }
        field(50001; "PWD Call Type"; Code[10])
        {
            Caption = 'Call Type';
            Description = 'PW2009';
            TableRelation = "PWD Call Type";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                LocationPriority.SETRANGE(LocationPriority."Call Type Code", "PWD Call Type");
                LocationPriority.SETCURRENTKEY("Call Type Code", "Location priority"); //gte
                LocationPriority.ASCENDING(TRUE);
                IF LocationPriority.FIND('-') THEN
                    VALIDATE("Location Code", LocationPriority."Location code");
                IF (CallType.GET("PWD Call Type")) AND ("PWD Call Type" <> '') THEN BEGIN
                    CallType.TESTFIELD("Posting No. Series");
                    VALIDATE("Posting No. Series", CallType."Posting No. Series");
                    CallType.TESTFIELD("Shipping No. Series");
                    VALIDATE("Shipping No. Series", CallType."Shipping No. Series");

                END;
                IF "PWD Call Type" = '' THEN BEGIN
                    SalesSetup.GET();
                    NoSeriesMgt.SetDefaultSeries("Shipping No. Series", SalesSetup."Posted Shipment Nos.");
                    NoSeriesMgt.SetDefaultSeries("Posting No. Series", SalesSetup."Posted Invoice Nos.");
                END;
            end;
        }
        field(50002; "PWD Delivery time"; Time)
        {
            Caption = 'Delivery time';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD DSA No."; Code[10])
        {
            Caption = 'DSA No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateSalesLines(FIELDCAPTION("PWD DSA No."), FALSE);
            end;
        }
        field(50004; "PWD Person Number"; Integer)
        {
            Caption = 'Person Number';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Preparation in process"; Boolean)
        {
            Caption = 'Preparation in process';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.RESET();
                SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        SalesLine."PWD Preparation in Process" := "PWD Preparation in process";
                        SalesLine.MODIFY();
                    UNTIL SalesLine.NEXT() = 0;
                IF "PWD Preparation in process" = FALSE THEN BEGIN
                    VALIDATE("PWD Preparation Status", "PWD Preparation Status"::" ");
                    VALIDATE("PWD Ready to ship", FALSE);
                    VALIDATE("PWD Order Prepared", FALSE);
                END;
            end;
        }
        field(50006; "PWD Order Prepared"; Boolean)
        {
            Caption = 'Order Prepared';
            Description = 'PW2009';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                SalesLine.RESET();
                SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                        SalesLine."PWD Order Line Prepared" := "PWD Order Prepared";
                        SalesLine.MODIFY();
                    UNTIL SalesLine.NEXT() = 0;

                IF "PWD Order Prepared" = TRUE THEN BEGIN
                    VALIDATE("PWD Preparation Status", "PWD Preparation Status"::"Ready to ship");
                    VALIDATE("PWD Ready to ship", TRUE);
                END ELSE BEGIN
                    IF ("PWD Preparation Status" = "PWD Preparation Status"::Prepared) OR ("PWD Preparation Status" = "PWD Preparation Status"::"Ready to ship") THEN
                        VALIDATE("PWD Preparation Status", "PWD Preparation Status"::"In process");
                    "PWD Ready to ship" := FALSE;
                END;
            END;
        }
        field(50021; "PWD Seafrance Order No."; Code[30])
        {
            Caption = 'Seafrance Order No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50110; "PWD Bill-to C/O"; Boolean)
        {
            Caption = 'c/o';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50111; "PWD Bill-to Additional name"; Text[50])
        {
            Caption = 'Nom complémentaire';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(55000; "PWD Filing Reason"; Code[10])
        {
            Caption = 'Filing Reason';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(36), "Field ID" = CONST(55000));
            DataClassification = CustomerContent;
        }
        field(55009; "PWD Trading Brand"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "PWD Trading Brand" = CONST(true)));
            Caption = 'Trading Brand';
            Description = 'PW2009';
            FieldClass = FlowField;
        }
        field(55010; "PWD Discount Profit %"; Decimal)
        {
            Caption = 'Discount Profit %';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55012; "PWD Order Trading Brand"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "PWD Order Trading brand" = CONST(True)));
            Caption = 'Order Trading Brand';
            Description = 'PW2009';
            FieldClass = FlowField;
        }
        field(55013; "PWD User Id"; Code[50])
        {
            Caption = 'User Id';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55014; "PWD Order to adjust"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("PWD Adjmt Prepared Qty" = FILTER(<> 0), "PWD Butchery" = FILTER(false), "PWD Countermark Location" = FILTER(false), "PWD Order Line Prepared" = FILTER(True)));
            Caption = 'Order to adjust';
            Description = 'PW2009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55015; "PWD Ready to ship"; Boolean)
        {
            Caption = 'Prêt à expédier';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55016; "PWD Preparation Status"; Option)
        {
            Caption = 'Preparation Status';
            Description = 'PW2009';
            Editable = false;
            OptionCaption = ' ,Ready to prepare,In process,Prepared,Ready to ship';
            OptionMembers = " ","Ready to prepare","In process",Prepared,"Ready to ship";
            DataClassification = CustomerContent;
        }
        field(55017; "PWD Ne pas utiliser No. de DSA"; Boolean)
        {
            Caption = 'Ne pas utiliser N° de DSA';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55018; "PWD Livraison OK"; Boolean)
        {
            Caption = 'Livraison OK';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55019; "PWD Reference"; Text[100])
        {
            Caption = 'Référence';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55048; "PWD Monthly Code"; Code[10])
        {
            Caption = 'Monthly Code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(55050; "PWD Presta Facturable par fourniss"; Boolean)
        {
            Caption = 'Presta Facturable par fourniss';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60001; "PWD Commentaire 1"; Text[50])
        {
            Caption = 'Commentaire 1';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60002; "PWD Commentaire 2"; Text[50])
        {
            Caption = 'Commentaire 2';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60003; "PWD Commentaire 3"; Text[50])
        {
            Caption = 'Commentaire 3';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60004; "PWD Commentaire 4"; Text[50])
        {
            Caption = 'Commentaire 4';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(60005; "PWD Commentaire 5"; Text[50])
        {
            Caption = 'Commentaire 5';
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
    }
    local procedure GetCallCust(CallCustNo: Code[20])
    begin
        IF NOT (CallCustNo = '') THEN BEGIN
            IF CallCustNo <> RecCall."Call No." THEN
                RecCall.GET(CallCustNo);
        END ELSE
            CLEAR(CallCustNo);
    end;

    procedure VerifyPriceweight(var salesorderII: Record "Sales Header")
    var
        Location: Record Location;
    begin
        SalesLineII.RESET();
        SalesLineII.SETRANGE("Document Type", salesorderII."Document Type");
        SalesLineII.SETRANGE("Document No.", salesorderII."No.");
        SalesLineII.SETRANGE(SalesLineII.Type, SalesLineII.Type::Item);
        IF (SalesLineII.FIND('-')) THEN BEGIN
            IF SalesLineII."Gross Weight" = 0 THEN
                ERROR(CstG002);
            IF SalesLineII."Net Weight" = 0 THEN
                ERROR(CstG001);
            IF ((Location.GET(SalesLineII."Location Code")) AND (Location."PWD Controle du prix plancher")) THEN
                IF SalesLineII."Unit Price" = 0 THEN
                    ERROR(CstG003);
        END;
    end;

    procedure CalcAlcool(var VolumeEff: Decimal; var TotalPI: Decimal; var TotalBiere: Decimal; var TotalVin: Decimal; var TotalVolEff: Decimal; var TotalMillCig: Decimal; var TotalKgTabac: Decimal; var TotalAlcoolPur: Decimal; var TotalRhum: Decimal)
    var
        FromSalesLine: Record "Sales Line";
        Item: Record Item;
        ItemFamily: Record "PWD Family & Sub Family";
        ItemSubFamily: Record "PWD Family & Sub Family";
        VolumeLigne: Decimal;
        PoidsLigne: Decimal;
        "QtéAlcool": Decimal;
        "QtéTabac": Decimal;
        "QtéAlcoolTotal": Decimal;
        "QtéTabacTotal": Decimal;
    begin

        CLEAR(FromSalesLine);
        FromSalesLine.SETRANGE("Document Type", "Document Type");
        FromSalesLine.SETRANGE("Document No.", "No.");
        FromSalesLine.SETRANGE(Type, FromSalesLine.Type::Item);
        IF FromSalesLine.FIND('-') THEN
            REPEAT
                CLEAR(VolumeLigne);
                CLEAR(PoidsLigne);
                CLEAR(QtéAlcool);
                CLEAR(QtéTabac);
                CLEAR(VolumeEff);

                VolumeLigne := FromSalesLine."Net Weight" * FromSalesLine."Quantity (Base)";
                PoidsLigne := FromSalesLine."Net Weight" * FromSalesLine."Quantity (Base)";

                Item.GET(FromSalesLine."No.");

                // Calcul total tabac alcool
                IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family") THEN BEGIN
                    IF ((ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool) AND (Item."PWD Family" = '47')) THEN BEGIN
                        IF Item."PWD Alcool %" <> 0 THEN BEGIN
                            IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN
                                QtéAlcool := FromSalesLine."Net Weight" * FromSalesLine."Quantity (Base)" / 100;
                            IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net x °Alcool" THEN
                                QtéAlcool := FromSalesLine."Net Weight" * FromSalesLine."Quantity (Base)" * Item."PWD Alcool %" / 100;
                        END;
                        IF ((Item."PWD Family" = '47') AND (Item."PWD Sub Family" <> '05')) THEN TotalAlcoolPur += QtéAlcool;
                        IF ((Item."PWD Family" = '47') AND (Item."PWD Sub Family" = '05')) THEN TotalRhum += QtéAlcool;
                    END;

                    IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN
                        IF ItemFamily."Mode de calcul AT" = ItemFamily."Mode de calcul AT"::"Poids Net" THEN
                            QtéTabac := FromSalesLine."Net Weight" * FromSalesLine."Quantity (Base)";
                END;
                QtéAlcoolTotal := QtéAlcoolTotal + QtéAlcool;
                QtéTabacTotal := QtéTabacTotal + QtéTabac;

                IF ItemFamily.GET(ItemFamily.Type::Item, ItemFamily."Group Type"::Family, '', Item."PWD Family") THEN BEGIN
                    IF ItemFamily."Type famille" = ItemFamily."Type famille"::Alcool THEN BEGIN
                        VolumeEff := VolumeLigne;
                        TotalVolEff += VolumeEff;
                        IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family",
                                              Item."PWD Family", Item."PWD Sub Family") THEN BEGIN
                            IF ((Item."PWD Family" = '46') AND (Item."PWD Sub Family" = '02')) THEN TotalPI += VolumeLigne;
                            IF (Item."PWD Family" = '41') THEN TotalBiere += VolumeLigne;
                            IF (Item."PWD Family" IN ['43', '44', '45']) THEN TotalVin += VolumeLigne;
                        END;
                    END;
                    IF ItemFamily."Type famille" = ItemFamily."Type famille"::Tabac THEN
                        IF ItemSubFamily.GET(ItemSubFamily.Type::Item, ItemSubFamily."Group Type"::"Sub Family",
                                              Item."PWD Family", Item."PWD Sub Family") THEN BEGIN
                            IF ((Item."PWD Family" = '48') AND (Item."PWD Sub Family" = '10')) THEN
                                TotalMillCig += ((FromSalesLine."Quantity (Base)" * 200) / 1000);
                            IF ((Item."PWD Family" = '48') AND (Item."PWD Sub Family" IN ['20', '30'])) THEN TotalKgTabac += PoidsLigne;
                        END;
                END;
            UNTIL FromSalesLine.NEXT() = 0;
    end;
    //TODO
    // procedure BlockDocument()
    // var
    //     MemberOf: Record 2000000003;
    //     Text1000000001: Label 'Vous ne pouvez pas modifier de commande au statut %1.';
    // begin
    //     CLEAR(MemberOf);
    //     IF ((Status = Status::Released) AND (NOT MemberOf.GET(USERID, 'DIRECTION'))) THEN ERROR(Text1000000001, FORMAT(Status));
    // end;

    var
        RecCall: Record "PWD Call";
        LocationPriority: Record "PWD Location Priority";
        SalesLineII: Record "Sales Line";
        CallType: Record "PWD Call Type";
        CstG001: Label 'Vous devez remplir le poids Net pour toutes les lignes de vente';
        CstG002: Label 'Vous devez remplir le poids Brut pour toutes les lignes de vente';
        CstG003: Label 'Vous devez remplir le prix de l''article pour toutes les lignes de vente';
}

