report 50115 "PWD Evaluation stock SAS Ghes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/EvaluationstockSASGhes.rdl';
    Caption = 'Evaluation stock SAS Ghes';
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
            column("USERID"; USERID)
            {
            }
            column(InfoSoc_Name; InfoSoc.Name)
            {
            }
            column(Item_TABLECAPTION; STRSUBSTNO('%1: %2', Item.TABLECAPTION, ItemFilter))
            {
            }
            column(Text005_StartDateText_; STRSUBSTNO(Text005, StartDateText))
            {
            }
            column(Text005_EndDate; STRSUBSTNO(Text005, FORMAT(EndDate)))
            {
            }
            column(EmptyString_Control57; '')
            {
            }
            column(Text006_TariffNumber_Description2; STRSUBSTNO(Text006, "Tariff No.", TariffNumber."PWD Description 2"))
            {
            }
            column(ValueOfInvoicedQty; ValueOfInvoicedQty)
            {
                AutoFormatType = 1;
            }
            column(ValueOfInvIncreases; ValueOfInvIncreases)
            {
                AutoFormatType = 1;
            }
            column(CostOfInvDecreases; CostOfInvDecreases)
            {
                AutoFormatType = 1;
            }
            column(ValueEntry_CostAmountActual; "Value Entry"."Cost Amount (Actual)")
            {
            }
            column(STRSUBSTNO_Text007__Tariff_No___; STRSUBSTNO(Text007, "Tariff No."))
            {
            }
            column(InvDecreases; InvDecreases)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Item_Ledger_Entry___Invoiced_Quantity_; "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(ValueOfRcdIncreases_; ValueOfRcdIncreases)
            {
                AutoFormatType = 1;
            }
            column(Item_CostOfShipDecreases; CostOfShipDecreases)
            {
                AutoFormatType = 1;
            }
            column(ValueOfQtyOnHand_ValueOfRcdIncreases__CostOfShipDecreases; ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases)
            {
                AutoFormatType = 1;
            }
            column(STRSUBSTNO_Text008__Tariff_No___; STRSUBSTNO(Text008, "Tariff No."))
            {
            }
            column(ShipDecreases; ShipDecreases)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Item_Ledger_Entry__Quantity; "Item Ledger Entry".Quantity)
            {
            }
            column(STRSUBSTNO_Text009__Tariff_No___; STRSUBSTNO(Text009, "Tariff No."))
            {
            }

            column(ValueOfInvoicedQty_Control84; ValueOfInvoicedQty)
            {
                AutoFormatType = 1;
            }
            column(InvIncreases; InvIncreases)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Item_Ledger_Entry_Invoiced_Quantity; "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(ValueOfQtyOnHand; ValueOfQtyOnHand)
            {
                AutoFormatType = 1;
            }
            column(ValueOfRcdIncreases; ValueOfRcdIncreases)
            {
                AutoFormatType = 1;
            }
            column(CostOfShipDecreases_; CostOfShipDecreases)
            {
                AutoFormatType = 1;
            }
            column(ValueOfQtyOnHand___ValueOfRcdIncreases___CostOfShipDecreases_Control48; ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases)
            {
                AutoFormatType = 1;
            }
            column(ShipDecreases_Control1000000012; ShipDecreases)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Item_Ledger_Entry__Quantity_Control1000000016; "Item Ledger Entry".Quantity)
            {
            }
            column(InventoryValuationTariff_No_Caption; Inventory_Valuation____Tariff_No_CaptionLbl)
            {
            }
            column(PAGECaptionLbl; PAGECaptionLbl)
            {
            }
            column(Text_Caption; This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl)
            {
            }
            column(ItemLedgerEntry_ItemNo_Caption; "Item Ledger Entry".FIELDCAPTION("Item No."))
            {
            }
            column(Item_Description_CaptionLbl; Item_Description_CaptionLbl)
            {
            }
            column(Coût_unitaireCaption; Coût_unitaireCaptionLbl)
            {
            }
            column(InvIncreases_Caption; InvIncreases_Control38CaptionLbl)
            {
            }
            column(InvDecreases_Caption; InvDecreases_CaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(ValueCaption_Control32; ValueCaption_Control32Lbl)
            {
            }
            column(ValueCaption_Control56; ValueCaption_Control56Lbl)
            {
            }

            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Expected_Cost_Included_TotalCaption; Expected_Cost_Included_TotalCaptionLbl)
            {
            }
            column(Expected_Cost_TotalCaption; Expected_Cost_TotalCaptionLbl)
            {
            }
            column(Item_No_; "No.")
            {
            }
            column(Item_Tariff_No_; "Tariff No.")
            {
            }
            column(Item_Description_____Item__Description_2_Caption; Control34)
            {
            }
            column(QuantityCaption_Control1000000019; QuantityCaption_Control1000000019)
            {
            }
            column(QuantityCaption_Control1000000021; QuantityCaption_Control1000000021)
            {
            }

            column(QuantityCaption_Control1000000022; QuantityCaption_Control1000000022)
            {
            }

            column(QuantityCaption_Control1000000020; QuantityCaption_Control1000000020Lbl)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = SORTING("Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.");
                column(Item_Ledger_Entry_Item_No_; "Item No.")
                {
                }
                column(Open; Open)
                {
                }
                column(Item_Ledger_Entry_Positive; Positive)
                {
                }
                column(Item_Ledger_Entry_Variant_Code; "Variant Code")
                {
                }
                column(Item_Ledger_Entry_Serial_No; "Serial No.")
                {
                }
                column(Item_Ledger_Entry_Lot_No; "Lot No.")
                {
                }
                column(Item_Ledger_Entry_Expiration_Date; "Expiration Date")
                {
                }
                column(Item_Description_Item__Description_2_; Item.Description + ' ' + Item."Description 2")
                {
                }
                column(Coût_unitaire; ItemUnitCost)
                {
                }
                column(InvoicedQty; InvoicedQty)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(InvIncreases_Control38; InvIncreases)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(InvDecreases_Control39; InvDecreases)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ValueOfInvoicedQty_Control15; ValueOfInvoicedQty)
                {
                    AutoFormatType = 1;
                }
                column(Value_Entry_Cost_Amount_Actual; "Value Entry"."Cost Amount (Actual)")
                {
                }
                column(Item_Ledger_Entry__Invoiced_Quantity_; "Invoiced Quantity")
                {
                }
                column(Quantity_Order; Item."Qty. on Sales Order" + Item."PWD Qty. on Quote Order")
                {
                    DecimalPlaces = 0 : 2;
                }
                column(Item_Coût_unitaire; Item."Qty. on Purch. Order")
                {
                }
                column(Item_Ledger_Entry_Quantity; Quantity)
                {
                }
                column(QtyOnHand; QtyOnHand)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(RcdIncreases; RcdIncreases)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(ValueOfQtyOnHand_ValueOfRcdIncreases_CostOfShipDecreases; ValueOfQtyOnHand + ValueOfRcdIncreases - CostOfShipDecreases)
                {
                    AutoFormatType = 1;
                }
                column(CostOfShipDecreases; CostOfShipDecreases)
                {
                    AutoFormatType = 1;
                }
                column(ValueOfQtyOnHand__Control50; ValueOfQtyOnHand)
                {
                    AutoFormatType = 1;
                }
                column(Expected_Cost_IncludedCaption; Expected_Cost_IncludedCaptionLbl)
                {
                }
                column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemTableView = SORTING("Item Ledger Entry No.");
                    column(ShowExpected; ShowExpected)
                    {
                    }
                    column(ExpCostPostedToGL; ExpCostPostedToGL)
                    {
                    }
                    column(CostPostedToGL; CostPostedToGL)
                    {
                    }
                    column(StartDate; StartDate)
                    {
                    }
                    column(InvandShipDiffer; InvandShipDiffer)
                    {
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
                        END ELSE
                            IF ("Item Ledger Entry Type" IN
                               ["Item Ledger Entry Type"::Purchase,
                                "Item Ledger Entry Type"::"Positive Adjmt.",
                                "Item Ledger Entry Type"::Output])
                            THEN BEGIN
                                ValueOfRcdIncreases := "Cost Amount (Expected)";
                                ValueOfInvIncreases := "Cost Amount (Actual)";
                                InvIncreases := "Invoiced Quantity";
                            END ELSE BEGIN
                                CostOfShipDecreases := -"Cost Amount (Expected)";
                                CostOfInvDecreases := -"Cost Amount (Actual)";
                                InvDecreases := -"Invoiced Quantity";
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
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Item No.", Item."No.");
                    SETFILTER("Variant Code", Item.GETFILTER("Variant Filter"));
                    SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
                    SETFILTER("Global Dimension 1 Code", Item.GETFILTER("Global Dimension 1 Filter"));
                    SETFILTER("Global Dimension 2 Code", Item.GETFILTER("Global Dimension 2 Filter"));
                    IF EndDate <> 0D THEN
                        SETRANGE("Posting Date", 0D, EndDate);

                    ItemUnitCost := ROUND(Item."Unit Cost", 0.01);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                InvandShipDiffer := FALSE;
                IF TariffNumber.GET(Item."Tariff No.") THEN;
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
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; "StartDate")
                    {
                        Caption = 'Starting Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; "EndDate")
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = All;
                    }
                    field(ShowExpected; "ShowExpected")
                    {
                        Caption = 'Include Expected Cost';
                        ApplicationArea = All;
                    }
                }
            }
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
    end;

    var
        InfoSoc: Record "Company Information";
        TariffNumber: Record "Tariff Number";
        InvandShipDiffer: Boolean;
        ShowExpected: Boolean;
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
        ItemUnitCost: Decimal;
        QtyOnHand: Decimal;
        RcdIncreases: Decimal;
        ShipDecreases: Decimal;
        ValueOfInvIncreases: Decimal;
        ValueOfInvoicedQty: Decimal;
        ValueOfQtyOnHand: Decimal;
        ValueOfRcdIncreases: Decimal;
        "Coût_unitaireCaptionLbl": Label 'Coût unitaire';
        PAGECaptionLbl: Label 'Page';
        Expected_Cost_Included_TotalCaptionLbl: Label 'Expected Cost Included Total';
        Expected_Cost_IncludedCaptionLbl: Label 'Expected Cost Included';
        Expected_Cost_TotalCaptionLbl: Label 'Expected Cost Total';
        InvDecreases_CaptionLbl: Label 'Decreases (LCY)';
        Inventory_Valuation____Tariff_No_CaptionLbl: Label 'Inventory Valuation  / Tariff No.';
        InvIncreases_Control38CaptionLbl: Label 'Increases (LCY)';
        Item_Description_CaptionLbl: Label 'Label';
        QuantityCaption_Control40Lbl: Label 'Quantity';
        QuantityCaption_Control58Lbl: Label 'Quantity';
        QuantityCaption_Control1000000019Lbl: Label 'Quantity';
        QuantityCaption_Control1000000020Lbl: Label 'Quantity';
        QuantityCaptionLbl: Label 'Quantity';
        Text005: Label 'As of %1';
        Text006: Label 'Inventory Posting Group: %1';
        Text007: Label 'Inventory Posting Group Total: %1';
        Text008: Label 'Expected Cost Included Total: %1';
        Text009: Label 'Expected Cost Total: %1';
        This_report_includes_entries_that_have_been_posted_with_expected_costs_CaptionLbl: Label 'This report includes entries that have been posted with expected costs.';
        TotalCaptionLbl: Label 'Total';
        ValueCaption_Control32Lbl: Label 'Value';
        ValueCaption_Control56Lbl: Label 'Value';
        ValueCaptionLbl: Label 'Value';
        Control34: Label 'Control34';
        QuantityCaption_Control1000000019: Label 'Quantité sur';
        QuantityCaption_Control1000000021: Label 'Cde Vente  /';
        QuantityCaption_Control1000000022: Label 'Cde Achat';
        StartDateText: Text[10];
        ItemFilter: Text[250];

    procedure InvAndShipDiffers(): Boolean
    begin
        EXIT(
          (QtyOnHand + RcdIncreases - ShipDecreases) <>
          (InvoicedQty + InvIncreases - InvDecreases));
    end;
}
