codeunit 50021 "PWD RunJournal"
{
    trigger OnRun()
    begin
        ItemJnlManagement.RunPrestation;
    end;

    var
        ItemJnlManagement: Codeunit ItemJnlManagement;
}

