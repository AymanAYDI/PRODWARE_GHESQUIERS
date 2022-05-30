report 50007 "Generation Purchase Order -TrB"
{
    // *** Contremarque - C2A
    // Génération des commandes d'achat.

    Caption = 'Generation Purchase Order';
    ProcessingOnly = true;
    UsageCategory = None;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = WHERE("PWD Trading Brand" = CONST(true), "PWD Order Trading brand" = CONST(false));

                trigger OnAfterGetRecord()
                begin
                    //----------------------------------------------------------------------------//
                    //*** Vérifie 1 ligne devis achat associée à chaque ligne vente.
                    //----------------------------------------------------------------------------//
                    PurchQuoteLine.RESET();
                    PurchQuoteLine.SETRANGE("PWD Sales Type Doc Appeal tenders", "Sales Line"."Document Type".AsInteger());
                    PurchQuoteLine.SETRANGE("PWD Sales No. Appeal Tenders", "Sales Line"."Document No.");

                    PurchQuoteLine.SETRANGE("PWD Sales Line No. Appeal Tenders", "Sales Line"."Line No.");
                    PurchQuoteLine.SETRANGE("PWD Selected Quote", TRUE);
                    NbRecord := PurchQuoteLine.COUNT;

                    IF NbRecord <> 1 THEN BEGIN
                        IF NbRecord = 0 THEN
                            ERROR(Text1000000002, "Sales Line"."Document Type", "Sales Line"."Document No.", "Sales Line"."Line No.", "Sales Line"."No.")
                        ELSE
                            ERROR(Text1000000003, "Sales Line"."Document Type",
                                 "Sales Line"."Document No.", "Sales Line"."Line No.", "Sales Line"."No.");
                    END ELSE BEGIN
                        //*** Recalcul du cout unitaire.
                        PurchQuoteLine.FIND('-');
                        "Sales Line"."Unit Cost (LCY)" := PurchQuoteLine."Unit Cost (LCY)";
                        "Sales Line".VALIDATE("Unit Cost (LCY)");
                        "Sales Line".MODIFY();
                    END;

                    //----------------------------------------------------------------------------//
                    //*** Vérifie que toute les lignes de la commande d'achat correspondent à la même cde de vente.
                    //----------------------------------------------------------------------------//
                    PurchQuoteLine.FIND('-');

                    PurchquoteLine2.SETRANGE("Document Type", PurchQuoteLine."Document Type");
                    PurchquoteLine2.SETRANGE("Document No.", PurchQuoteLine."Document No.");
                    IF PurchQuoteLine.FIND('-') THEN
                        REPEAT
                            IF MemonumVente = '' THEN
                                MemonumVente := PurchquoteLine2."PWD Sales No. Appeal Tenders";
                            IF (MemonumVente <> PurchquoteLine2."PWD Sales No. Appeal Tenders") AND (PurchquoteLine2."PWD Sales No. Appeal Tenders" <> '') THEN
                                ERROR('La demande de prix d''achat %1 est ratachée à différente commande de vente.');
                        UNTIL PurchquoteLine2.NEXT() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    //*** Vérification et maj du cout unitaire
                end;
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "PWD Sales Type Doc Appeal tenders" = FIELD("Document Type"), "PWD Sales No. Appeal Tenders" = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Quote));

                trigger OnAfterGetRecord()
                begin
                    Window.UPDATE(3, "Purchase Line"."Document Type");
                    Window.UPDATE(4, "Purchase Line"."Document No.");
                    SLEEP(500);

                    IF MemoNumachat <> "Purchase Line"."Document No." THEN BEGIN
                        MemoNumachat := "Purchase Line"."Document No.";

                        PurchQuoteHeader.GET("Purchase Line"."Document Type", "Purchase Line"."Document No.");
                        CreateOrder(PurchQuoteHeader);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    MemoNumachat := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Sales Header"."Document Type");
                Window.UPDATE(2, "Sales Header"."No.");

                //----------------------------------------------------------------------------//
                //*** Supprime les lignes non sélectionnées
                //----------------------------------------------------------------------------//
                PurchQuoteLine.RESET();
                PurchQuoteLine.SETCURRENTKEY("PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders");
                PurchQuoteLine.SETRANGE("PWD Sales Type Doc Appeal tenders", "Sales Header"."Document Type".AsInteger());
                PurchQuoteLine.SETRANGE("PWD Sales No. Appeal Tenders", "Sales Header"."No.");
                PurchQuoteLine.SETRANGE("PWD Selected Quote", FALSE);
                IF PurchQuoteLine.FIND('-') THEN
                    REPEAT
                        PurchQuoteLine.DELETE(TRUE);

                        //*** si plus de ligne on supprime l'entete
                        PurchquoteLine2.RESET();
                        PurchquoteLine2.SETRANGE("Document Type", PurchQuoteLine."Document Type");
                        PurchquoteLine2.SETRANGE("Document No.", PurchQuoteLine."Document No.");
                        IF PurchquoteLine2.COUNT = 0 THEN BEGIN
                            PurchQuoteHeader.GET(PurchQuoteLine."Document Type", PurchQuoteLine."Document No.");
                            PurchQuoteHeader.DELETE(TRUE);
                        END;
                    UNTIL PurchQuoteLine.NEXT() = 0;

                //----------------------------------------------------------------------------//
                //*** Vérifie que toute les lignes des commande d'achat correspondent à la même cde de vente.
                //----------------------------------------------------------------------------//
                PurchQuoteLine.RESET();
                PurchQuoteLine.SETCURRENTKEY("PWD Sales Type Doc Appeal tenders", "PWD Sales No. Appeal Tenders", "PWD Sales Line No. Appeal Tenders");
                PurchQuoteLine.SETRANGE("PWD Sales Type Doc Appeal tenders", "Sales Header"."Document Type".AsInteger());
                PurchQuoteLine.SETRANGE("PWD Sales No. Appeal Tenders", "Sales Header"."No.");
                PurchQuoteLine.SETRANGE("PWD Selected Quote", TRUE);

                PurchquoteLine2.RESET();
                PurchquoteLine2.SETRANGE("Document Type", PurchQuoteLine."Document Type");
                PurchquoteLine2.SETRANGE("Document No.", PurchQuoteLine."Document No.");

                IF PurchQuoteLine.FIND('-') THEN
                    IF PurchquoteLine2.FIND('-') THEN
                        REPEAT
                            IF MemonumVente = '' THEN
                                MemonumVente := PurchquoteLine2."PWD Sales No. Appeal Tenders";
                            IF (MemonumVente <> PurchquoteLine2."PWD Sales No. Appeal Tenders") AND (PurchquoteLine2."PWD Sales No. Appeal Tenders" <> '') THEN
                                ERROR('La demande de prix d''achat %1 %2 est ratachée à différentes commandes de vente.', PurchQuoteLine."Document Type"
                                  , PurchQuoteLine."Document No.");
                        UNTIL PurchquoteLine2.NEXT() = 0;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Traitement en cours \Commande vente #1###### #2###### \Demande d''achat #3###### #4######');
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
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        PurchCommentLine: Record "Purch. Comment Line";
        PurchOrderHeader: Record "Purchase Header";
        PurchQuoteHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        PurchQuoteLine: Record "Purchase Line";
        PurchquoteLine2: Record "Purchase Line";
        SalesOrderLine: Record "Sales Line";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        AutoArchiveManagement: Codeunit "PWD ArchiveAutoManagement";
        MemoNumachat: Code[20];
        MemonumVente: Code[20];
        Window: Dialog;
        NbRecord: Integer;
        Text1000000002: Label 'Any vendor reply selected %1 %2 %3 \Item %4';
        Text1000000003: Label 'To many vendor reply selected %1 %2 %3 \Item %4';

    procedure CreateOrder(var rec: Record "Purchase Header")
    var
        OldPurchCommentLine: Record "Purch. Comment Line";
    begin
        PurchQuoteLine.RESET();

        rec.TESTFIELD("Document Type", rec."Document Type"::Quote);

        PurchOrderHeader := rec;
        PurchOrderHeader."Document Type" := PurchOrderHeader."Document Type"::Order;
        PurchOrderHeader."No. Printed" := 0;
        PurchOrderHeader.Status := PurchOrderHeader.Status::Open;
        PurchOrderHeader."No." := '';

        PurchOrderLine.LOCKTABLE();
        PurchOrderHeader.INSERT(TRUE);

        PurchOrderHeader."Order Date" := rec."Order Date";
        PurchOrderHeader."Posting Date" := rec."Posting Date";
        PurchOrderHeader."Document Date" := rec."Document Date";
        PurchOrderHeader."Expected Receipt Date" := rec."Expected Receipt Date";
        PurchOrderHeader.Validate("Dimension Set ID", rec."Dimension Set ID");
        PurchOrderHeader."Shortcut Dimension 1 Code" := rec."Shortcut Dimension 1 Code";
        PurchOrderHeader."Shortcut Dimension 2 Code" := rec."Shortcut Dimension 2 Code";
        PurchOrderHeader.MODIFY();

        PurchQuoteLine.SETRANGE("Document Type", rec."Document Type");
        PurchQuoteLine.SETRANGE("Document No.", rec."No.");

        IF PurchQuoteLine.FIND('-') THEN
            REPEAT
                PurchOrderLine := PurchQuoteLine;
                PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
                PurchOrderLine."Document No." := PurchOrderHeader."No.";
                ReservePurchLine.TransferPurchLineToPurchLine(
                  PurchQuoteLine, PurchOrderLine, PurchQuoteLine."Reserved Qty. (Base)");
                PurchOrderLine.Validate("Dimension Set ID", PurchQuoteLine."Dimension Set ID");
                PurchOrderLine."Shortcut Dimension 1 Code" := PurchQuoteLine."Shortcut Dimension 1 Code";
                PurchOrderLine."Shortcut Dimension 2 Code" := PurchQuoteLine."Shortcut Dimension 2 Code";
                PurchOrderLine.INSERT();

                //************************************//
                SalesOrderLine.GET(PurchOrderLine."PWD Sales Type Doc Appeal tenders", PurchOrderLine."PWD Sales No. Appeal Tenders",
                   PurchOrderLine."PWD Sales Line No. Appeal Tenders");
                SalesOrderLine."PWD Order Trading brand" := TRUE;
                SalesOrderLine."PWD Trad. Brand Order Purch No." := PurchOrderLine."Document No.";
                SalesOrderLine."PWD Trad. Br Order Purch. Line No." := PurchOrderLine."Line No.";
                SalesOrderLine.MODIFY();
            //************************************//
            UNTIL PurchQuoteLine.NEXT() = 0;

        PurchCommentLine.SETRANGE("Document Type", rec."Document Type");
        PurchCommentLine.SETRANGE("No.", rec."No.");
        IF NOT PurchCommentLine.ISEMPTY THEN BEGIN
            PurchCommentLine.LOCKTABLE();
            IF PurchCommentLine.FIND('-') THEN
                REPEAT
                    OldPurchCommentLine := PurchCommentLine;
                    PurchCommentLine.DELETE();
                    PurchCommentLine."Document Type" := PurchOrderHeader."Document Type";
                    PurchCommentLine."No." := PurchOrderHeader."No.";
                    PurchCommentLine.INSERT();
                    PurchCommentLine := OldPurchCommentLine;
                UNTIL PurchCommentLine.NEXT() = 0;
        END;

        ItemChargeAssgntPurch.RESET();
        ItemChargeAssgntPurch.SETRANGE("Document Type", rec."Document Type");
        ItemChargeAssgntPurch.SETRANGE("Document No.", rec."No.");

        WHILE ItemChargeAssgntPurch.FIND('-') DO BEGIN
            ItemChargeAssgntPurch.DELETE();
            ItemChargeAssgntPurch."Document Type" := PurchOrderHeader."Document Type";
            ItemChargeAssgntPurch."Document No." := PurchOrderHeader."No.";
            IF NOT (ItemChargeAssgntPurch."Applies-to Doc. Type" IN
              [ItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt,
               ItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment"])
            THEN BEGIN
                ItemChargeAssgntPurch."Applies-to Doc. Type" := PurchOrderHeader."Document Type";
                ItemChargeAssgntPurch."Applies-to Doc. No." := PurchOrderHeader."No.";
            END;
            ItemChargeAssgntPurch.INSERT();
        END;

        // FR01: Archive quote
        AutoArchiveManagement.StorePurchDocument(rec);

        Rec.DELETE();
        PurchQuoteLine.DELETEALL();
    end;
}
