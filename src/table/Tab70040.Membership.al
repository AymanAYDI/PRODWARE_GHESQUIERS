table 70040 "PWD Membership"
{
    Caption = 'Membership';
    DataPerCompany = false;
    LookupPageID = "PWD Membership List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[80])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(10; "No. of Tables"; Integer)
        {
            CalcFormula = Count("PWD Object Membership" WHERE("Object Type" = CONST("Table Data"), "Membership Code" = FIELD(Code)));
            Caption = 'No. of Tables';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "No. of Forms"; Integer)
        {
            CalcFormula = Count("PWD Object Membership" WHERE("Object Type" = CONST(Form), "Membership Code" = FIELD(Code)));
            Caption = 'No. of Forms';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "No. of Reports"; Integer)
        {
            CalcFormula = Count("PWD Object Membership" WHERE("Object Type" = CONST(Report), "Membership Code" = FIELD(Code)));
            Caption = 'No. of Reports';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
}

