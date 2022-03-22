page 50079 "PWD RunJournal"
{
    Caption = 'Saisie SeaFrance';
    layout
    {
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RunJournal.RUN;
        ERROR('');
        CurrPage.CLOSE();
    end;

    var
        RunJournal: Codeunit RunJournal;
}

