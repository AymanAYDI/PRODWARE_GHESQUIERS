codeunit 50003 "PWD File Management"
{
    procedure ClientTempFileName(FileExtension: Text) ClientFileName: Text
    var
        ClientTempPath: Text;
    begin
        if not IsLocalFileSystemAccessible() then
            Error(LocalFileSystemNotAccessibleErr);

        // Returns the pseudo uniquely generated name of a non existing file in the client temp directory
        //ToDo
        /*
        TempFile.CreateTempFile;
        ClientFileName := CreateFileNameWithExtension(TempFile.Name, FileExtension);
        TempFile.Close;
        TempFile.Create(ClientFileName);
        TempFile.Close;
        ClientTempPath := GetDirectoryName(DownloadTempFile(ClientFileName));
        if Erase(ClientFileName) then;
        ClientFileHelper.Delete(ClientTempPath + '\' + PathHelper.GetFileName(ClientFileName));*/
        ClientFileName := CreateFileNameWithExtension(ClientTempPath + '\' + Format(CreateGuid()), FileExtension);
    end;

    procedure CreateFileNameWithExtension(FileNameWithoutExtension: Text; Extension: Text) FileName: Text
    begin
        FileName := FileNameWithoutExtension;
        if Extension <> '' then begin
            if Extension[1] <> '.' then
                FileName := FileName + '.';
            FileName := FileName + Extension;
        end
    end;

    [Obsolete('The windows client type has been retired. This procedure will always return false.', '17.3')]
    procedure IsLocalFileSystemAccessible(): Boolean
    var
        ClientTypeManagement: Codeunit "Client Type Management";
    begin
        exit(ClientTypeManagement.GetCurrentClientType() = CLIENTTYPE::Windows);
    end;

    procedure GetDirectoryName(FileName: Text): Text
    begin
        if FileName = '' then
            exit(FileName);

        FileName := DelChr(FileName, '<');
        //ToDo
        //exit(PathHelper.GetDirectoryName(FileName));
    end;

    procedure DownloadTempFile(ServerFileName: Text): Text
    var
        FileName: Text;
    begin
        FileName := ServerFileName;
        //ToDo
        /*
        Path := Magicpath;
        Download(ServerFileName, '', Path, AllFilesDescriptionTxt, FileName);*/
        exit(FileName);
    end;

    var
        LocalFileSystemNotAccessibleErr: Label 'Sorry, this action is not available for the online version of the app.';
}
