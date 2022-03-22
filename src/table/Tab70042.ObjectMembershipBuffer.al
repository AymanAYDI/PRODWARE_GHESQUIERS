table 70042 "PWD Object Membership Buffer"
{
    Caption = 'Object Membership Buffer';
    DataPerCompany = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionCaption = 'Table Data,Table,Form,Report,Dataport,Codeunit,,,,,System';
            OptionMembers = "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System;
            DataClassification = CustomerContent;
        }
        field(2; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = IF ("Object Type" = CONST("Table Data")) AllObj."Object ID" WHERE("Object Type" = CONST(Table)) ELSE
            IF ("Object Type" = CONST(Table)) AllObj."Object ID" WHERE("Object Type" = CONST(Table)) ELSE
            IF ("Object Type" = CONST(Form)) AllObj."Object ID" WHERE("Object Type" = CONST(Page)) ELSE
            IF ("Object Type" = CONST(Report)) AllObj."Object ID" WHERE("Object Type" = CONST(Report)) ELSE
            IF ("Object Type" = CONST(Dataport)) AllObj."Object ID" WHERE("Object Type" = CONST(XMLport)) ELSE
            IF ("Object Type" = CONST(Codeunit)) AllObj."Object ID" WHERE("Object Type" = CONST(Codeunit)) ELSE
            IF ("Object Type" = CONST(System)) AllObj."Object ID" WHERE("Object Type" = CONST(System));
            DataClassification = CustomerContent;
        }
        field(4; "Object Name"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = FIELD("Object Type"), "Object ID" = FIELD("Object ID")));
            Caption = 'Object Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Object Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = FIELD("Object Type"), "Object ID" = FIELD("Object ID")));
            Caption = 'Object Caption';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Object Type", "Object ID")
        {
            Clustered = true;
        }
    }

    var
        Text1000000000: Label 'Looking for new Table Data';
        Text1000000001: Label 'Looking for new System Functions';


    procedure UpdSystemMembership()
    var
        AllObj: Record AllObj;
        ObjectMembership: Record "PWD Object Membership Buffer";
        Window: Dialog;
    begin
        Window.OPEN('#1############################');

        AllObj.RESET();
        AllObj.SETRANGE("Object Type", "Object Type"::"Table Data");
        AllObj.SETFILTER("Object ID", '>=2000000000');
        Window.UPDATE(1, Text1000000000);
        IF AllObj.FIND('-') THEN
            REPEAT
                IF AllObj."Object ID" IN [2000000002 .. 2000000006, 2000000053, 2000000054, 2000000058, 2000000203] THEN
                    IF NOT ObjectMembership.GET(AllObj."Object Type", AllObj."Object ID") THEN BEGIN
                        ObjectMembership.INIT();
                        ObjectMembership."Object Type" := AllObj."Object Type";
                        ObjectMembership."Object ID" := AllObj."Object ID";
                        ObjectMembership.INSERT();
                    END;
            UNTIL AllObj.NEXT() = 0;

        AllObj.RESET();
        AllObj.SETRANGE("Object Type", "Object Type"::System);
        Window.UPDATE(1, Text1000000001);
        IF AllObj.FIND('-') THEN
            REPEAT
                IF NOT ObjectMembership.GET(AllObj."Object Type", AllObj."Object ID") THEN BEGIN
                    ObjectMembership.INIT();
                    ObjectMembership."Object Type" := AllObj."Object Type";
                    ObjectMembership."Object ID" := AllObj."Object ID";
                    ObjectMembership.INSERT();
                END;
            UNTIL AllObj.NEXT() = 0;

        Window.CLOSE();
    end;
}

