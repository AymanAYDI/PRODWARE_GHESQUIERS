tableextension 60039 "PWD IntrastatJnlLine" extends "Intrastat Jnl. Line"
{
    fields
    {

        field(50000; "PWD Supplementary Units Value"; Decimal)
        {
            Caption = 'Supplementary Units';
            Description = 'SOBI';
            DataClassification = CustomerContent;
        }
    }
}

