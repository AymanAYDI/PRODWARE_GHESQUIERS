report 50053 "PWD Palmares des articles"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/Palmaresdesarticles.rdl';
    UsageCategory = None;
    Caption = 'Palmares des articles';
    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Source No.", "Item No.");
            RequestFilterFields = "Item No.", "Source No.", "Posting Date";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(SalesAmount; SalesAmount)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(SelectAmount; SelectAmount)
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(Item_Ledger_Entry__Source_No__; "Source No.")
            {
            }
            column(ABS_Quantity_; ABS(Quantity))
            {
            }
            column(Item_Ledger_Entry__Sales_Amount__Actual__; "Sales Amount (Actual)")
            {
            }
            column(PercCATotal; PercCATotal)
            {
            }
            column(TotalFor___FIELDCAPTION__Item_No___; TotalFor + FIELDCAPTION("Item No."))
            {
            }
            column(TotalFor___FIELDCAPTION__Source_No___; TotalFor + FIELDCAPTION("Source No."))
            {
            }
            column(VarMaxPrice; VarMaxPrice)
            {
            }
            column(Item_Ledger_Entry_Description; Description)
            {
            }
            column(ProfitN; ProfitN)
            {
            }
            column(PercentProfitN; PercentProfitN)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(DateFilterCaption; DateFilterCaptionLbl)
            {
            }
            column("Shéma_DirecteurCaption"; Shéma_DirecteurCaptionLbl)
            {
            }
            column(TABLEAUX_DE_BORD_ET_INDICATEURS_DE_PERFORMANCESCaption; TABLEAUX_DE_BORD_ET_INDICATEURS_DE_PERFORMANCESCaptionLbl)
            {
            }
            column(SAS_AVITACaption; SAS_AVITACaptionLbl)
            {
            }
            column("Palmares_des_articles_dont_le_montant_de_vente_est___àCaption"; Palmares_des_articles_dont_le_montant_de_vente_est___àCaptionLbl)
            {
            }
            column(Direction_et_CommerciauxCaption; Direction_et_CommerciauxCaptionLbl)
            {
            }
            column("Périodicité___HebdomadaireCaption"; Périodicité___HebdomadaireCaptionLbl)
            {
            }
            column(Item_Ledger_EntryCaption; Item_Ledger_EntryCaptionLbl)
            {
            }
            column(CurrReport_PAGENO_Caption; CurrReport_PAGENO_Control1000000004CaptionLbl)
            {
            }
            column(SelectAmountCaption; SelectAmountCaptionLbl)
            {
            }
            column("QuantitéCaption"; QuantitéCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Sales_Amount__Actual__Caption; FIELDCAPTION("Sales Amount (Actual)"))
            {
            }
            column(CA_TotalCaption; CA_TotalCaptionLbl)
            {
            }
            column(VarMaxPriceCaption; VarMaxPriceCaptionLbl)
            {
            }
            column(Item_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Item_Ledger_Entry__Source_No__Caption; FIELDCAPTION("Source No."))
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ItemLedgerEntry.CALCFIELDS("Sales Amount (Actual)");
                IF VarSalesAmount <> 0 THEN
                    PercCATotal := ("Sales Amount (Actual)" / VarSalesAmount) * 100;
                ProfitN := "Sales Amount (Actual)" - VarMaxPrice;
                IF "Sales Amount (Actual)" <> 0 THEN
                    PercentProfitN := ProfitN / "Sales Amount (Actual)" * 100;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Source No.");
                DateFilter := GETFILTER("Posting Date");
                IF SalesAmount <> 0 THEN
                    SETFILTER("Sales Amount (Actual)", '%1..', SalesAmount);
                //CurrReport.CREATETOTALS(PercCATotal, ProfitN, PercentProfitN);
                SETRANGE("Entry Type", "Entry Type"::Sale);

                // TotalAmountPeriod
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                IF DateFilter <> '' THEN
                    ItemLedgerEntry.SETFILTER("Posting Date", DateFilter);
                IF ItemLedgerEntry.FindSet() THEN
                    REPEAT
                        ItemLedgerEntry.CALCFIELDS("Sales Amount (Actual)");
                        VarSalesAmount += ItemLedgerEntry."Sales Amount (Actual)";
                    UNTIL ItemLedgerEntry.NEXT() = 0;

                IF RecItem.GET("Item No.") THEN
                    IF RecItem."PWD Maximum Price" <> 0 THEN
                        VarMaxPrice := RecItem."PWD Maximum Price" * Quantity
                    ELSE
                        VarMaxPrice := RecItem."Unit Cost" * Quantity;
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

    var
        RecItem: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        PercCATotal: Decimal;
        PercentProfitN: Decimal;
        ProfitN: Decimal;
        SalesAmount: Decimal;
        SelectAmount: Decimal;
        VarMaxPrice: Decimal;
        VarSalesAmount: Decimal;
        LastFieldNo: Integer;
        CA_TotalCaptionLbl: Label '% CA Total';
        CurrReport_PAGENO_Control1000000004CaptionLbl: Label 'Page';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DateFilterCaptionLbl: Label 'Filtre date';
        Direction_et_CommerciauxCaptionLbl: Label 'Direction et Commerciaux';
        Item_Ledger_EntryCaptionLbl: Label 'Item Ledger Entry';
        "Palmares_des_articles_dont_le_montant_de_vente_est___àCaptionLbl": Label 'Palmares des articles dont le montant de vente est > à';
        "Périodicité___HebdomadaireCaptionLbl": Label 'Périodicité : Hebdomadaire';
        "QuantitéCaptionLbl": Label 'Quantité';
        SAS_AVITACaptionLbl: Label 'SAS AVITA';
        SelectAmountCaptionLbl: Label 'Sélection du montant';
        "Shéma_DirecteurCaptionLbl": Label 'Shéma Directeur';
        TABLEAUX_DE_BORD_ET_INDICATEURS_DE_PERFORMANCESCaptionLbl: Label 'TABLEAUX DE BORD ET INDICATEURS DE PERFORMANCES';
        TotalFor: Label 'Total ';
        VarMaxPriceCaptionLbl: Label 'Montant Plancher';
        DateFilter: Text[30];
    // FooterPrinted: Boolean;
}
