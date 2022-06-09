pageextension 50013 "PWD SalesQuote" extends "Sales Quote"
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("PWD No."; Rec."No.")
            {
                ApplicationArea = All;
                Importance = Standard;
                Visible = PWDDocNoVisible;
            }

            field("PWD Call No."; Rec."PWD Call No.")
            {
                ApplicationArea = All;
            }
            field("PWD Call Type"; Rec."PWD Call Type")
            {
                ApplicationArea = all;
            }
        }
        addafter("Requested Delivery Date")
        {
            field("PWD Delivery time"; Rec."PWD Delivery time")
            {
                ApplicationArea = all;
            }
        }
        addafter(Status)
        {
            field("PWD Filing Reason"; Rec."PWD Filing Reason")
            {
                ApplicationArea = all;
            }
            field("PWD Reference"; Rec."PWD Reference")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bill-to Contact No.")
        {
            field("PWD Bill-to Additional name"; Rec."PWD Bill-to Additional name")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bill-to Name")
        {
            field("PWD Bill-to Name 2"; Rec."Bill-to Name 2")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bill-to Contact")
        {
            field("Discount Profit %"; Rec."PWD Discount Profit %")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Ship-to Contact")
        {
            field("PWD Trading Brand"; Rec."PWD Trading Brand")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            action("PWD Item no stocks")
            {
                Caption = 'Article non stockés';
                RunObject = Page "Catalog Item List";
                ApplicationArea = all;
                Image = NonStockItem;
            }
        }
        addafter(Print)
        {
            action("PWD FilingReason")
            {
                ApplicationArea = all;
                Caption = 'Filing Reason';
                Image = Delete;
                trigger OnAction()
                BEGIN
                    Rec.TESTFIELD("PWD Filing Reason");
                    AutoArchmngt.StoreSalesDocument(Rec);
                    Rec.DELETE(TRUE);
                    CurrPage.UPDATE(FALSE);
                END;
            }
            action("PWD Calc PU")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Image = Calculate;
                trigger OnAction()
                VAR
                    RecLSalesHeader: Record "Sales Header";
                BEGIN
                    RecLSalesHeader.RESET();
                    RecLSalesHeader.SETRANGE("Document Type", Rec."Document Type");
                    RecLSalesHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(REPORT::"PWD Calcul PU=CU*coef", TRUE, TRUE, RecLSalesHeader);
                END;
            }
            action("PWD Quote PDF_Email")
            {
                ApplicationArea = all;
                Promoted = true;
                Image = SendTo;
                PromotedCategory = Process;
                trigger OnAction()
                VAR
                    CduGenerationPDF: Codeunit "PWD Generation PDF Auto";
                BEGIN
                    CLEAR(CduGenerationPDF);
                    CduGenerationPDF.GeneratePDFSalesQuote(Rec."No.");
                END;
            }
            group("PWD tender")
            {
                caption = 'Trading Brand';
                action("PWD Article de Contremarque")
                {
                    ApplicationArea = all;
                    Caption = 'Article de Contremarque';
                    Image = Item;
                    trigger OnAction()
                    VAR
                        FromSalesLine: Record "Sales Line";
                    BEGIN
                        IF FromSalesLine."PWD Trading Brand" = TRUE THEN BEGIN
                            FromSalesLine.VALIDATE("PWD Trading Brand", FALSE);
                            FromSalesLine.VALIDATE("Location Code", Rec."Location Code");
                        END ELSE BEGIN
                            FromSalesLine.VALIDATE("PWD Trading Brand", TRUE);
                            FromSalesLine.VALIDATE("Location Code", 'CML');
                        END;
                        FromSalesLine.MODIFY();
                    END;
                }
                separator(separator011)
                {
                }
                action("PWD Selection des fournisseurs interroger")
                {
                    ApplicationArea = all;
                    Caption = 'Sélection des fournisseurs à interroger';
                    Image = Action;
                    RunObject = Page "Appeal for tenders/Vendor -TrB";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                }
                action("PWD Generation des demandes de prix")
                {
                    ApplicationArea = all;
                    Caption = 'Génération des demandes de prix';
                    Image = Price;
                    TRIGGER OnAction()
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
                    trigger OnAction()
                    BEGIN
                        CreatePurchQuote.InitDocument(Rec."Document Type".AsInteger(), Rec."No.");
                        CreatePurchQuote.RUN();
                        Rec.SETRECFILTER();
                        REPORT.RUNMODAL(Report::"PWD Export Microsoft Excel", FALSE, FALSE, Rec);
                        Rec.RESET();
                    END;
                }
                action("PWD Import demande de prix depuis Excel")
                {
                    ApplicationArea = all;
                    Caption = 'Import demande de prix depuis Excel';
                    Image = ImportExcel;
                    trigger OnAction()
                    BEGIN
                        Rec.SETRECFILTER();
                        REPORT.RUNMODAL(Report::"PWD Import Microsoft Excel", FALSE, FALSE, Rec);
                        Rec.RESET();
                    END;
                }
                action("PWD Selection des  offres fournisseurs")
                {
                    ApplicationArea = all;
                    Caption = 'Sélection des  offres fournisseurs';
                    Image = Action;
                    trigger OnAction()
                    VAR
                        SalesLine: Record "Sales Line";
                    BEGIN
                        SalesLine.RESET();
                        SalesLine.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine.SETRANGE("Document No.", Rec."No.");
                        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                        PAGE.RUN(Page::"Vendors offers to select -TrB", SalesLine);
                    END;
                }
                action("PWD Acceptation des offres")
                {
                    ApplicationArea = all;
                    Caption = 'Acceptation des offres';
                    Image = PrintReport;
                    trigger OnAction()
                    VAR
                        SalesHeader: Record "Sales Header";
                    BEGIN
                        SalesHeader := Rec;
                        SalesHeader.SETRECFILTER();
                        REPORT.RUN(Report::"Accept selected offers -TrB", FALSE, FALSE, SalesHeader);
                    END;
                }
            }
        }
    }
    var
        CreatePurchQuote: Report "Create Purchase Quote r -TrB";
        AutoArchmngt: Codeunit "PWD ArchiveAutoManagement";
        PWDDocNoVisible: boolean;

    procedure PWDSetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        PWDDocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Quote, Rec."No.");
    end;
}
