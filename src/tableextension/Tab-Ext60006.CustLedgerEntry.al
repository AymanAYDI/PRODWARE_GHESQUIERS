tableextension 60006 "PWD CustLedgerEntry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(50000; "PWD Reference"; Text[100])
        {
            Caption = 'Reference';
            Description = 'PW2009';
            DataClassification = CustomerContent;
        }
    }
}