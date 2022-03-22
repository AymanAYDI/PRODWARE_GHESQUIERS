tableextension 60004 "PWD GLEntry" extends "G/L Entry"
{
    fields
    {
        field(50000; "PWD Export COALA"; Boolean)
        {
            Caption = 'Ecriture exportée COALA';
            DataClassification = CustomerContent;
        }
        field(50001; "PWD Export Date"; Date)
        {
            Caption = 'Date d''exportation COALA';
            DataClassification = CustomerContent;
        }
    }
}