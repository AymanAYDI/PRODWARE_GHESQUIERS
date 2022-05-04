pageextension 50064 "PWD SalesQuotes" extends "Sales Quotes"
{
    actions
    {
        addafter(Print)
        {
            action("PWD Quote PDF / Email")
            {
                ApplicationArea = all;
                Caption = 'Quote PDF / Email';
                Ellipsis = True;
                Promoted = True;
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
        }
    }
}
