pageextension 50019 "PWD PurchaseQuote" extends "Purchase Quote"
{
    actions
    {
        addafter(Print)
        {
            separator(separator1000)
            {
            }
            action("PWD Classification")
            {
                ApplicationArea = all;
                Caption = 'Classement sans suite';
                Image = Delete;
                trigger OnAction()
                VAR
                    AutoarchMgnt: Codeunit "PWD ArchiveAutoManagement";
                BEGIN
                    AutoarchMgnt.StorePurchDocument(Rec);
                    Rec.DELETE(TRUE);
                    CurrPage.UPDATE(FALSE);
                END;
            }
        }
    }
}
