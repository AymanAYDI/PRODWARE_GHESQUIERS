report 50112 "PWD Export COALA"
{
    Caption = 'Export COALA';
    Permissions = TableData "G/L Entry" = rim;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = lists;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.") WHERE(Amount = FILTER(<> 0));

            trigger OnAfterGetRecord()
            begin
                GRecExportCoala.RESET();
                GRecExportCoala.SETRANGE("Document No.", "G/L Entry"."Document No.");
                GRecExportCoala.SETRANGE("G/L Account No.", "G/L Entry"."G/L Account No.");
                GRecExportCoala.SETRANGE("Export COALA Succes", FALSE);
                IF GRecExportCoala.FINDFIRST() THEN BEGIN
                    GRecExportCoala."Debit Amount" := GRecExportCoala."Debit Amount" + "G/L Entry"."Debit Amount";
                    GRecExportCoala."Credit Amount" := GRecExportCoala."Credit Amount" + "G/L Entry"."Credit Amount";
                    CASE "G/L Entry"."Document Type" OF
                        "G/L Entry"."Document Type"::Invoice:
                            BEGIN
                                RecGSalesInvoiceHeader.RESET();
                                RecGSalesInvoiceHeader.GET("G/L Entry"."Document No.");
                                GRecExportCoala.Description := COPYSTR(RecGSalesInvoiceHeader."Bill-to Name", 1, 15) + '/' +
                                  RecGSalesInvoiceHeader."Bill-to Country/Region Code" + '/' + COPYSTR(RecGSalesInvoiceHeader."Ship-to Name", 1, 31);
                            END;
                        "G/L Entry"."Document Type"::"Credit Memo":
                            BEGIN
                                RecGSalesCrMemoHeader.RESET();
                                RecGSalesCrMemoHeader.GET("G/L Entry"."Document No.");
                                GRecExportCoala.Description := 'AVOIR' + '/' + COPYSTR(RecGSalesCrMemoHeader."Bill-to Name", 1, 15) + '/' +
                                  RecGSalesCrMemoHeader."Bill-to Country/Region Code" + '/' + COPYSTR(RecGSalesCrMemoHeader."Ship-to Name", 1, 28);
                            END;
                    END;
                    GRecExportCoala.MODIFY();
                END ELSE BEGIN
                    GRecExportCoala.INIT();
                    GRecExportCoala."Document Type" := "G/L Entry"."Document Type";
                    GRecExportCoala."Entry No." := NumInt + 1;
                    GRecExportCoala."G/L Entry No." := "G/L Entry"."Entry No.";
                    GRecExportCoala."G/L Account No." := "G/L Entry"."G/L Account No.";
                    GRecExportCoala."Document No." := "G/L Entry"."Document No.";
                    GRecExportCoala."Posting Date" := "G/L Entry"."Posting Date";
                    GRecExportCoala."Document Date" := "G/L Entry"."Document Date";
                    CASE "G/L Entry"."Document Type" OF
                        "G/L Entry"."Document Type"::Invoice:
                            BEGIN
                                RecGSalesInvoiceHeader.RESET();
                                RecGSalesInvoiceHeader.GET("G/L Entry"."Document No.");
                                GRecExportCoala.Description := COPYSTR(RecGSalesInvoiceHeader."Bill-to Name", 1, 15) + '/' +
                                  RecGSalesInvoiceHeader."Bill-to Country/Region Code" + '/' + COPYSTR(RecGSalesInvoiceHeader."Ship-to Name", 1, 31);
                            END;
                        "G/L Entry"."Document Type"::"Credit Memo":
                            BEGIN
                                RecGSalesCrMemoHeader.RESET();
                                RecGSalesCrMemoHeader.GET("G/L Entry"."Document No.");
                                GRecExportCoala.Description := 'AVOIR' + '/' + COPYSTR(RecGSalesCrMemoHeader."Bill-to Name", 1, 15) + '/' +
                                  RecGSalesCrMemoHeader."Bill-to Country/Region Code" + '/' + COPYSTR(RecGSalesCrMemoHeader."Ship-to Name", 1, 28);
                            END;
                    END;
                    GRecExportCoala."Debit Amount" := "G/L Entry"."Debit Amount";
                    GRecExportCoala."Credit Amount" := "G/L Entry"."Credit Amount";
                    GRecExportCoala."Export COALA Succes" := FALSE;
                    GRecExportCoala."Export DateTime" := CURRENTDATETIME;
                    RecGCustomerPostingGroup.RESET();
                    RecGCustomerPostingGroup.SETRANGE("Receivables Account", "G/L Account No.");
                    IF RecGCustomerPostingGroup.FINDSET() THEN BEGIN
                        RecGCust.GET("G/L Entry"."Source No.");
                        GRecExportCoala."G/L Account No. COALA" := RecGCust."PWD Customer No. COALA";
                    END;
                    GRecExportCoala.INSERT();
                    NumInt += 1;
                END;

                IF NOT "PWD Export COALA" THEN BEGIN
                    "PWD Export COALA" := TRUE;
                    "PWD Export Date" := TODAY;
                    MODIFY();
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF GRecExportCoala.FINDLAST() THEN
                    NumInt := GRecExportCoala."Entry No."
                ELSE
                    NumInt := 0;
                IF NOT NewExport THEN BEGIN
                    SETRANGE("G/L Entry"."PWD Export COALA", TRUE);
                    SETRANGE("G/L Entry"."PWD Export Date", StartingDate, EnddingDate);
                END ELSE BEGIN
                    SETRANGE("G/L Entry"."PWD Export COALA", FALSE);
                    SETRANGE("G/L Entry"."Posting Date", StartingDate, EnddingDate);
                END;
                IF SourceCode <> '' THEN
                    SETRANGE("G/L Entry"."Source Code", SourceCode);
            end;
        }
        dataitem("PWD Export COALA"; "PWD Export COALA")
        {
            DataItemTableView = SORTING("Entry No.") WHERE("Export COALA Succes" = CONST(False));
            trigger OnAfterGetRecord()
            begin
                IF PrintToExcel THEN
                    MakeExcelDataBody();
                "Export COALA Succes" := TRUE;
                MODIFY();
            end;

            trigger OnPreDataItem()
            begin
                COMMIT();
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
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                        ApplicationArea = All;
                    }
                    field(SourceCode; SourceCode)
                    {
                        Caption = 'Code journal';
                        DrillDownPageID = "Source Codes";
                        LookupPageID = "Source Codes";
                        ApplicationArea = All;
                    }
                    field("Nouvel export"; NewExport)
                    {
                        Caption = 'Nouvel export';
                        ApplicationArea = All;
                    }
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Filtre date début';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            EnddingDate := StartingDate;
                        end;
                    }
                    field(EnndingDate; EnddingDate)
                    {
                        Caption = 'Filtre date fin';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                        end;
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

    trigger OnInitReport()
    begin
        PrintToExcel := TRUE;
        SourceCode := 'VENTES';
        NewExport := FALSE;
        DateFilter := TODAY;
        StartingDate := TODAY;
        EnddingDate := TODAY;
    end;

    trigger OnPostReport()
    begin
        COMMIT();

        IF PrintToExcel THEN
            CreateExcelbook();
    end;

    trigger OnPreReport()
    begin
        GLFilter := "G/L Entry".GETFILTERS;
        PeriodText := "G/L Entry".GETFILTER("Posting Date");
        IF PrintToExcel THEN
            MakeExcelInfo();

        IF StartingDate = 0D THEN
            ERROR('Veuillez saisir une date de début.');

        IF EnddingDate = 0D THEN
            ERROR('Veuillez saisir une date de fin.');
    end;

    var
        RecGCust: Record Customer;
        RecGCustomerPostingGroup: Record "Customer Posting Group";
        TempExcelBuf: Record "Excel Buffer" temporary;
        GRecExportCoala: Record "PWD Export COALA";
        RecGSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        RecGSalesInvoiceHeader: Record "Sales Invoice Header";
        NewExport: Boolean;
        PrintToExcel: Boolean;
        SourceCode: Code[10];
        DateFilter: Date;
        EnddingDate: Date;
        StartingDate: Date;
        NumInt: Integer;
        PeriodText: Text[30];
        GLFilter: Text[250];

    procedure MakeExcelInfo()
    begin
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin
        //ToDo
        /*
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION("Document Date"), FALSE, '', FALSE, FALSE, TRUE, '');
        TempExcelBuf.AddColumn(FORMAT(Text000), FALSE, '', FALSE, FALSE, TRUE, '');
        TempExcelBuf.AddColumn(FORMAT(Text001), FALSE, '', FALSE, FALSE, TRUE, '');
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION("Document No."), FALSE, '', FALSE, FALSE, TRUE, '');
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION(Description), FALSE, '', FALSE, FALSE, TRUE, '');
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION("Debit Amount"), FALSE, '', FALSE, FALSE, TRUE, '');
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION("Credit Amount"), FALSE, '', FALSE, FALSE, TRUE, '');
        TempExcelBuf.AddColumn(FORMAT(Text002), FALSE, '', FALSE, FALSE, TRUE, '');
        TempExcelBuf.AddColumn(FORMAT(Text003), FALSE, '', FALSE, FALSE, TRUE, '');
        */
    end;

    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        TempExcelBuf.NewRow();
        //ToDo
        /*
        TempExcelBuf.AddColumn(
          "PWD Export COALA"."Document Date", FALSE, '', FALSE,
          FALSE, FALSE, '');

        TempExcelBuf.AddColumn(
          'vt', FALSE, '', FALSE,
          FALSE, FALSE, '');

        IF "PWD Export COALA"."G/L Account No. COALA" <> '' THEN
            TempExcelBuf.AddColumn(
              "PWD Export COALA"."G/L Account No. COALA", FALSE, '', FALSE,
              FALSE, FALSE, '')
        ELSE
            TempExcelBuf.AddColumn(
              "PWD Export COALA"."G/L Account No.", FALSE, '', FALSE,
              FALSE, FALSE, '');

        TempExcelBuf.AddColumn(
          "PWD Export COALA"."Document No.", FALSE, '', FALSE,
          FALSE, FALSE, '');

        TempExcelBuf.AddColumn(
          "PWD Export COALA".Description, FALSE, '', FALSE,
          FALSE, FALSE, '');

        TempExcelBuf.AddColumn(
          "PWD Export COALA"."Debit Amount", FALSE, '', FALSE,
          FALSE, FALSE, '');

        TempExcelBuf.AddColumn(
          "PWD Export COALA"."Credit Amount", FALSE, '', FALSE,
          FALSE, FALSE, '');

        TempExcelBuf.AddColumn(
          'E', FALSE, '', FALSE,
          FALSE, FALSE, '');

        TempExcelBuf.AddColumn(
          "G/L Entry"."Global Dimension 1 Code", FALSE, '', FALSE,
          FALSE, FALSE, '');
          */
    end;

    procedure CreateExcelbook()
    begin
        //ToDo
        /*TempExcelBuf.CreateBook;
        TempExcelBuf.CreateSheet(Text002, Text001, COMPANYNAME, USERID);
        TempExcelBuf.GiveUserControl;*/
        ERROR('');
    end;
}