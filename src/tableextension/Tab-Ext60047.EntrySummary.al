tableextension 60047 "PWD EntrySummary" extends "Entry Summary"
{
    fields
    {
        field(50000; "PWD Origin Area"; Code[10])
        {
            Caption = 'Origin Area';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Certificat Transit No."; Code[30])
        {
            Caption = 'Certificat Transit No.';
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
    }
}
