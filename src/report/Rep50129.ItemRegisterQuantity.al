report 50129 "PWD Item Register - Quantity"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/Item Register - Quantity.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Item Register - Quantity';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Register"; "Item Register")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(ItemRegFilterCopyText; TableCaption + ': ' + ItemRegFilter)
            {
            }
            column(ItemRegFilter; ItemRegFilter)
            {
            }
            column(No_ItemRegister; "No.")
            {
            }
            column(ItemRegQtyCaption; ItemRegQtyCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(ItemDescriptionCaption; ItemDescriptionCaptionLbl)
            {
            }
            column(No_ItemRegisterCaption; No_ItemRegisterCaptionLbl)
            {
            }
            column(LocationCap; LocationCap)
            {
            }
            column(Item_Register__Journal_Batch_Name; "Journal Batch Name")
            {
            }
            column(PoidsNetUnitaireCap; PoidsNetUnitaire)
            {
            }
            column(MontantdouaneCap; Montantdouane)
            {
            }
            column(TotalMontantDouaneCap; TotalMontantDouane)
            {
            }
            column(TotalPoidsNetCap; TotalPoidsNet)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(PostingDate_ItemLedgEntry; Format("Posting Date"))
                {
                }
                column(EntryType_ItemLedgEntry; "Entry Type")
                {
                    IncludeCaption = true;
                }
                column(ItemNo_ItemLedgEntry; "Item No.")
                {
                    IncludeCaption = true;
                }
                column(ItemDescription; ItemDescription)
                {
                }
                column(Quantity_ItemLedgEntry; Quantity)
                {
                    IncludeCaption = true;
                }
                column(EntryNo_ItemLedgEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(DocNo_ItemLedgEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(LocationCode_ItemLedgEntry; "Location Code")
                {
                }
                column(NetWeight_ItemLedgEntry; "PWD Net Weight")
                {
                    DecimalPlaces = 2 : 3;
                }
                column(MontantDouane_ItemLedgEntry; "PWD Montant douane")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(MontantDouaneLigne; MontantDouaneLigne)
                {
                    DecimalPlaces = 2 : 2;
                }
                column(PoidsNetTotal; PoidsNetTotal)
                {
                    DecimalPlaces = 2 : 3;
                }
                column(Comments_ItemLedgEntry; "PWD Comments")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*
                    ItemDescription := Description;
                    if ItemDescription = '' then begin
                        if not Item.Get("Item No.") then
                            Item.Init();
                        ItemDescription := Item.Description;
                    end;*/
                    // Modif C2A(LLE)
                    IF NOT Item.GET("Item No.") THEN
                        Item.INIT();
                    ItemDescription := Item.Description + Item."Description 2";
                    // FinModif C2A(LLE)
                    MontantDouaneLigne := "Item Ledger Entry".Quantity * "Item Ledger Entry"."PWD Montant douane";
                    // Modif C2A(LLE) suite appel 7718
                    PoidsNetTotal := "Item Ledger Entry".Quantity * "Item Ledger Entry"."PWD Net Weight";
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Entry No.", "Item Register"."From Entry No.", "Item Register"."To Entry No.");
                end;
            }
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
        ItemRegFilter := "Item Register".GetFilters;
    end;

    var
        Item: Record Item;
        ItemRegFilter: Text;
        ItemDescription: Text[100];
        ItemRegQtyCaptionLbl: Label 'Item Register - Quantity';
        CurrReportPageNoCaptionLbl: Label 'Page';
        PostingDateCaptionLbl: Label 'Posting Date';
        ItemDescriptionCaptionLbl: Label 'Description';
        No_ItemRegisterCaptionLbl: Label 'Register No.';
        Montantdouane: label 'Montant douane';
        PoidsNetUnitaire: label 'Poids Net Unitaire';
        LocationCap: label 'Location Code';
        TotalMontantDouane: label 'Total Montant douane:';
        TotalPoidsNet: label 'Total Poids Net:';
        MontantDouaneLigne: Decimal;
        PoidsNetTotal: Decimal;

}

