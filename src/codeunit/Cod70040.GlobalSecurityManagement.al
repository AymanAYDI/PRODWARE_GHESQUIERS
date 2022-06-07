codeunit 70040 "PWD GlobalSecurityManagement"
{
    trigger OnRun()
    var
        Selection: Integer;
    begin
        IF CONFIRM(Text1000000001, FALSE) THEN BEGIN
            Selection := STRMENU(Text1000000000, 2);
            IF Selection = 0 THEN
                EXIT;

            IF Selection = 1 THEN BEGIN
                Window.OPEN('#1###################');
                Window.UPDATE(1, Text1000000003);
                ResetAllRolesAndPermissions();
                Window.CLOSE();
                MESSAGE(Text1000000002);
            END;

            IF Selection = 2 THEN BEGIN
                Window.OPEN('#1###################');
                Window.UPDATE(1, Text1000000003);
                ResetOnlyRoleTOUS();
                Window.CLOSE();
                MESSAGE(Text1000000002);
            END;

            IF Selection = 3 THEN BEGIN
                Window.OPEN('#1###################');
                UserRole.RESET();
                UserRole.SETFILTER("Role ID", '<>SUPER&<>TOUS');
                IF UserRole.FindFirst() THEN
                    REPEAT
                        Window.UPDATE(1, UserRole."Role ID");
                        ResetUserTableDataPermissions(UserRole);
                    UNTIL UserRole.NEXT() = 0;
                Window.CLOSE();
                MESSAGE(Text1000000002);
            END;

            IF Selection = 4 THEN BEGIN
                Window.OPEN('#1###################');
                Permission.RESET();
                Permission.SETFILTER("Role ID", '<>SUPER&<>TOUS');
                IF Permission.FindFirst() THEN
                    REPEAT
                        Window.UPDATE(1, Permission."Role ID");
                        IF NOT AllObj.GET(Permission."Object Type", Permission."Object ID") THEN
                            Permission.DELETE()
                        ELSE BEGIN
                            //TODO
                            Permission."Execute Permission" := Permission."Execute Permission"::Yes;
                            Permission."Insert Permission" := Permission."Insert Permission"::Yes;
                            Permission."Modify Permission" := Permission."Modify Permission"::Yes;
                            Permission."Delete Permission" := Permission."Delete Permission"::Yes;
                            Permission.MODIFY();
                        END;
                    UNTIL Permission.NEXT() = 0;
                Window.CLOSE();
                MESSAGE(Text1000000002);
            END;
        END;
    end;

    var
        AllObj: Record AllObj;
        Permission: Record Permission;
        UserRole: Record "Permission Set";
        Window: Dialog;
        Text1000000000: Label 'Restore minimum permissions (roles Super and Tous),Restore permissions for role Tous,Delete custom permissions on Table Data,Check existing permissions';
        Text1000000001: Label 'You are about to reset the existing configuration. Do you really want to continue ?';
        Text1000000002: Label 'Permissions have been successfully updated.';
        Text1000000003: Label 'Please wait...';
        Text1000000004: Label 'Role Selection : #1##########';
        Text1000000005: Label 'Role %1 does not exist.';

    procedure ResetAllRolesAndPermissions()
    begin
        DeleteAllRoles();
        SetRoleTOUSProperties();
    end;

    procedure ResetOnlyRoleTOUS()
    begin
        DeleteRoleTOUS();
        SetRoleTOUSProperties();
    end;

    procedure SetMaximumPermission(RoleID: Code[20]; ObjectType: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; ObjectID: Integer)

    begin
        Permission.INIT();
        Permission."Role ID" := RoleID;
        Permission."Object Type" := ObjectType;
        Permission."Object ID" := ObjectID;
        Permission."Read Permission" := Permission."Read Permission"::Yes;
        Permission."Insert Permission" := Permission."Insert Permission"::Yes;
        Permission."Modify Permission" := Permission."Modify Permission"::Yes;
        Permission."Delete Permission" := Permission."Delete Permission"::Yes;
        Permission."Execute Permission" := Permission."Execute Permission"::Yes;
        Permission.INSERT();
    end;

    procedure SetExecuteIndirect(RoleID: Code[20]; ObjectType: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; ObjectID: Integer)
    begin
        Permission.INIT();
        Permission."Role ID" := RoleID;
        Permission."Object Type" := ObjectType;
        Permission."Object ID" := ObjectID;
        Permission."Read Permission" := Permission."Read Permission"::" ";
        Permission."Insert Permission" := Permission."Insert Permission"::" ";
        Permission."Modify Permission" := Permission."Modify Permission"::" ";
        Permission."Delete Permission" := Permission."Delete Permission"::" ";
        Permission."Execute Permission" := Permission."Execute Permission"::Indirect;
        Permission.INSERT();
    end;

    procedure SetExecuteYes(RoleID: Code[20]; ObjectType: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; ObjectID: Integer)

    begin
        Permission.INIT();
        Permission."Role ID" := RoleID;
        Permission."Object Type" := ObjectType;
        Permission."Object ID" := ObjectID;
        Permission."Read Permission" := Permission."Read Permission"::" ";
        Permission."Insert Permission" := Permission."Insert Permission"::" ";
        Permission."Modify Permission" := Permission."Modify Permission"::" ";
        Permission."Delete Permission" := Permission."Delete Permission"::" ";
        Permission."Execute Permission" := Permission."Execute Permission"::Yes;
        Permission.INSERT();
    end;

    procedure SetREtoYesIMDtoInd(RoleID: Code[20]; ObjectType: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; ObjectID: Integer)
    var

    begin
        Permission.INIT();
        Permission."Role ID" := RoleID;
        Permission."Object Type" := ObjectType;
        Permission."Object ID" := ObjectID;
        Permission."Read Permission" := Permission."Read Permission"::Yes;
        Permission."Insert Permission" := Permission."Insert Permission"::Indirect;
        Permission."Modify Permission" := Permission."Modify Permission"::Indirect;
        Permission."Delete Permission" := Permission."Delete Permission"::Indirect;
        Permission."Execute Permission" := Permission."Execute Permission"::Yes;
        Permission.INSERT();
    end;

    procedure SetIMDtoYes(RoleID: Code[20]; ObjectType: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; ObjectID: Integer)
    var
    begin
        Permission.INIT();
        Permission."Role ID" := RoleID;
        Permission."Object Type" := ObjectType;
        Permission."Object ID" := ObjectID;
        Permission."Read Permission" := Permission."Read Permission"::" ";
        Permission."Insert Permission" := Permission."Insert Permission"::Yes;
        Permission."Modify Permission" := Permission."Modify Permission"::Yes;
        Permission."Delete Permission" := Permission."Delete Permission"::Yes;
        Permission."Execute Permission" := Permission."Execute Permission"::" ";
        Permission.INSERT();
    end;

    procedure SetREtoYes(RoleID: Code[20]; ObjectType: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; ObjectID: Integer)
    begin
        Permission.INIT();
        Permission."Role ID" := RoleID;
        Permission."Object Type" := ObjectType;
        Permission."Object ID" := ObjectID;
        Permission."Read Permission" := Permission."Read Permission"::Yes;
        Permission."Insert Permission" := Permission."Insert Permission"::" ";
        Permission."Modify Permission" := Permission."Modify Permission"::" ";
        Permission."Delete Permission" := Permission."Delete Permission"::" ";
        Permission."Execute Permission" := Permission."Execute Permission"::Yes;
        Permission.INSERT();
    end;

    procedure SetExecuteAllowedValue(ValueInput: Boolean; var ObjectMembership: Record "PWD Object Membership"; RoleInput: Code[20])
    var

    begin
        Window.OPEN(Text1000000004, RoleInput);
        Window.Update(1, RoleInput);
        Window.CLOSE();
        ObjectMembership.FindFirst();
        IF NOT UserRole.GET(RoleInput) THEN
            ERROR(Text1000000005, RoleInput)
        ELSE
            REPEAT
                Permission."Role ID" := RoleInput;
                Permission."Object Type" := ObjectMembership."Object Type";
                Permission."Object ID" := ObjectMembership."Object ID";
                IF NOT Permission.MODIFY() THEN BEGIN
                    Permission.INIT();
                    Permission.INSERT();
                    if ValueInput then
                        Permission.Validate("Execute Permission", Permission."Execute Permission"::Yes)
                    else
                        Permission.Validate("Execute Permission", Permission."Execute Permission"::" ");
                END;
            UNTIL ObjectMembership.NEXT() = 0;
    end;

    procedure ResetUserTableDataPermissions(SelUserRole: Record "Permission Set")
    var
    begin
        AllObj.RESET();
        AllObj.SETFILTER("Object Type", 'TableData');
        AllObj.SETFILTER("Object ID", '<2000000000');
        IF AllObj.FindSet() THEN
            REPEAT
                IF STRPOS(UPPERCASE(AllObj."Object Name"), 'BUFFER') = 0 THEN
                    IF Permission.GET(SelUserRole."Role ID", AllObj."Object Type", AllObj."Object ID") THEN
                        Permission.DELETE();
            UNTIL AllObj.NEXT() = 0;
        AllObj.RESET();
        AllObj.SETFILTER("Object Type", 'TableData');
        AllObj.SETFILTER("Object ID", '2000000002..2000000006|2000000053..2000000054|2000000203');
        IF AllObj.FindSet() THEN
            REPEAT
                IF Permission.GET(SelUserRole."Role ID", AllObj."Object Type", AllObj."Object ID") THEN
                    Permission.DELETE();
            UNTIL AllObj.NEXT() = 0;
    end;

    procedure DeleteAllRoles()
    begin
        UserRole.SETFILTER("Role ID", '<>SUPER');
        IF UserRole.FindFirst() THEN
            UserRole.DELETEALL();

        Permission.SETFILTER("Role ID", '<>SUPER');
        IF Permission.FindFirst() THEN
            Permission.DELETEALL();
    end;

    procedure DeleteRoleTOUS()
    begin
        UserRole.SETFILTER("Role ID", 'TOUS');
        IF UserRole.FindFirst() THEN
            UserRole.DELETEALL();

        Permission.SETFILTER("Role ID", 'TOUS');
        IF Permission.FindFirst() THEN
            Permission.DELETEALL();
    end;

    procedure SetRoleTOUSProperties()
    begin
        Permission.RESET();
        IF Permission.FindSet() THEN
            REPEAT
                Permission.VALIDATE("Execute Permission");
                Permission.MODIFY();
            UNTIL Permission.NEXT() = 0;

        IF NOT UserRole.GET('TOUS') THEN BEGIN
            UserRole.Init();
            UserRole."Role ID" := 'TOUS';
            UserRole.Name := 'Tous les utilisateurs';
            UserRole.INSERT();
        END;
        UserRole.SETFILTER("Role ID", 'TOUS');
        UserRole.FindFirst();
        //Set Permissions for TableData
        AllObj.RESET();
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::TableData);
        IF AllObj.FindFirst() THEN
            SetREtoYesIMDtoInd(UserRole."Role ID", AllObj."Object Type", 0);
        //Set Permissions for 'Buffer' Table Data
        AllObj.RESET();
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::TableData);
        IF AllObj.FindFirst() THEN
            REPEAT
                IF STRPOS(UPPERCASE(AllObj."Object Name"), 'BUFFER') <> 0 THEN
                    SetIMDtoYes(UserRole."Role ID", AllObj."Object Type", AllObj."Object ID");
            UNTIL AllObj.NEXT() = 0;
        //Set Permissions for object 'Table'
        AllObj.RESET();
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::Table);
        IF AllObj.FindFirst() THEN
            SetREtoYes(UserRole."Role ID", AllObj."Object Type", 0);
        //Set Permissions for objects 'Form' & 'Report'
        AllObj.RESET();
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::Page);
        IF AllObj.FindFirst() THEN
            SetExecuteIndirect(UserRole."Role ID", AllObj."Object Type", 0);
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::Report);
        IF AllObj.FindFirst() THEN
            SetExecuteIndirect(UserRole."Role ID", AllObj."Object Type", 0);
        //Set Permissions for objects 'Dataport' & 'Codeunit'
        AllObj.RESET();
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::XMLport);
        IF AllObj.FindFirst() THEN
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 0);
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::Codeunit);
        IF AllObj.FindFirst() THEN
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 0);
        //Set Permissions for 'Menu' forms
        AllObj.RESET();
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::Page);
        IF AllObj.FindFirst() THEN
            REPEAT
                //TODO
                IF STRPOS(UPPERCASE(AllObj."Object Name"), 'MENU') <> 0 THEN
                    SetExecuteYes(UserRole."Role ID", AllObj."Object Type", AllObj."Object ID");
            UNTIL AllObj.NEXT() = 0;
        //Set Permissions for System Functions
        AllObj.RESET();
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::System);
        IF AllObj.FindFirst() THEN BEGIN
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 2510);
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 2520);
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 3220);
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 3230);
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 3410);
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 3510);
            SetMaximumPermission(UserRole."Role ID", AllObj."Object Type", 5830);
        END;

        //Set Permissions for System TableData
        AllObj.RESET();
        AllObj.SETRANGE("Object Type", AllObj."Object Type"::TableData);
        AllObj.SETFILTER("Object ID", '>=2000000000');
        IF AllObj.FindFirst() THEN
            REPEAT
                IF NOT (AllObj."Object ID" IN [2000000002 .. 2000000006, 2000000053, 2000000054, 2000000058, 2000000203]) THEN
                    SetIMDtoYes(UserRole."Role ID", AllObj."Object Type", AllObj."Object ID");
            UNTIL AllObj.NEXT() = 0;
        AllObj.RESET();
    end;
}
