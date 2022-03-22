tableextension 60007 "PWD Vendor" extends Vendor
{
    fields
    {
        field(50000; "PWD Family"; Code[10])
        {
            Caption = 'Family';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(23), "Field ID" = CONST(50000));
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Sub Family"; Code[10])
        {
            Caption = 'Sub Family';
            Description = 'PW2009';
            TableRelation = "PWD Custom Parameters".Code WHERE("Table ID" = CONST(23), "Field ID" = CONST(50001));
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Delivery Time Rating"; Integer)
        {
            Caption = 'Delivery Time Rating';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Delivered Quantity Rating"; Integer)
        {
            Caption = 'Delivered Quantity Rating';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Technical Rating"; Integer)
        {
            Caption = 'Technical Rating';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Documentation Rating"; Integer)
        {
            Caption = 'Documentation Rating';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50006; "PWD Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            Description = 'PW2009';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(50007; "PWD Shipment Method"; Code[10])
        {
            Caption = 'Shipment Method';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50099; "PWD Ancien code"; Code[20])
        {
            Caption = 'Ancien code';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}