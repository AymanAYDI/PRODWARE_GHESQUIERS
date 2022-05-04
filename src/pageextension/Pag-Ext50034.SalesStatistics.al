pageextension 50034 "PWD SalesStatistics" extends "Sales Statistics"
{
    layout
    {
        addafter(Customer)
        {
            group("PWD Marge")
            {
                caption = 'Marge';
                field("PWD ProfitPct"; ProfitPct)
                {
                    ApplicationArea = all;
                    Caption = 'Original Profit %';
                    DecimalPlaces = 1 : 1;
                    Editable = FALSE;
                }
                field("PWD Discount Profit"; Cust."Discount Profit %")
                {
                    ApplicationArea = all;
                    Caption = 'Discount Profit %';
                    Editable = false;
                }
                field("Margin Profit"; ProfitPct - Cust."Discount Profit %")
                {
                    ApplicationArea = all;
                    Caption = 'Margin Profit %';
                }
                field("PWD ProfitLCY"; ProfitLCY)
                {
                    Caption = 'Profit (LCY)';
                    ApplicationArea = all;
                }
                field("Discount Profit (LCY)"; TotalSalesLineLCY.Amount * Cust."Discount Profit %" / 100)
                {
                    ApplicationArea = all;
                    Caption = 'Discount Profit (LCY)';
                    Editable = false;
                }
                field("Differencial Profit (LCY)"; ProfitLCY - (TotalSalesLineLCY.Amount * Cust."Discount Profit %" / 100))
                {
                    ApplicationArea = All;
                    Caption = 'Differencial Profit (LCY)';
                }

            }
        }
    }
    var

}
