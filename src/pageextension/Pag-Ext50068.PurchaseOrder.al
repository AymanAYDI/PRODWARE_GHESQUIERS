pageextension 50068 "PWD PurchaseOrder" extends "Purchase Order"
{
    layout
    {
        modify("No.")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("PWD NO."; Rec."NO.")
            {
                ApplicationArea = Suite;
                Importance = Promoted;
                ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                Visible = DocNoVisible;
            }
        }
        addafter(Status)
        {
            field("PWD Buy-from Contact"; Rec."Buy-from Contact")
            {
                ApplicationArea = All;
            }
        }
        addafter("Pay-to Contact No.")
        {
            field("PWD No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                ApplicationArea = All;
            }
        }
        addafter("Buy-from Contact")
        {
            field("PWD Reception OK"; Rec."PWD Reception OK")
            {
                ApplicationArea = All;
            }
            field("PWD DateLastPurchR"; DateLastPurchR)
            {
                ApplicationArea = All;
                Caption = 'Date of last purchase receipt';
            }
        }
        addafter("Prepayment")
        {
            group("PWD Stocking Advise")
            {
                Caption = 'Stocking Advise';
                field("PWD Sealing"; Rec."PWD Sealing")
                {
                    ApplicationArea = All;
                }
                field("PWD Attachment 1"; Rec."PWD Attachment 1")
                {
                    ApplicationArea = All;
                }
                field("PWD Attachment 2"; Rec."PWD Attachment 2")
                {
                    ApplicationArea = All;
                }
                field("PWD Attachment 3"; Rec."PWD Attachment 3")
                {
                    ApplicationArea = All;
                }
                field("PWD Attachment 4"; Rec."PWD Attachment 4")
                {
                    ApplicationArea = All;
                }
                field("PWD Notice Series No."; Rec."PWD Notice Series No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("PWD Stocking Advise")
        {
            group("PWD Vendor Quality")
            {
                Caption = 'Vendor Quality';
                field("PWD Delivery Time Rating"; Rec."PWD Delivery Time Rating")
                {
                    ApplicationArea = All;
                }
                field("PWD Delivered Quantity Rating"; Rec."PWD Delivered Quantity Rating")
                {
                    ApplicationArea = All;
                }
                field("PWD Technical Rating"; Rec."PWD Technical Rating")
                {
                    ApplicationArea = All;
                }
                field("PWD Documentation Rating"; Rec."PWD Documentation Rating")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter(Control1904651607)
        {
            part("PWD Purchases Line FactBox"; "PWD Purchases Line FactBox")
            {
                applicationArea = all;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                            "Document No." = FIELD("Document No."),
                            "Line No." = FIELD("Line No.");

            }

        }
    }
    actions
    {
        addafter(Reopen)
        {
            separator(Separator14)
            {
            }
            action("PWD Classement sans suite")
            {
                ApplicationArea = All;
                Caption = 'Classement sans suite';
                Image = Delete;
                trigger OnAction()
                VAR
                    autoArchMngnt: Codeunit "PWD ArchiveAutoManagement";
                begin
                    autoArchMngnt.StorePurchDocument(Rec);
                    Rec.DELETE(TRUE);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("PWD commande PDF / Mail")
            {
                ApplicationArea = All;
                Caption = 'Commande PDF / Mail';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SendTo;

                trigger OnAction()
                VAR
                    CduGenerationPDF: Codeunit "PWD Generation PDF Auto";
                BEGIN
                    CLEAR(CduGenerationPDF);
                    CduGenerationPDF.GeneratePDFPurchaseOrder(Rec."No.");
                END;
            }
        }
        addafter("&Print")
        {
            action("PWD Demande d'achats")
            {
                ApplicationArea = All;
                Caption = 'Demande d''achats';
                Image = Purchase;
                RunObject = Page "Req. Worksheet";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
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
                ApplicationArea = Suite;
                Caption = 'P&ost';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                trigger OnAction()
                BEGIN
                    CLEAR(ValidatePurchaseOrder);
                    ValidatePurchaseOrder.InitRequete(Rec);
                    ValidatePurchaseOrder.RUNMODAL();
                end;
            }
        }
        modify("Post and &Print")
        {
            Visible = false;
        }
        addafter("Post and &Print")
        {
            action("PWD PWD Post and &Print")
            {
                ApplicationArea = Suite;
                Caption = 'Post and &Print';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    CLEAR(ValidatePurchaseOrder);
                    ValidatePurchaseOrder.FctSetPrint();
                    ValidatePurchaseOrder.InitRequete(Rec);
                    ValidatePurchaseOrder.RUNMODAL();
                END;
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
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
        PurchRRec.SETCURRENTKEY("Order No.", "Document Date");
        PurchRRec.SETRANGE("Order No.", Rec."No.");
        IF PurchRRec.FindFirst() THEN
            DateLastPurchR := FORMAT(PurchRRec."Document Date")
        ELSE
            DateLastPurchR := '';
    end;

    procedure PWDSetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible("Purchase Document Type"::Order.AsInteger(), Rec."No.");
    end;

    Var
        PurchRRec: Record "Purch. Rcpt. Header";
        ValidatePurchaseOrder: Report "PWD Validate Purchase Order";
        DocNoVisible: Boolean;
        DateLastPurchR: Text[30];
}
