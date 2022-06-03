pageextension 50030 "PWD PostedPurchaseReceipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("PWD No. de COM7"; Rec."PWD No. de COM7")
            {
                ApplicationArea = all;
            }
            field("PWD No. de DS"; Rec."PWD No. de DS")
            {
                ApplicationArea = All;
            }
        }
        addafter(Invoicing)
        {
            Group("Stocking Advice")
            {
                Caption = 'Stocking Advice';
                Field(Sealing; Rec."PWD Sealing")
                {
                    ApplicationArea = all;
                }
                Field("Attachment 1"; Rec."PWD Attachment 1")
                {
                    ApplicationArea = all;
                }
                Field("Attachment 2"; Rec."PWD Attachment 2")
                {
                    ApplicationArea = all;
                }
                Field("Attachment 3"; Rec."PWD Attachment 3")
                {
                    ApplicationArea = all;
                }
                Field("Attachment 4"; Rec."PWD Attachment 4")
                {
                    ApplicationArea = all;
                }
            }

            Group("Vendor Quality")
            {
                Caption = 'Vendor Quality';

                Field("Delivery Time Rating"; Rec."PWD Delivery Time Rating")
                {
                    ApplicationArea = all;
                }
                Field("Delivered Quantity Rating"; Rec."PWD Delivered Quantity Rating")
                {
                    ApplicationArea = all;
                }
                Field("Technical Rating"; Rec."PWD Technical Rating")
                {
                    ApplicationArea = all;
                }
                Field("Documentation Rating"; Rec."PWD Documentation Rating")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        addafter(Approvals)
        {
            separator(Separator)
            {
            }
            action("PWD Lignes COM7")
            {
                ApplicationArea = all;
                Caption = 'Lignes COM7';
                RunObject = Page "PWD Lignes Doc Douane";
                Image = AllLines;
                RunPageLink = "Document Type" = CONST("P.Receipt"),
                                  "Document No." = FIELD("No."),
                                  "Customs Document Type" = CONST(COM7);
            }
        }
        modify("&Print")
        {
            Visible = false;
        }
        addafter("&Receipt")
        {
            Group(Imprimer)
            {
                Caption = 'Imprimer';
                Action("PWD Imprimer")
                {
                    Caption = 'Imprimer...';
                    Image = Print;
                    ApplicationArea = All;
                    Trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                        PurchRcptHeader.PrintRecords(TRUE);
                    END;
                }
                Action("Avis de placement")
                {
                    Caption = 'Avis de placement';
                    ApplicationArea = All;
                    Image = Print;
                    Trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                        PurchRcptHeader.PrintRecordsNoticeInv(TRUE);
                    END;
                }
                Action("COM 7")
                {
                    Caption = 'COM 7';
                    ApplicationArea = All;
                    Image = Print;
                    Trigger OnAction()
                    Var
                        PWDCduFunctionMgt: Codeunit "PWD Function Mgt";
                    BEGIN
                        CLEAR(PWDCduFunctionMgt);
                        PWDCduFunctionMgt.PrintCOM7(Rec);
                    END;
                }
                Action("Statement Summary")
                {
                    ApplicationArea = all;
                    Caption = 'Statement Summary';
                    Image = Print;
                    Trigger OnAction()
                    BEGIN
                        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
                        PurchRcptHeader.PrintDS();
                    END;
                }
            }
        }
    }
    VAR
        PurchRcptHeader: Record "Purch. Rcpt. Header";
}
