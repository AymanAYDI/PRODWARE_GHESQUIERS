pageextension 50065 "PWD SalesOrderList" extends "Sales Order List"
{
    layout
    {
        addafter("Shipping Advice")
        {
            field("PWD Preparation Status"; Rec."PWD Preparation Status")
            {
                ApplicationArea = all;
            }
            field("PWD Seafrance Order No."; Rec."PWD Seafrance Order No.")
            {
                ApplicationArea = All;
            }
            field("PWD Amount"; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Send IC Sales Order Cnfmn.")
        {
            action("PWD Confirm. order PDF / Mail")
            {
                ApplicationArea = all;
                Caption = 'Confirm. order PDF / Mail';
                Ellipsis = true;
                Promoted = true;
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
    }
}
