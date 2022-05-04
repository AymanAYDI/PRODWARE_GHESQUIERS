report 113 "PWD ACustomer/Item Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerItemSales.rdlc';
    Caption = 'Customer/Item Sales';

    dataset
    {
        dataitem(DataItem6836; Table18)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(Value_Entry__TABLECAPTION__________ItemLedgEntryFilter; "Value Entry".TABLECAPTION + ': ' + ItemLedgEntryFilter)
            {
            }
            column(ItemLedgEntryFilter; ItemLedgEntryFilter)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual__; ValueEntryBuffer."Sales Amount (Actual)")
            {
            }
            column(ValueEntryBuffer__Discount_Amount_; -ValueEntryBuffer."Discount Amount")
            {
            }
            column(Profit; Profit)
            {
                AutoFormatType = 1;
            }
            column(ProfitPct; ProfitPct)
            {
                DecimalPlaces = 1 : 1;
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(Customer_Item_SalesCaption; Customer_Item_SalesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Item_No__Caption; ValueEntryBuffer__Item_No__CaptionLbl)
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(ValueEntryBuffer__Invoiced_Quantity_Caption; ValueEntryBuffer__Invoiced_Quantity_CaptionLbl)
            {
            }
            column(Item__Base_Unit_of_Measure_Caption; Item__Base_Unit_of_Measure_CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Sales_Amount__Actual___Control44Caption; ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl)
            {
            }
            column(ValueEntryBuffer__Discount_Amount__Control45Caption; ValueEntryBuffer__Discount_Amount__Control45CaptionLbl)
            {
            }
            column(Profit_Control46Caption; Profit_Control46CaptionLbl)
            {
            }
            column(ProfitPct_Control47Caption; ProfitPct_Control47CaptionLbl)
            {
            }
            column(Customer__Phone_No__Caption; FIELDCAPTION("Phone No."))
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            dataitem(DataItem8894; Table5802)
            {
                DataItemLink = Source No.=FIELD(No.),Posting Date=FIELD(Date Filter),Global Dimension 1 Code=FIELD(Global Dimension 1 Filter),Global Dimension 2 Code=FIELD(Global Dimension 2 Filter);
                DataItemTableView = SORTING(Source Type,Source No.,Item No.,Posting Date) WHERE(Source Type=CONST(Customer));
                RequestFilterFields = "Item No.","Inventory Posting Group","Posting Date";

                trigger OnAfterGetRecord()
                begin
                    ValueEntryBuffer.SETRANGE("Item No.", "Item No.");

                    IF NOT ValueEntryBuffer.FIND('-') THEN BEGIN
                      ValueEntryBuffer.INIT;
                      ValueEntryBuffer."Entry No." := NextEntryNo;
                      ValueEntryBuffer."Item No." := "Item No.";
                      ValueEntryBuffer.INSERT;

                      NextEntryNo := NextEntryNo + 1;
                    END;

                    ValueEntryBuffer."Invoiced Quantity" := ValueEntryBuffer."Invoiced Quantity" + "Invoiced Quantity";
                    ValueEntryBuffer."Sales Amount (Actual)" := ValueEntryBuffer."Sales Amount (Actual)" + "Sales Amount (Actual)";
                    ValueEntryBuffer."Cost Amount (Actual)" := ValueEntryBuffer."Cost Amount (Actual)" + "Cost Amount (Actual)";
                    ValueEntryBuffer."Discount Amount" := ValueEntryBuffer."Discount Amount" + "Value Entry"."Discount Amount";
                    ValueEntryBuffer."Cost Amount (Non-Invtbl.)" := ValueEntryBuffer."Cost Amount (Non-Invtbl.)" + "Cost Amount (Non-Invtbl.)";
                    ValueEntryBuffer.MODIFY;
                end;

                trigger OnPreDataItem()
                begin
                    ValueEntryBuffer.RESET;
                    ValueEntryBuffer.DELETEALL;

                    NextEntryNo := 1;
                end;
            }
            dataitem(DataItem5444;Table2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(ValueEntryBuffer__Item_No__;ValueEntryBuffer."Item No.")
                {
                }
                column(Item_Description;Item.Description)
                {
                }
                column(ValueEntryBuffer__Invoiced_Quantity_;-ValueEntryBuffer."Invoiced Quantity")
                {
                    DecimalPlaces = 0:5;
                }
                column(ValueEntryBuffer__Sales_Amount__Actual___Control44;ValueEntryBuffer."Sales Amount (Actual)")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Discount_Amount__Control45;-ValueEntryBuffer."Discount Amount")
                {
                    AutoFormatType = 1;
                }
                column(Profit_Control46;Profit)
                {
                    AutoFormatType = 1;
                }
                column(ProfitPct_Control47;ProfitPct)
                {
                    DecimalPlaces = 1:1;
                }
                column(Item__Base_Unit_of_Measure_;Item."Base Unit of Measure")
                {
                }
                column(ProfitPct_Control40;ProfitPct)
                {
                    DecimalPlaces = 1:1;
                }
                column(Profit_Control39;Profit)
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Discount_Amount__Control38;-ValueEntryBuffer."Discount Amount")
                {
                    AutoFormatType = 1;
                }
                column(ValueEntryBuffer__Sales_Amount__Actual___Control37;ValueEntryBuffer."Sales Amount (Actual)")
                {
                    AutoFormatType = 1;
                }
                column(Customer_Name_Control36;Customer.Name)
                {
                }
                column(Integer_Number;Number)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                      ValueEntryBuffer.FIND('-')
                    ELSE
                      ValueEntryBuffer.NEXT;

                    Profit :=
                      ValueEntryBuffer."Sales Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Non-Invtbl.)";

                    IF PrintToExcel AND Item.GET(ValueEntryBuffer."Item No.") THEN BEGIN
                      CalcProfitPct;
                      MakeExcelDataBody;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(
                      ValueEntryBuffer."Sales Amount (Actual)",
                      ValueEntryBuffer."Discount Amount",
                      Profit);

                    ValueEntryBuffer.RESET;
                    SETRANGE(Number, 1, ValueEntryBuffer.COUNT);
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

                CurrReport.CREATETOTALS(
                  ValueEntryBuffer."Sales Amount (Actual)",
                  ValueEntryBuffer."Discount Amount",
                  Profit);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per Customer';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PrintToExcel := FALSE;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
          CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        ItemLedgEntryFilter := "Value Entry".GETFILTERS;
        PeriodText := "Value Entry".GETFILTER("Posting Date");

        IF PrintToExcel THEN
          MakeExcelInfo;
    end;

    var
        Text000: Label 'Period: %1';
        Item: Record "27";
        ValueEntryBuffer: Record "5802" temporary;
        ExcelBuf: Record "370" temporary;
        CustFilter: Text[250];
        ItemLedgEntryFilter: Text[250];
        PeriodText: Text[30];
        NextEntryNo: Integer;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        Text001: Label 'Data';
        Text002: Label 'Customer/Item Sales';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date';
        Text008: Label 'Customer Filters';
        Text009: Label 'Value Entry Filters';
        PrintToExcel: Boolean;
        Text010: Label 'Profit';
        Text011: Label 'Profit %';
        Customer_Item_SalesCaptionLbl: Label 'Customer/Item Sales';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        ValueEntryBuffer__Item_No__CaptionLbl: Label 'Item No.';
        Item_DescriptionCaptionLbl: Label 'Description';
        ValueEntryBuffer__Invoiced_Quantity_CaptionLbl: Label 'Invoiced Quantity';
        Item__Base_Unit_of_Measure_CaptionLbl: Label 'Unit of Measure';
        ValueEntryBuffer__Sales_Amount__Actual___Control44CaptionLbl: Label 'Amount';
        ValueEntryBuffer__Discount_Amount__Control45CaptionLbl: Label 'Discount Amount';
        Profit_Control46CaptionLbl: Label 'Profit';
        ProfitPct_Control47CaptionLbl: Label 'Profit %';
        TotalCaptionLbl: Label 'Total';

    local procedure CalcProfitPct()
    begin
        WITH ValueEntryBuffer DO BEGIN
          IF "Sales Amount (Actual)" <> 0 THEN
            ProfitPct := ROUND(100 * Profit / "Sales Amount (Actual)",0.1)
          ELSE
            ProfitPct := 0;
        END;
    end;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheed;
        ExcelBuf.AddInfoColumn(FORMAT(Text003),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(FORMAT(Text002),FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text004),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(REPORT::"Customer/Item Sales",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn(Customer.GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'');
        ExcelBuf.AddInfoColumn("Value Entry".GETFILTERS,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer.FIELDCAPTION("No."),FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn(Customer.FIELDCAPTION(Name),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Item No."),FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn(Item.FIELDCAPTION(Description),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Invoiced Quantity"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(Item.FIELDCAPTION("Base Unit of Measure"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Sales Amount (Actual)"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Discount Amount"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,TRUE,'');
    end;

    procedure MakeExcelDataBody()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Customer."No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Customer.Name,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer."Item No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(-ValueEntryBuffer."Invoiced Quantity",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item."Base Unit of Measure",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer."Sales Amount (Actual)",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(-ValueEntryBuffer."Discount Amount",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Profit,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(ProfitPct,FALSE,'',FALSE,FALSE,FALSE,'');
    end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');
    end;
}

