pageextension 50078 "PWD PurchaseOrderList" extends "Purchase Order List"
{
    actions
    {
        addafter("Send IC Purchase Order")
        {
            action("PWD Commande PDF / Mail")
            {
                ApplicationArea = all;
                Ellipsis = true;
                Caption = 'Commande PDF / Mail';
                Promoted = True;
                Image = SendTo;
                PromotedCategory = Process;
                Trigger OnAction()
                VAR
                    CduGenerationPDF: Codeunit "PWD Generation PDF Auto";
                BEGIN
                    CLEAR(CduGenerationPDF);
                    CduGenerationPDF.GeneratePDFPurchaseOrder(Rec."No.");
                END;
            }
        }
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
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
                PromotedCategory = Category8;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                trigger OnAction()
                var
                    ValidatePurchaseOrder: Report "PWD Validate Purchase Order";
                begin
                    CLEAR(ValidatePurchaseOrder);
                    ValidatePurchaseOrder.InitRequete(Rec);
                    ValidatePurchaseOrder.RUNMODAL();
                end;
            }
            action("PWD PostAndPrint")
            {
                ApplicationArea = Suite;
                Caption = 'Post and &Print';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';

                trigger OnAction()
                var
                    ValidatePurchaseOrder: Report "PWD Validate Purchase Order";
                begin
                    CLEAR(ValidatePurchaseOrder);
                    ValidatePurchaseOrder.FctSetPrint();
                    ValidatePurchaseOrder.InitRequete(Rec);
                    ValidatePurchaseOrder.RUNMODAL();
                end;
            }
        }
    }
}
