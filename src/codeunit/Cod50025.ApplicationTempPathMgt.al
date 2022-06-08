codeunit 50025 "PWD Application Temp Path Mgt."
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var

        ClientTempPath: Text[1024];
        ServerTempPath: Text[1024];

    procedure GetClientTempPath(): Text[1024]
    begin
        //TODO
        /*
        IF ClientTempPath = '' THEN
            ClientTempPath := ThreeTierMgt.Path(ThreeTierMgt.ClientTempFileName('', ''));
            */
        EXIT(ClientTempPath);
    end;

    procedure GetServerTempPath(): Text[1024]
    begin
        //TODO
        /*
        IF ServerTempPath = '' THEN
            ServerTempPath := ThreeTierMgt.Path(ThreeTierMgt.ServerTempFileName('', ''));
            */
        EXIT(ServerTempPath);
    end;
}
