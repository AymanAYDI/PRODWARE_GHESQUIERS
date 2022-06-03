report 50003 "Create Purchase Quote r -TrB"
{
    Caption = 'Create Purchase Quote';
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = None;
    dataset
    {
        dataitem("PWD Appeal for Tenders"; "PWD Appeal for Tenders")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Vendor No.") WHERE(Detail = CONST(true));
            RequestFilterFields = "Document Type", "Document No.";

            trigger OnAfterGetRecord()
            begin
                IF "PWD Appeal for Tenders".Exclude = FALSE THEN BEGIN
                    Window.UPDATE(1, "PWD Appeal for Tenders"."Document Type");
                    Window.UPDATE(2, "PWD Appeal for Tenders"."Document No.");

                    IF "PWD Appeal for Tenders"."Vendor No." <> '' THEN BEGIN

                        IF (DocType <> "PWD Appeal for Tenders"."Document Type".AsInteger()) OR (DocNo <> "PWD Appeal for Tenders"."Document No.") OR
                          (VendorNo <> "PWD Appeal for Tenders"."Vendor No.") THEN BEGIN

                            InsertPurchQuoteHeader();

                            DocType := "PWD Appeal for Tenders"."Document Type".AsInteger();
                            DocNo := "PWD Appeal for Tenders"."Document No.";
                            VendorNo := "PWD Appeal for Tenders"."Vendor No.";
                            //ToDo Var Not Used 
                            //ReqRecDate := "PWD Appeal for Tenders"."Requested Receipt Date";
                        END;
                        IF NOT SalesLine.GET("Document Type", "Document No.", "Line No. document") THEN
                            SalesLine.INIT();
                        InsertPurchQuoteLine();
                    END;
                    "PWD Appeal for Tenders".DELETE();
                    AppTenders.SETRANGE("Document Type", "PWD Appeal for Tenders"."Document Type");
                    AppTenders.SETRANGE("Document No.", "PWD Appeal for Tenders"."Document No.");
                    AppTenders.SETRANGE("Line No. document", "PWD Appeal for Tenders"."Line No. document");
                    AppTenders.SETRANGE(Detail, TRUE);
                    IF NOT AppTenders.FIND('-') THEN BEGIN
                        AppTenders.SETRANGE(Detail, FALSE);
                        AppTenders.DELETEALL();
                    END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                IF FiltreNumdoc <> '' THEN BEGIN
                    "PWD Appeal for Tenders".SETRANGE("Document Type", FiltreTypeDoc);
                    "PWD Appeal for Tenders".SETRANGE("Document No.", FiltreNumdoc);
                END;

                Window.OPEN(
                   Text1000000005 +
                   Text1000000006 +
                   Text1000000007);
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
        IF NOT CONFIRM(Text1000000014, TRUE) = TRUE THEN
            CurrReport.QUIT();
    end;

    var
        PurchQuoteHeader: Record "Purchase Header";
        PurchQuoteLine: Record "Purchase Line";
        PurchSetUp: Record "Purchases & Payables Setup";
        AppTenders: Record "PWD Appeal for Tenders";
        SalesLine: Record "Sales Line";
        DocNo: Code[20];
        FiltreNumdoc: Code[20];
        VendorNo: Code[20];
        //ReqRecDate: Date;
        Window: Dialog;
        NextLineNo: Integer;
        Text1000000005: Label 'Sales document #1###### #2######\';
        Text1000000006: Label 'ENU=Creating purchase orders           #3######\';
        Text1000000007: Label 'Creating purchase lines            #4######\';
        Text1000000014: Label 'Create purchase quote ?';
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        FiltreTypeDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";

    procedure InitDocument(TypeDoc: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; NumDoc: Code[20])
    begin
        FiltreTypeDoc := TypeDoc;
        FiltreNumdoc := NumDoc;
    end;

    procedure InsertPurchQuoteHeader()
    begin
        PurchSetUp.GET();
        PurchSetUp.TESTFIELD("Order Nos.");

        PurchQuoteHeader.INIT();
        PurchQuoteHeader."Document Type" := PurchQuoteHeader."Document Type"::Quote;
        PurchQuoteHeader."No." := '';
        PurchQuoteHeader."Posting Date" := TODAY;
        PurchQuoteHeader.INSERT(TRUE);
        Window.UPDATE(3, PurchQuoteHeader."No.");

        PurchQuoteHeader."Your Reference" := '';
        PurchQuoteHeader."Order Date" := TODAY;
        PurchQuoteHeader."Expected Receipt Date" := 0D;
        PurchQuoteHeader.VALIDATE("Buy-from Vendor No.", "PWD Appeal for Tenders"."Vendor No.");
        PurchQuoteHeader.MODIFY();

        NextLineNo := 0;
    end;

    procedure InsertPurchQuoteLine()
    begin

        PurchQuoteLine.INIT();
        PurchQuoteLine."Document Type" := PurchQuoteLine."Document Type"::Quote;
        PurchQuoteLine."Document No." := PurchQuoteHeader."No.";
        NextLineNo := NextLineNo + 10000;
        PurchQuoteLine."Line No." := NextLineNo;

        PurchQuoteLine."Buy-from Vendor No." := "PWD Appeal for Tenders"."Vendor No.";
        PurchQuoteLine.VALIDATE(Type, PurchQuoteLine.Type::Item);
        PurchQuoteLine.VALIDATE("No.", "PWD Appeal for Tenders"."No.");
        PurchQuoteLine.Description := "PWD Appeal for Tenders".Description;
        PurchQuoteLine."Description 2" := "PWD Appeal for Tenders"."Description 2";
        Window.UPDATE(4, PurchQuoteLine."No.");
        PurchQuoteLine.VALIDATE(Quantity, "PWD Appeal for Tenders".Quantity);
        PurchQuoteLine.VALIDATE("Location Code", SalesLine."Location Code");
        PurchQuoteLine.Description := SalesLine.Description;
        PurchQuoteLine."Description 2" := SalesLine."Description 2";
        PurchQuoteLine."PWD SalesTypeDocAppealTend." := "PWD Appeal for Tenders"."Document Type".AsInteger();
        PurchQuoteLine."PWD Sales No. Appeal Tenders" := "PWD Appeal for Tenders"."Document No.";
        PurchQuoteLine."PWD SalesLineNoAppealTenders" := "PWD Appeal for Tenders"."Line No. document";
        PurchQuoteLine."Requested Receipt Date" := "PWD Appeal for Tenders"."Requested Receipt Date";
        PurchQuoteLine.INSERT();
    end;
}
