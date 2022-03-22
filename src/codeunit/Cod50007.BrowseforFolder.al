codeunit 50007 "PWD Browse for Folder"
{

    trigger OnRun()
    begin
        MESSAGE(BrowseForFolder(Text001, 0));
    end;

    var
        WindowsShell: Automation;
        ActiveWindow: Automation;
        Text001: Label 'Title goes here...';


    procedure BrowseForFolder(Title: Text[80]; Root: Variant): Text[260]
    var
        SelectedFolder: Automation;
        FolderItem: Automation;
    begin
        IF ISCLEAR(WindowsShell) THEN
            CREATE(WindowsShell);
        IF ISCLEAR(ActiveWindow) THEN
            CREATE(ActiveWindow);

        SelectedFolder := WindowsShell.BrowseForFolder(ActiveWindow.Handle, Title, BIF_RETURNONLYFSDIRS(), Root);

        IF NOT ISCLEAR(SelectedFolder) THEN BEGIN
            FolderItem := SelectedFolder.Self;
            EXIT(FolderItem.Path);
        END;
    end;

    local procedure BIF_RETURNONLYFSDIRS(): Integer
    begin
        EXIT(1);
    end;
}

