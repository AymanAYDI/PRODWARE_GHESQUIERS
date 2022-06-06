page 99000 "PWD Test Cyrillique"
{
    PageType = Card;

    layout
    {
        area(content)
        {
            field(TestFrappe; TestFrappe)
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
                Caption = 'OK';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = CreateDocument;

                trigger OnAction()
                begin

                    //TODO: Automation
                    //CLEAR(Excel);
                    //CREATE(Excel);
                    /*

                    Excel.LanguageSettings;

                    Book := Excel.Workbooks.Add;
                    NomFeuilleExcel := '';
                    Sheet := Excel.ActiveSheet;
                    Sheet.Activate;

                    Excel.ActiveCell.Value := TestFrappe;

                    Excel.Visible := TRUE;*/
                end;
            }
        }
    }
    var
        TestFrappe: Text[250];
}
