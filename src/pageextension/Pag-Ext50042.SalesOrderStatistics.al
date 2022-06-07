pageextension 50042 "PWD SalesOrderStatistics" extends "Sales Order Statistics"
{
    layout
    {
        addafter(Customer)
        {
            group("PWD Profit")
            {
                caption = 'Profit';
                //TODO
                /*
                                field(CustDiscountProfit; Customer."Discount Profit %")
                                {
                                    applicationarea = all;
                                }
                                field("PWD ProfitPct1"; CurrPage."ProfitPct[1]")
                                {
                                    Caption = '% marge sur vente';
                                    ApplicationArea = All;
                                }
                                field("PWD ProfitLCY[1]"; ProfitLCY[1])
                                {
                                    ApplicationArea = All;
                                }

                                field("Margin Profit"; CurrPage."ProfitPct[1]" - Customer."Discount Profit %")
                                {
                                    Caption = 'Margin Profit';
                                    applicationarea = all;
                                }

                                field(DiscountProfitLCY; TotalSalesLineLCY[1].Amount * Customer."Discount Profit %" / 100)
                                {
                                    Caption = 'Discount Profit (LCY)';
                                    applicationarea = all;
                                    Editable = FALSE;
                                }
                                field("Differencial Profit (LCY)"; ProfitLCY[1] - (TotalSalesLineLCY[1]].Amount * Customer."Discount Profit %" / 100))
                                {
                                    ApplicationArea = All;
                                }
                                */
            }
        }
        addafter("PWD Profit")
        {
            group("PWD Alcool")
            {
                caption = 'Alcool';
                field("PWD TotalPI"; TotalPI)
                {
                    caption = 'PI';
                    applicationarea = all;
                    Editable = FALSE;
                }
                field("PWD TotalBiere"; TotalBiere)
                {
                    Caption = 'BiŠre';
                    applicationarea = all;
                }
                field("PWD TotalVin"; TotalVin)
                {
                    caption = 'Vin/Champ./Mousseux';
                    applicationarea = all;
                    Editable = FALSE;
                }
                field("PWD TotalVolEff"; TotalVolEff)
                {
                    caption = 'Effective volume';
                    applicationarea = all;
                    Editable = FALSE;
                }
                field("PWD TotalAlcoolPur"; TotalAlcoolPur)
                {
                    caption = 'Pur Alcool';
                    applicationarea = all;
                    Editable = FALSE;
                }
                field("PWD TotalRhum"; TotalRhum)
                {
                    caption = 'Rhums DOM';
                    applicationarea = all;
                    Editable = FALSE;
                }
                /*field("PWD Mille cigarettes"; "Mille cigarettes")
                {
                    applicationarea = all;
                    caption = 'Mille cigarettes';
                }*/
                field("PWD TotalKgTabac"; TotalKgTabac)
                {
                    ApplicationArea = all;
                    Caption = 'Kg tabac';
                    Editable = FALSE;
                }
            }
        }
    }
    var
        Customer: Record Customer;
        TotalAlcoolPur: Decimal;
        TotalBiere: Decimal;
        TotalKgTabac: Decimal;
        TotalMillCig: Decimal;
        TotalPI: Decimal;
        TotalRhum: Decimal;
        TotalVin: Decimal;
        TotalVolEff: Decimal;
        VolumeEff: Decimal;

    trigger OnAfterGetRecord()
    var
    //  EntryExitPoints: page "Entry/Exit Points";
    begin
        if Customer.Get(Rec."Bill-to Customer No.") then;
        Rec.CalcAlcool(VolumeEff, TotalPI, TotalBiere, TotalVin, TotalVolEff, TotalMillCig, TotalKgTabac, TotalAlcoolPur, TotalRhum);
    end;
}
