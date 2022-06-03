table 70041 "PWD Object Membership"
{
    Caption = 'Object Membership';
    DataPerCompany = false;
    DrillDownPageID = "PWD Objects Membership";
    LookupPageID = "PWD Objects Membership";
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
        field(3; "Membership Code"; Code[20])
        {
            Caption = 'Membership Code';
            TableRelation = "PWD Membership".Code;
            DataClassification = CustomerContent;
        }
        field(4; "Object Name"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = FIELD("Object Type"), "Object ID" = FIELD("Object ID")));
            Caption = 'Object Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Membership Name"; Text[80])
        {
            CalcFormula = Lookup("PWD Membership".Name WHERE(Code = FIELD("Membership Code")));
            Caption = 'Membership Name';
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
        field(10; "No. of Objects"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Objects';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Object Type", "Object ID")
        {
            Clustered = true;
        }
        key(Key2; "Membership Code", "Object Type", "Object ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text1000000000: Label 'Looking for new Forms';
        Text1000000001: Label 'Looking for new Reports';
        Text1000000002: Label 'Looking for new Table Data';
        Text1000000003: Label 'Delete unknown objects';
        Text1000000004: Label '%1 new objects inserted in the list.';

    procedure UpdMembership()
    var
        AllObj: Record AllObj;
        ObjectMembership: Record "PWD Object Membership";
        Window: Dialog;
        LineCount: Integer;
        LineNo: Integer;
        ObjectNo: Integer;
    begin
        IF ObjectMembership.FindFirst() THEN
            IF ObjectMembership."No. of Objects" = AllObj.COUNT THEN
                EXIT;

        ObjectNo := 0;
        Window.OPEN(
          '#1############################\' +
          '#2############################\' +
          '@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

        AllObj.RESET();
        AllObj.SETRANGE("Object Type", "Object Type"::Form);
        LineNo := 0;
        LineCount := AllObj.COUNT;
        Window.UPDATE(1, Text1000000000);
        IF AllObj.FIND('-') THEN
            REPEAT
                LineNo += 1;
                Window.UPDATE(2, AllObj."Object Name");
                Window.UPDATE(3, ROUND(LineNo / LineCount * 9999, 1));
                IF STRPOS(UPPERCASE(AllObj."Object Name"), 'MENU') = 0 THEN
                    IF NOT ObjectMembership.GET(AllObj."Object Type", AllObj."Object ID") THEN BEGIN
                        ObjectMembership.INIT();
                        ObjectMembership."Object Type" := AllObj."Object Type";
                        ObjectMembership."Object ID" := AllObj."Object ID";
                        ObjectMembership.INSERT();
                        ObjectNo += 1;
                    END;
            UNTIL AllObj.NEXT() = 0;

        AllObj.SETRANGE("Object Type", "Object Type"::Report);
        LineNo := 0;
        LineCount := AllObj.COUNT;
        Window.UPDATE(1, Text1000000001);
        IF AllObj.FIND('-') THEN
            REPEAT
                LineNo += 1;
                Window.UPDATE(2, AllObj."Object Name");
                Window.UPDATE(3, ROUND(LineNo / LineCount * 9999, 1));
                IF NOT ObjectMembership.GET(AllObj."Object Type", AllObj."Object ID") THEN BEGIN
                    ObjectMembership.INIT();
                    ObjectMembership."Object Type" := AllObj."Object Type";
                    ObjectMembership."Object ID" := AllObj."Object ID";
                    ObjectMembership.INSERT();
                    ObjectNo += 1;
                END;
            UNTIL AllObj.NEXT() = 0;

        AllObj.SETRANGE("Object Type", "Object Type"::"Table Data");
        LineNo := 0;
        LineCount := AllObj.COUNT;
        Window.UPDATE(1, Text1000000002);
        IF AllObj.FIND('-') THEN
            REPEAT
                LineNo += 1;
                Window.UPDATE(2, AllObj."Object Name");
                Window.UPDATE(3, ROUND(LineNo / LineCount * 9999, 1));
                IF NOT ObjectMembership.GET(AllObj."Object Type", AllObj."Object ID") THEN BEGIN
                    ObjectMembership.INIT();
                    ObjectMembership."Object Type" := AllObj."Object Type";
                    ObjectMembership."Object ID" := AllObj."Object ID";
                    ObjectMembership.INSERT();
                    ObjectNo += 1;
                END;
            UNTIL AllObj.NEXT() = 0;

        Window.UPDATE(1, Text1000000003);
        ObjectMembership.RESET();
        IF ObjectMembership.FIND('-') THEN
            REPEAT
                IF NOT AllObj.GET(ObjectMembership."Object Type", ObjectMembership."Object ID") THEN
                    ObjectMembership.DELETE();
            UNTIL ObjectMembership.NEXT() = 0;

        ObjectMembership.RESET();
        IF ObjectMembership.FIND('-') THEN BEGIN
            AllObj.RESET();
            ObjectMembership."No. of Objects" := AllObj.COUNT;
            ObjectMembership.MODIFY();
        END;

        Window.CLOSE();
        IF ObjectNo > 0 THEN
            MESSAGE(Text1000000004, ObjectNo);
    end;
}
