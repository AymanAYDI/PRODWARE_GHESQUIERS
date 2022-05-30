tableextension 60055 "PWD NonstockItem" extends "Nonstock Item"
{
    fields
    {
        field(50000; "PWD Tariff No."; Code[10])
        {
            Caption = 'Tariff No.';
            TableRelation = "Tariff Number";
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Description 2"; Text[30])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Shelf No."; Code[10])
        {
            Caption = 'Shelf No.';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(27), "Field ID" = CONST(12));
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Family"; Code[10])
        {
            Caption = 'Family';
            TableRelation = "PWD Family & Sub Family".Code WHERE(Type = CONST(Item), "Group Type" = CONST(Family));
            DataClassification = CustomerContent;
        }
        field(50004; "PWD National Add. Code"; Code[19])
        {
            Caption = 'National Add. Code';
            TableRelation = "PWD National Add. Code";
            DataClassification = CustomerContent;
        }
        field(50005; "PWD IMPA Code"; Code[10])
        {
            Caption = 'IMPA Code';
            DataClassification = CustomerContent;
        }
    }
}
