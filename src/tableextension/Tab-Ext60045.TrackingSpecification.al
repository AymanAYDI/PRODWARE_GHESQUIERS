tableextension 60045 "PWD TrackingSpecification" extends "Tracking Specification"
{
    fields
    {
        field(50000; "PWD Country Origin"; Code[10])
        {
            Caption = 'Country Origin';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Certificate Transit No."; Code[30])
        {
            Caption = 'Certificate Transit No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50002; "PWD Stocking Advice No."; Code[20])
        {
            Caption = 'Stocking Advice No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50003; "PWD Origin Lot No."; Code[20])
        {
            Caption = 'Origin Lot No.';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50004; "PWD Meat Family"; Code[10])
        {
            Caption = 'Meat Family';
            Description = 'PW2009';
            TableRelation = "PWD Meat Family";
            DataClassification = CustomerContent;
        }
        field(50005; "PWD Meat Type"; Option)
        {
            Caption = 'Meat Type';
            Description = 'PW2009';
            OptionCaption = 'InPut,OutPut';
            OptionMembers = "Entrée",Sortie;
            DataClassification = CustomerContent;
        }
    }
}
