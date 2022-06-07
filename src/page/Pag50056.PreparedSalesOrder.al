page 50056 "PWD Prepared Sales Order"
{
    Caption = 'Sales Order';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order), "PWD Preparation Status" = FILTER(>= Prepared));
    ApplicationArea = all;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Call Type"; Rec."PWD Call Type")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field(Reference; Rec."PWD Reference")
                {
                    ApplicationArea = All;
                }
                field("Ne pas utiliser No. de DSA"; Rec."PWD Ne pas utiliser No. de DSA")
                {
                    ApplicationArea = All;
                }
                field("DSA No."; Rec."PWD DSA No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Delivery time"; Rec."PWD Delivery time")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Preparation in process"; Rec."PWD Preparation in process")
                {
                    ApplicationArea = All;

                    /*trigger OnValidate()
                    begin
                        Memberof.SETRANGE(Memberof."User ID", USERID);
                        Memberof.SETRANGE(Memberof."Role ID", 'SUPER');
                        IF NOT Memberof.FIND('-') THEN
                            ERROR(Text1000000004);
                    end;*/
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Preparation Status"; Rec."PWD Preparation Status")
                {
                    ApplicationArea = All;
                }
                field("Livraison OK"; Rec."PWD Livraison OK")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(DateLastPurchR; DateLastPurchR)
                {
                    Caption = 'Date de la dernière livraison';
                    ApplicationArea = All;
                }
                field("Commentaire 1"; Rec."PWD Commentaire 1")
                {
                    ApplicationArea = All;
                }
                field("Commentaire 2"; Rec."PWD Commentaire 2")
                {
                    ApplicationArea = All;
                }
                field("Commentaire 3"; Rec."PWD Commentaire 3")
                {
                    ApplicationArea = All;
                }
                field("Commentaire 4"; Rec."PWD Commentaire 4")
                {
                    ApplicationArea = All;
                }
                field("Commentaire 5"; Rec."PWD Commentaire 5")
                {
                    ApplicationArea = All;
                }
                field("Seafrance Order No."; Rec."PWD Seafrance Order No.")
                {
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "Sales Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Facturation)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Discount Profit %"; Rec."PWD Discount Profit %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ApplicationArea = All;
                }
            }
            group(Livraison)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Trading Brand"; Rec."PWD Trading Brand")
                {
                    ApplicationArea = All;
                }
                field("Order Trading Brand"; Rec."PWD Order Trading Brand")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                }
            }
            group(International)
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        ChangeExchangeRate: page "Change Exchange Rate";
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        IF ChangeExchangeRate.RUNMODAL() = ACTION::OK THEN BEGIN
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
            }
            /* group(BizTalk)
             {
                 Caption = 'BizTalk';
                 field("BizTalk Sales Order"; "BizTalk Sales Order")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("Date Received"; "Date Received")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("Time Received"; "Time Received")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("Customer Order No."; "Customer Order No.")
                 {
                     ApplicationArea = All;
                 }
                 field("BizTalk Sales Order Cnfmn."; "BizTalk Sales Order Cnfmn.")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("Date Sent"; "Date Sent")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
                 field("Time Sent"; "Time Sent")
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }
             }*/
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Appel d'offre")
            {
                Caption = 'Trading Brand';
                action("Article de &contremarque")
                {
                    Caption = 'Article de &contremarque';
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                    Image = Item;

                    trigger OnAction()
                    var
                        FromSalesLine: Record "Sales Line";
                    begin
                        CurrPage.SalesLines.PAGE.GETRECORD(FromSalesLine);
                        IF FromSalesLine."PWD Trading Brand" = TRUE THEN BEGIN
                            FromSalesLine.VALIDATE("PWD Trading Brand", FALSE);
                            FromSalesLine.VALIDATE("Location Code", Rec."Location Code");
                        END ELSE BEGIN
                            FromSalesLine.VALIDATE("PWD Trading Brand", TRUE);
                            FromSalesLine.VALIDATE("Location Code", 'CML');
                        END;
                        FromSalesLine.MODIFY();
                    end;
                }
                separator(Action1000000033)
                {
                }
                action("Sélection des fournisseurs à interroger")
                {
                    Caption = 'Sélection des fournisseurs à interroger';
                    RunObject = Page "Appeal for tenders/Vendor -TrB";
                    Image = Action;
                    RunPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Action1000000021)
                {
                }
                action("Génération des demandes de prix")
                {
                    Caption = 'Génération des demandes de prix';
                    ApplicationArea = All;
                    Image = Price;

                    trigger OnAction()
                    begin
                        CreatePurchQuote.InitDocument(Rec."Document Type".AsInteger(), Rec."No.");
                        CreatePurchQuote.RUN();
                    end;
                }
                action("Export demandes de prix au format Excel")
                {
                    Caption = 'Export demandes de prix au format Excel';
                    ApplicationArea = All;
                    Image = ExportToExcel;

                    trigger OnAction()
                    begin
                        CreatePurchQuote.InitDocument(Rec."Document Type".AsInteger(), Rec."No.");
                        CreatePurchQuote.RUN();
                        Rec.SETRECFILTER();
                        REPORT.RUNMODAL(Report::"PWD Export Microsoft Excel", FALSE, FALSE, Rec);
                        Rec.RESET();
                    end;
                }
                action("Import demandes de prix depuis Excel")
                {
                    Caption = 'Import demandes de prix depuis Excel';
                    ApplicationArea = All;
                    Image = ImportExcel;

                    trigger OnAction()
                    begin
                        Rec.SETRECFILTER();
                        REPORT.RUNMODAL(Report::"PWD Import Microsoft Excel", FALSE, FALSE, Rec);
                        Rec.RESET();
                    end;
                }
                separator(Action1000000016)
                {
                }
                action("Sélection des  offres fournisseurs")
                {
                    Caption = 'Sélection des  offres fournisseurs';
                    Image = Action;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesLine: Record "Sales Line";
                    begin
                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine.SETRANGE("Document No.", Rec."No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        Page.RUN(Page::"Vendors offers to select -TrB", SalesLine);
                    end;
                }
                action("Acceptation des offres")
                {
                    Caption = 'Acceptation des offres';
                    ApplicationArea = All;
                    Image = Approve;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader := Rec;
                        SalesHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Accept selected offers -TrB", FALSE, FALSE, SalesHeader);
                    end;
                }
                separator(Action1000000019)
                {
                }
                action("Création des tarifs fruits et légumes")
                {
                    Caption = 'Création des tarifs fruits et légumes';
                    ApplicationArea = All;
                    Image = CreateDocument;

                    trigger OnAction()
                    begin
                        SalesHeader := Rec;
                        SalesHeader.SETRECFILTER();
                        REPORT.RUN(50019, FALSE, FALSE, SalesHeader);
                    end;
                }
                separator(Action1000000054)
                {
                }
                action("Génération  des commandes d'achat")
                {
                    Caption = 'Génération  des commandes d''achat';
                    ApplicationArea = All;
                    Image = Purchase;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader := Rec;
                        SalesHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Generation Purchase Order -TrB", TRUE, FALSE, SalesHeader);
                    end;
                }
            }
            group("&Commande")
            {
                Caption = 'O&rder';
                action(Statistiques)
                {
                    Caption = 'Statistics';
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                    Image = Statistics;

                    trigger OnAction()
                    begin
                        SalesSetup.GET();
                        IF SalesSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.SalesLines.PAGE.CalcInvDisc();
                            COMMIT()
                        END;
                        Page.RUNMODAL(Page::"Sales Order Statistics", Rec);
                    end;
                }
                action(Fiche)
                {
                    Caption = 'Card';
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                    Image = Card;
                }
                action("Co&mmentaires")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                    ApplicationArea = All;
                    Image = Comment;
                }
                action("Li&vraisons")
                {
                    Caption = 'S&hipments';
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                    Image = PostedShipment;

                }
                action("F&actures")
                {
                    Caption = 'Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                    Image = Invoice;
                }
                action("A&xe analytique")
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //TODO
                    RunObject = Page "Dimension Set Entries";
                    //RunPageLink = "Table ID" = CONST(36), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Line No." = CONST(0);
                    ApplicationArea = All;
                }
                separator(Action120)
                {
                }
                action(Planification)
                {
                    Caption = 'Planning';
                    ApplicationArea = All;
                    Image = Planning;

                    trigger OnAction()
                    var
                        SalesPlan: page "Sales Order Planning";
                    begin
                        SalesPlan.SetSalesOrder(Rec."No.");
                        SalesPlan.RUNMODAL();
                    end;
                }
                separator(Action1000000010)
                {
                }
                action("&Imprimer certificat")
                {
                    Caption = '&Imprimer certificat';
                    ApplicationArea = All;
                    Image = Print;

                    trigger OnAction()
                    begin
                        PrintCustomsCertificate();
                    end;
                }
            }
            group("Fonction&s")
            {
                Caption = 'F&unctions';
                action("Copier &document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    ApplicationArea = All;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL();
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Archi&ver document")
                {
                    Caption = 'Archi&ve Document';
                    ApplicationArea = All;
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Déplacer lignes né&gatives")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    ApplicationArea = All;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL();
                        MoveNegSalesLines.ShowDocument();
                    end;
                }
                action("Articles &non stockés")
                {
                    Caption = 'Nonstoc&k Items';
                    ApplicationArea = All;
                    Image = NonStockItem;

                    trigger OnAction()
                    begin
                        IF NOT UpdateAllowed() THEN
                            EXIT;

                        CurrPage.SalesLines.PAGE.ShowNonstockItems();
                    end;
                }
                action("Promesse de livraison")
                {
                    Caption = 'Order &Promising';
                    Visible = false;
                    ApplicationArea = All;
                    Image = OrderPromising;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", Rec."Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", Rec."No.");
                        Page.RUNMODAL(Page::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                group(Magasin)
                {
                    Caption = 'Warehouse';
                    action("Lignes expédition")
                    {
                        Caption = 'Shipment Lines';
                        RunObject = Page "Whse. Shipment Lines";
                        RunPageLink = "Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                        ApplicationArea = All;
                        Image = ShipmentLines;
                    }
                    action("Créer expédition")
                    {
                        Caption = 'Create Shipment';
                        ApplicationArea = All;
                        Image = NewShipment;

                        trigger OnAction()
                        var
                            GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                        begin
                            GetSourceDocOutbound.CreateFromSalesOrder(Rec);
                        end;
                    }
                }
                action(Lancer)
                {
                    Caption = 'Re&lease';
                    RunObject = Codeunit "Release Sales Document";
                    ShortCutKey = 'Ctrl+F11';
                    ApplicationArea = All;
                    Image = ReleaseDoc;
                }
                action("R&ouvrir")
                {
                    Caption = 'Re&open';
                    ApplicationArea = All;
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.Reopen(Rec);
                    end;
                }
                separator(Action1000000014)
                {
                }
                action("Envo&yer confirmation cde vente BizTalk")
                {
                    Caption = '&Send BizTalk Sales Order Cnfmn.';
                    Visible = false;
                    ApplicationArea = All;
                    Image = SendConfirmation;

                    trigger OnAction()
                    var
                    //ToDo
                    //BizTalkManagement: Codeunit "BizTalkManagement";
                    begin
                        // BizTalkManagement.SendSalesOrderConf(Rec);
                    end;
                }
                separator(Action1000000000)
                {
                }
                action("Classement sans suite")
                {
                    Caption = 'Filing Reason';
                    Image = Action;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        AutoarchMngt: Codeunit "PWD ArchiveAutoManagement";
                    begin
                        AutoarchMngt.StoreSalesDocument(Rec);
                        Rec.DELETE(TRUE);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(Action1000000012)
                {
                }
                action("Imprimer BP")
                {
                    Caption = 'Imprimer BP';
                    Visible = false;
                    ApplicationArea = All;
                    Image = Print;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        Text1000000002: Label 'Attention : la préparation de commande n''a pas encore été calculée.';
                    begin
                        IF Rec."PWD Preparation in process" = FALSE THEN MESSAGE(Text1000000002);
                        CurrPage.SETSELECTIONFILTER(SalesHeader);
                        //ToDo
                        //REPORT.RUN(REPORT::"Picking List Unit Price Null", TRUE, TRUE, SalesHeader);
                        REPORT.RUN(REPORT::"Picking List", TRUE, TRUE, SalesHeader);
                    end;
                }
            }
            group("&Validation")
            {
                Caption = 'P&osting';
                action("Impression test")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    ApplicationArea = All;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("&Valider")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    ShortCutKey = 'F11';
                    ApplicationArea = All;
                    Image = Post;

                    trigger OnAction()
                    begin
                        Rec.VerifyPriceweight(Rec);
                        CLEAR(ValidateSalesOrder);
                        ValidateSalesOrder.InitRequete(Rec);
                        ValidateSalesOrder.RUNMODAL();
                    end;
                }
                action("Valider et i&mprimer")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    RunObject = Codeunit "Sales-Post + Print";
                    ShortCutKey = 'Shift+F11';
                    ApplicationArea = All;
                    Image = PostPrint;
                }
                action("Valider par l&ot")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    ApplicationArea = All;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Disponibilité Art. Mag.")
            {
                Caption = 'Item Availability by Location';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = ItemAvailability;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    //ToDo
                    //CurrPage.SalesLines.PAGE.ItemAvailability(2);
                end;
            }
            action("&Imprimer")
            {
                Caption = '&Print';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                begin
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PurchRRec.RESET();
        PurchRRec.SETCURRENTKEY("Order No.", "Document Date");
        PurchRRec.SETRANGE("Order No.", Rec."No.");
        IF PurchRRec.FIND('-') THEN
            DateLastPurchR := FORMAT(PurchRRec."Document Date")
        ELSE
            DateLastPurchR := '';
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD();
        EXIT(Rec.ConfirmDeletion());
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.BlockDocument();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetSalesFilter();
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FILTERGROUP(0);
        END;

        Rec.SETRANGE("Date Filter", 0D, WORKDATE() - 1);
        PurchRRec.RESET();
        PurchRRec.SETCURRENTKEY("Order No.", "Document Date");
        PurchRRec.SETRANGE("Order No.", Rec."No.");
        IF PurchRRec.FIND('-') THEN
            DateLastPurchR := FORMAT(PurchRRec."Document Date")
        ELSE
            DateLastPurchR := '';
    end;

    var
        //ToDo
        //Memberof: Record 2000000003;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        PurchRRec: Record "Sales Shipment Header";
        CopySalesDoc: Report "Copy Sales Document";
        CreatePurchQuote: Report "Create Purchase Quote r -TrB";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ValidateSalesOrder: Report "PWD Validate Sales Order";
        ArchiveManagement: Codeunit ArchiveManagement;
        DocPrint: Codeunit "Document-Print";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        Text000: Label 'Unable to execute this function while in view only mode.';
        DateLastPurchR: Text[30];

    procedure UpdateAllowed(): Boolean
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    procedure PrintCustomsCertificate()
    begin
        CurrPage.SalesLines.PAGE.DescriptionOnFormat();
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE();
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;
}
