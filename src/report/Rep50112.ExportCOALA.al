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
                    SETRANGE("G/L Entry"."PWD Export Date", StartingDateV, EnddingDate);
                END ELSE BEGIN
                    SETRANGE("G/L Entry"."PWD Export COALA", FALSE);
                    SETRANGE("G/L Entry"."Posting Date", StartingDateV, EnddingDate);
                END;
                IF SourceCodeV <> '' THEN
                    SETRANGE("G/L Entry"."Source Code", SourceCodeV);
            end;
        }
        dataitem("PWD Export COALA"; "PWD Export COALA")
        {
            DataItemTableView = SORTING("Entry No.") WHERE("Export COALA Succes" = CONST(False));
            trigger OnAfterGetRecord()
            begin
                IF PrintToExcelV THEN
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
                    field(PrintToExcel; PrintToExcelV)
                    {
                        Caption = 'Print to Excel';
                        ApplicationArea = All;
                    }
                    field(SourceCode; SourceCodeV)
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
                    field(StartingDate; StartingDateV)
                    {
                        Caption = 'Filtre date début';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            EnddingDate := StartingDateV;
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
        PrintToExcelV := TRUE;
        SourceCodeV := 'VENTES';
        NewExport := FALSE;
        DateFilter := TODAY;
        StartingDateV := TODAY;
        EnddingDate := TODAY;
    end;

    trigger OnPostReport()
    begin
        COMMIT();

        IF PrintToExcelV THEN
            CreateExcelbook();
    end;

    trigger OnPreReport()
    begin
        GLFilter := "G/L Entry".GETFILTERS;
        PeriodText := "G/L Entry".GETFILTER("Posting Date");
        IF PrintToExcelV THEN
            MakeExcelInfo();

        IF StartingDateV = 0D THEN
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
        PrintToExcelV: Boolean;
        SourceCodeV: Code[10];
        DateFilter: Date;
        EnddingDate: Date;
        StartingDateV: Date;
        NumInt: Integer;
        PeriodText: Text[30];
        GLFilter: Text[250];
        Text002: Label 'Monnaie';
        Text001: Label 'N° compte';
        Text000: Label 'Code journal';
        Text003: Label 'Section analytique';
        Text004: Label 'ExportCOALA';

    procedure MakeExcelInfo()
    begin
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    var
        celltype: option Number,Text,Date,Time;
    begin

        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION("Document Date"), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);
        TempExcelBuf.AddColumn(FORMAT(Text000), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);
        TempExcelBuf.AddColumn(FORMAT(Text001), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION("Document No."), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION(Description), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION("Debit Amount"), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);
        TempExcelBuf.AddColumn("PWD Export COALA".FIELDCAPTION("Credit Amount"), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);
        TempExcelBuf.AddColumn(FORMAT(Text002), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);
        TempExcelBuf.AddColumn(FORMAT(Text003), FALSE, '', FALSE, FALSE, TRUE, '', CellType::Text);

    end;

    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
        celltype: option Number,Text,Date,Time;
    begin
        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        TempExcelBuf.NewRow();

        TempExcelBuf.AddColumn(
          "PWD Export COALA"."Document Date", FALSE, '', FALSE,
          FALSE, FALSE, '', CellType::Text);
        TempExcelBuf.AddColumn(
          'vt', FALSE, '', FALSE,
          FALSE, FALSE, '', CellType::Text);

        IF "PWD Export COALA"."G/L Account No. COALA" <> '' THEN
            TempExcelBuf.AddColumn(
              "PWD Export COALA"."G/L Account No. COALA", FALSE, '', FALSE,
              FALSE, FALSE, '', CellType::Text)
        ELSE
            TempExcelBuf.AddColumn(
              "PWD Export COALA"."G/L Account No.", FALSE, '', FALSE,
              FALSE, FALSE, '', CellType::Text);

        TempExcelBuf.AddColumn(
          "PWD Export COALA"."Document No.", FALSE, '', FALSE,
          FALSE, FALSE, '', CellType::Text);

        TempExcelBuf.AddColumn(
          "PWD Export COALA".Description, FALSE, '', FALSE,
          FALSE, FALSE, '', CellType::Text);

        TempExcelBuf.AddColumn(
          "PWD Export COALA"."Debit Amount", FALSE, '', FALSE,
          FALSE, FALSE, '', CellType::Text);

        TempExcelBuf.AddColumn(
          "PWD Export COALA"."Credit Amount", FALSE, '', FALSE,
          FALSE, FALSE, '', CellType::Text);

        TempExcelBuf.AddColumn(
          'E', FALSE, '', FALSE,
          FALSE, FALSE, '', CellType::Text);

        TempExcelBuf.AddColumn(
          "G/L Entry"."Global Dimension 1 Code", FALSE, '', FALSE,
          FALSE, FALSE, '', CellType::Text);

    end;

    procedure CreateExcelbook()
    begin
        TempExcelBuf.CreateNewBook(Text004);
        TempExcelBuf.WriteSheet(Text002, COMPANYNAME, USERID);
        TempExcelBuf.CloseBook();
        TempExcelBuf.SetFriendlyFilename(Text004);//StrSubstNo(Text004, currentdatetime, USERID));
        TempExcelBuf.OpenExcel();
    end;
}