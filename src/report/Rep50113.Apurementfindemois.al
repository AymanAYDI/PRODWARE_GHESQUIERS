report 50113 "PWD Apurement fin de mois"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/Apurementfindemois.rdl';
    Caption = 'Inventory Valuation';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("Tariff No.", "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "PWD Family", "Tariff No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; '')
            {
            }
            column(USERID; USERID)
            {
            }
            column(InfoSoc_Name; InfoSoc.Name)
            {
            }
            column(Item_TABLECAPTION_ItemFilter; STRSUBSTNO('Pour %1, les filtres sont: %2', Item.TABLECAPTION, ItemFilter))
            {
            }
            column(Filtre___ecrFilter; 'Filtre ' + ecrFilter)
            {
            }
            column(Text005_StartDateText; STRSUBSTNO(Text005, StartDateText))
            {
            }
            column(EmptyString; '')
            {
            }
            column(EmptyString_Control46; '')
            {
            }
            column(EmptyString_Control47; '')
            {
            }
            column(STRSUBSTNO_Text005_FORMAT_EndDate; STRSUBSTNO(Text005, FORMAT(EndDate)))
            {
            }
            column(EmptyString_Control57; '')
            {
            }
            column(Text006_Tariff_No_TariffNumber_Description; STRSUBSTNO(Text006, "Tariff No.", TariffNumber.Description))
            {
            }
            column(STRSUBSTNO_Text007__Tariff_No___; STRSUBSTNO(Text007, "Tariff No."))
            {
            }
            column(ValueInAmountEndPeriod; ValueInAmountEndPeriod)
            {
                AutoFormatType = 1;
                DecimalPlaces = 5 : 5;
            }
            column(Inventory_ValuationCaption; Inventory_ValuationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; "Item Ledger Entry".FIELDCAPTION("Item No."))
            {
            }
            column(DésignationCaption; DésignationCaptionLbl)
            {
            }
            column("EntréesCaption"; EntréesCaptionLbl)
            {
            }
            column(SortiesCaption; SortiesCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Stock_Final_en_montantCaption; Stock_Final_en_montantCaptionLbl)
            {
            }
            column(Item_No_; "No.")
            {
            }
            column(Item_Tariff_No_; "Tariff No.")
            {
            }
            column(QttValorisedEndPeriod; QttValorisedEndPeriod)
            {
                DecimalPlaces = 5 : 5;
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = SORTING("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
                RequestFilterFields = "Location Code";
                column(Item_Ledger_Entry_Item_No; "Item No.")
                {
                }
                column(Item_Description_Item__Description_2; Item.Description + Item."Description 2")
                {
                }

                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemTableView = SORTING("Item Ledger Entry No.");
                    column(ValueOfQtyOnHand; ValueOfQtyOnHand)
                    {
                    }
                    column(ValueOfRcdIncreases; ValueOfRcdIncreases)
                    {
                    }
                    column(InvoicedQty; InvoicedQty)
                    {
                        DecimalPlaces = 5 : 5;
                    }
                    column(CostOfShipDecreases; CostOfShipDecreases)
                    {
                    }
                    column(InvandShipDiffer; InvandShipDiffer)
                    {
                    }
                    column(CostPostedToGL; CostPostedToGL)
                    {
                    }
                    column(ExpCostPostedToGL; ExpCostPostedToGL)
                    {
                    }
                    column(InvDecreases; InvDecreases)
                    {
                        DecimalPlaces = 5 : 5;
                    }
                    column(InvIncreases; InvIncreases)
                    {
                        DecimalPlaces = 5 : 5;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF (EndDate <> 0D) AND ("Posting Date" > EndDate) THEN
                            CurrReport.SKIP();
                        ValueOfQtyOnHand := 0;
                        ValueOfInvoicedQty := 0;
                        InvoicedQty := 0;

                        ValueOfRcdIncreases := 0;
                        ValueOfInvIncreases := 0;
                        InvIncreases := 0;

                        CostOfShipDecreases := 0;
                        CostOfInvDecreases := 0;
                        InvDecreases := 0;
                        IF ("Posting Date" < StartDate) THEN BEGIN
                            ValueOfQtyOnHand := "Cost Amount (Expected)";
                            ValueOfInvoicedQty := "Cost Amount (Actual)";
                            InvoicedQty := "Invoiced Quantity";
                            IF (methodeAT = 1) THEN InvoicedQty := "Invoiced Quantity" * Item."Net Weight" / 100;
                            IF (methodeAT = 2) THEN InvoicedQty := "Invoiced Quantity" * Item."Net Weight" * Item."PWD Alcool %" / 100;
                            IF (methodeAT = 3) THEN InvoicedQty := "Invoiced Quantity" * Item."Net Weight";

                        END ELSE
                            IF ("Item Ledger Entry Type" IN
                               ["Item Ledger Entry Type"::Purchase,
                                "Item Ledger Entry Type"::"Positive Adjmt.",
                                "Item Ledger Entry Type"::Output])
                            THEN BEGIN
                                ValueOfRcdIncreases := "Cost Amount (Expected)";
                                ValueOfInvIncreases := "Cost Amount (Actual)";
                                InvIncreases := "Invoiced Quantity";
                                IF methodeAT = 1 THEN InvIncreases := "Invoiced Quantity" * Item."Net Weight" / 100;
                                IF methodeAT = 2 THEN InvIncreases := "Invoiced Quantity" * Item."Net Weight" * Item."PWD Alcool %" / 100;
                                IF methodeAT = 3 THEN InvIncreases := "Invoiced Quantity" * Item."Net Weight";

                            END ELSE BEGIN
                                CostOfShipDecreases := -"Cost Amount (Expected)";
                                CostOfInvDecreases := -"Cost Amount (Actual)";
                                InvDecreases := -"Invoiced Quantity";
                                IF methodeAT = 1 THEN InvDecreases := -"Invoiced Quantity" * Item."Net Weight" / 100;
                                IF methodeAT = 2 THEN InvDecreases := -"Invoiced Quantity" * Item."Net Weight" * Item."PWD Alcool %" / 100;
                                IF methodeAT = 3 THEN InvDecreases := -"Invoiced Quantity" * Item."Net Weight";
                            END;

                        IF "Expected Cost" THEN BEGIN
                            CostPostedToGL := "Cost Posted to G/L";
                            ExpCostPostedToGL := "Cost Posted to G/L";
                        END ELSE
                            InvCostPostedToGL := "Cost Posted to G/L";
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF ShowExpected AND InvAndShipDiffers() THEN
                            InvandShipDiffer := TRUE
                        ELSE BEGIN
                            ValueOfQtyOnHand := ValueOfInvoicedQty;
                            ValueOfRcdIncreases := ValueOfInvIncreases;
                            CostOfShipDecreases := CostOfInvDecreases;
                            CostPostedToGL := InvCostPostedToGL;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                        SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
                        SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
                        SETFILTER("Global Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
                        SETFILTER("Global Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    QtyOnHand := 0;
                    RcdIncreases := 0;
                    ShipDecreases := 0;
                    IF TariffNumber.GET(Item."Tariff No.") THEN;
                    IF "Posting Date" < StartDate THEN
                        QtyOnHand := Quantity
                    ELSE
                        IF ("Entry Type" IN
                           ["Entry Type"::Purchase,
                            "Entry Type"::"Positive Adjmt.",
                            "Entry Type"::Output])
                        THEN
                            RcdIncreases := Quantity
                        ELSE
                            ShipDecreases := -Quantity;
                    QttValorisedEndPeriod := "Invoiced Quantity";
                    IF methodeAT = 1 THEN QttValorisedEndPeriod := "Invoiced Quantity" * Item."Net Weight" / 100;
                    IF methodeAT = 2 THEN QttValorisedEndPeriod := "Invoiced Quantity" * Item."Net Weight" * Item."PWD Alcool %" / 100;
                    IF methodeAT = 3 THEN QttValorisedEndPeriod := "Invoiced Quantity" * Item."Net Weight";
                    IF magasin.GET("Item Ledger Entry"."Location Code") THEN BEGIN
                        IF magasin."PWD Valorisation mvts periode" = magasin."PWD Valorisation mvts periode"::"Coût unitaire" THEN
                            ValueInAmountEndPeriod := "Invoiced Quantity" * Item."Unit Cost";
                        IF magasin."PWD Valorisation mvts periode" = magasin."PWD Valorisation mvts periode"::"Prix douane" THEN
                            ValueInAmountEndPeriod := "Invoiced Quantity" * Item."PWD Customs Price";
                    END;
                end;

                trigger OnPreDataItem()
                begin

                    SETRANGE("Item No.", Item."No.");
                    SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
                    SETFILTER("Global Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
                    SETFILTER("Global Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
                    IF EndDate <> 0D THEN
                        SETRANGE("Posting Date", 0D, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ToutTypeFamille = FALSE THEN
                    IF (Item."PWD Family" = '') AND (Item."PWD Family (Sea France)" = '') THEN
                        CurrReport.SKIP()
                    ELSE
                        IF ItemFamille.GET(ItemFamille.Type::Item, ItemFamille."Group Type"::Family, '', Item."PWD Family (Sea France)")
                        THEN BEGIN
                            IF ItemFamille."Type famille" = ItemFamille."Type famille"::" " THEN
                                CurrReport.SKIP()
                        END ELSE
                            IF ItemFamille.GET(ItemFamille.Type::Item, ItemFamille."Group Type"::Family, '', Item."PWD Family") THEN
                                IF ItemFamille."Type famille" = ItemFamille."Type famille"::" " THEN CurrReport.SKIP();
                InvandShipDiffer := FALSE;
                methodeAT := 0;
                IF ItemFamille.GET(ItemFamille.Type::Item, ItemFamille."Group Type"::Family, '', Item."PWD Family (Sea France)") THEN BEGIN
                    IF (ItemFamille."Type famille" = ItemFamille."Type famille"::Alcool) AND
                       (ItemFamille."Mode de calcul AT" = ItemFamille."Mode de calcul AT"::"Poids Net") THEN
                        methodeAT := 1;
                    IF (ItemFamille."Type famille" = ItemFamille."Type famille"::Alcool) AND
                       (ItemFamille."Mode de calcul AT" = ItemFamille."Mode de calcul AT"::"Poids Net x °Alcool") THEN
                        methodeAT := 2;
                    IF (ItemFamille."Type famille" = ItemFamille."Type famille"::Tabac) AND
                       (ItemFamille."Mode de calcul AT" = ItemFamille."Mode de calcul AT"::"Poids Net") THEN
                        methodeAT := 3;
                END ELSE
                    IF ItemFamille.GET(ItemFamille.Type::Item, ItemFamille."Group Type"::Family, '', Item."PWD Family") THEN BEGIN
                        IF (ItemFamille."Type famille" = ItemFamille."Type famille"::Alcool) AND
                           (ItemFamille."Mode de calcul AT" = ItemFamille."Mode de calcul AT"::"Poids Net") THEN
                            methodeAT := 1;
                        IF (ItemFamille."Type famille" = ItemFamille."Type famille"::Alcool) AND
                           (ItemFamille."Mode de calcul AT" = ItemFamille."Mode de calcul AT"::"Poids Net x °Alcool") THEN
                            methodeAT := 2;
                        IF (ItemFamille."Type famille" = ItemFamille."Type famille"::Tabac) AND
                           (ItemFamille."Mode de calcul AT" = ItemFamille."Mode de calcul AT"::"Poids Net") THEN
                            methodeAT := 3;
                    END;
            end;

            trigger OnPreDataItem()
            begin
                ItemFilter := Item.GETFILTERS;
                InfoSoc.GET();
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF (StartDate = 0D) AND (EndDate = 0D) THEN
            EndDate := WORKDATE();

        IF StartDate IN [0D, 00000101D] THEN
            StartDateText := ''
        ELSE
            StartDateText := FORMAT(StartDate - 1);

        ecrFilter := "Item Ledger Entry".GETFILTERS;

        IF "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Location Code") = '' THEN
            ERROR('veuillez saisir un code magasin à filtrer');
    end;

    var
        InfoSoc: Record "Company Information";
        magasin: Record Location;
        ItemFamille: Record "PWD Family & Sub Family";
        TariffNumber: Record "Tariff Number";
        InvandShipDiffer: Boolean;
        ShowExpected: Boolean;
        ToutTypeFamille: Boolean;
        EndDate: Date;
        StartDate: Date;
        CostOfInvDecreases: Decimal;
        CostOfShipDecreases: Decimal;
        CostPostedToGL: Decimal;
        ExpCostPostedToGL: Decimal;
        InvCostPostedToGL: Decimal;
        InvDecreases: Decimal;
        InvIncreases: Decimal;
        InvoicedQty: Decimal;
        QttValorisedEndPeriod: Decimal;
        QtyOnHand: Decimal;
        RcdIncreases: Decimal;
        ShipDecreases: Decimal;
        ValueInAmountEndPeriod: Decimal;
        ValueOfInvIncreases: Decimal;
        ValueOfInvoicedQty: Decimal;
        ValueOfQtyOnHand: Decimal;
        ValueOfRcdIncreases: Decimal;
        methodeAT: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        "DésignationCaptionLbl": Label 'Désignation';
        "EntréesCaptionLbl": Label 'Entrées';
        Inventory_ValuationCaptionLbl: Label 'Inventory Valuation';
        QuantityCaptionLbl: Label 'Quantity';
        SortiesCaptionLbl: Label 'Sorties';
        Stock_Final_en_montantCaptionLbl: Label 'Stock Final en montant';
        Text005: Label 'As of %1';
        Text006: Label 'Inventory Posting Group: %1';
        Text007: Label 'Inventory Posting Group Total: %1';
        StartDateText: Text[10];
        ecrFilter: Text[250];
        ItemFilter: Text[250];

    procedure InvAndShipDiffers(): Boolean
    begin
        EXIT(
          (QtyOnHand + RcdIncreases - ShipDecreases) <>
          (InvoicedQty + InvIncreases - InvDecreases));
    end;
}
