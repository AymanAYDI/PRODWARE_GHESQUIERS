tableextension 60061 "PWD ReturnReceiptHeader" extends "Return Receipt Header"
{
    fields
    {
        field(50000; "PWD Call No."; Code[10])
        {
            Caption = 'Call No.';
            Description = 'PW2009';
            TableRelation = "PWD Call"."Call No.";
            DataClassification = CustomerContent;
        }
        field(50110; "PWD Bill-to C/O"; Boolean)
        {
            Caption = 'c/o';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(50111; "PWD Bill-to Additional name"; Text[50])
        {
            Caption = 'Nom complémentaire';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
        field(55000; "PWD Filing Reason"; Code[10])
        {
            Caption = 'Filing Reason';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(36), "Field ID" = CONST(55000));
            DataClassification = CustomerContent;
        }
    }
}

