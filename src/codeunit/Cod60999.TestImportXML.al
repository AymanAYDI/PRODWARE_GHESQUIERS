codeunit 60999 "PWD Test Import XML"
{

    trigger OnRun()
    begin
        CLEAR(SourceXml);
        CREATE(SourceXml);

        SourceXml.Open('c:\test.xml');

        WHILE NOT SourceXml.EOF DO

            ;

        SourceXml.Close;
    end;

    var
        SourceXml: Automation;
}

