report 698 "PWD Get Sales Orders"
{
    // 05/07/07   C2A(LLE)   cf appel NAV0016498 modif in trigger InsertReqWkshLine
    // 
    // C2A_001 C2A.AMI 15.10.07  Modif Trigger InsertReqWkshLine commande spécial
    //                             - Cf Appel 17481

    Caption = 'Get Sales Orders';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order), Type = CONST(Item), "Purch. Order Line No." = CONST(0), "Outstanding Quantity" = FILTER(<> 0));
            RequestFilterFields = "Document No.", "Sell-to Customer No.", "No.";
            RequestFilterHeading = 'Sales Order Line';

            trigger OnAfterGetRecord()
            begin
                IF ("Sales Line"."Purchasing Code" = '') AND (SpecOrder <> 1) THEN
                    IF "Sales Line"."Drop Shipment" THEN BEGIN
                        LineCount := LineCount + 1
                        Window.UPDATE(1, LineCount);
                        InsertReqWkshLine("Sales Line");
                    END;

                IF "Sales Line"."Purchasing Code" <> '' THEN
                    IF PurchasingCode.GET("Sales Line"."Purchasing Code") THEN
                        IF (PurchasingCode."Drop Shipment") AND (SpecOrder <> 1) THEN BEGIN
                            LineCount := LineCount + 1;
                            Window.UPDATE(1, LineCount);
                            InsertReqWkshLine("Sales Line");
                        END ELSE
                            IF (PurchasingCode."Special Order") AND
                               ("Special Order Purchase No." = '') AND
                               (SpecOrder <> 0)
                            THEN BEGIN
                                LineCount := LineCount + 1;
                                Window.UPDATE(1, LineCount);
                                InsertReqWkshLine("Sales Line");
                            END;
            end;

            trigger OnPostDataItem()
            begin
                IF LineCount = 0 THEN
                    ERROR(Text001);
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
                    field(GetDim; GetDim)
                    {
                        Caption = 'Retrieve dimensions from';
                        OptionCaption = 'Item,Sales Line';
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
        ReqWkshTmpl.GET(ReqLine."Worksheet Template Name");
        ReqWkshName.GET(ReqLine."Worksheet Template Name", ReqLine."Journal Batch Name");
        ReqLine.SETRANGE("Worksheet Template Name", ReqLine."Worksheet Template Name");
        ReqLine.SETRANGE("Journal Batch Name", ReqLine."Journal Batch Name");
        ReqLine.LOCKTABLE();
        IF ReqLine.FIND('+') THEN BEGIN
            ReqLine.INIT();
            LineNo := ReqLine."Line No.";
        END;
        Window.OPEN(Text000);
    end;

    var
        PurchasingCode: Record Purchasing;
        ReqWkshTmpl: Record "Req. Wksh. Template";
        ReqLine: Record "Requisition Line";
        ReqWkshName: Record "Requisition Wksh. Name";
        SalesHeader: Record "Sales Header";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        Window: Dialog;
        LineCount: Integer;
        LineNo: Integer;
        SpecOrder: Integer;
        Text000: Label 'Processing sales lines  #1######';
        Text001: Label 'There are no sales lines to retrieve.';
        GetDim: Option Item,"Sales Line";

    procedure SetReqWkshLine(NewReqLine: Record "Requisition Line"; SpecialOrder: Integer)
    begin
        ReqLine := NewReqLine;
        SpecOrder := SpecialOrder;
    end;

    local procedure InsertReqWkshLine(SalesLine: Record "Sales Line")
    var
        JnlLineDim: Record "Dim. Value per Account";
        DocDim: Record "Gen. Jnl. Dim. Filter";
    begin
        ReqLine.RESET();
        ReqLine.SETCURRENTKEY(Type, "No.");
        ReqLine.SETRANGE(Type, "Sales Line".Type);
        ReqLine.SETRANGE("No.", "Sales Line"."No.");
        ReqLine.SETRANGE("Sales Order No.", "Sales Line"."Document No.");
        ReqLine.SETRANGE("Sales Order Line No.", "Sales Line"."Line No.");
        IF ReqLine.FIND('-') THEN
            EXIT;

        LineNo := LineNo + 10000;
        ReqLine.INIT();
        ReqLine."Worksheet Template Name" := ReqWkshName."Worksheet Template Name";
        ReqLine."Journal Batch Name" := ReqWkshName.Name;
        ReqLine."Line No." := LineNo;
        ReqLine.VALIDATE(Type, SalesLine.Type);
        ReqLine.VALIDATE("No.", SalesLine."No.");
        //C2A GTE
        ReqLine.VALIDATE(Description, SalesLine.Description);
        ReqLine.VALIDATE("Description 2", SalesLine."Description 2");
        // C2A GTE

        ReqLine."Variant Code" := SalesLine."Variant Code";
        ReqLine.VALIDATE("Location Code", SalesLine."Location Code");
        ReqLine."Bin Code" := SalesLine."Bin Code";

        // Drop Shipment means replenishment by purchase only
        IF (ReqLine."Replenishment System" <> ReqLine."Replenishment System"::Purchase) AND
           SalesLine."Drop Shipment"
        THEN
            ReqLine.VALIDATE("Replenishment System", ReqLine."Replenishment System"::Purchase);

        //>-> GHE-RE.1.00
        //IF SpecOrder <> 1 THEN //code retiré
        //<-< GHE-RE.1.00

        ReqLine.VALIDATE("Unit of Measure Code", SalesLine."Unit of Measure Code");
        ReqLine.VALIDATE(
          Quantity,
          ROUND(SalesLine."Outstanding Quantity" * SalesLine."Qty. per Unit of Measure" / ReqLine."Qty. per Unit of Measure", 0.00001));
        ReqLine."Sales Order No." := SalesLine."Document No.";
        ReqLine."Sales Order Line No." := SalesLine."Line No.";
        ReqLine."Sell-to Customer No." := SalesLine."Sell-to Customer No.";
        SalesHeader.GET(1, SalesLine."Document No.");
        IF SpecOrder <> 1 THEN
            ReqLine."Ship-to Code" := SalesHeader."Ship-to Code";
        ReqLine."Item Category Code" := SalesLine."Item Category Code";
        ReqLine.Nonstock := SalesLine.Nonstock;
        ReqLine."Action Message" := ReqLine."Action Message"::New;
        ReqLine."Product Group Code" := SalesLine."Product Group Code";
        ReqLine."Purchasing Code" := SalesLine."Purchasing Code";
        // Backward Scheduling
        ReqLine."Due Date" := SalesLine."Shipment Date";
        ReqLine."Ending Date" :=
          LeadTimeMgt.PlannedEndingDate(
            ReqLine."No.", ReqLine."Location Code", ReqLine."Variant Code", ReqLine."Due Date", ReqLine."Vendor No.", ReqLine."Ref. Order Type");
        ReqLine.CalcStartingDate('');
        ReqLine.UpdateDatetime();
        //>-> GHE-RE.1.00
        ReqLine.Description := SalesLine.Description;
        //ReqLine.VALIDATE(ReqLine."Direct Unit Cost",SalesLine."Unit Cost (LCY)");
        //<-< GHE-RE.1.00
        //BEGIN   05/07/07   C2A(LLE)   cf appel NAV0016498
        //Begin #C2A_001
        //  IF SalesLine."Specific Cost" THEN
        IF SalesLine."PWD Specific Cost" OR SalesLine."Special Order" THEN
        //End #C2A_001
        BEGIN
            ReqLine."Direct Unit Cost" := SalesLine."Unit Cost";
            ReqLine."PWD Specific cost" := TRUE;
        END;
        //END   05/07/07   C2A(LLE)   cf appel NAV0016498

        ReqLine.INSERT();
        ItemTrackingMgt.CopyItemTracking(SalesLine.RowID1(), ReqLine.RowID1(), TRUE);
        IF GetDim = GetDim::"Sales Line" THEN BEGIN
            JnlLineDim.SETRANGE("Table ID", DATABASE::"Requisition Line");
            JnlLineDim.SETRANGE("Journal Template Name", ReqLine."Worksheet Template Name");
            JnlLineDim.SETRANGE("Journal Batch Name", ReqLine."Journal Batch Name");
            JnlLineDim.SETRANGE("Journal Line No.", ReqLine."Line No.");
            JnlLineDim.SETRANGE("Allocation Line No.", 0);
            JnlLineDim.DELETEALL();
            ReqLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
            ReqLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
            ReqLine.MODIFY();
            DocDim.SETRANGE("Table ID", DATABASE::"Sales Line");
            DocDim.SETRANGE("Document Type", SalesLine."Document Type");
            DocDim.SETRANGE("Document No.", SalesLine."Document No.");
            DocDim.SETRANGE("Line No.", SalesLine."Line No.");
            IF DocDim.FIND('-') THEN
                REPEAT
                    JnlLineDim.INIT();
                    JnlLineDim."Table ID" := DATABASE::"Requisition Line";
                    JnlLineDim."Journal Template Name" := ReqLine."Worksheet Template Name";
                    JnlLineDim."Journal Batch Name" := ReqLine."Journal Batch Name";
                    JnlLineDim."Journal Line No." := ReqLine."Line No.";
                    JnlLineDim."Allocation Line No." := 0;
                    JnlLineDim."Dimension Code" := DocDim."Dimension Code";
                    JnlLineDim."Dimension Value Code" := DocDim."Dimension Value Code";
                    JnlLineDim.INSERT();
                UNTIL DocDim.NEXT() = 0;
        END;
    end;
}

