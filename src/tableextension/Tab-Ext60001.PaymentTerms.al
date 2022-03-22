tableextension 60001 "PWD PaymentTerms" extends "Payment Terms"
{
    fields
    {
        field(50000; "PWD International Description"; Text[50])
        {
            Caption = 'International Description';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}