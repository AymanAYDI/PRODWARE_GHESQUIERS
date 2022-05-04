codeunit 50021 "PWD RunJournal"
{
    trigger OnRun()
    begin
        PWDFunctionMgt.RunPrestation();
    end;

    var
        PWDFunctionMgt: Codeunit "PWD Function Mgt";
}

