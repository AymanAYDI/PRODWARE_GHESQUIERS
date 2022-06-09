pageextension 50014 "PWD SalesOrder" extends "Sales Order"
{
    layout
    {
        addafter("No.")
        {
            field("PWD Call Type"; Rec."PWD Call Type")
            {
                ApplicationArea = All;
            }
            field("PWD Call No."; Rec."PWD Call No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Date")
        {
            field("PWD Delivery time"; Rec."PWD Delivery time")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sell-to Contact")
        {
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = All;
            }
            field("PWD DSA No."; Rec."PWD DSA No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field("PWD Requested Delivery Date"; Rec."Requested Delivery Date")
            {
                ApplicationArea = All;
            }
            field("PWD Promised Delivery Date"; Rec."Promised Delivery Date")
            {
                ApplicationArea = All;
            }
            field("PWD Ne pas utiliser No. de DSA"; Rec."PWD Ne pas utiliser No. de DSA")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field("PWD Preparation Status"; Rec."PWD Preparation Status")
            {
                ApplicationArea = All;
            }
            field("PWD Livraison OK"; Rec."PWD Livraison OK")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("PWD Preparation in process"; Rec."PWD Preparation in process")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    AccessControl.SETRANGE(AccessControl."User Security ID", UserSecurityId());
                    AccessControl.SETRANGE(AccessControl."Role ID", CstG002);
                    IF NOT AccessControl.FindFirst() THEN
                        ERROR(cstG004);
                end;
            }
            field("PWD DateLastPurchR"; DateLastPurchR)
            {
                ApplicationArea = All;
                Caption = 'Date de la derni‚re livraison';
            }
            field("PWD Seafrance Order No."; Rec."PWD Seafrance Order No.")
            {
                ApplicationArea = All;
            }
            field("PWD Commentaire 1"; Rec."PWD Commentaire 1")
            {
                ApplicationArea = All;
            }
            field("PWD Commentaire 2"; Rec."PWD Commentaire 2")
            {
                ApplicationArea = All;
            }
            field("PWD Commentaire 3"; Rec."PWD Commentaire 3")
            {
                ApplicationArea = All;
            }
            field("PWD Commentaire 4"; Rec."PWD Commentaire 4")
            {
                ApplicationArea = All;
            }
            field("PWD Commentaire 5"; Rec."PWD Commentaire 5")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Contact No.")
        {
            field("PWD Bill-to Additional name"; Rec."PWD Bill-to Additional name")
            {
                ApplicationArea = All;
            }
            field("PWD Bill-to C/O"; Rec."PWD Bill-to C/O")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Name")
        {
            field("PWD Bill-to Name 2"; Rec."Bill-to Name 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Contact")
        {
            field("PWD Discount Profit %"; Rec."PWD Discount Profit %")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("PWD Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("PWD VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;
            }
        }
        modify("Payment Terms Code")
        {
            Editable = false;
        }
        modify("Due Date")
        {
            Editable = false;
        }
        modify("Payment Discount %")
        {
            Editable = false;
        }
        modify("Pmt. Discount Date")
        {
            Editable = false;
        }
        modify("Payment Method Code")
        {
            Editable = false;
        }
        addafter("VAT Bus. Posting Group")
        {
            field("PWD Combine Shipments"; Rec."Combine Shipments")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Contact")
        {
            field("PWD Trading Brand"; Rec."PWD Trading Brand")
            {
                ApplicationArea = All;
            }
            field("PWD Order Trading Brand"; Rec."PWD Order Trading Brand")
            {
                ApplicationArea = All;
            }
        }

        modify("Location Code")
        {
            Visible = false;
        }
        modify("Outbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        addafter("Shipping Advice")
        {
            field("PWD Shipping Time"; Rec."Shipping Time")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Pla&nning")
        {
            separator(Separator) { }
            action("PWD Item no stocks")
            {
                ApplicationArea = all;
                Caption = 'Article non stockés';
                RunObject = Page "Catalog Item List";
                Image = NonStockItem;
            }
            action("PWD Print certificat")
            {
                Caption = 'Imprimer Certificate';
                ApplicationArea = all;
                Image = Certificate;
                trigger OnAction()
                BEGIN
                    PrintCustomsCertificate();
                END;
            }
        }
        addafter(Reopen)
        {
            separator("PWD separator026")
            {
            }
            action("PWD Classement sans suite")
            {
                Caption = 'Classement sans suite';
                ApplicationArea = all;
                Image = Delete;
                Trigger OnAction()
                VAR
                    AutoarchMngt: Codeunit "PWD ArchiveAutoManagement";
                BEGIN
                    AutoarchMngt.StoreSalesDocument(Rec);
                    Rec.DELETE(TRUE);
                    CurrPage.UPDATE(FALSE);
                END;
            }
            separator("PWD separator028")
            {
            }
            action("PWD Imprimer BP")
            {
                ApplicationArea = all;
                Caption = 'Imprimer BP';
                Image = Print;
                Trigger OnAction()
                BEGIN
                    IF Rec."PWD Preparation in process" = FALSE THEN MESSAGE(cstG004);
                    CurrPage.SETSELECTIONFILTER(SalesHeader);
                    //TODO
                    //REPORT.RUN(REPORT::"Picking List Unit Price Null", TRUE, TRUE, SalesHeader);
                    REPORT.RUN(REPORT::"Picking List", TRUE, TRUE, SalesHeader);
                END;
            }
            action("PWD Trier lignes")
            {
                ApplicationArea = all;
                Caption = 'Trier lignes';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                Image = FilterLines;
                Trigger OnAction()
                BEGIN
                    FctLineFilters();
                END;
            }
            action("PWD Calculer PU")
            {
                ApplicationArea = all;
                Caption = 'Calculer PU';
                Promoted = True;
                PromotedCategory = Process;
                Image = Calculate;
                Trigger OnAction()
                VAR
                    RecLSalesHeader: Record "Sales Header";
                BEGIN
                    RecLSalesHeader.RESET();
                    RecLSalesHeader.SETRANGE("Document Type", Rec."Document Type");
                    RecLSalesHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(REPORT::"PWD Calcul PU=CU*coef", TRUE, TRUE, RecLSalesHeader);
                END;
            }
            action("PWD Confirm. commande PDF / Mail")
            {
                ApplicationArea = all;
                Caption = 'Confirm. commande PDF / Mail';
                Promoted = True;
                Image = SendTo;
                PromotedCategory = Process;
                Trigger OnAction()
                VAR
                    CduGenerationPDF: Codeunit "PWD Generation PDF Auto";
                BEGIN
                    CLEAR(CduGenerationPDF);
                    CduGenerationPDF.GeneratePDFSalesOrder(Rec."No.");
                END;
            }
        }
        modify(Post)
        {
            Visible = false;
        }
        addafter(Post)
        {
            action("PWD Post")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                AboutTitle = 'Posting the order';
                AboutText = 'Posting will ship or invoice the quantities on the order, or both. Post and Send can save the order as a file, print it, or attach it to an email, all in one go.';

                trigger OnAction()
                begin
                    Rec.TESTFIELD("PWD Call Type");
                    Rec.TESTFIELD("Requested Delivery Date");
                    Rec.TESTFIELD("Promised Delivery Date");
                    IF (Rec."Requested Delivery Date" < Rec."Document Date") OR (Rec."Promised Delivery Date" < Rec."Document Date") THEN
                        ERROR('La date de livraison ne peut ˆtre inf‚rieur … la date de document.');
                    Rec.VerifyPriceweight(Rec);
                    CLEAR(ValidateSalesOrder);
                    ValidateSalesOrder.InitRequete(Rec);
                    ValidateSalesOrder.RUNMODAL();
                end;
            }
        }
        addbefore("Work Order")
        {
            separator("PWD Separator100")
            {
            }
            action("PWD PrintSalesHeader")
            {
                ApplicationArea = all;
                Caption = 'Print';
                Image = Print;
                trigger OnAction()
                var
                    DocPrint: Codeunit "Document-Print";
                BEGIN
                    CtrlImpConfCde();
                    DocPrint.PrintSalesHeader(Rec);
                END;
            }
        }
        addafter("&Print")
        {
            separator("PWD Separator23")
            {
            }
            group("PWD Appel d'offre ")
            {
                Caption = 'Appel d''offre';
                separator(separator33)
                {
                }
                action("PWD Sélection des fournisseur interroger")
                {
                    ApplicationArea = all;
                    Caption = 'Sélection des fournisseurs à interroger';
                    Image = Action;
                    RunObject = Page "Appeal for tenders/Vendor -TrB";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "Document No." = FIELD("No.");
                }
                separator(separator35)
                {
                }
                action("PWD Generation des demandes de prix")
                {
                    ApplicationArea = All;
                    Caption = 'Génération des demandes de prix';
                    Image = Price;
                    Trigger OnAction()
                    BEGIN
                        CreatePurchQuote.InitDocument(Rec."Document Type".AsInteger(), Rec."No.");
                        CreatePurchQuote.RUN();
                    END;
                }
                action("PWD Export demandes de prix au format Excel")
                {
                    ApplicationArea = all;
                    Caption = 'Export demandes de prix au format Excel';
                    Image = ExportToExcel;
                    Trigger OnAction()
                    BEGIN
                        CreatePurchQuote.InitDocument(Rec."Document Type".AsInteger(), Rec."No.");
                        CreatePurchQuote.RUN();
                        Rec.SETRECFILTER();
                        REPORT.RUNMODAL(Report::"PWD Export Microsoft Excel", FALSE, FALSE, Rec);
                        Rec.RESET();
                    END;
                }
                action("PWD Import demandes de prix depuis Excel")
                {
                    ApplicationArea = all;
                    Caption = 'Import demandes de prix depuis Excel';
                    Image = ImportExcel;
                    Trigger OnAction()
                    BEGIN
                        Rec.SETRECFILTER();
                        REPORT.RUNMODAL(Report::"PWD Import Microsoft Excel", FALSE, FALSE, Rec);
                        Rec.RESET();
                    END;
                }
                Separator("PWD Separator39") { }
                Action("PWD Sélection des  offres fournisseurs")
                {
                    ApplicationArea = all;
                    Caption = 'Sélection des offres fournisseurs';
                    Image = Action;
                    Trigger OnAction()
                    VAR
                        SalesLine: Record "Sales Line";
                    BEGIN
                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine.SETRANGE("Document No.", Rec."No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        Page.RUN(Page::"Vendors offers to select -TrB", SalesLine);
                    END;
                }
                Action("PWD Acceptation des offres")
                {
                    ApplicationArea = all;
                    Caption = 'Acceptation des offres';
                    Image = Completed;
                    Trigger OnAction()
                    BEGIN
                        SalesHeader := Rec;
                        SalesHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Accept selected offers -TrB", FALSE, FALSE, SalesHeader);
                    END;
                }
                Separator("PWD Separator42") { }
                Action("PWD Création des tarifs fruits et légumes")
                {
                    ApplicationArea = all;
                    Caption = 'Création des tarifs fruits et légumes';
                    Image = CreateDocument;
                    Trigger OnAction()
                    BEGIN
                        SalesHeader := Rec;
                        SalesHeader.SETRECFILTER();
                        REPORT.RUN(50019, FALSE, FALSE, SalesHeader);
                    END;
                }
                separator("PWD Separator44") { }
                Action("PWD Génération  des commandes achat")
                {
                    ApplicationArea = all;
                    Caption = 'Génération  des commandes d''achat';
                    Image = CreateDocument;
                    Trigger OnAction()
                    BEGIN
                        SalesHeader := Rec;
                        SalesHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Generation Purchase Order -TrB", TRUE, FALSE, SalesHeader);
                    END;
                }
            }
            group("PWD Disponibilité Art. Mag.")
            {
                caption = 'Disponibilité Art. Mag.';
                action("Disponibilité Art. Mag.")
                {
                    applicationArea = all;
                    caption = 'Disponibilité Art. Mag.';
                    Image = ItemAvailability;
                    Trigger OnAction()
                    var
                        SalesLine: Record "Sales Line";
                        ItemAvailabilityFormsMgt: Codeunit "Item Availability Forms Mgt";
                    BEGIN
                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine.SETRANGE("Document No.", Rec."No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        ItemAvailabilityFormsMgt.ShowItemAvailFromSalesLine(SalesLine, 2);
                    END;
                }
            }
        }
    }

    PROCEDURE PrintCustomsCertificate()
    BEGIN
        CurrPage.SalesLines.Page.PrintHealthCertificate();
    END;

    PROCEDURE CtrlImpConfCde()
    BEGIN
        /* Member.SETRANGE("User ID",USERID);
         Member.SETRANGE("Role ID",'DIRECTION');
         IF NOT Member.FindFist() THEN BEGIN
            //Ctrl des lignes
            SalesLineCtrl.SETRANGE("Document Type","Document Type");
            SalesLineCtrl.SETRANGE("Document No.","No.");
            SalesLineCtrl.SETRANGE(Type,SalesLineCtrl.Type::Item);
            SalesLineCtrl.SETRANGE("Unit Price",0);
            IF SalesLineCtrl.FindFirst() THEN REPEAT
              IF (Location.GET(SalesLineCtrl."Location Code")) AND(Location."Controle du prix plancher") THEN
               ERROR(cstG005);
            UNTIL SalesLineCtrl.NEXT=0;
            SalesLineCtrl.SETRANGE("Unit Price");
            IF SalesLineCtrl.FindSet() THEN BEGIN
               REPEAT

                  //*** Controle prix unitaire > prix plancher de l'article
                  IF Item.GET(SalesLineCtrl."No.") AND
                  (Location.GET(SalesLineCtrl."Location Code")) AND(Location."Controle du prix plancher") THEN BEGIN
                     BottomPrice := Item."Bottom Price";
                     IF "Currency Code" <> '' THEN BEGIN
                        Currency.GET("Currency Code");
                        BottomPrice :=
                            ROUND(
                            CurrExchRate.ExchangeAmtLCYToFCY(
                            TODAY,"Currency Code",
                            BottomPrice,"Currency Factor"),
                            Currency."Unit-Amount Rounding Precision")
                     END;
                     IF (SalesLineCtrl."Unit Price" < BottomPrice) AND  (BottomPrice <> 0) THEN
                        ERROR(cstG006
                        ,SalesLineCtrl."No.");
                  END;
               UNTIL SalesLineCtrl.NEXT = 0;
            END;
         END;*/
    END;

    PROCEDURE FctLineFilters()
    VAR
        RecSalesLIne: Record "Sales Line";
    BEGIN
        RecSalesLIne.RESET();
        RecSalesLIne.SETCURRENTKEY("Document Type", "Document No.", "Location Code", "PWD Family", "No.");
        RecSalesLIne.SETRANGE("Document Type", Rec."Document Type");
        RecSalesLIne.SETRANGE("Document No.", Rec."No.");
        CurrPage.SalesLines.Page.SETTABLEVIEW(RecSalesLIne);
        CurrPage.SalesLines.Page.UpdateForm(TRUE);
    END;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        END;
        PurchRRec.RESET();
        PurchRRec.SETCURRENTKEY("Order No.", "Document Date");
        PurchRRec.SETRANGE("Order No.", Rec."No.");
        IF PurchRRec.FindFirst() THEN
            DateLastPurchR := FORMAT(PurchRRec."Document Date")
        ELSE
            DateLastPurchR := '';
    end;

    trigger OnAfterGetRecord()
    BEGIN
        PurchRRec.RESET();
        PurchRRec.SETCURRENTKEY(PurchRRec."Order No.", PurchRRec."Document Date");
        PurchRRec.SETRANGE(PurchRRec."Order No.", Rec."No.");
        IF PurchRRec.FindFirst() THEN
            DateLastPurchR := FORMAT(PurchRRec."Document Date")
        ELSE
            DateLastPurchR := '';
    END;

    trigger OnModifyRecord(): Boolean
    BEGIN
        Rec.BlockDocument();
    END;

    var
        AccessControl: Record "Access Control";
        SalesHeader: Record "Sales Header";
        PurchRRec: Record "Sales Shipment Header";
        CreatePurchQuote: Report "Create Purchase Quote r -TrB";
        ValidateSalesOrder: Report "PWD Validate Sales Order";
        UserMgt: Codeunit "User Setup Management";
        cstG004: Label 'Vous n''avez pas les droits pour modifier ce champ !';
        DateLastPurchR: Text[30];
        CstG002: Label 'SUPER';
}
